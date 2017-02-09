' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
 
 sub RunUserInterface()
 'Se crea la escena
    screen = CreateObject("roSGScreen")
    scene = screen.CreateScene("HomeScene")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    screen.Show()   
    
'Se aniaden data de los menus    
    LabelList = [
        {title : "Movies"},
        {title : "Series"},
        {title : "Guide"},
        {title : "Search"}
    ]
'Data del menu play  
    OptionsList = [{Title:"Play"}]     
            
    scene.Content = ContentList3Node(GetApiArray())
    scene.LabelContent = ContentList2Node(LabelList)
    scene.OptionsContent = ContentList2Node(OptionsList)
    
    while true
        msg = wait(0, port)
        print "------------------"
        print "msg = "; msg
    end while
    
    if screen <> invalid then
        screen.Close()
        screen = invalid
    end if
    
end sub


