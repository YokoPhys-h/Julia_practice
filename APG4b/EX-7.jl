a = true
b = false
c = true

if a
    w1 = "At"
else
    w1 = "Yo"
end


if !a && b
    w2 = "Bo"
elseif !b || c
    w2 = "Co"
end
if a && b && c
    w3 = "foo!"
elseif true && false
    w3 = "yeah!"
elseif !a || c
    w3 = "der"
end

println(w1 * w2 * w3)