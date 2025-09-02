local dap = require("dap")
dap.defaults.fallback.switchbuf = "usetab,uselast"

-- TODO: make sure to set path to your codelldb
local codelldbPath = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb"
local liblldbPath = "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/Current/LLDB"
local xcodebuild = require("xcodebuild.integrations.dap")
xcodebuild.setup(codelldbPath, liblldbPath)

local define = vim.fn.sign_define
define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Javascript Debugger",
    program = "${file}",
    cwd = "${workspaceFolder}"
  },
}

local dapDebugServer = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter"
dap.adapters.pwa-node = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      dapDebugServer,
      "${port}"
    },
  },
}
