-- Neovim Plugin for using Codex AI CLI (ChatGPT).
-- https://github.com/johnseth97/codex.nvim

-- ### Usage:
-- - Call `:Codex` (or `:CodexToggle`) to open or close the Codex popup or side-panel.
-- - Map your own keybindings via the `keymaps.toggle` setting.
-- - To choose floating popup vs side-panel, set `panel = false` (popup) or `panel = true` (panel) in your setup options.
-- - To capture Codex output in an editable buffer instead of a terminal, set `use_buffer = true` (or `false` to keep terminal) in your setup options.
-- - Add the following code to show backgrounded Codex window in lualine:

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

function _M.isWorkMachine()
    io.write("Checking for work machine before loading copilot...\n")
    local result = _M.getHostname() == "MAC-JRAMOS"
    if result then
        io.write("Work machine detected. Loading copilot...\n")
    else
        io.write("Not a work machine. Skipping copilot...\n")
    end
end

return {
    'kkrampis/codex.nvim',
    lazy = true,
    enabled = _M.isWorkMachine(),
    cmd = { 'Codex', 'CodexToggle' }, -- Optional: Load only on command execution
    keys = {
        {
            '<leader>cc', -- Change this to your preferred keybinding
            function() require('codex').toggle() end,
            desc = 'Toggle Codex popup or side-panel',
            mode = { 'n', 't' }
        },
    },
    opts = {
        keymaps     = {
            toggle = nil,    -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
            quit = '<C-q>',  -- Keybind to close the Codex window (default: Ctrl + q)
        },                   -- Disable internal default keymap (<leader>cc -> :CodexToggle)
        border      = 'rounded', -- Options: 'single', 'double', or 'rounded'
        width       = 0.8,   -- Width of the floating window (0.0 to 1.0)
        height      = 0.8,   -- Height of the floating window (0.0 to 1.0)
        model       = nil,   -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
        autoinstall = true,  -- Automatically install the Codex CLI if not found
        panel       = false, -- Open Codex in a side-panel (vertical split) instead of floating window
        use_buffer  = false, -- Capture Codex stdout into a normal buffer instead of a terminal buffer
    },
}

