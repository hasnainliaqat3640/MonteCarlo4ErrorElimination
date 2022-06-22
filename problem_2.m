clc
clear
close all
% ------------------------
% -    f(x) = 1/(x+1)    -
% ------------------------
f = @(x) 1./(x+1);
xint = [0 4];
yint = [0 1];
N = [500 5000 10000];
figure(1)
for loop = 1:3
    if loop == 1 || loop == 2 subplot(220+loop);
    else subplot(212);
    end
    fplot(f, xint, 'k', 'LineWidth', 3)
    xlabel('x')
    ylabel('f(x) = 1/(x+1)')
    title(strcat('Monte Carlo simulation of \int1/(x+1)dx in [0 4] (N=', num2str(N(loop)), ')'))
    grid on
    hold on
    ylim(yint)
    rng(1051)
    xvals = xint(2)*rand(N(loop),1);
    yvals = yint(2)*rand(N(loop),1);

    yfunc = 1./(xvals+1);
    X = 0;

    for i=1:length(yvals)
        if yvals(i) <= yfunc(i)
            X = X+1;
            plot(xvals(i), yvals(i),'b.')
        else
            plot(xvals(i), yvals(i),'r.')
        end
    end

    apprx_integral = (X/N(loop))*(xint(2)-xint(1))*(yint(2)-yint(1));

    syms x
    act_integral = eval(int(1/(x+1),x,[0 4]));
    error = abs(apprx_integral-act_integral);

    fprintf('------------------------------------------\n');
    fprintf('Number of samples (N): %d\n', N(loop));
    fprintf('Actual and Approximated Integrals for 1/(x+1) in [0 4]\n')
    fprintf('\tActual Integral = %.4f\n', act_integral)
    fprintf('\tApproximated Integral using MonteCarlo Method = %.4f\n',...
        apprx_integral)
    fprintf('\tAbsolute Error = %.4f\n', error)
end
