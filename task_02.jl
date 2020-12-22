
#Робот - в произвольной клетке поля (без внутренних перегородок и маркеров).Итог:Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы
function mark_frame_perimetr!(r::Robot)#функция которая маркирует весь перемитер(используется метод программирования сверху-вниз)
    num_vert = moves!(r, Sud) #идем вниз и передаем количество шагов в переменную num_vert
    num_hor = moves!(r, West)#идем налево и передаем количество шагов в переменную num_hor
    #УТВ: Робот - в Юго-Западном углу

    for side in [Nord, Ost, Sud, West]#проходимся по каждой стороне
        putmarkers!(r, side) #раставляем маркеры по стороне
    end 
    #УТВ: По всему периметру стоят маркеры

    moves!(r, Nord, num_vert)#двигаемся наверх на количетсво num_vert
    moves!(r, Ost, num_hor)#двигаемся направо на количество num_hor
    #УТВ: Робот - в исходном положении
end

function moves!(r::Robot,side::HorizonSide)#передвигаем робота по стороне horizonside и возвращаем количество шагов  num_step
    num_steps=0#обнуляем счетчик шагов 
    while isborder(r,side)==false#пока не граница
        move!(r,side)#двигаем робота
        num_steps+=1#обновляем счётчик
    end
    return num_steps#возвращаем общее количество шагов
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)#передвигаем робота по horizonside на количество шагов (num_steps)
    for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную и мы проходимся по шагам
        move!(r,side)#двигаем робота
    end
end

function putmarkers!(r::Robot, side::HorizonSide)#ставим маркеры на стороне horizonSide
    while isborder(r,side)==false #пока не граница 
        move!(r,side) #двигаем робота
        putmarker!(r) #ставим маркер
    end
end