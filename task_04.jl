#ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля. РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.



function mark_rows!(r::Robot)#выделяем ряды
    num_ost = moves!(r, Ost)#двигаемся на восток
    num_vert = moves!(r, Sud)#двигаемся на юг
    num_hor = moves!(r, West)#двигаемся на запад
    #УТВ: Робот - в Юго-Западном углу

    putmarkers!(r, num_hor)#маркируем поле
    #УТВ: Все ряды поля промаркированы в соответствующем порядке

    moves!(r, Sud)#двигаемся на юг
    moves!(r, West)#двигаемся на запад
    moves!(r, Nord, num_vert)#двигаемся на север
    moves!(r, Ost, num_hor-num_ost)#двигаемся на восток
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

function put_num_markers!(r::Robot,side::HorizonSide,num_marks::Int)#двигаем по side на num_marks
    for _ in 1:num_marks#проходимся от 1 до num_marks
        putmarker!(r)#ставим маркер
        move!(r,side)#двигаем робота
    end
    putmarker!(r)#ставим маркер
end

function putmarkers!(r::Robot, num_marks::Int)#красим поле
    while !isborder(r,Nord)#пока не граница на севере
        put_num_markers!(r, Ost, num_marks)#ставим маркеры на восток
        
        move!(r, Nord)#двигаем робота на север
        moves!(r, West)#двигаем робота на запад
        num_marks -= 1#обновляем счетчик
    end

    put_num_markers!(r, Ost, num_marks)#ставим маркеры на восток на num_marks
end
