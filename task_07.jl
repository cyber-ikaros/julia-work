#

function mark_chess!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)

    mark = true
    side = Ost

    if num_vert % 2 == 1
        mark = !mark
    end
    if num_hor % 2 == 1
        mark = !mark
    end

    while !isborder(r, Nord)
        mark = putmarkers!(r, side, mark)
        side = inverse(side)
        move!(r,Nord)
    end
    putmarkers!(r, side, mark)

    moves!(r, Sud)
    moves!(r, West)
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
end

function putmarkers!(r::Robot, side::HorizonSide, mark::Bool) 
    while !isborder(r,side)
        if mark
            putmarker!(r)
        end
        move!(r,side)
        mark = !mark
    end
    if mark
        putmarker!(r)
    end
    return !mark
end