return {
  'brianhuster/live-preview.nvim',
  dependencies = { 'folke/snacks.nvim' },

  keys = {
    {
      "<leader>lp", -- keybind
      ":LivePreview start<CR>", -- command to execute
      mode = "n", -- normal mode
      desc = "Run LivePreivew", -- helpful description for which-key
    },
  },
}
