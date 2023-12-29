  -- change some telescope options and a keymap to browse plugin files
 return {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>ff",
        function() require("telescope.builtin").find_files() end,
        desc = "Find Plugin File",
      },
    },
}