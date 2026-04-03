local M = {}

M.general = {
  n = {
    -- quick fix
    ["<C-q>"] = {
      function()
        local qf_exists = false
        for _, win in pairs(vim.fn.getwininfo()) do
          if win["quickfix"] == 1 then
            qf_exists = true
          end
        end
        if qf_exists == true then
          vim.cmd "cclose"
          return
        end
        if not vim.tbl_isempty(vim.fn.getqflist()) then
          vim.cmd "copen"
        end
      end,
      "Toggle Quickfix window"
    },

    -- close buffers
    ["<leader>xx"] = { "<cmd> bufdo bd <CR>", "Close Buffers" },
  }
}

M.dap = {
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

    ["<leader>dud"] = { function() require("xcodebuild.integrations.dap").build_and_debug() end, "Build and Debug" },
    ["<leader>dur"] = { function() require("xcodebuild.integrations.dap").debug_without_build() end, "Debug Without Building" },
    ["<leader>dut"] = { function() require("xcodebuild.integrations.dap").debug_tests() end, "Debug Tests" },
    ["<leader>duT"] = { function() require("xcodebuild.integrations.dap").debug_class_tests() end, "Debug Class Tests" },
    ["<leader>dub"] = { function() require("xcodebuild.integrations.dap").toggle_breakpoint() end, "Toggle Breakpoint" },
    ["<leader>duB"] = { function() require("xcodebuild.integrations.dap").toggle_message_breakpoint() end, "Toggle Message Breakpoint" },
    ["<leader>dux"] = { function()
      require("xcodebuild.integrations.dap").terminate_session()
      require("dap").listeners.after["event_terminated"]["me"]()
    end,
      "Terminate Debugger"
    }
  },
}

M.xcodebuild = {
  n = {
    -- Xcodebuild
    ["<leader>uy"] = {
      "<cmd>XcodebuildPicker<CR>",
      "Show Xcodebuild Actions"
    },
    ["<leader>uyf"] = {
      "<cmd>XcodebuildProjectManager<CR>",
      "Show Project Manager Actions"
    },

    ["<leader>uyb"] = {
      "<cmd>XcodebuildBuild<CR>",
      "Build Project"
    },
    ["<leader>uyB"] = {
      "<cmd>XcodebuildBuildForTesting<CR>",
      "Build For Testing"
    },
    ["<leader>uyr"] = {
      "<cmd>XcodebuildBuildRun<CR>",
      "Build & Run Project"
    },

    ["<leader>uyt"] = {
      "<cmd>XcodebuildTest<CR>",
      "Run Tests"
    },
    ["<leader>uyT"] = {
      "<cmd>XcodebuildTestClass<CR>",
      "Run This Test Class"
    },

    ["<leader>uyl"] = {
      "<cmd>XcodebuildToggleLogs<CR>",
      "Togggle Xcodebuild Logs"
    },
    ["<leader>uycc"] = {
      "<cmd>XcodebuildToggleCodeCoverage<CR>",
      "Togggle Code Coverage"
    },
    ["<leader>uye"] = {
      "<cmd>XcodebuildShowCodeCoverageReport<CR>",
      "Show Code Coverage Report"
    },
    ["<leader>uys"] = {
      "<cmd>XcodebuildFailingSnapshots<CR>",
      "Show Failing Snapshots"
    },

    ["<leader>uyd"] = {
      "<cmd>XcodebuildSelectDevice<CR>",
      "Select Device"
    },
    ["<leader>uyp"] = {
      "<cmd>XcodebuildSelectTestPlan<CR>",
      "Select Test Plan"
    },
    ["<leader>uyq"] = {
      "<cmd>Telescope quickfix<CR>",
      "Show QuickFix List"
    },


    ["<leader>uyx"] = {
      "<cmd>XcodebuildQuickfixLine<CR>",
      "Quickfisx Line"
    },
    ["<leader>uya"] = {
      "<cmd>XcodebuildCodeActions<CR>",
      "Show code Actions"
    },
    ["<leader>uyo"] = {
      "<cmd>XcodebuildOpenInXcode<CR>",
      "Show code Actions"
    },
    ["<leader>uyte"] = {
      "<cmd>XcodebuildTestExplorerToggle<CR>",
      "Toggle XcodeBuild Test Explorer"
    },
    ["<leader>uyc"] = {
      "<cmd>XcodebuildCancel<CR>",
      "Cancel Running Action"
    }
  },
  v = {
    ["<leader>uyt"] = {
      "<cmd>XcodebuildTestSelected<CR>",
      "Run Selected Tests"
    },
  }
}

M.harpoon = {
  n = {
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find symbols in current buffer" },

    ["<leader>a"] = { function() require("harpoon"):list():add() end, "Add file to harpoon" },
    ["<C-e>"] = { function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, "List of harpoon files" },

    ["<C-h>"] = { function() require("harpoon"):list():select(1) end, "Navigate to harpoon file 1" },
    ["<C-j>"] = { function() require("harpoon"):list():select(2) end, "Navigate to harpoon file 2" },
    ["<C-k>"] = { function() require("harpoon"):list():select(3) end, "Navigate to harpoon file 3" },
    ["<C-l>"] = { function() require("harpoon"):list():select(4) end, "Navigate to harpoon file 4" },

    ["<C-y>"] = { function() require("harpoon"):list():prev() end, "Toggle previous buffer stored in harpoon" },
    ["<C-;>"] = { function() require("harpoon"):list():next() end, "Toggle next buffer stored in harpoon" }
  }
}

M.claude = {
  n = {
    ["<leader>cl"] = { "<cmd> ClaudeCode <CR>", "Claude Code" },
    ["<leader>cR"] = { "<cmd> ClaudeCodeRefactor <CR>", "Claude Code Refactor" },
  }
}

M.CopilotChat = {
  n = {
    ["<leader>ccc"] = { "<cmd> CopilotChatToggle <CR>", "Copilot Chat Toggle" }
  }
}

M.gitsigns = {
  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

return M
