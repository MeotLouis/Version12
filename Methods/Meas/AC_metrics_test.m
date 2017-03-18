function [DCgain, f3db, UGF, PM, PR] = AC_metrics_test()

acdata  = loadsig('FFOTA_Mag&Phase.ac0');
% acdata  = loadsig('FFOTA_Mag&Phase(with ripple).ac0');
freq    = evalsig(acdata,'HERTZ');
gain    = evalsig(acdata,'lstb_db');
phase   = evalsig(acdata,'lstb_phase');
[DCgain, f3db, UGF, PM, PR] = AC_metrics(freq, gain, phase);
 
end