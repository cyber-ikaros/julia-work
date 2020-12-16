function mark_innerrectangle_perimetr!(r::Robot)
    num_steps=fill(0,3) # - вектор-столбец из 3-х нулей
    for (i,side) in enumerate((Sud,West,Sud))
        num_steps[i]=moves!(r,side)
    end
    #УТВ: Робот - в Юго-западном углу внешней рамки

    side = find_border!(r,Ost,side)
    #УТВ: Робот - у западной границы внутренней перегородки

    mark_innerrectangle_perimetr!(r,side)
    #УТВ: Робот - снова у западной границы внутренней прямоугольной перегородки

    moves!(r,Sud)
    moves!(r,West)
    #УТВ: Робот - в Юго-западном улу внешней рамки

    for (i,side) in enumerate((Nord,Ost,Nord))
        moves!(r,side, num_steps[i])
    end
    #УТВ: Робот - в исходном положении
end

function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)
    if side == Nord
        # обходить прямоугольник следует по часовой стрелке
        direction_of_movement=(Nord,Ost,Sud, West)
        direction_to_border=(Ost,Sud,West,Nord)
    else 
        # обходить прямоугольник следует против часовой стрелки
        direction_of_movement=(Sud,Ost,Nord,West)
        direction_to_border=(Ost,Nord,West,Sud)
    end

    for i ∈ 1:4   
        # надо ставить маркеры вдоль очередной стороны внутренней перегородки 
        # (перемещаться надо в одном направлении, а следить за перегородеой в - 
        # перпендикулярном ему)
        putmarkers!(r,  direction_of_movement[i], direction_to_border[i]) 
    end
end

function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)
    direction_of_movement, direction_to_border = get_directions(side)
    for i ∈ 1:4   
        putmarkers!(r, direction_of_movement[i], direction_to_border[i]) 
    end
end

get_directions(side::HorizonSide) = if side == Nord  
    # - обход будет по часовой стрелке      
        return (Nord,Ost,Sud, West), (Ost,Sud,West,Nord)
    else # - обход будет против часовой стрелки
        return (Sud,Ost,Nord,West), (Ost,Nord,West,Sud) 
    end

function putmarkers!(r::Robot, direction_of_movement::HorizonSide, direction_to_border::HorizonSide)
    while isborder(r,direction_to_border)==true
        move!(r,direction_of_movement)
    end
end