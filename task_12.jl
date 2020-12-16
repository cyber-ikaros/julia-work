module NNChessMarker
    using HorizonSideRobots
    import Main.inverse
#=
Предполагается, что в пространстве имен Main определена функция inverse, например, путем вставки из файла "roblib.jl"
=#
    export mark_chess

    X_COORDINATE=0
    Y_COORDINATE=0

    CELL_SIZE = 0 # - размер "шахматной" клеки 

    function mark_chess(r::Robot,n::Int)
        global CELL_SIZE
        CELL_SIZE = n # инициализация глобальной переменной

        #УТВ: Робот - в юго-западном углу
        side=Ost
        mark_row(r,side)
        while isborder(r,Nord)==false
            move_decart!(r,Nord)
            side = inverse(side)
            mark_row(r,side)
        end
    end

    function mark_row(r::Robot,size::HorizonSide)       
        putmarker_chess!(r)
        while isborder!(r,side)==false
            move_decart!(r,side)
            putmarker_chess!(r)
        end
    end

    function putmarker_chess!(r)
        if (mod(X_COORDINATE, 2*CELL_SIZE) in 0:CELL_SIZE-1) && (mod(Y_COORDINATE, 2*CELL_SIZE) in 0:CELL_SIZE-1) 
            putmarker!(r)
        end
    end

    function move_decart!(r,side)
        global X_COORD, Y_COORD
        if side==Nord
            Y_COORD+=1
        elseif side==Sud
            Y_COORD-=1
        elseif side==Ost
            X_COORD+=1
        else # side==West
            X_COORD-=1
        end
        move!(r,side)
    end

end