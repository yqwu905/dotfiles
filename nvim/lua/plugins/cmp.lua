return function()
  local present, cmp = pcall(require, "cmp")

  if not present then
    return
  end

  local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
  }

  -- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

  local default = {
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        -- local icons = require("plugins.configs.lspkind_icons")
        -- vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          buffer = "[BUF]",
          ultisnips = "[Snip]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
      fields = { "kind", "abbr", "menu" },
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = function(fallback)
        if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
          vim.fn["UltiSnips#ExpandSnippet"]()
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "ultisnips" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "cmdline" },
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
  }
  cmp.setup(default)
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmdline" },
    }, {
      { name = "path" },
    }),
  })
end
