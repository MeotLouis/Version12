function y = FFTPSD(x,Fs)
    m = length(x);          % 整个数据长度
    n = pow2(nextpow2(m));  % 扩展到合适长度，2的整数次幂
    y = fft(x,n);           
    f = (0:n-1)*(Fs/n);     %频率范围
    P = y.*conj(y)/n;   %功率谱密度
    f=f(1:n/2);
    P=P(1:n/2);
   
    plot(f,10*log10(P)); %把数据转换为dB
%     plot(f,P);
    grid;
    xlabel('Frequency (Hz)');
    ylabel('Power(dB)');
    title('{\bf Periodogram}');
end