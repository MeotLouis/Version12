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

function [SNDR_str,SFDR_str,THD_str] = FFT_metrics(time, signal, fc_fdmt, BW_fdmt, fn_L, fn_H)

% use interpolation to generate signals with equidistance timepoints
N_bi        = length(time);                         % number of equidistance timepoints
seqtime     = linspace(time(1),time(N_bi),N_bi);    % equidistance timepoints
seqsignal   = interp1(time,signal,seqtime);         % interpolated signals
% seqtime     = time;
% seqsignal   = signal;

% obtain double-side spectrum
fs          = N_bi/time(N_bi);                      % sampling freq
n           = 0:N_bi-1;
f_bi        = n*fs/N_bi - fs/2;
Fsignal_bi  = abs(fftshift(fft(seqsignal,N_bi)));

% obtain single-side spectrum
Nstart      = ceil((N_bi+3)/2);                     % f_bi(Nstart) = min(f|f>0Hz)
f           = f_bi(Nstart:N_bi);
Fsignal     = Fsignal_bi(Nstart:N_bi);

if (nargin == 2)
    i_fdmt = find(Fsignal == max(Fsignal));
    fc_fdmt = f(i_fdmt);
    BW_fdmt = fc_fdmt/4;
    fn_L = f(1);
    fn_H = f(end)/1;
else
    i_fdmt = 5000;
end

% plot
% plot(f_bi,Fsignal_bi);
f_db = 20.*log10(f./fc_fdmt);
Fsignal_db = 20.*log10(Fsignal./Fsignal(i_fdmt));
plot(f,Fsignal_db);

% find index of frequency
i_ff_L     = find(f > fc_fdmt - BW_fdmt/2, 1 )
i_ff_H     = find(f < fc_fdmt + BW_fdmt/2, 1, 'last' )
i_fn_L     = find(f >= fn_L, 1 )
i_fn_H     = find(f <= fn_H, 1, 'last' )


% prepare for SFDR, obtain signal without fundamental
Fsignal_wof = Fsignal;
Fsignal_wof(i_ff_L:i_ff_H)  = 0;


% calculate power of signals/harmonics/noise
Ptotal      = sum(Fsignal(i_fn_L:i_fn_H).*conj(Fsignal(i_fn_L:i_fn_H)));
Pfdmt       = sum(Fsignal(i_ff_L:i_ff_H).*conj(Fsignal(i_ff_L:i_ff_H)))           % power of fundamental
Pnoise_hmnc = Ptotal - Pfdmt
Phmnc       = sum(Fsignal(2*i_ff_L:2*i_ff_H).*conj(Fsignal(2*i_ff_L:2*i_ff_H)))... 
            + sum(Fsignal(3*i_ff_L:3*i_ff_H).*conj(Fsignal(3*i_ff_L:3*i_ff_H)))... 
            + sum(Fsignal(4*i_ff_L:4*i_ff_H).*conj(Fsignal(4*i_ff_L:4*i_ff_H)))... 
            + sum(Fsignal(5*i_ff_L:5*i_ff_H).*conj(Fsignal(5*i_ff_L:5*i_ff_H)))...
            + sum(Fsignal(6*i_ff_L:6*i_ff_H).*conj(Fsignal(6*i_ff_L:6*i_ff_H)))...
            + sum(Fsignal(7*i_ff_L:7*i_ff_H).*conj(Fsignal(7*i_ff_L:7*i_ff_H)));
%+ sum(Fsignal(8*i_ff_L:8*i_ff_H).^2)+ sum(Fsignal(9*i_ff_L:9*i_ff_H).^2);     
                                                        % power of harmonics
                                                        % suppose bandwith of 2nd,3rd,...,9th harmonic is twice,3times,...,9times of fundamental's bandwidth
Pnoise      = Ptotal - Pfdmt - Phmnc;                   % power of noise                                                        
SNDR        = 10 * log10(Pfdmt/(Ptotal-Pfdmt));
SFDR        = 20 * log10(max(Fsignal)/max(Fsignal_wof));
THD         = 10 * log10(Phmnc/Pfdmt);

SNDR_str = [num_plus_kmg(SNDR),'dB'];
SFDR_str = [num_plus_kmg(SFDR),'dB'];
THD_str = [num_plus_kmg(THD),'dB'];

f(end);

end