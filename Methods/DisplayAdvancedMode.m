function handles = DisplayAdvancedMode( handles,type_analysis,pop_callback )

%On supprime l'ancien affichage
delete(handles.panel_analysis);

%On change le titre affich� dans le panel immuable
set(handles.static_name_analysis,'String',[type_analysis,' ','Analysis creator (Simple Mode)']);

%On cr�er le panel analysis
handles.panel_analysis=uipanel('Tag','panel_analysis',...
	'Parent',handles.panel_principal,...
	'units','pixels',...
    'Position',[7,140,392,245]);

%On r�cup�re les coordonn�es du panel analysis
pos_panel_analysis=get(handles.panel_analysis,'Position');

uicontrol('Style','text',...
        'String','Choose a form of syntax',...
        'Parent',handles.panel_analysis,...
        'FontSize',10,...
        'Position',[10,(pos_panel_analysis(4))-25,pos_panel_analysis(3)-20,15]);

%Liste des String � l'int�rieur du popup
if isequal(type_analysis,'.AC')
    listSyntax={'.AC type np fstart fstop','.AC type np fstart fstop <SWEEP var star stop incr >',...
        '.AC type np fstart fstop <SWEEP var type np start stop >',...
        '.AC var1 START = <param_expr1> STOP = <parSam_expr2> + STEP = <param_expr3>',...
        '.AC var1 START= start1 STOP= stop1 STEP = incr1',...
        '.AC type np fstart fstop <SWEEP DATA= datanm>',...
        '.AC DATA= datanm','.AC type np fstart fstop <SWEEP MONTE= val>',...
        '.AC DATA= datanm OPTIMIZE= opt_par_fun RESULTS= measnames + MODEL= optmod'};
elseif isequal(type_analysis,'.DC')
    listSyntax={'.DC var1 START = start1 STOP = stop1 STEP = incr1',...
        '.DC var1 START=<param_expr1> STOP=<param_expr2> + STEP=<param_expr3>',...
        '.DC var1 start1 stop1 incr1 <SWEEP var2 type np start2 stop2>',...
        '.DC var1 start1 stop1 incr1 <var2 start2 stop2 incr2 >',...
        '.DC var1 type np start1 stop1 <SWEEP DATA=datanm>',...
        '.DC DATA=datanm<SWEEP var2 start2 stop2 incr2>',...
        '.DC DATA=datanm',...
        '.DC var1 type np start1 stop1 <SWEEP MONTE=val>',...
        '.DC MONTE=val',...
        '.DC DATA=datanm OPTIMIZE=opt_par_fun RESULTS=measnames MODEL=optmod',...
        '.DC var1 start1 stop1 SWEEP OPTIMIZE=OPTxxx RESULTS=measname MODEL=optmod'};
else
    listSyntax={'.TRAN var1 START=start1 STOP=stop1 STEP=incr1',...
        '.TRAN var1 START=<param_expr1> STOP=<param_expr2> STEP=<param_expr3>',...
        '.TRAN var1 START=start1 STOP=stop1 STEP=incr1 <SWEEP var2 type np start2 stop2>',...
        '.TRAN DATA=datanm',...
        '.TRAN var1 START=start1 STOP=stop1 STEP=incr1 <SWEEP DATA=datanm>',...
        '.TRAN DATA=datanm<SWEEP var pstart pstop pincr>',...
        '.TRAN DATA=datanm OPTIMIZE=opt_par_fun RESULTS=measnames MODEL=optmod'};
end

%Creation du static text
uicontrol('Parent',handles.panel_analysis,...
    'Style','edit',...
    'String','Enter the complete command below',...
    'Position',[20,pos_panel_analysis(4)-90,pos_panel_analysis(3)-40,20]);
%Creation de l'editText
handles.edit_advanced=uicontrol('Parent',handles.panel_analysis,...
    'Style','edit',...
    'BackgroundColor','white',...
    'Position',[20,pos_panel_analysis(4)-120,pos_panel_analysis(3)-40,20]);
%Cr�ation du popup de choix de syntaxe  
handles.popup=uicontrol('Style','popupmenu',...
        'String',listSyntax,...
        'Parent',handles.panel_analysis,...
        'Position',[10,pos_panel_analysis(4)-50,pos_panel_analysis(3)-20,15],...
        'BackgroundColor','white',...
        'Callback',{pop_callback,handles});
end

