local M = {}

local turbo_pink = {
  background = '#000080', -- Blue
  foreground = '#FFFFFF', -- White
  comment = '#55FF55', -- Light Green
  keyword = '#FF5555', -- Light Red
  string = '#FFFF55', -- Light Yellow
  number = '#55FFFF', -- Light Cyan
  type = '#AAAAFF', -- Light Blue
  identifier = '#f461f4', -- Light Magenta
  cursorline = '#000050', -- Dark stuff
}

local miscl = {
  keyword = '#FFA500', -- Orange
  string = '#FFFF9C', -- Yellow
  comment = '#9EFF8E', -- Light green
  cursorline = '#333333', -- Dark gray
}

local turbo_green = {
  background = '#000080', -- Blue
  foreground = '#FFFFFF', -- White
  comment = '#008680',
  keyword = '#FFFFFF', -- Orange
  string = '#FFA500',
  number = '#f461f4', -- Light gray
  type = '#00FF00', -- Green
  identifier = '#50FA7B', -- White
  cursorline = '#000050', -- Dark stuff
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

  -- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  --   pattern = '*',
  --   callback = function()
  --     print 'calling here'
  --     if vim.api.nvim_buf_get_option(0, 'filetype') == 'markdown' then
  --       vim.opt_local.winhighlight = 'Normal:MarkdownBackground'
  --     end
  --   end,
  -- })
end

M.modes = {
  base = turbo_green,
  rose = turbo_pink,
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
  vim.cmd('highlight CursorLine guibg=' .. colors.cursorline .. 'guifg=fg')

  vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#008080', fg = '#000000' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#008080', fg = '#000000' })
  vim.api.nvim_set_hl(0, 'CmpNormal', { bg = '#FF0000' })

  treesitter_setup()
end

return M
