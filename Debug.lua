
function debug(d,str)
   if d == true then print("---DEBUG Print---"); print(str) end 
end

function debugf(d,f, ...)
    if d == true then print("---debugf---"); return f(unpack(arg)) end
end
function debugd(d,t)
    if d == true then dump(t) end
end
