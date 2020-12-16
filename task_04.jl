function mark_rows!(r::Robot)
    num_ost = moves!(r, Ost)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    #УТВ: Робот - в Юго-Западном углу

    putmarkers!(r, num_hor)
    #УТВ: Все ряды поля промаркированы в соответствующем порядке

    moves!(r, Sud)
    moves!(r, West)
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor-num_ost)
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

function put_num_markers!(r::Robot,side::HorizonSide,num_marks::Int)
    for _ in 1:num_marks
        putmarker!(r)
        move!(r,side)
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, num_marks::Int)
    while !isborder(r,Nord)
        put_num_markers!(r, Ost, num_marks)
        
        move!(r, Nord)
        moves!(r, West)
        num_marks -= 1
    end

    put_num_markers!(r, Ost, num_marks)
end
