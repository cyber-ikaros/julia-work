function find_marker(r)
    num_steps_max=1
    side=Nord
    while ismarker(r)==false
        for _ in 1:2
            find_marker(r,side,num_steps_max)
            side=next(side)
        end
        num_steps_max+=1
    end
end

function find_marker(r,side,num_steps_max)
    for _ in 1:num_steps_max
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+1,4))