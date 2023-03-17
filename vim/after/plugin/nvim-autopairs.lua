require('nvim-autopairs').setup({})

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
local npairs = require('nvim-autopairs')
npairs.add_rules({
    Rule("f'", "'", "python")
        :with_pair(cond.not_after_regex("'")),
    Rule("r'", "'", "python")
        :with_pair(cond.not_after_regex("'")),
    Rule("b'", "'", "python")
        :with_pair(cond.not_after_regex("'")),
})
