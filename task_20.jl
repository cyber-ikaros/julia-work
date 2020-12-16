function count_hor_borders(r::Robot)::Int
    moves!(r, Sud)
    moves!(r, West)

    count = 0
    side = Ost

    while !isborder(r, Nord)
        move!(r, side)
        is_hor_border = false

        while !isborder(r, side)
            if isborder(r, Nord) && !is_hor_border
                count += 1
                is_hor_border = true
            elseif !isborder(r, Nord)
                is_hor_border = false
            end

            move!(r, side)
        end

        side = inverse(side)
        move!(r, Nord)
    end

    return count
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

function moves!(r::Robot,side::HorizonSide)
    while move_if_possible!(r,side)
        
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

next(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))