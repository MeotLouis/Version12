function [Phase_Ripple] = PhaseRipple(freq, phase)

i_LocalMax      = find(diff(sign(diff(phase)))==-2, 1 ) + 1;
Phase_LocalMax  = phase(i_LocalMax);            % peak of phase curve
Phase_Min       = min(phase(1:i_LocalMax));     % minimum phase from DC to 'peak' frequency

Phase_Ripple    = Phase_LocalMax - Phase_Min;

end