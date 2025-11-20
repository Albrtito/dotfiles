function getKeyByValue(filename, targetValue)
    local valueToKey = {}

    -- Read and parse the file
    local file = io.open(filename, "r")
    if not file then
        error("Could not open file: " .. filename)
    end

    for line in file:lines() do
        local value, key = line:match("^(.-)=(.-)$")
        if value and key then
            valueToKey[value] = key
        end
    end
    file:close()

    -- Return the key for the given value
    return valueToKey[targetValue]
end

function loadValueKeyMap(filename)
    local valueToKey = {}
    local file = io.open(filename, "r")

    if not file then
        error("Could not open file: " .. filename)
    end

    for line in file:lines() do
        -- Trim whitespace and split on first '='
        line = line:match("^%s*(.-)%s*$") -- trim whitespace
        local value, key = line:match("^(.-)=(.-)$")
        if value and key then
            valueToKey[value] = key
        end
    end
    file:close()

    return valueToKey
end
