dofile(vim.g.base46_cache .. "lsp")
local base = require("plugins.configs.lspconfig")

local on_attach = base.on_attach
local capabilities = base.capabilities
local sourcekit_capabilities = capabilities
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
    on_save = false,
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

lspconfig.copilot.setup {{
  init_options = {
    editorInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
    editorPluginInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
  },
  cmd = { "copilot-language-server", "--stdio" },
  root_markers = { '.git' },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)

    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignIn', function()
      sign_in(bufnr, client)
    end, { desc = 'Sign in Copilot with GitHub' })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignOut', function()
      sign_out(bufnr, client)
    end, { desc = 'Sign out Copilot with GitHub' })
  end,
  settings = {
    telemetry = {
      telemetryLevel = 'off',
    },
  },
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  init_options = { hostInfo = 'neovim' },
  cmd = { 'typescript-language-server', '--stdio' },
  formatting = {
    on_save = false,
  },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
  root_dir = function(bufnr, on_dir)
    -- The project root is where the LSP can be started from
    -- As stated in the documentation above, this LSP supports monorepos and simple projects.
    -- We select then from the project root, which is identified by the presence of a package
    -- manager lock file.
    local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
    -- Give the root markers equal priority by wrapping them in a table
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers } or root_markers
    local project_root = vim.fs.root(bufnr, root_markers)
    if not project_root then
      return
    end

    on_dir(project_root)
  end,
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)

    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, {})
  end,
  capabilities = capabilities,
  handlers = {
    -- handle rename request for certain code actions like extracting functions / types
    ['_typescript.rename'] = function(_, result, ctx)
      local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
      vim.lsp.util.show_document({
        uri = result.textDocument.uri,
        range = {
          start = result.position,
          ['end'] = result.position,
        },
      }, client.offset_encoding)
      vim.lsp.buf.rename()
      return vim.NIL
    end,
  },
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
  formatting = {
    on_save = false,
  },
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

lspconfig.html.setup {
  capabilities = capabilities
}

