-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    'nvim-telescope/telescope-dap.nvim',
    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    local widgets = require('dap.ui.widgets')
    return {

      -- Basic debugging keymaps, feel free to change to your liking!
      { '<leader>dd', dap.continue, desc = 'Debug: Start/Continue' },
      { '<leader>de', dapui.close },
      { '<leader>dr', dap.repl.open, desc='Open repl'},
      { '<leader>jj', dap.step_over, desc = 'Debug: Step Over' },
      { '<leader>jl', dap.step_into, desc = 'Debug: Step Into' },
      { '<leader>jk', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      { '<leader>dbc', dap.clear_breakpoints, desc = 'Debug: Clear Toggle Breakpoint' },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {'<leader>dh', widgets.hover, mode={'n','v'}},

      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    require("dapui").setup(
        {
            controls = {
              element = "repl",
              enabled = true,
              icons = {
                disconnect = "",
                pause = "",
                play = "",
                run_last = "",
                step_back = "",
                step_into = "",
                step_out = "",
                step_over = "",
                terminate = ""
              }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
              border = "single",
              mappings = {
                close = { "q", "<Esc>" }
              }
            },
            force_buffers = true,
            icons = {
              collapsed = "",
              current_frame = "",
              expanded = ""
            },
            -- layouts = { {
            --     elements = { {
            --         id = "scopes",
            --         size = 0.25
            --       },{
            --         id = "stacks",
            --         size = 0.25
            --       }, {
            --         id = "watches",
            --         size = 0.25
            --       } },
            --     position = "left",
            --     size = 40
            --   }, {
            --     elements = { {
            --         id = "repl",
            --         size = 0.5
            --       }, {
            --         id = "console",
            --         size = 0.5
            --       } },
            --     position = "bottom",
            --     size = 10
            --   } },
            layouts = { {
                elements = { {
                    id = "scopes",
                    size = 1.0
                  }},
                position = "left",
                size = 30
              }, {
                elements = { {
                    id = "repl",
                    size = 0.8
                  }
                },
                position = "bottom",
                size = 15
              } },
            mappings = {
              edit = "e",
              expand = { "<CR>", "<2-LeftMouse>" },
              open = "o",
              remove = "d",
              repl = "r",
              toggle = "t"
            },
            render = {
              indent = 1,
              max_value_lines = 100
            }
          }
        )
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end
}
