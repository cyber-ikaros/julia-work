#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля. Итог: Робот - в исходном положении, и все клетки поля промакированы

function mark_field!(r::Robot)#заполняем поле
    num_vert = moves!(r, Sud)#двигаемся на юг
    num_hor = moves!(r, West)#двигаемся на запад
    #УТВ: Робот - в Юго-Западном углу

    putmarkers!(r, Nord)#ставим маркеры
    #УТВ: Все клетки поля промаркированы

    moves!(r, Sud)#перемешаемся на юг до границы
    moves!(r, West)#перемещаемся на запад до границы
    moves!(r, Nord, num_vert)#перемещаемся на север на количество num_vert
    moves!(r, Ost, num_hor)#перемещаемся на восток на количество num_hor
    #УТВ: Робот - в исходном положении
end

function moves!(r::Robot,side::HorizonSide)#передвигаем робота до границы по направлнию side 
    num_steps=0#обнуляем счетчик
    while !isborder(r,side)#пока не граница
        move!(r,side)#двигаем робота
        num_steps+=1#обновляем счетчик
    end
    return num_steps#возвращаем количество шагов
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)# передвигаем робота по стороне side на num_steps
    for _ in 1:num_steps#цикл от 1 ого до количества шагов
        move!(r,side)#двигаем робота
    end
end

function putmarkers!(r::Robot, side::HorizonSide)#выставляем маркеры на поле
    while !isborder(r,side)#пока не граница
        putmarker!(r)#ставим маркер
        move!(r,side)#двигаем робота
    end
    
    putmarker!(r)#ставим маркер
    if !isborder(r,Ost)#если не граница востока
        move!(r,Ost)#двигаем на восток
        return putmarkers!(r, inverse(side))#вызываем рекурентно функцию putmarkers в противоположную сторону
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))#меняем сторону на противоположную
