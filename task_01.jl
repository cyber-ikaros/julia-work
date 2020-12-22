
#Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
function mark_kross!(r::Robot) # - главная функция  
    for side in (Nord,West,Sud,Ost) # - перебор всех направлений Nord, West, Sud, Ost
        putmarkers!(r,side) # - ставим макеры по стороне side
        move_by_markers(r,inverse(side)) #перемещаем робота по стороне противоположной side
    end
    putmarker!(r)#ставим маркер
end

# Всюду в заданном направлении ставит маркеры вплоть до перегородки, но в исходной клетке маркер не ставит
putmarkers!(r::Robot,side::HorizonSide) = 
    while isborder(r,side)==false #пока не граница поля
        move!(r,side)#двигаем по стороне
        putmarker!(r)#ставим маркер
    end#конец

# Перемещает робота в заданном направлении пока, пока он находится в клетке с маркером (в итоге робот окажется в клетке без маркера)
move_by_markers(r::Robot,side::HorizonSide) = 
    while ismarker(r)==true #пока клетка на которой находится робот закрашена
        move!(r,side) #двигаемся
    end

# Возвращает направление, противоположное заданному
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))