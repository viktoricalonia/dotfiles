local base = require("plugins.configs.lspconfig")

local on_attach = function(client, bufnr)
  if client.name == "copilot" then
    client._on_insert_enter({})
  end
  base.on_attach(client, bufnr)
end

local capabilities = base.capabilities

local lspConfigUtil = require("lspconfig.util")
local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"},
  root_dir = function(filename, _)
    return lspConfigUtil.root_pattern("buildServer.json")(filename)
      or lspConfigUtil.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
      or lspConfigUtil.find_git_ancestor(filename)
      or lspConfigUtil.root_pattern("Package.swift")(filename)
  end,
})
