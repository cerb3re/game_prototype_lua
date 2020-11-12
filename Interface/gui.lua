local gui = {}

function gui.newGroup()
  local myGroup = {}
  myGroup.elements = {}
  
  function myGroup:addElement(pElement)
    table.insert(self.elements, pElement)
  end
  
  function myGroup:setVisible(pVisible)
    for n,v in pairs(myGroup.elements) do
      v:setVisible(pVisible)
    end
  end
  
  function myGroup:draw()
    love.graphics.push()
    for n,v in pairs(myGroup.elements) do
      v:draw()
    end
    love.graphics.pop()
  end
    
  return myGroup
end

return gui