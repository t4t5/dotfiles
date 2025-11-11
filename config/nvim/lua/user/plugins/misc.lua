return {
  -- respect camelcase/underscores
  { 'chaoren/vim-wordmotion' },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- So that you can paste inline with <leader>p
  'inkarkat/vim-UnconditionalPaste',

  -- change surrounding tags
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },

  'tpope/vim-dadbod',

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1

      -- Custom command to connect to a database URL and open DBUI
      vim.api.nvim_create_user_command('DBUIConnect', function(opts)
        vim.g.db = opts.args
        -- vim.notify('Connecting to: ' .. opts.args)
        vim.cmd('DBUI')
      end, {
        nargs = 1,
        desc = 'Connect to database URL and open DBUI',
        complete = 'file', -- Basic completion, you can customize this
      })

      -- Auto-navigate to first connection when DBUI opens
      vim.api.nvim_create_autocmd('User', {
        pattern = 'DBUIOpened',
        callback = function()
          -- Use defer_fn to ensure the buffer is fully rendered
          vim.defer_fn(function()
            -- Find and focus the DBUI window
            for i = 1, vim.fn.winnr('$') do
              local ft = vim.fn.getwinvar(i, '&filetype')
              if ft == 'dbui' then
                vim.cmd(i .. 'wincmd w')

                -- open first connection:
                vim.cmd('normal gg2jo')
                -- expand 'Schemas' (last item):
                vim.cmd([[execute "normal j\<C-j>o"]])
                -- expand 'public' (last item):
                vim.cmd([[execute "normal j\<C-j>o"]])

                -- vim.notify('Auto-expanded connection and schemas!')
                break
              end
            end
          end, 100)
        end,
      })
    end,
  },
}
