local ls = require("luasnip")
local snip = ls.snippet
local func = ls.function_node

local today = function() return { os.date('%Y-%m-%d') } end

local tomorrow = function()
    local todayTime = os.time(os.date('*t'))
    -- Add one day (86400 seconds)
    local tomorowTime = todayTime + 86400
    return os.date('%Y-%m-%d', tomorowTime)
end

local yesterday = function()
    local todayTime = os.time(os.date('*t'))
    -- Subtract one day (86400 seconds)
    local yesterdayTime = todayTime - 86400
    return os.date('%Y-%m-%d', yesterdayTime)
end

ls.add_snippets(nil, {
    all = {
        snip({
            trig = "today",
            namr = "Today",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(today, {}),
        }),
        snip({
            trig = "tomorrow",
            namr = "Tomorrow",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(tomorrow, {}),
        }),
        snip({
            trig = "yesterday",
            namr = "Yesterday",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(yesterday, {}),
        }),
    },
})
