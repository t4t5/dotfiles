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
}
