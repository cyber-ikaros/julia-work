function mark_angles!(r)
    num_steps = through_rectangles_into_angle(r,(Sud,Ost))
    
    for side in (Nord, West, Sud, Ost)
        moves!(r,side)
        putmarker!(r)
    end
    
    moves_from_angle!(r,(Nord,West),num_steps)
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = next(direct_side)
    reverse_side = inverse(orthogonal_side)
    num_steps=0
    while isborder(r, direct_side) == true
        if isborder(r, orthogonal_side) == false
            move!(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    
    if isborder(r,direct_side) == false
        move!(r,direct_side)
        if num_steps > 0
            while isborder(r,reverse_side) == true
                move!(r,direct_side)
            end
        end
        result = true
    else
        result = false
    end
    
    for _ in 1:num_steps
        move!(r, reverse_side)
    end

    return result
end

function through_rectangles_into_angle(r,angle::NTuple{2,HorizonSide})::Vector{Int}
    num_steps::Vector{Int}=[]
    while !isborder(r,angle[1]) || !isborder(r,angle[2])
        push!(num_steps, moves!(r, angle[2]))
        push!(num_steps, moves!(r, angle[1]))
    end
    return num_steps
end

function moves_from_angle!(r,sides,num_steps::Vector{Int})
    for (i,n) in enumerate(reverse!(num_steps))
        moves!(r, sides[mod(i-1, length(sides))+1], n)
    end
end

function moves!(r,side)
    num_steps=0
    while move_if_possible!(r,side)
        num_steps+=1
    end
    return num_steps
end

moves!(r,side,num_steps) = for _ in 1:num_steps move_if_possible!(r,side) end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

next(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))