function mark_centers(r)
    num_steps = through_rectangles_into_angle(r,(Sud,West))
    # УТВ: Робот - в юго-западном углу и в num_steps - закодирован пройденный путь
    num_steps_to_ost = sum(num_steps[1:2:end])
    num_steps_to_nord = sum(num_steps[2:2:end])

    #---------------------
    movements!(r,Nord,num_steps_to_nord)
    putmarker!(r)
    num_steps_to_sud = movements!(r,Nord)

    movements!(r,Ost,num_steps_to_ost)
    putmarker!(r)
    num_steps_to_west = movements!(r,Ost)

    movements!(r,Sud,num_steps_to_sud)
    putmarker!(r)
    movements!(r,Sud) # возвращаемое значение игнорируется

    movements!(r,Sud,num_steps_to_west)
    putmarker!(r)
    movements!(r,Sud) # возвращаемое значение игнорируется
    # УТВ: Маркеры поставлены и Робот - в юго-западном углу
    #-------------------

    movements!(r,(Ost,Nord),num_steps)
    #УТВ: Робот - в исходном положении
end