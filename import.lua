-- Import code
print("--Houser Library--\nUse hlib.help.info()")
import = {}
hlib = {}
hlib.help = {}
import.imported = {}
import.libraries = {}

import.finished = function ()
    import.libraries = {}
end

import.all = function ()
    for _,v in pairs(import.libraries) do
        v()
    end
    import.libraries = {}
end

import.library = function(f)
    if type(f) == "string" then
        if import.libraries[f] then
            import.libraries[f]()
            import.libraries[f] = nil
            table.insert(import.imported,f)
        end
    elseif type(f) == "table" then
        for _,v in ipairs(f) do
            if import.libraries[v] then
                import.libraries[v]()
                import.libraries[v] = nil
                table.insert(import.imported,v)
            end
        end
    end
end
