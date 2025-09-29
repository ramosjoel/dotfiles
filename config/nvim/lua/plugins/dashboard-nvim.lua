-- Function to grab the hostname of the machine.
local _M = {}
function _M.getHostname()
    local f = io.popen("/bin/hostname")
    if not f then
        return ""
    end
    local hostname = f:read("*a") or ""
    f:close()
    hostname = string.gsub(hostname, "\n$", "")
    return hostname
end

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      -- config
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        footer =
          function()
            if _M.getHostname() == 'MAC-JRAMOS' then
              return {
              '',
              '  GoodRx - Joel Ramos'
            }
            else
              return {
                '',
                '  Personal - Joel Ramos'
              }
            end
          end,
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Singularity',
            group = 'DashboardShortCut',
            action = 'cd ~/GoodRx/singularity',
            key = 'a',
          },
          {
            desc = ' Maestro',
            group = 'DashboardShortCut',
            action = 'cd ~/GoodRx/maestro-e2e-tests',
            key = 'm',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'cd ~/.dotfiles',
            key = 'd',
          },
        },
      },
    })
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
