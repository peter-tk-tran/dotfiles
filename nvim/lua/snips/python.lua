local ls = require "luasnip"

ls.add_snippets("python", {
    ls.snippet("try", {
        -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
        -- ls.insert_node(1, "cond"), ls.text_node(" ? "), ls.insert_node(2, "then"), ls.text_node(" : "), ls.insert_node(3, "else")
        ls.text_node({"try:", ""}), ls.insert_node(1, "code"), ls.text_node("", "except"), ls.insert_node(2, "exception")
    })
})
-- ls.add_snippets("python", {
--     ls.snippet("isn", {
--         ls.isn(1, {
--             ls.text_node({"This is indented as deep as the trigger",
--             "and this is at the beginning of the next line"})
--         }, "")
--     })
-- })
