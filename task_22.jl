function count_rectangular_borders(r::Robot)::Int
    moves!(r, Sud)
    moves!(r, Ost)

    count = 0
    side = West

    while !isborder(r, Nord)
        possible, is_rectangular_border = move_if_possible!(r, side)

        while possible
            if is_rectangular_border
                count += 1
            end

            possible, is_rectangular_border = move_if_possible!(r, side)
        end

        side = inverse(side)
        move!(r, Nord)
    end

    return count
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Tuple{Bool, Bool}
    if direct_side == Ost
        orthogonal_side = Sud
    else
        orthogonal_side = next(direct_side)
    end

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
            while isborder(r,reverse_side) && !isborder(r,direct_side)
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

    return result, num_steps == 1 && result
end

function moves!(r::Robot,side::HorizonSide)
    possible, _ = move_if_possible!(r,side)
    while possible
        possible, _ = move_if_possible!(r,side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

next(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))