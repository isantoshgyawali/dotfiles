---@module 'hl'
-- You'll probably like this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

--------------------------------
-- PROGRAMS PERMANENT RESIDENCE |
--------------------------------
hl.window_rule({ match = { class = "^([Kk]itty)$" }, workspace = 1 })
hl.window_rule({ match = { class = "^([Zz]en.*)$" }, workspace = 2 })
hl.window_rule({ match = { class = "^([Cc]ode)$" }, workspace = 3 })
hl.window_rule({ match = { class = "^(md.obsidian.Obsidian)$" }, workspace = 3 })
hl.window_rule({ match = { class = "^([Zz]oom)$" }, workspace = 8 })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome)$" }, workspace = 8 })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, workspace = 8 })
hl.window_rule({ match = { class = "^(sysmon)$" }, workspace = 9 })
hl.window_rule({ match = { class = "^(org.pwmt.zathura)$" }, workspace = 10 })
hl.window_rule({ match = { class = "^(org.gnome.Nautilus)$" }, workspace = 10 })
hl.window_rule({ match = { class = "^([Ww]aydroid.*)$" }, workspace = 10 })
hl.window_rule({ match = { class = "^([Aa]ntigravity.*)$" }, workspace = 10 })
hl.window_rule({ match = { class = "^(floating)$" }, float = true })
hl.window_rule({ match = { title = "^(controlCenter)$" }, size = { "70%", "80%" } })

--android-shared-screen
hl.window_rule({ match = { title = "^(Emulator)$" }, workspace = 1 })
hl.window_rule({ match = { title = "^(CPH2333)$" }, workspace = 1 })
hl.window_rule({ match = { title = "^(CPH2333)$" }, tile = true })
hl.window_rule({ match = { title = "^(.*Network Manager.*)$" }, float = true })

-----------------------------------
-- OPACITY DEFINITION FOR PROGRAMS |
-----------------------------------
hl.window_rule({ match = { class = "^([Cc]ode)$" }, opacity = "0.97 0.85" })
hl.window_rule({ match = { class = "^([Kk]itty)$" }, opacity = "1.00 0.75" })
hl.window_rule({ match = { class = "^([Zz]en.*)$" }, opacity = "0.90 0.75" })
hl.window_rule({ match = { class = "^(md.obsidian.Obsidian)$" }, opacity = "0.90 0.85" })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome)$" }, opacity = "0.90 0.85" })
hl.window_rule({ match = { class = "^(org.gnome.Nautilus)$" }, opacity = "0.90 0.85" })
hl.window_rule({ match = { class = "^(com.obsproject.Studio)$" }, opacity = "0.90 0.85" })

---- Overriding opacity rules for youtube, figma
hl.window_rule({ match = { title = "(.*YouTube.*)$" }, opacity = "1 override" })
hl.window_rule({ match = { title = "(.*Figma.*)$" }, opacity = "1 override" })
