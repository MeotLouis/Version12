function [DCgain_str, f3db_str, UGF_str, PM_str, PR_str] = AC_metrics(freq, gain, phase)

DCgain  = gain(1);                            % ac sweep must start with a low frequency
freq_db = log10(freq);
f3db_db = invinterp(freq_db, DCgain-gain-3, 0);
f3db    = 10^f3db_db;
UGF_db  = max(invinterp(freq_db, gain, 0));      % ac sweep must end with a high frequency
UGF     = 10^UGF_db;
PM      = interp1(freq_db,phase,UGF_db);
if (abs(phase(1))<1)
    PM  = PM + 180;
PR      = PhaseRipple(freq,phase);    

DCgain_str = [num_plus_kmg(DCgain),'dB'];
f3db_str = [num_plus_kmg(f3db),'Hz'];
UGF_str = [num_plus_kmg(UGF),'Hz'];
PM_str = [num_plus_kmg(PM),'deg'];
PR_str = [num_plus_kmg(PR),'deg'];

end