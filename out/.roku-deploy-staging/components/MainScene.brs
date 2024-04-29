sub init()
m.rows = m.top.findNode("rows")

content = CreateObject("roSGnode", "contentNode")
content.update({children: [
    CreateObject("roSGnode", "contentNode"),
    CreateObject("roSGnode", "contentNode"),
    CreateObject("roSGnode", "contentNode"),
    CreateObject("roSGnode", "contentNode")  ,
    ' CreateObject("roSGnode", "contentNode") ,
    ' CreateObject("roSGnode", "contentNode")  ,
]}, true)

m.rows.content = content
m.rows.setFocus(true)
end sub