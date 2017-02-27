function [DCgain, f3db, UGF, PM, PR] = AC_metrics(freq, gain, phase)

DCgain  = gain(1);                            % ac sweep must start with a low frequency
freq_db = log10(freq);
f3db_db = invinterp(freq_db, DCgain-gain-3, 0);
f3db    = 10^f3db_db;
UGF_db  = max(invinterp(freq_db, gain, 0));      % ac sweep must end with a high frequency
UGF     = 10^UGF_db
PM      = interp1(freq_db,phase,UGF_db);
if (abs(phase(1))<1)
    PM  = PM + 180;
PR      = PhaseRipple(freq,phase);    

end