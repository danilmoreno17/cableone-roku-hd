Function ParseXMLContent(list As Object)
    RowItems = createObject("RoSGNode","ContentNode")
    
    for each rowAA in list
        row = ContentList2Node(rowAA.ContentList)
        row.Title = rowAA.Title
        RowItems.appendChild(row)
    end for

    return RowItems
End Function
function ContentList2Node(contentList as Object) as Object
    result = createObject("roSGNode","ContentNode")
   
    for each itemAA in contentList
    
        item = createObject("roSGNode", "ContentNode")
        item.SetFields(itemAA)
        result.appendChild(item)
        
    end for
    
    return result
end function
function ContentList3Node(contentList as Object) as Object 
    
     'Populate the RowList content here
        data = CreateObject("roSGNode", "ContentNode")
        for numRows = 0 to 3
            row = data.CreateChild("ContentNode")
            row.title = "Categoria " + stri(numRows)
              for each itemAA in contentList
                item = row.CreateChild("SimpleRowListItemData")
                item.posterUrl = itemAA.hdposterurl
                item.labelText = itemAA.title
           end for
        end for
            return data
end function

Function GetApiArray()
    url = CreateObject("roUrlTransfer")
    url.SetUrl("http://api.delvenetworks.com/rest/organizations/59021fabe3b645968e382ac726cd6c7b/channels/1cfd09ab38e54f48be8498e0249f5c83/media.rss")
    rsp = url.GetToString()
    'print rsp
    responseXML = ParseXML(rsp)
    If responseXML <> invalid then
         responseXML   = responseXML.GetChildElements()
         responseArray = responseXML.GetChildElements()
    End if     

    result = []
    for each xmlItem in responseArray
        if xmlItem.getName() = "item"
            itemAA = xmlItem.GetChildElements()
            if itemAA <> invalid
                item = {}
                
                for each xmlItem in itemAA
                    item[xmlItem.getName()] = xmlItem.getText()
                    item.textName =  xmlItem.getText()
                   ' print item
                    if xmlItem.getName() = "media:content"
                        item.stream = {url : xmlItem.url}
                        item.url = xmlItem.getAttributes().url
                        item.streamFormat = "mp4"
                         
                        
                        mediaContent = xmlItem.GetChildElements()
                        for each mediaContentItem in mediaContent
                            if mediaContentItem.getName() = "media:thumbnail"
                                item.HDPosterUrl = "http://nagr.tmsimg.com/assets/p7895607_b1t_v5_aa.jpg"  'mediaContentItem.getattributes().url
                                item.hdBackgroundImageUrl = "http://nagr.tmsimg.com/assets/p7895607_b1t_v5_aa.jpg"'"https://upload.wikimedia.org/wikipedia/commons/8/8e/Eyjafjallaj%C3%B6kull.jpeg"     
                            end if
                        end for
                    end if
                end for
                result.push(item)
            end if
        end if
    end for
    
    return result
End Function


Function ParseXML(str As String) As dynamic
    if str = invalid return invalid
    xml = CreateObject("roXMLElement")
    if not xml.Parse(str) return invalid
    return xml
End Function