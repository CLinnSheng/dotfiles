return {
  'lewis6991/gitsigns.nvim',
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },

    signs_staged = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },

    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Git Blame
      map("n", "<leader>gB", function() gs.blame_line( {full = true }) end, "Blame line")
      map("n", "<leader>gd", function() gs.diffthis("~") end, "Git Diff") -- In future will change, now just diff with the latest commit

    end,
  },
}
