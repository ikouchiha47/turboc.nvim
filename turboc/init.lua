local M = {}

local base_colors = {
  background = '#06069e', -- Blue
  foreground = '#FFFFFF', -- White
  comment = '#55FF55', -- Light Green
  keyword = '#FF5555', -- Light Red
  string = '#FFFF55', -- Light Yellow
  number = '#55FFFF', -- Light Cyan
  type = '#AAAAFF', -- Light Blue
  identifier = '#f461f4', -- Light Magenta
}

local dracula_colors = {
  background = '#0000AA', -- Blue
  foreground = '#f8f8f2', -- Light Foreground
  comment = '#6272a4', -- Comment Blue
  keyword = '#ff79c6', -- Pink
  string = '#f1fa8c', -- Yellow
  number = '#bd93f9', -- Purple
  type = '#8be9fd', -- Cyan
  identifier = '#50fa7b', -- Green
}

local function treesitter_setup()
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
      custom_captures = {
        ['keyword'] = 'Keyword',
        ['string'] = 'String',
        ['number'] = 'Number',
        ['type'] = 'Type',
        ['identifier'] = 'Identifier',
        ['comment'] = 'Comment',
      },
    },
  }
end

M.modes = {
  base = base_colors,
  dracula = dracula_colors,
}

M.setup = function(opts)
  local mode = opts['mode'] or 'base'
  local colors = M.modes[mode] or M.modes.base

  -- print('turbo c theme mode ' .. mode)

  vim.cmd 'highlight clear'
  vim.cmd 'syntax reset'

  vim.cmd('highlight Normal guifg=' .. colors.foreground .. ' guibg=' .. colors.background)
  vim.cmd('highlight Comment guifg=' .. colors.comment)
  vim.cmd('highlight Keyword guifg=' .. colors.keyword)
  vim.cmd('highlight String guifg=' .. colors.string)
  vim.cmd('highlight Number guifg=' .. colors.number)
  vim.cmd('highlight Type guifg=' .. colors.type)
  vim.cmd('highlight Identifier guifg=' .. colors.identifier)
  vim.cmd('highlight SignColumn guibg=' .. colors.background)

  treesitter_setup()
end

return M
