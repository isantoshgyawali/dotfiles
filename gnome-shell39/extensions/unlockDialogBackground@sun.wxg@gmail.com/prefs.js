import Adw from 'gi://Adw';
import Gio from 'gi://Gio';
import GLib from 'gi://GLib';
import GObject from 'gi://GObject';
import Gtk from 'gi://Gtk';
import Gdk from 'gi://Gdk';
import GdkPixbuf from 'gi://GdkPixbuf';

import {ExtensionPreferences} from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';

const BACKGROUND_SCHEMA = 'org.gnome.desktop.background.lockdialog';

class PrefsWidget {
    constructor(settings) {
        this.gsettings = settings;

        this.widget = new Gtk.Box({
            orientation: Gtk.Orientation.VERTICAL,
            margin_top: 10,
            margin_bottom: 10,
            margin_start: 10,
            margin_end: 10,
        });

        this.vbox = new Gtk.Box({
            orientation: Gtk.Orientation.VERTICAL,
            margin_top: 0,
            hexpand: true,
        });
        this.vbox.set_size_request(550, 650);

        this.addBoldTextToBox("Change background", this.vbox);
        this.vbox.append(new Gtk.Separator({ orientation: Gtk.Orientation.HORIZONTAL, margin_bottom: 5, margin_top: 5}));
        this.vbox.append(this.addAdjustBlur());
        this.vbox.append(this.addAdjustBrightness());
        this.vbox.append(this.addPictureUrl());
        this.vbox.append(this.addPictureShow());

        this.widget.append(this.vbox);
    }

    addPictureUrl() {
        let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5 });
        let setting_label = new Gtk.Label({ label: "Picture", xalign: 0, hexpand: true });
        this.setting_entry = new Gtk.Entry({ hexpand: true, margin_start: 20 });

        this.setting_entry.set_text(this.gsettings.get_string('picture-uri'));
        this.setting_entry.connect('changed', (entry) => { this.gsettings.set_string('picture-uri', entry.get_text()); });
        this.setting_entry.set_text(this.gsettings.get_string('picture-uri-dark'));
        this.setting_entry.connect('changed', (entry) => { this.gsettings.set_string('picture-uri-dark', entry.get_text()); });

        this.fileChooseButton = new Gtk.Button({ margin_start: 5 });
        this.fileChooseButton.set_label("Browse");
        this.fileChooseButton.connect("clicked", this.showFileChooserDialog.bind(this));


        hbox.append(setting_label);
        hbox.append(this.setting_entry);
        hbox.append(this.fileChooseButton);

        return hbox;
    }

    showFileChooserDialog() {
        let fileChooser = new Gtk.FileChooserDialog({ title: "Select File" });
        fileChooser.set_transient_for(this.widget.get_root());
        fileChooser.set_default_response(1);

        let filter = new Gtk.FileFilter();
        filter.add_pixbuf_formats();
        fileChooser.filter = filter;

        fileChooser.add_button("Open", Gtk.ResponseType.ACCEPT);

        fileChooser.connect("response", (dialog, response) => {
            if (response == Gtk.ResponseType.ACCEPT) {
                let file = dialog.get_file().get_path()
                if (file.length > 0)
                    this.setting_entry.set_text(file);
                fileChooser.destroy();
            }
        });

        fileChooser.show();

    }

    addPictureShow() {
        this.drawArea = new Gtk.DrawingArea({
            halign: Gtk.Align.CENTER
        });
        this.drawArea.set_draw_func( (drawArea, cr, width, height) => {
            if (!GLib.file_test(this.setting_entry.get_text(), GLib.FileTest.EXISTS))
                return;

            let pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_size(this.setting_entry.get_text(),
                                                                -1,
                                                                height);

            this.drawArea.set_size_request(this.vbox.get_width(), -1);

            Gdk.cairo_set_source_pixbuf(cr, pixbuf, 0, 0);
            cr.paint();
        });

        this.setting_entry.connect('changed', (entry) => {
                                    if (GLib.file_test(entry.get_text(), GLib.FileTest.EXISTS))
                                        this.drawArea.queue_draw();
                                    });

        let hbox = new Gtk.Box({ orientation: Gtk.Orientation.HORIZONTAL,
                                 margin_top: 10,
                                 hexpand:true,
                                 vexpand:true,
                                 halign:Gtk.Align.CENTER });

        hbox.append(this.drawArea);

        return hbox;
    }

    addBoldTextToBox(text, box) {
        let txt = new Gtk.Label({xalign: 0, margin_top: 20});
        txt.set_markup('<b>' + text + '</b>');
        txt.set_wrap(true);
        box.append(txt);
    }

    addAdjustBlur() {
        let hbox = new Gtk.Box({orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5});
        let blurLabel = new Gtk.Label({label: 'Adjust Sigma', xalign: 0, hexpand: true});

        this.blur_adjustment = new Gtk.Adjustment({
            lower: 0,
            'step-increment': 1,
            'page-increment': 5,
            upper: 100,
        });

        this.blur_scale = new Gtk.Scale({
            hexpand: true,
            'draw-value': true,
            'value-pos': 'left',
            'can-focus': true,
            digits: 0,
            adjustment: this.blur_adjustment,
        });

        this.blur_scale.set_value(this.gsettings.get_int('sigma'));
        this.blur_scale.connect('value-changed', entry => {
            this.gsettings.set_int('sigma', entry.get_value());
        });

        hbox.append(blurLabel);
        hbox.append(this.blur_scale);

        return hbox;
    }

    addAdjustBrightness() {
        let hbox = new Gtk.Box({orientation: Gtk.Orientation.HORIZONTAL, margin_top: 5});
        let brightnessLabel = new Gtk.Label({label: 'Adjust Brightness', xalign: 0, hexpand: true});

        this.brightness_adjustment = new Gtk.Adjustment({
            lower: 0,
            'step-increment': 0.05,
            'page-increment': 0.1,
            upper: 1,
        });

        this.brightness_scale = new Gtk.Scale({
            hexpand: true,
            'draw-value': true,
            'value-pos': 'left',
            'can-focus': true,
            digits: 2,
            adjustment: this.brightness_adjustment,
        });

        this.brightness_scale.set_value(this.gsettings.get_double('brightness'));
        this.brightness_scale.connect('value-changed', entry => {
            this.gsettings.set_double('brightness', entry.get_value());
        });

        hbox.append(brightnessLabel);
        hbox.append(this.brightness_scale);

        return hbox;
    }
}

export default class UnlockDialogBackgroundPrefs extends ExtensionPreferences {
    getPreferencesWidget() {
        let widget = new PrefsWidget(this.getSettings());
        return widget.widget;
    }
}
