local DEBUG = false
f = 0
        
function readCSV(data)
   local  m = data
    local t = {}                   -- table to store the indices
    local idx = 0
    local idx2 = 0
    local i = 0
    local brk = 0
    
    while true do
        brk = string.find(m,"\n",idx2)
        i= string.find(m, ",",idx)    -- find 'next' newline
          if i == nil then 

            if brk == string.find(m,"\n",#m) then
                local txt = string.sub(m,idx,#m -1)
                table.insert(t,txt)
                break
            end
        local txt = string.sub(m,idx,#m)
        table.insert(t,txt)
        break 
        end
            if brk >=idx and brk <= i then
                --print("loaded")
                idx2 = brk+1
                local txt = string.sub(m,idx,brk-1)
                table.insert(t,txt)
                idx = brk+1
                txt = "brk"
                table.insert(t,txt)
                txt = string.sub(m,idx,i-1)
                table.insert(t,txt) 
            idx=i+1 
        else
            local txt = string.sub(m,idx,i-1)
              table.insert(t, txt)
            idx = i+1
            
        end
    end
    --table.insert(t,"brk")
    debugf(DEBUG,dump,t)
    return t
end

function getFile(file)
    
    
    http.request(file,didGetData)
    print("f is "..f)
    
    print("returning F")
    return f
end

function didGetData(data,status,head)
    print(status)
        f = data
        print("File Request Sucess!")
        
    end

