function [ affichage ] = DisplayHelp(string,int)
%DISPLAYHELP Summary of this function goes here
%   Detailed explanation goes here
%The imput is (string,int)
switch string
  case 'element'
      switch int
          case 1
              affichage=Textes.Empty;
          case 2
              affichage=Textes.R;
          case 3
              affichage=Textes.C;
          case 4
              affichage=Textes.L;
          case 5
              affichage=Textes.K;
          case 6
              affichage=Textes.D;
      end
  case 'option'
      switch int
          case 1
              affichage='';
          case 2
              affichage=Textes.DEFAULT;
          case 3
              affichage=Textes.ACOUT;
          case 4
              affichage=Textes.BRIEF;
          case 5
              affichage=Textes.CO;
          case 6
              affichage=Textes.INGOLD;
          case 7
              affichage=Textes.LENNAM;
          case 8
              affichage=Textes.LIST;
          case 9
              affichage=Textes.MEASDGT;
          case 10
              affichage=Textes.NODE;
          case 11
              affichage=Textes.NOELCK;
          case 12
              affichage=Textes.NOMOD;
          case 13
              affichage=Textes.NOPAGE;
          case 14
              affichage=Textes.NOTOP;
          case 15
              affichage=Textes.NUMDGT;
          case 16
              affichage=Textes.NXX;
          case 17
              affichage=Textes.OPTLST;
          case 18
              affichage=Textes.OPTS;
          case 19
              affichage=Textes.ARTIST;
          case 20
              affichage=Textes.CDS;
          case 21
              affichage=Textes.CSDF;
          case 22
              affichage=Textes.MEASOUT;
          case 23
              affichage=Textes.POST;
          case 24
              affichage=Textes.PROBE;
          case 25
              affichage=Textes.PSF;
          case 26
              affichage=Textes.SDA;
          case 27
              affichage=Textes.ZUKEN;
          case 28
              affichage=Textes.PLIM;
          case 29
              affichage=Textes.SEARCH;
          case 30
              affichage=Textes.LIST;
          case 31
              affichage=Textes.CPTIME;
          case 32
              affichage=Textes.EPSMIN;
          case 33
              affichage=Textes.EXPMAX;
          case 34
              affichage=Textes.LIMTIM;
          case 35
              affichage=Textes.NOWARN;
          case 36
              affichage=Textes.DIAGNOSTIC;
          case 37
              affichage=Textes.WARNLIMIT;
          case 38
              affichage=Textes.TEMP;
          case 39
              affichage=Textes.GLOBAL;
          case 40
              affichage=Textes.ACCT;
      end
  case 'source'
      switch int
          case 1
              affichage=Textes.Empty;
          case 2
              affichage=Textes.V;
          case 3
              affichage=Textes.V;
          case 4
              affichage=Textes.E;
          case 5
              affichage=Textes.F;
          case 6
              affichage=Textes.G;
          case 7
              affichage=Textes.H;
      end
    case 'netlist'
        affichage='';
    case 'choose_analysis'
        switch int
          case 1
              affichage=Textes.ac;
          case 2
              affichage=Textes.dc;
          case 3
              affichage=Textes.trans;
        end
    case 'option_analysis'
        switch int
          case 0
              affichage=Textes.Empty;
          case 1
              affichage=Textes.DATA;
          case 2
              affichage=Textes.MONTE;
          case 3
              affichage=Textes.START;
          case 4
              affichage=Textes.STOP;
          case 5
              affichage=Textes.SWEEP;
          case 6
              affichage=Textes.UIC;
          case 7
              affichage=Textes.OPTIMIZE;
          case 8
              affichage=Textes.MODEL;
          case 9
              affichage=Textes.RESULTS;
          case 10
              affichage=Textes.TEMP;
        end
    case 'advanced_analysis'
        switch int
          case 1
              affichage=Textes.Empty;
          case 2
              affichage=Textes.V;
          case 3
              affichage=Textes.V;
          case 4
              affichage=Textes.E;
          case 5
              affichage=Textes.F;
          case 6
              affichage=Textes.G;
          case 7
              affichage=Textes.H;
      end
    otherwise
        affichage='';      
end
end

