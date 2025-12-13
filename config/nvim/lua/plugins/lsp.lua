return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jose-elias-alvarez/typescript.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        -- why tf I didn't used it before
        local ls = require('luasnip')
        local snippet = ls.snippet
        local text = ls.text_node
        local insert = ls.insert_node
        local fmt = require("luasnip.extras.fmt").fmt

        -- javascipt / typescript snippets
        local jsTsFileType = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
        for _, ft in pairs(jsTsFileType) do
            ls.add_snippets(ft, {
                snippet("js", {
                    text('console.log(JSON.stringify('),
                    insert(1, "items"),
                    text(', null, 2))')
                })
            })

            ls.add_snippets(ft, {
                snippet("nv",
                    fmt([[
                    import {{ NativeStackNavigationOptions }} from "@react-navigation/native-stack"
                    import {{ useNavigation }} from "expo-router";
                    const navigation = useNavigation();
                    useEffect(() => {{
                        const options: NativeStackNavigationOptions = {{
                            headerShown: true,
                            header: () => (
                                <SafeAreaView>
                                    {}
                                </SafeAreaView>
                            ),
                        }};

                        navigation.setOptions(options);
                    }}, [navigation]);]],
                        { insert(1, "// write here") }
                    )
                )
            })

            ls.add_snippets(ft, {
                snippet("rnfe",
                    fmt([[
                    import {{ Text, View }} from "react-native";
                    export default function {}() {{
                        return (
                            <View>
                                <Text>{2}</Text>
                            </View>
                        )
                    }}]],
                        { insert(1, "Function_Name"), insert(2, "Hello, there!") }
                    )
                )
            })

            ls.add_snippets(ft, {
                snippet("st",
                    fmt([[
                        setTimeout(() => {{
                            {}
                        }}, 300)
                    ]],
                        { insert(1, "// write here") }
                    )
                )
            })

            ls.add_snippets(ft, {
                snippet("ei",
                    fmt([[
                    import {{{}}} from "@expo/vector-icons"
                    ]],
                        { insert(1, "IconPack") }
                    )
                )
            })

            ls.add_snippets(ft, {
                snippet("us",
                    fmt([[
                    useEffect(() => {{
                        {}
                    }}, []);]],
                        { insert(1, "// write here") }
                    )
                )
            })
        end

        -- golang snippets
        ls.add_snippets("go", {
            snippet("ue",
                fmt([[
                        if err != nil {{
                            return nil, {}
                        }}
                    ]],
                    { insert(1, "err") }
                )
            )
        })

        ls.add_snippets("go", {
            snippet("fe",
                fmt([[
                        if err != nil {{
                            return nil, fmt.Errorf("{}: %w", {}, err)
                        }}
                    ]],
                    {
                        insert(1, 'Error'),
                        insert(2, 'variable')
                    }
                )
            )
        })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "ts_ls",
                "tailwindcss",
                "sqls",
                "jsonls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'luasnip',  priority = 1000 },
                { name = 'nvim_lsp', priority = 900 },
                { name = 'buffer',   priority = 500 },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = true,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        local opts = { remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float(
                nil, { max_height = 5000, }
            )
        end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set({ "n", "v" }, "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end
}
