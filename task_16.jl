function mark_field!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    #УТВ: Робот - в Юго-Западном углу

    putmarkers!(r, Nord)
    #УТВ: Все клетки поля промаркированы

    moves!(r, Sud)
    moves!(r, West)
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
    #УТВ: Робот - в исходном положении
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = next(direct_side)
    reverse_side = inverse(orthogonal_side)
    num_steps=0
    while isborder(r, direct_side) == true
        if !isborder(r, orthogonal_side)
            move!(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    #УТВ: Робот или уперся в угол внешней рамки поля, или готов сделать шаг (или несколько) в направлении 
    # direct_side
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
    num_steps=0
    while move_if_possible!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move_if_possible!(r,side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide)
    putmarker!(r)
    while move_if_possible!(r,side)
        putmarker!(r)
    end
    
    if !isborder(r,Ost)
        move!(r,Ost)
        return putmarkers!(r, inverse(side))
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

next(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
