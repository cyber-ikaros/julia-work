function average_temperature(r::Robot)
    temp_sum, marks_num = pass_field(r, 0, 0)

    if marks_num == 0
        return 0
    else
        return temp_sum / marks_num
    end
end

function pass_vert(r::Robot, side::HorizonSide, temp_sum::Int, marks_num::Int)
    while !isborder(r, side)
        if ismarker(r)
            marks_num += 1
            temp_sum += temperature(r)
        end

        move!(r,side)
    end

    if ismarker(r)
        marks_num += 1
        temp_sum += temperature(r)
    end

    return temp_sum, marks_num
end

function pass_field(r::Robot, temp_sum::Int, marks_num::Int)
    side = Nord

    while !isborder(r, Ost)
        temp_sum, marks_num = pass_vert(r, side, temp_sum, marks_num)

        side = inverse(side)

        move!(r, Ost)
    end

    return pass_vert(r, side, temp_sum, marks_num)
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))