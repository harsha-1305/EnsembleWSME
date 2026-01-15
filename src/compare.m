clear()
clf('reset')
hold on
foldername = "peak_microstates\";
folders = dir(foldername);

pltall = 0;
n = 301;
lgd = [];

data = readmatrix('SAXS_profile.xlsx');
x_exp = data(4:end, 1).' .* 10;
y_exp = data(4:end, 8).';
y_err = data(4:end, 9).';
y_ift = data(4:end, 10).';
p1 = plot(x_exp, y_exp, 'o');
% p1 = errorbar(x_exp, y_exp, y_err, 'o');
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"Experimental"}, size(p1.XData)));
lgd = [lgd "Experimental"];
title("Kratky plot of SAXS data")
xlabel("q(nm^-1)")
ylabel("I(q).q^2")
yscale log

x = load("x.mat").x;
y = load("y_folded.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"folded"}, size(p1.XData)));
lgd = [lgd "folded"];

x = load("x.mat").x;
y = load("y.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
% p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"each"}, size(p1.XData)));
% lgd = [lgd "each"];

y = load("y_10.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1 = plot(x_fit, y_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"10"}, size(p1.XData)));
lgd = [lgd "10"];

y = load("y_50.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1 = plot(x_fit, y_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"50"}, size(p1.XData)));
lgd = [lgd "50"];

y = load("y_100.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1 = plot(x_fit, y_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"100"}, size(p1.XData)));
lgd = [lgd "100"];

y = load("y_250.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1 = plot(x_fit, y_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"250"}, size(p1.XData)));
lgd = [lgd "250"];

y = load("y_500.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1 = plot(x_fit, y_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"500"}, size(p1.XData)));
lgd = [lgd "500"];

y = load("y_1000.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
p1 = plot(x_fit, y_fit.*x_fit.*x_fit);
% p1 = plot(x_fit, y_fit);
p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"1000"}, size(p1.XData)));
lgd = [lgd "1000"];

y = load("Y_2000_broken.mat").y;
[x_fit, y_fit] = clean_x_y(x, y, x_exp, y_exp, y_err);
% p1 = plot(x_fit, y_fit.*x_fit.*x_fit, '--');
% p1.DataTipTemplate.DataTipRows(end+1) = dataTipTextRow('Series', repmat({"2000"}, size(p1.XData)));
% lgd = [lgd "2000"];

legend(lgd)
disp("Done")