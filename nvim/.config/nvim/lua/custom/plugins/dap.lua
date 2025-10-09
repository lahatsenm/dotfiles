return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('dap-go').setup()

      -- This one is just a copy of tjdevries config file dap.lua
      require('nvim-dap-virtual-text').setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
            return '*****'
          end

          if #variable.value > 15 then
            return ' ' .. string.sub(variable.value, 1, 15) .. '... '
          end

          return ' ' .. variable.value
        end,
      }
      --------------------------------------------------------------

      -- Change the default breakpoint sign
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })

      -- bash debugger configuration
      dap.adapters.bashdb = {
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
        name = 'bashdb',
      }

      dap.configurations.sh = {
        {
          type = 'bashdb',
          request = 'launch',
          name = 'Launch file',
          showDebugOutput = true,
          pathBashdb = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
          pathBashdbLib = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
          trace = true,
          file = '${file}',
          program = '${file}',
          cwd = '${workspaceFolder}',
          -- cwd = vim.fn.getcwd(),
          pathCat = 'cat',
          pathBash = '/bin/bash',
          pathMkfifo = 'mkfifo',
          pathPkill = 'pkill',
          args = function()
            local args_string = vim.fn.input 'Arguments: '
            return vim.split(args_string, ' +')
          end,
          env = {},
          terminalKind = 'integrated',
        },
      }

      -- -- Set bash configurations as the same as sh configurations. I don't even know if this is necessary xD
      -- -- Come to think about it, this is not necessary for now xD
      -- dap.configurations.bash = dap.configurations.sh

      -- c/c++/rust debugger configurations
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          -- CHANGE THIS to your path!
          command = '/home/logos/.local/share/nvim/mason/bin/codelldb',
          args = { '--port', '${port}' },

          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      -- Use the same debugger configurations for c and rust.
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- go debugger configuration
      dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        },
      }

      -- elixir debugger configuration
      local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
      if elixir_ls_debugger ~= '' then
        dap.adapters.mix_task = {
          type = 'executable',
          command = elixir_ls_debugger,
        }

        dap.configurations.elixir = {
          {
            type = 'mix_task',
            name = 'phoenix server',
            task = 'phx.server',
            request = 'launch',
            projectDir = '${workspaceFolder}',
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
          },
        }
      end

      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint, { desc = '[DAP]: Toggle breakpoint' })
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor, { desc = '[DAP]: Run to cursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval()
      end, { desc = '[DAP]: Eval var under cursor' })

      vim.keymap.set('n', '<F5>', dap.continue)
      vim.keymap.set('n', '<F6>', dap.step_into)
      vim.keymap.set('n', '<F7>', dap.step_over)
      vim.keymap.set('n', '<F8>', dap.step_out)
      vim.keymap.set('n', '<F9>', dap.step_back)
      vim.keymap.set('n', '<F12>', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
