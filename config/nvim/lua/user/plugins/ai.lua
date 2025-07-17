return {
  -- GitHub Copilot:
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  },

  -- own plugin
  -- {
  --   'superagent',
  --   dir = vim.fn.expand("~/dev/nvim/superagent"), -- test locally
  --   config = function()
  --     require('superagent').setup()
  --   end
  -- },

  -- Avante
  -- (AI chatbot):
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20240620",
        },
      },
      mappings = {
        ask = "<leader>al",
        edit = "<leader>ak",
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          none = "c0",
          both = "cb",
          next = "c]",
          prev = "c[",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<CR>",
        },
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below is optional, make sure to setup it properly if you have lazy=true
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

}
