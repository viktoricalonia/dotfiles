local chadConfig = require("nvchad.configs.lspconfig")
chadConfig.defaults()

-- #NOTE: This is the MAIN lsp config

-- check setup configs here
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
--
--
local servers = { "html", "cssls", "vtsls", "ts_ls", "sourcekit", "kotlin_lsp", "eslint", "jsonls" }
vim.lsp.enable(servers)


vim.lsp.config('kotlin_lsp', {
  cmd = { 'intellij-server', '--stdio' },
  init_options = {
    provideFormatter = false
  },
  root_markers = {
    { 'settings.gradle', 'settings.gradle.kts' }, -- tier 1: prefer the real build root
    { 'build.gradle',    'build.gradle.kts',   'pom.xml', 'workspace.json' },
  },
  on_attach = function(client, _)
    client.server_capabilities.signatureHelpProvider = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
vim.lsp.enable('kotlin_lsp')

vim.lsp.config('sourcekit', {
  init_options = {
    provideFormatter = false
  },
  on_attach = function(client, _)
    client.server_capabilities.signatureHelpProvider = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})
vim.lsp.enable('sourcekit')

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          name = '@vue/typescript-plugin',
          location = vim.fn.expand('$MASON/packages') .. '/vue-language-server' .. '/node_modules/@vue/language-server',
          languages = { 'vue' },
          configNamespace = 'typescript',
        },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.config("vue_ls", {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'package.json' },
  on_init = function(client)
    local retries = 0

    ---@param _ lsp.ResponseError
    ---@param result any
    ---@param context lsp.HandlerContext
    local function typescriptHandler(_, result, context)
      local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })[1]
          or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })[1]
          or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'typescript-tools' })[1]

      if not ts_client then
        -- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
        if retries <= 10 then
          retries = retries + 1
          vim.defer_fn(function()
            typescriptHandler(_, result, context)
          end, 100)
        else
          vim.notify(
            'Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.',
            vim.log.levels.ERROR
          )
        end
        return
      end

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = 'typescript.tsserverRequest',
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r and r.body } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify('tsserver/response', response_data)
      end)
    end

    client.handlers['tsserver/request'] = typescriptHandler
  end,
})

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

vim.lsp.config('copilot', {
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
vim.lsp.enable('copilot')

-- read :h vim.lsp.config for changing options of lsp servers
