local lspconfig = require 'lspconfig'
local lsp_folder = "/home/ring/var/lsp"
local api = vim.api
local util = require("lspconfig/util")
local saga = require 'lspsaga'

saga.init_lsp_saga{
  finder_action_keys = {
    open = '<enter>', vsplit = 'v',split = 's',quit = 'q'
  },
}

local custom_attach = function(client, bufnr)
  -- local has_completion,completion = pcall(require,'completion')
  -- if not has_completion then
  --   print('Does not load completion-nvim')
  --   return
  -- end
  -- completion.on_attach()

  -- TODO --
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end


local servers = {
  'dockerls','bashls',
  'vuels', 'yamlls', 'vimls',
  'cssls'
}

for _,server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = custom_attach
  }
end


lspconfig.pyright.setup{
  on_attach = custom_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true
      }
    }
  }
}

-- lspconfig.pyls.setup {
--   enable = true,
--   plugins = {
--     pyls_mypy = {
--       enabled = true,
--       live_mode = false
--     }
--   },
--   on_attach = custom_attach
-- }


lspconfig.tsserver.setup({
  cmd = {"typescript-language-server", "--stdio"},
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  on_attach = custom_attach
})


lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu",
  },
  on_attach = custom_attach,
  -- Required for lsp-status
  init_options = {
    clangdFileStatus = true
  },
  -- handlers = nvim_status.extensions.clangd.setup(),
  -- capabilities = nvim_status.capabilities,
})



lspconfig.gopls.setup {
  cmd = {"gopls","--remote=auto"},
  capabilities ={
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },
  on_attach = custom_attach,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  }
}

lspconfig.sumneko_lua.setup {
  cmd = {
    lsp_folder.."/lua-language-server/bin/Linux/lua-language-server",
    "-E",
    lsp_folder.."/lua-language-server/main.lua"
  },
  on_attach = custom_attach,
  root_dir = vim.loop.cwd,
  -- root_dir = function(fname)
  --   return util.find_git_ancestor(fname) or
  --     util.path.dirname(fname)
  -- end,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}



