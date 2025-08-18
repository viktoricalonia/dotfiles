dofile(vim.g.base46_cache .. "lsp")
local base = require("plugins.configs.lspconfig")

local on_attach = base.on_attach
local capabilities = base.capabilities
local sourcekit_capabilities = vim.lsp.protocol.make_client_capabilities()
sourcekit_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

local lspConfigUtil = require("lspconfig.util")
local lspconfig = require('lspconfig')

-- check setup configs here
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls

-- lspconfig.clangd.setup {
--   on_attach = function(client, bufnr)
--     client.server_capabilities.signatureHelpProvider = false
--     on_attach(client, bufnr)
--   end,
--   capabilities = capabilities,
-- }

lspconfig.sourcekit.setup({
  capabilities = sourcekit_capabilities,
  on_attach = on_attach,
  cmd = { "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp" },
  formatting = {
    on_save = true,
  },
  filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp", "objc", "objcpp" },
  get_language_id = function(_, ftype)
    if ftype == "objc" then
      return "objective-c"
    end
    if ftype == "objcpp" then
      return "objective-c"
    end
    return ftype
  end,
  root_dir = function(filename, _)
    return lspConfigUtil.root_pattern("buildServer.json")(filename)
        or lspConfigUtil.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
        or lspConfigUtil.find_git_ancestor(filename)
        or lspConfigUtil.root_pattern("Package.swift")(filename)
  end,
})

lspconfig.eslint.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.jsonls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.html.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.vimls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.apex_ls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.vtsls.setup {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          name = '@vue/typescript-plugin',
          location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
          languages = { 'vue' },
          configNamespace = 'typescript',
        },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.volar.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.yamlls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}
