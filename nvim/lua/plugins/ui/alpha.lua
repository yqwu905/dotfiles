return {
  'goolord/alpha-nvim',
  config = function ()
    local present, alpha = pcall(require, 'alpha')

    if not present then
      return
    end

    local ascii = {
      ' ⡿⠋⠄⣀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠻⣿⣿ ',
      ' ⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿ ',
      ' ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠹ ',
      ' ⣿⣿⡟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿⣿⡆ ',
      ' ⡟⢻⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣣⠄⡀⢬⣭⣻⣷⡌⢿⣿⣿⣿⣿⣿ ',
      ' ⠃⣸⡀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⣆⢹⣿⣿⣿⡈⢿⣿⣿⣿⣿ ',
      ' ⠄⢻⡇⠄⢛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣆⠸⣆⠙⠛⠛⠃⠘⣿⣿⣿⣿ ',
      ' ⠄⠸⣡⠄⡈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⣠⣉⣤⣴⣿⣿⠿⠿⠿⡇⢸⣿⣿⣿ ',
      ' ⠄⡄⢿⣆⠰⡘⢿⣿⠿⢛⣉⣥⣴⣶⣿⣿⣿⣿⣻⠟⣉⣤⣶⣶⣾⣿⡄⣿⡿⢸ ',
      ' ⠄⢰⠸⣿⠄⢳⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⡇⢻⡇⢸ ',
      ' ⢷⡈⢣⣡⣶⠿⠟⠛⠓⣚⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⠇⠘ ',
      ' ⡀⣌⠄⠻⣧⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⡟⠘⠄⠄ ',
      ' ⣷⡘⣷⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⣠⣤⣶⣶⣾⡆⣿⣿⣿⠟⠁⠄⠄⠄⠄ ',
      ' ⣿⣷⡘⣿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣿⣿⣿⣿⣷⡿⠟⠉⠄⠄⠄⠄⡄⢀ ',
      ' ⣿⣿⣷⡈⢷⡀⠙⠛⠻⠿⠿⠿⠿⠿⠷⠾⠿⠟⣛⣋⣥⣶⣄⠄⢀⣄⠹⣦⢹⣿ ',
    }

    local header = {
      type = 'text',
      val = ascii,
      opts = {
        position = 'center',
        hl = 'Type',
      },
    }

    local function button(sc, txt, keybind)
      local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

      local opts = {
        position = 'center',
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 36,
        align_shortcut = 'right',
        hl = 'Type',
      }

      if keybind then
        opts.keymap = {'n', sc_, keybind, {noremap = true, silent = true}}
      end

      return {
        type = 'button',
        val = txt,
        on_press = function ()
          local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
          vim.api.nvim_feedkeys(key, 'normal', false)
        end,
        opts = opts,
      }
    end

    local buttons = {
      type = 'group',
      val = {
        button('SPC f f', '  Find File  ', ':Telescope find_files<CR>'),
        button('SPC f r', '  Recent File  ', ':Telescope oldfiles<CR>'),
        button('SPC f w', '  Find Word  ', ':Telescope live_grep<CR>'),
        button(
          'SPC f o',
          '  Neorg File',
          '<cmd>lua require("telescope.builtin").find_files({search_dirs={"~/repos/notes"}})<cr>'
        ),
        button('SPC b m', '  Bookmarks  ', ':Telescope marks<CR>'),
        button('SPC t h', '  Themes  ', ':Telescope themes<CR>'),
        button('SPC e c', '  Settings', ':e $MYVIMRC | :cd %:p:h <CR>'),
      },
      opts = {
        spacing = 1,
      },
    }

    local section = {
      header = header,
      buttons = buttons,
    }

    alpha.setup({
      layout = {
        {type = 'padding', val = 5},
        section.header,
        {type = 'padding', val = 2},
        section.buttons,
      },
      opts = {},
    })
  end,
}
