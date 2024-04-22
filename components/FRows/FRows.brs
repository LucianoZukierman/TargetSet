function init()
    
         setUpRefs()

         focusedTargetSet1 = createObject("roSGNode", "TargetSet")
          focusedTargetSet2 = createObject("roSGNode", "TargetSet")
          focusedTargetSet3 = createObject("roSGNode", "TargetSet")
          focusedTargetSet4 = createObject("roSGNode", "TargetSet")
          m.targetList.focusedTargetSet = [ focusedTargetSet1, focusedTargetSet2, focusedTargetSet3, focusedTargetSet4 ]


        marginLong = 100
        marginShort = 24

        focusedTargetSet1.targetRects = [
        	                  { x:96,  y:44,  width:1920 -96, height:100 },
	                          { x:96,  y:44 + 100 + marginLong,  width:1920 -96, height:100 },
                              { x:96,  y:(44 + 100 + marginLong) + 100 + marginShort,  width:1920-96, height:100 },
	                          { x:96,  y:((44 + 100 + marginLong) + 100 + marginShort) + 100 + marginShort,  width:1920-96, height:100 }
				]
	      focusedTargetSet1.color = "0x00202020AA"
          focusedTargetSet1.focusIndex = 0

          focusedTargetSet2.targetRects = [
            { x:96,  y:-100 - 44,  width:1920 -96, height:100 },
            { x:96,  y:44 ,  width:1920 -96, height:100 },
            { x:96,  y:(44 + 100 + marginLong),  width:1920-96, height:100 },
            { x:96,  y:(44 + 100 + marginLong) + 100 + marginShort,  width:1920-96, height:100 }
]
        focusedTargetSet2.color = "0x00202020AA"
        focusedTargetSet2.focusIndex = 1

        
        focusedTargetSet3.targetRects = [
            { x:96,  y:-100 - 44,  width:1920 -96, height:100 },
            { x:96,  y:-100 - 44 ,  width:1920 -96, height:100 },
            { x:96,  y:44,  width:1920-96, height:100 },
            { x:96,  y:44 + 100 + marginLong,  width:1920-96, height:100 }
]
        focusedTargetSet3.color = "0x00202020AA"
        focusedTargetSet3.focusIndex = 2


        focusedTargetSet4.targetRects = [
            { x:96,  y:-100 - 44,  width:1920 -96, height:100 },
            { x:96,  y:-100 - 44 ,  width:1920 -96, height:100 },
            { x:96,  y:-100 - 44 ,  width:1920-96, height:100 },
            { x:96,  y:44,  width:1920-96, height:100 }
]
        focusedTargetSet4.color = "0x00202020AA"
        focusedTargetSet4.focusIndex = 3




        unfocusedTargetSet = createObject("roSGNode", "TargetSet")
        m.targetList.unfocusedTargetSet = unfocusedtargetSet

        unfocusedTargetSet.targetRects = [
            { x:96,  y:44,  width:1920 -96, height:100 },
            { x:96,  y:44 + 100 + marginLong,  width:1920 -96, height:100 },
            { x:96,  y:(44 + 100 + marginLong) + 100 + marginShort,  width:1920-96, height:100 },
            { x:96,  y:((44 + 100 + marginLong) + 100 + marginShort) + 100 + marginShort,  width:1920-96, height:100 }

				]
	      unfocusedTargetSet.color = "0x00202020AA"

         m.targetList.targetSet = focusedTargetSet1
         m.targetList.showTargetRects = true
	     m.targetList.itemComponentName = "SimpleItemComponent"

        dataModel = setUpDataModel()
         m.targetList.content = dataModel



        m.targetList.setFocus(true)

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
        targetRectsArray = []

        for i = 0 to childrenContent.count() - 1
            
            targetRects = getFirstTargetRectsItem(childrenContent, i)
            targetRectsArray.push(targetRects)

        end for

        ' setUpList(firstTargetRects)
    end sub


function getFirstTargetRectsItem(childrenContent as object, focusIndex as integer) as object
    
    leftMargin = 96
    targetRects = []
    yPos= m.top.marginTop
    marginLong = 100
    marginShort = 24
    margin = marginShort
    for i = 0 to childrenContent.count() - 1
        if i + 1 = focusIndex + 1  then margin = marginLong else margin = marginShort
        if i < focusIndex then yPos = -100 - m.top.marginTop
        if i = focusIndex then yPos = m.top.marginTop
        
      targetRects.push({ x: leftMargin, y: yPos, width:1920 -96, height:100  })
      yPos += 100 + margin
    end for
    return targetRects
end function

    ' sub setUpList(targetRects as object, childrenContent as object)
    '     focusedArray = []
    ' for i = 0 to childrenContent.count() - 1
    '   targetSet = createObject("roSGNode", "TargetSet")
    '   if (targetRects[i].y + targetRects[i].height) > m.top.height then redefineTargetSet(i)
    '   targetSet.targetRects = targetRects
    '   targetSet.color = m.top.targetSetColor
    '   targetSet.focusIndex = i
    '   focusedArray.push(targetSet)
    ' end for
  
    ' m.targetList.focusedTargetSet = focusedArray
    ' m.unfocusedTargetRects = focusedArray
  
    ' ' The unfocusedTargetSet is fetched according to the current focused item,
    ' ' using the jumpToFilterItem as an index to get it from the previously defined unfocusedTargetRects variable.
    ' if m.top.animateToItem < m.childrenContent.count()
    '   animateToItem = m.top.animateToItem
    ' else
    '   animateToItem = 0
    ' end if
  
    ' targetSet = createObject("roSGNode", "TargetSet")
    ' targetSet.targetRects = m.unfocusedTargetRects[animateToItem].targetRects
    ' targetSet.color = m.top.targetSetColor
    ' m.targetList.targetSet = targetSet
    ' m.targetList.unfocusedTargetSet = targetSet
  
    ' m.targetList.showTargetRects = true
  
    ' m.targetList.content = m.content
    ' end sub

    function isNode(val as dynamic, subtype = "" as string) as boolean
        return val <> invalid and type(val) = "roSGNode" and (ucase(val.subtype()) = ucase(subtype) or subtype = "")
    end function

