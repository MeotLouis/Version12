function y = num_plus_kmg(x)

x_abs = abs(x);

if (x_abs > 10^12)
    c = 'T';
    x = x ./ 10^12;
elseif (x_abs > 10^9)
    c = 'G';
    x = x ./ 10^9;
elseif (x_abs > 10^6)
    c = 'M';
    x = x ./ 10^6;
elseif (x_abs > 10^3)
    c = 'k';
    x = x ./ 10^3;
elseif (x_abs > 1)
    c = '';
elseif (x_abs > 10^(-3))
    c = 'm';
    x = x * 10^3;
elseif (x_abs > 10^(-6))
    c = 'u';
    x = x * 10^6;
elseif (x_abs > 10^(-9))
    c = 'n';
    x = x * 10^9;
elseif (x_abs > 10^(-12))
    c = 'p';
    x = x_abs * 10^12;
else
    c = 'f';
    x = x * 10^15;
end
x_str = sprintf('%8.3f',x);
y = [x_str,' ',c];

end