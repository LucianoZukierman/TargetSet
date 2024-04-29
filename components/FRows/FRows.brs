function init()
    
         setUpRefs()
 
   end function

    function setUpDataModel()
        contentRoot = createObject("roSGNode", "ContentNode")
	      for i = 0 to 1
            child = contentRoot.createChild("ContentNode")
            child.title = "Item " + i.tostr()
        end for
        return contentRoot
    end function

    
    sub onFocusedChanged()
        if m.top.hasFocus() and not m.targetList.isInFocusChanged() then m.targetList.setFocus(true)
    end sub

    sub onContentChanged()  
        content = m.top.content 
        if not isNode(content) then return
        m.childrenContent = content.getChildren(content.getChildCount(), 0 )
        setUpTargetRects(m.childrenContent)
    end sub

    sub setUpComponents()
    end sub

    sub setUpRefs()
        m.targetList = m.top.findNode("targetList")
    end sub

    sub setUpTargetRects(childrenContent as object)
       targetSetArray = []
        for i = 0 to childrenContent.count() - 1
            targetSet = createObject("roSGNode", "TargetSet")
            targetRects = getTargetRectByFocusIndex(childrenContent, i)
            targetSet.targetRects = targetRects
            targetSet.focusIndex = i
            targetSet.color = "0x00202020AA"
            targetSetArray.push(targetSet)
        end for
        m.targetList.targetSet = targetSetArray[0]
        m.targetList.focusedTargetSet = targetSetArray
        m.targetList.setFocus(true)
        m.targetList.showTargetRects = true
        m.targetList.itemComponentName = "SimpleItemComponent"
       dataModel = setUpDataModel()
        m.targetList.content = dataModel
    end sub


function getTargetRectByFocusIndex(childrenContent as object, focusIndex as integer) as object
    
    leftMargin = 96
    targetRects = []
    yPos= m.top.marginTop
    titleHeight = 100
    margin = 24

    ' contentHeight= calculateContentHeight(childrenContent,focusIndex, margin)
    
    for i = 0 to childrenContent.count() - 1
        if i < focusIndex  then yPos = -100 - m.top.marginTop
        if i = focusIndex 
            yPos = m.top.marginTop 
            height = 100 + titleHeight
        else height = 100
        end if
        
      targetRects.push({ x: leftMargin, y: yPos, width:1920 -96, height:height  })
      if i + 1 = focusIndex + 1 
         yPos += titleHeight + margin + 100 
        else
            yPos += margin + 100
      end if
    end for
    return targetRects
end function


function calculateContentHeight(childrenContent as object, focusIndex as integer, margin as integer ) as integer
' Estoy parado en el focuxIndex 1 , contentHeight es = height[1] 200px + height[2] 100px + height[3] 100px + marginSpace 24px + marginSpace 24px + m.top.margin 44px = 492
    contentHeight = 0
    height = 100
    heightFocus = 200
    for i = focusIndex to childrenContent.count() - 1
        ''continuar...
    return contentHeight
    end for
    end function

    function isNode(val as dynamic, subtype = "" as string) as boolean
        return val <> invalid and type(val) = "roSGNode" and (ucase(val.subtype()) = ucase(subtype) or subtype = "")
    end function

