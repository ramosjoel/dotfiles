-- Function to grab the hostname of the machine.
local _M = {}
function _M.getHostname()
    local f = io.popen ("/bin/hostname")
    if not f then
        return ""
    end
    local hostname = f:read("*a") or ""
    f:close()
    hostname =string.gsub(hostname, "\n$", "")
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

-- GitHub Copilot'
return {
  'github/copilot.vim',
  -- Only load on work machine
  enabled = _M.isWorkMachine()
}
