local ls = require "luasnip"

ls.add_snippets("python", {
    ls.snippet("test", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        ls.insert_node(1, "cond"), ls.text_node(" ? "), ls.insert_node(2, "then"), ls.text_node(" : "), ls.insert_node(3, "else")
    })
})
