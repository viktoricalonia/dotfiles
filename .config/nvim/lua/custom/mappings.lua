local M = {}

M.dap = {
  plugin = true,
  n = {
    -- DAP
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },

    -- Xcodebuild
    ["<leader>xc"] = {
      "<cmd>XcodebuildPicker<CR>",
      "Show Xcodebuild Actions"
    },
    ["<leader>xcf"] = {
      "<cmd>XcodebuildProjectManager<CR>",
      "Show Project Manager Actions"
    },

    ["<leader>xcb"] = {
      "<cmd>XcodebuildBuild<CR>",
      "Build Project"
    },
    ["<leader>xcB"] = {
      "<cmd>XcodebuildBuildForTesting<CR>",
      "Build For Testing"
    },
    ["<leader>xcr"] = {
      "<cmd>XcodebuildBuildRun<CR>",
      "Build & Run Project"
    },

    ["<leader>xct"] = {
      "<cmd>XcodebuildTest<CR>",
      "Run Tests"
    },
    ["<leader>xcT"] = {
      "<cmd>XcodebuildTestClass<CR>",
      "Run This Test Class"
    },

    ["<leader>xcl"] = {
      "<cmd>XcodebuildToggleLogs<CR>",
      "Togggle Xcodebuild Logs"
    },
    ["<leader>xcc"] = {
      "<cmd>XcodebuildToggleCodeCoverage<CR>",
      "Togggle Code Coverage"
    },
    ["<leader>xce"] = {
      "<cmd>XcodebuildShowCodeCoverageReport<CR>",
      "Show Code Coverage Report"
    },
    ["<leader>xcs"] = {
      "<cmd>XcodebuildFailingSnapshots<CR>",
      "Show Failing Snapshots"
    },

    ["<leader>xcd"] = {
      "<cmd>XcodebuildSelectDevice<CR>",
      "Select Device"
    },
    ["<leader>xcp"] = {
      "<cmd>XcodebuildSelectTestPlan<CR>",
      "Select Test Plan"
    },
    ["<leader>xcq"] = {
      "<cmd>Telescope quickfix<CR>",
      "Show QuickFix List"
    },


    ["<leader>xcx"] = {
      "<cmd>XcodebuildQuickfixLine<CR>",
      "Quickfisx Line"
    },
    ["<leader>xca"] = {
      "<cmd>XcodebuildCodeActions<CR>",
      "Show code Actions"
    },
  },
  v = {
    ["<leader>xct"] = {
      "<cmd>XcodebuildTestSelected<CR>",
      "Run Selected Tests"
    },
  }

}

return M
