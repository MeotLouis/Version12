function y = FFTPSD(x,Fs)
    m = length(x);          % �������ݳ���
    n = pow2(nextpow2(m));  % ��չ�����ʳ��ȣ�2����������
    y = fft(x,n);           
    f = (0:n-1)*(Fs/n);     %Ƶ�ʷ�Χ
    P = y.*conj(y)/n;   %�������ܶ�
    f=f(1:n/2);
    P=P(1:n/2);
   
    plot(f,10*log10(P)); %������ת��ΪdB
%     plot(f,P);
    grid;
    xlabel('Frequency (Hz)');
    ylabel('Power(dB)');
    title('{\bf Periodogram}');
end