return {
  -- run tests
  {
    'klen/nvim-test',
    config = function()
      require('nvim-test').setup {}
      require('nvim-test.runners.jest'):setup {
        command = './node_modules/.bin/vitest',
      }
    end,
  },

  -- debugging:
  -- NOTE: requires installing codelldb via Mason!
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()

      -- ui tweaks:
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
      vim.fn.sign_define('DapStopped', { text = '🟡', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

      -- Run dap-ui whenever dap is run:
      local dap, dapui = require 'dap', require 'dapui'
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
