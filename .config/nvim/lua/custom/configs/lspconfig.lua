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

lspconfig.html.setup {
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

-----@brief
---
--- https://www.npmjs.com/package/@github/copilot-language-server
---
--- The Copilot Language Server enables any editor or IDE
--- to integrate with GitHub Copilot via
--- [the language server protocol](https://microsoft.github.io/language-server-protocol/).
---
--- **[GitHub Copilot](https://github.com/features/copilot)**
--- is an AI pair programmer tool that helps you write code faster and smarter.
---
--- **Sign up for [GitHub Copilot Free](https://github.com/settings/copilot)!**
---
--- Please see [terms of use for GitHub Copilot](https://docs.github.com/en/site-policy/github-terms/github-terms-for-additional-products-and-features#github-copilot)
---

---@param bufnr integer,
---@param client vim.lsp.Client
local function sign_in(bufnr, client)
  client:request(
  ---@diagnostic disable-next-line: param-type-mismatch
    'signIn',
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.command then
        local code = result.userCode
        local command = result.command
        vim.fn.setreg('+', code)
        vim.fn.setreg('*', code)
        local continue = vim.fn.confirm(
          'Copied your one-time code to clipboard.\n' .. 'Open the browser to complete the sign-in process?',
          '&Yes\n&No'
        )
        if continue == 1 then
          client:exec_cmd(command, { bufnr = bufnr }, function(cmd_err, cmd_result)
            if cmd_err then
              vim.notify(err.message, vim.log.levels.ERROR)
              return
            end
            if cmd_result.status == 'OK' then
              vim.notify('Signed in as ' .. cmd_result.user .. '.')
            end
          end)
        end
      end

      if result.status == 'PromptUserDeviceFlow' then
        vim.notify('Enter your one-time code ' .. result.userCode .. ' in ' .. result.verificationUri)
      elseif result.status == 'AlreadySignedIn' then
        vim.notify('Already signed in as ' .. result.user .. '.')
      end
    end
  )
end

---@param client vim.lsp.Client
local function sign_out(_, client)
  client:request(
  ---@diagnostic disable-next-line: param-type-mismatch
    'signOut',
    vim.empty_dict(),
    function(err, result)
      if err then
        vim.notify(err.message, vim.log.levels.ERROR)
        return
      end
      if result.status == 'NotSignedIn' then
        vim.notify('Not signed in.')
      end
    end
  )
end

lspconfig.copilot.setup({
  cmd = { "copilot-language-server", "--stdio" },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignIn', function()
      sign_in(bufnr, client)
    end, { desc = 'Sign in Copilot with GitHub' })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignOut', function()
      sign_out(bufnr, client)
    end, { desc = 'Sign out Copilot with GitHub' })
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_markers = { ".git/", "package.json", "copilot.config.json" },
  settings = { telemetry = { enable = false } },
})
