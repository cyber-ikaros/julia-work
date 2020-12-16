"""
    moves!(r::Robot, side::HorizonSide)

-- перемещает Робота до упора в заданном направлении и возвращает число пройденных шагов
"""
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while !isborder(r,side)
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

"""
    moves!(r::Robot, side::HorizonSide, num_steps::Int)

-- перемещает Робота в заданном направлении на заданное число шагов (если на пути - перегородка, то - ошибка)
"""
moves!(r::Robot, side::HorizonSide, num_steps::Int) = 
for _ in 1:num_steps
    move!(r,side)
end

"""
    find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide)

-- останавливает робота у перегородки, которая ожидается с направления side_to_border, при движении робота "змейкой" в сторону перегородки (от упора до упора в поперечном этому напавлении). 

-- side_of_movement - начальное "поперечное" направление
"""
find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide) = 
while isborder(r,side_to_border)==false  
    if isborder(r,side_of_movement)==false
        move!(r,side_of_movement)
    else
        move!(r,side_to_border)
        side_of_movement=inverse(side_of_movement)
    end
end

"""
    inverse(side::HorizonSide)

-- возвращает направлене горизонта, противоположное заданному    
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))


"""
    putmarkers!(r::Robot, side::HorizonSide)

-- ставит маркеры, пермещая Робота до упора в заданном направлении (в начальной клетке маркер не ставится)    
"""
putmarkers!(r::Robot, side::HorizonSide) = 
while isborder(r,side)==false
    move!(r,side)
    putmarker!(r)
end

"""
    putmarkers!(r::Robot,side_of_movement::HorizonSide,side_to_border::HorizonSide)

-- Ставит маркеры и перемещает Робота в направлении side_of_movement пока рядом с ним в направлении side_to_border имеется перегородка (эти два направления должны быть взаимно перпендикулярными) 
"""
putmarkers!(r::Robot,side_of_movement::HorizonSide,side_to_border::HorizonSide) = 
while isborder(r,side_to_border)==true
    move!(r,side_of_movement)
end

"""
    through_rectangles_into_angle(r,angle::NTuple{2,HorizonSide})

-- Перемещает Робота в заданный угол, прокладывая путь межу внутренними прямоугольными перегородками и возвращает массив, содержащий числа шагов в каждом из заданных направлений на этом пути
"""
function through_rectangles_into_angle(r,angle::NTuple{2,HorizonSide})
    num_steps=[]
    while isborder(r,angle[1])==false || isborder(r,angle[2]) # Робот - не в юго-западном углу
        push!(num_steps, movements!(r, angle[2]))
        push!(num_steps, movements!(r, angle[1]))
    end
    return num_steps
end

"""
    movements!(r,sides,num_steps::Vector{Int})

-- перемещает Робота по пути, представленного двумя последовательностями, sides и num_steps 
-- sides - содержит последовательность направлений перемещений
-- num_steps - содержит последовательность чисел шагов в каждом из этих направлений, соответственно; при этом, если длина последовательности sides меньше длины последовательности num_steps, то предполагается, что последовательность sides должна быть продолжена периодически        
"""
function movements!(r,sides,num_steps::Vector{Int})
    for (i,n) in enumerate(num_steps)
        movements!(r, sides[mod(i-1, length(sides))+1], n)
    end
end

movements!(r::Robot, side::HorizonSide) = while isborder(r,side)==false move!(r,side) end 