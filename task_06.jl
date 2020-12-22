#ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками. РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.


function mark_innerrectangle_perimetr!(r::Robot) #выполнение главной функциии
    num_steps=fill(0,3) # - вектор-столбец из 3-х нулей
    for (i,side) in enumerate((Sud,West,Sud))#проходимся по каждой стороне
        num_steps[i]=moves!(r,side)#записываем в вектор num_steps количество шагов для каждой стороны
    end
    #УТВ: Робот - в Юго-западном углу внешней рамки

    side = find_border!(r,Ost,side)#передвигаемся к западной границе внутренней перегородки
    #УТВ: Робот - у западной границы внутренней перегородки

    mark_innerrectangle_perimetr!(r,side)#выделяем периметр  внутренней перегородки
    #УТВ: Робот - снова у западной границы внутренней прямоугольной перегородки

    moves!(r,Sud)#двигаемся на юг
    moves!(r,West)#двигаемся на восток
    #УТВ: Робот - в Юго-западном улу внешней рамки

    for (i,side) in enumerate((Nord,Ost,Nord))#проходимся по вектору
        moves!(r,side, num_steps[i])#передвигаемся по каждому направлению на значения из вектора
    end
    #УТВ: Робот - в исходном положении
end

function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)#маркеруем периметр
    if side == Nord #если сторона севере
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
        putmarkers!(r, direction_of_movement[i], direction_to_border[i])#ставим маркеры 
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