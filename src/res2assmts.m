function assmts = res2assmts(mis_res, len, sub_name)
    assmts = repelem("", size(mis_res, 1));
    assmts = assmts.';
    for i = 1:size(mis_res, 1)
        mi = mis_res(i, :);
        assmt = repelem("", 5);

        if mi(3) ~= 1
            assmt(1) = sub_name + " 1 " + num2str(mi(3)-1) + " disordered";
        end
        assmt(2) = sub_name + " " + num2str(mi(3)) + " " + num2str(mi(3)+mi(4)-1) + " structure fixed";
        if mi(7) == 1
            if mi(3)+mi(4)-1 ~= len
                assmt(3) = sub_name + " " + num2str(mi(3)+mi(4)) + " " + num2str(len) + " disordered";
            end
        else
            assmt(3) = sub_name + " " + num2str(mi(3)+mi(4)) + " " + num2str(mi(5)-1) + " disordered";
            if mi(7) == 3
                assmt(4) = sub_name + " " + num2str(mi(5)) + " " + num2str(mi(5)+mi(6)-1) + " structure fixed";
            else
                assmt(4) = sub_name + " " + num2str(mi(5)) + " " + num2str(mi(5)+mi(6)-1) + " structure";
            end
            if mi(5)+mi(6)-1 ~= len
                assmt(5) = sub_name + " " + num2str(mi(5)+mi(6)) + " " + num2str(len) + " disordered";
            end
        end
        c = newline;
        assmt = join(assmt, c);
        assmts(i) = assmt;
    end
end