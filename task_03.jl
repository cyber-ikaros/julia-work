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

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while !isborder(r,side)
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r,side)
        putmarker!(r)
        move!(r,side)
    end
    
    putmarker!(r)
    if !isborder(r,Ost)
        move!(r,Ost)
        return putmarkers!(r, inverse(side))
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
