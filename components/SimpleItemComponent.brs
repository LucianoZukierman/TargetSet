sub init()
        m.theRect  = m.top.findNode("theRect")
        ' m.theLabel = m.top.findNode("theLabel")
        m.focusColorInterp = m.top.findNode("focusColorInterp")
        m.focusColorInterp.fieldToInterp = "theRect.color"
    end sub

    ' function itemContentChanged()
    '     m.theLabel.text = m.top.itemContent.title
    ' end function

    function currTargetChanged()
        if m.top.index = 0
            print "currTarget for item "; m.top.index; " changed to "; m.top.currTarget
        end if
    end function

    function currRectChanged()
	      m.theRect.width = m.top.currRect.width
	      m.theRect.height = m.top.currRect.height
    end function

    function focusPercentChanged()
        print "focusPercent for item "; m.top.index; " changed to "; m.top.focusPercent
        if (m.top.groupHasFocus)
            m.focusColorInterp.fraction = m.top.focusPercent
        else
            m.focusColorInterp.fraction = 0
        end if
    end function
