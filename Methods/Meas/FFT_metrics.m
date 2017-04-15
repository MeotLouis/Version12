% FFT metrics
% inputs: 
%   time & signal           - timepoints and signals extracted from Hspice
%   fc_signal & BW_signal   - center frequency of fundamental
%   fn_L & fn_H             - lower & upper limit of noise power integration
% outputs: 
%   f & Fsignal             - frequency & magnitude of single-side spectrum
%   i_ff_L & i_ff_H         - index of minimum/maximum frequency of fundamental
%   i_fn_L & i_fn_H         - index of minimum/maximum frequency of noise
%   Ptotal, Pfdmt, Phmnc    - power of total/fundamental/harmonic signals

% function [f,Fsignal,i_ff_L,i_ff_H,i_fn_L,i_fn_H,Ptotal,Pfdmt,Phmnc,SNDR,SFDR,THD] = FFT_metrics(time, signal, fc_fdmt, BW_fdmt, fn_L, fn_H)

% x=loadsig('E:\ADA\spFile\FFT_test\FFT.tr0'); time=evalsig(x,'TIME'); signal=evalsig(x,'ip'); len=length(time) 
% [SNDR,SFDR,THD]=FFT_metrics(time,signal)
function [SNDR_str,SFDR_str,THD_str] = FFT_metrics(time_ori, signal_ori)

% use interpolation to generate signals with equidistance timepoints

time        = time_ori;
signal      = signal_ori;
% length_ori  = length(time_ori)
% length_dec  = floor(length_ori/1024)
% N_last      = 1+1023*length_dec;
% time        = time_ori(1:length_dec:N_last);
% signal      = signal_ori(1:length_dec:N_last);


N_bi        = length(time);                         % number of equidistance timepoints
window_sig  = blackman(N_bi); 

% not_mono    = 0;
% for (j=2:N_bi-1)
%     if ((time(j)>time(j-1)&&time(j)>time(j+1)) || (time(j)<time(j-1)&&time(j)<time(j+1)) || time(j)==time(j-1) || time(j)==time(j+1))
%         not_mono = 1;
%         j
%     end
% end
% not_mono

seqtime     = linspace(time(1),time(end),N_bi);    % equidistance timepoints
seqsignal   = (interp1(time,signal,seqtime))';         % interpolated signals
seqsignal   = seqsignal.*window_sig;

% obtain double-side spectrum
fs          = N_bi/time(N_bi);                      % sampling freq
n           = 0:N_bi-1;
f_bi        = n*fs/N_bi - fs/2;
Fsignal_bi  = abs(fftshift(fft(seqsignal,N_bi)));

% obtain single-side spectrum
Nstart      = ceil((N_bi+3)/2);                     % f_bi(Nstart) = min(f|f>0Hz)
f           = f_bi(Nstart:N_bi);
Fsignal     = Fsignal_bi(Nstart:N_bi);
f(end)

% plot FFT spectrum
i_fdmt = find(Fsignal == max(Fsignal));
Fsignal_db = 20.*log10(Fsignal./Fsignal(i_fdmt));
plot(f,Fsignal_db);

% flag for reversing Fsignal
if (N_bi-Nstart+1 < 2*i_fdmt)
    Fsignal = fliplr(Fsignal')';
    i_fdmt  = find(Fsignal == max(Fsignal));
end

fc_fdmt     = f(i_fdmt);
BW_fdmt     = fc_fdmt/2;
fn_L        = f(1);
fn_H        = f(end)/1;

% find index of frequency
i_ff_H     = find(f < fc_fdmt + BW_fdmt/2, 1, 'last' );
i_BW       = i_ff_H - i_fdmt;
i_fn_L     = find(f >= fn_L, 1 );
i_fn_H     = find(f <= fn_H, 1, 'last' );


% prepare for SFDR, obtain signal without fundamental
Fsignal_wof = Fsignal;
Fsignal_wof((i_fdmt-i_BW):(i_fdmt+i_BW))  = 0;


% calculate power of signals/harmonics/noise
% Ptotal      = sum(Fsignal(i_fn_L:i_fn_H).*conj(Fsignal(i_fn_L:i_fn_H)));
Pfdmt       = sum(Fsignal((i_fdmt-i_BW):(i_fdmt+i_BW)).*conj(Fsignal((i_fdmt-i_BW):(i_fdmt+i_BW))));           % power of fundamental
Pnoise_hmnc = sum(Fsignal_wof(i_fn_L:i_fn_H).*conj(Fsignal_wof(i_fn_L:i_fn_H)));
N_hmnc1     = floor((N_bi-Nstart+1-i_BW)/i_fdmt);
Phmnc       = 0;  
for (j = 2:N_hmnc1)
	Phmnc   = Phmnc + sum(Fsignal((j*i_fdmt-i_BW):(j*i_fdmt+i_BW)).*conj(Fsignal((j*i_fdmt-i_BW):(j*i_fdmt+i_BW))));
end
Phmnc;

% Pnoise      = Ptotal - Pfdmt - Phmnc;                   % power of noise                                                        
SNDR        = 10 * log10(Pfdmt/Pnoise_hmnc);
SFDR        = 20 * log10(max(Fsignal)/max(Fsignal_wof));
THD         = 10 * log10(Phmnc/Pfdmt);

SNDR_str = [num_plus_kmg(SNDR),'dB'];
SFDR_str = [num_plus_kmg(SFDR),'dB'];
THD_str = [num_plus_kmg(THD),'dB'];

f(end);

end