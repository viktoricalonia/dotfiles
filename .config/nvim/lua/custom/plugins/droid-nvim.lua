-- lazy.nvim (recommended: pin to a specific version)
return {
  "rizukirr/droid-nvim",
  ft = { "kotlin", "java", "groovy", "xml" },
  config = function()
    require("telescope").load_extension("ui-select")

    local droid = require('droid')
    droid.setup({
      lsp = { enabled = false }, -- Master toggle for all LSPs },
      logcat = {
        mode = "horizontal",     -- "horizontal" | "vertical" | "float"
        height = 15,
        filters = {
          package = "mine", -- "mine" (auto-detect) or specific package
          log_level = "v",  -- v, d, i, w, e, f
        },
      },
      -- android-cli backend. "auto" uses the `android` binary if on PATH,
      -- true forces it (warns when missing), false disables it entirely.
      -- When active, droid-nvim routes emulator management, :DroidRun
      -- deploy, screenshots, and KB docs through android-cli. :DroidInstall
      -- stays on gradle (android run cannot install without launching).
      android_cli = "auto",
    })

    -- DAP Integration
    local dap = require("dap")
    dap.adapters.intellij_debugger = require("droid.lsp.dap").adapter()
    dap.configurations.kotlin = require("droid.lsp.dap").default_configs()

    -- Setup Mappings
    require("core.utils").load_mappings("droid")
  end,
}
