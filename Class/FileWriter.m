classdef FileWriter < handle
    %FileWriter to be used to create the settings files for the UI.
    %   functions will create the files for specific areas of the UI.
    % Initial Author: Alex Irvine 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % | @ChangeLog  |  
    % | Update      | Date          | Reason        | Author        |
    % | comments    | 13/01/2016    | documentation | Alex Irvine   |
    % |             |               |               |               |
    % | added derive
    % | x file      | 12/02/2016    | feature       | Alex Irvine   |
    % | added killer| 04/03/2016    | feature       | Alex Irvine   |
    % | rewriteDeriv| 10/03/2016    | feature       | Alex Irvine   |
    % | WriteErrorFi| 16/03/2016    | feature       | Alex Irvine   |
    % | WriteSOResul| 17/03/2016    | feature       | Alex Irvine   |
    % | WriteMOResul| 17/03/2016    | feature       | Alex Irvine   |
    % | WritePreProc| 29/03/2016    | feature       | Alex Irvine   |
    % | WriteResults| 30/03/2016    | feature       | Alex Irvine   |
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    properties (Constant = true)
        Prepend = {'Sub Main ()';...
            ''' model path';...  
            'OpenFile("C:\koziel\cst_projects\model_source.cst")';... % this is re written in CST functions
                  };
        Append1 = {''' Rebuild geometry with new parameters';...
            'Rebuild';...
            ''' start solver';...
            'Dim status As Integer'};
        Append2 = {''' save';...
            'Save';...
            'End Sub'...
                };
            
        PrependForNew = {'Sub Main ()';...
                  };
        Append1ForNew = {''' Rebuild geometry with new parameters';...
            'Rebuild';...
            ''' start solver'};
        Append2ForNew = {'Dim solver_status As Integer';...
            '''     .AutoNormImpedance (True)';...
            '''     .NormingImpedance (50.0)';...
            'solver_status = .Start';...
            'End With';...
            ''' save';...
            'Save';...
            'End Sub'...
                };
    end
    properties % set from settings models for use in creating files
        ListOfParameters;
        ListOfResponses; 
        SourceDirectory;
        AnalyticalFormula;
        AnalyticalPath;
        AnalyticalFunction;
        ObjectiveFunction;
        Specification;
        FocusedFrequency;
        Solver;
    end
    
    methods
        %% create a .bas file for the simulator to use.
        %% @Param obj, this instance of class
        %% @Author Alex Irvine
        function CreateBas(obj)
        %CreateBas creates the macro file to send params to CST
        %   This function will create a vba file which will be used as a
        %   switch to send a member to CST for simulation
        
            % set the path then open or create the file for writing
            path = sprintf('%s%s', obj.SourceDirectory... 
                ,'/runMacro.bas');
            file = fopen(path,'wt');
            
            % write the prepend
            for i = 1:length(FileWriter.Prepend)
                fprintf(file,'%s\n',FileWriter.Prepend{i});
            end
            
            % write the parameter names
            for i = 1:length(obj.ListOfParameters)
               param = obj.CreateParamString(obj.ListOfParameters{i});
               fprintf(file,'%s\n',param);
            end
            
            % write the append
            for i = 1:length(FileWriter.Append1)
               fprintf(file,'%s\n',FileWriter.Append1{i}); 
            end
            
            % write the correct solver
            if strcmp(obj.Solver,'FD')
                fprintf(file,'%s\n','status = FDSolver.Start');
            else
                fprintf(file,'%s\n','status = Solver.Start');
            end
            
            % finish appending
            for i=1:length(FileWriter.Append2)
                fprintf(file,'%s\n',FileWriter.Append2{i});
            end
            
            % close
            fclose(file);
        end
        
        %% create a .bas file for the simulator to use (new socket)
        %% @Param obj, this instance of class
        %% @Author Alex Irvine
        function CreateBasForNewLink(obj)
        %CreateBas creates the macro file to send params to CST
        %   This function will create a vba file which will be used as a
        %   switch to send a member to CST for simulation
        
            % set the path then open or create the file for writing
            path = sprintf('%s%s', obj.SourceDirectory... 
                ,'/runMacro.bas');
            file = fopen(path,'wt');
            
            % write v2 at start
            fprintf(file,'''%s\n','CST script file v2');
            
            % write the prepend
            for i = 1:length(FileWriter.PrependForNew)
                fprintf(file,'%s\n',FileWriter.PrependForNew{i});
            end
            
            % write the parameter names
            for i = 1:length(obj.ListOfParameters)
               param = obj.CreateParamString(obj.ListOfParameters{i});
               fprintf(file,'%s\n',param);
            end
            
            % write the append
            for i = 1:length(FileWriter.Append1ForNew)
               fprintf(file,'%s\n',FileWriter.Append1ForNew{i}); 
            end
            
            % write the correct solver
            if strcmp(obj.Solver,'FD')
                fprintf(file,'%s\n','With FDSolver');
            else
                fprintf(file,'%s\n','With Solver');
            end
            
            % finish appending
            for i=1:length(FileWriter.Append2ForNew)
                fprintf(file,'%s\n',FileWriter.Append2ForNew{i});
            end
            
            % close
            fclose(file);
        end
        
        %% create the string for params to place in the .bas file
        %% @Param param, the parameter to be written
        %% @Returns param, the string containing the param
        %% @Author Alex Irvine
        function param = CreateParamString(~,param) 
        %CreateParamString creates the whole string required to be written.
        %   Taking the parameter name this function will create the whole
        %   line for the vba file that needs to be written
            param = sprintf('%s "%s", %s',...
               'StoreParameter', param.Name, '0');
        end
        
        %% create function file for analytical formula response
        %% @Param obj, this instance of the class
        %% @Param respName, the name of the response
        %% @Returns errored, a bool containing error status
        %% @Author Alex Irvine
        function errored = CreateAnalyticalFile(obj, respName)
        %CreateAnalyticalFile creates a file for the user to input their
        %analytical function
        %   If the user is not using simulations then their response would
        %   need to be an analytical formula written in the file this
        %   function creates
            
            % open or create the file
            file = fopen(obj.AnalyticalFormula,'wt');
            
            % write the first line
            fprintf(file,'%s%s%s%s%s%s\n', 'function ',respName,' = ',...
                'response_',respName,'(x)');
            
            % create the comments for the file
            comments = obj.CreateComments;
            
            % Write the comments
            for i=1:length(comments)
                fprintf(file,'%s\n',comments{i});
            end
            
            % close
            fclose(file);
            
            % get the function handle
            obj.CreateHandle();
            
            % make sure the path is included
            obj.AddFileToPath();
            
            % display the file to the user
            open(obj.AnalyticalFormula);
            
            % got to here then no errors
            errored = false;
        end
        
        %% create cell array for comments
        %% @Param obj, this instance of the class
        %% @Returns comments, cell array containing comments
        %% @Author Alex Irvine
        function comments = CreateComments(obj)
        %CreateComments creates the comments to be written in the
        %analytical formula file.
        
            % create first line
            comments{1,1} = '%% Write your analytical formula for the response in this file';
            listOfParamNames = {};
            
            % create cell array of parameters
            for i = 1:length(obj.ListOfParameters)
                if i ~= length(obj.ListOfParameters)
                    listOfParamNames{1,i} = sprintf('%s%s',obj.ListOfParameters{i}.Name,', ');
                else
                    listOfParamNames{1,i} = sprintf('%s%s',obj.ListOfParameters{i}.Name,' ');
                end
            end
            
            % create other lines
            if isempty(listOfParamNames)
                comments{2,1} = '%% x = parameters';
            else
                comments{2,1} = ['%% x = [ ',listOfParamNames{:},']'];
            end
            comments{3,1} = '%% n  = size(x,2)';
            comments{4,1} = '%% ensure you output to the named response variable';
        end
        
        %% add the parent folder of the analytical file to the working path
        %% deprecated since creation of project folders
        %% @Param obj, this instance of the class
        %% @Returns obj, updated object
        %% @Author Alex Irvine
        function obj = AddFileToPath(obj)
        %AddFileToPath adds the parent folder of the analytical file to
        %matlabs working path.
        %   This function is now deprecated due to projects having a parent
        %   folder which has its path added on load.
        
            % build path to add
            obj.AnalyticalPath = obj.AnalyticalFormula(1:end-length(obj.AnalyticalFunction)-3);
            addpath(obj.AnalyticalPath);
        end
        
        %% create function handle, passed as string for feval and string 
        %% builders alike.
        %% @Param obj, this instance of class
        %% @Returns obj, updated object
        %% @Author Alex Irvine
        function obj = CreateHandle(obj)
        %CreateHandle creates a string representation of the created
        %analytical function to pass around for function calls.
        
            analPath = strsplit(obj.AnalyticalFormula,filesep);
            fileName = strsplit(analPath{end},'.');
            
            % store handle
            obj.AnalyticalFunction = fileName{1};
        end
        
        %% default writer for generic use
        %% @Param File, the full path to the file to be written
        %% @Param CellArr, the cell array containing data to be written
        %% @Author Alex Irvine
        function GenericWrite(~, File, CellArr)
        %GenericWrite will write the passed cell array to the file
        %   Construct a cell array in order of lines to be written then
        %   pass the full path to the file and the cell array to create the
        %   file
            file = fopen(File,'wt');
            for i=1:length(CellArr)
                fprintf(file,'%s\n',CellArr{i});
            end
            fclose(file);
        end
        
        %% create a function file for an objective function
        %% @Param obj, this instance of class
        %% @Param funcname, the name of the function to be written
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns errored, status flag
        %% @Author Alex Irvine
        function errored = CreateObjectiveFile(obj,funcname,AlgSettings,...
                SimSettings)
        %CreateObjectiveFile creates the .m file containing the first line 
        %and comments.
        %   The user is expected to write their own objective functions in
        %   this file. 
            
            % create the cell array to be written
            cellarr = obj.CreateObjCellArrForFiles(funcname,AlgSettings,SimSettings);
            
            % write the file
            obj.GenericWrite(obj.ObjectiveFunction,cellarr);
            
            % add the path (now deprecated due to project folders)
            path = obj.ObjectiveFunction(1:end-length(funcname)-3);
            addpath(path);
            
            % open the file for the user to modify
            open(obj.ObjectiveFunction);
            errored = false;
        end
        
        %% create the cell array for objective function to be written
        %% @Param obj, this instance of class
        %% @Param funcname, the name of the function
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns cellarr, cell array containing the lines to be written
        %% @Author Alex Irvine
        function cellarr = CreateObjCellArr(obj,funcname,AlgSettings,...
                SimSettings)
        %CreateObjCellArr creates a cell array that can then be written 
        %using generic write.
        %   This function will separate information from settings to be
        %   written to the objective function files. The returned cell
        %   array then contains, in order, all lines needing to be written
        %   for GenericWrite to handle writing.
        
            cellarr = {};
            resNames = {};
            
            % response names in comma delimited list 
            for i=1:length(AlgSettings.ListOfResponses)
                if i==1 && i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf('%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i==1 && i==length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                else
                    resNames{1,i} = sprintf('%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                end
            end
            
            % first line
            cellarr{1,1} = ['function y = ',funcname,'(x',resNames{:},')'];
            
            % second line
            cellarr{2,1} = ['%% Use response names as they are passed to',...
                ' the function to build your objective function below.'];
            
            % if there is a focused frequency inform user in comments
            % where the indices are
            if ~isempty(obj.FocusedFrequency)
                % get the comments
                temp = obj.CreateSimComments(AlgSettings,SimSettings);
                
                % add comments to cell array for writing.
                for i=1:length(temp)
                    cellarr{2+i,1} = temp{i};
                end
            end
        end 
        
                %% create the cell array for objective function to be written
        %% @Param obj, this instance of class
        %% @Param funcname, the name of the function
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns cellarr, cell array containing the lines to be written
        %% @Author Alex Irvine
        function cellarr = CreateObjCellArrForFiles(obj,funcname,AlgSettings,...
                SimSettings)
        %CreateObjCellArr creates a cell array that can then be written 
        %using generic write.
        %   This function will separate information from settings to be
        %   written to the objective function files. The returned cell
        %   array then contains, in order, all lines needing to be written
        %   for GenericWrite to handle writing.
        
            cellarr = {};
            resNames = {};
            
            % response names in comma delimited list 
            for i=1:length(AlgSettings.ListOfResponses)
                if i==1 && i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf('%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i==1 && i==length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                else
                    resNames{1,i} = sprintf('%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                end
            end
            
            % first line
            cellarr{1,1} = ['function y = ',funcname,'(x',resNames{:},')'];
            
            % second line
            cellarr{2,1} = ['%% Use response names as they are passed to',...
                ' the function to build your objective function below.'];
            
            % add member to comments
            for i = 1:length(AlgSettings.ListOfParameters)
                if i ~= length(AlgSettings.ListOfParameters)
                    listOfParamNames{1,i} = sprintf('%s%s',AlgSettings.ListOfParameters{i}.Name,', ');
                else
                    listOfParamNames{1,i} = sprintf('%s%s',AlgSettings.ListOfParameters{i}.Name,' ');
                end
            end
            if isempty(listOfParamNames)
                cellarr{end+1,1} = '%% x = parameters';
            else
                cellarr{end+1,1} = ['%% x = [ ',listOfParamNames{:},']'];
            end
            
            % add responses to comments
            for i=1:length(AlgSettings.ListOfResponses)
                if strcmp(AlgSettings.ListOfResponses{i}.FormulaOrSimulation,'Simulation')
                    fileNames = {};
                    for j=1:length(AlgSettings.ListOfResponses{i}.SimResponseFiles)
                        if j==length(AlgSettings.ListOfResponses{i}.SimResponseFiles)
                            fileNames{end+1}=AlgSettings.ListOfResponses{i}.SimResponseFiles{j};
                        else
                            fileNames{end+1}=[AlgSettings.ListOfResponses{i}.SimResponseFiles{j},', '];
                        end
                    end
                    cellarr{end+1,1} = ['%% ',AlgSettings.ListOfResponses{i}.Name,' = {',fileNames{:},'}'];
                end
            end
        end 
        
        %% create a function file for a specification
        %% @Param obj, this instance of class
        %% @Param specname, the name of the constraint to be written
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns errored, status flag
        %% @Author Alex Irvine
        function errored = CreateSpecificationFile(obj,specname,...
                AlgSettings,SimSettings)
        %CreateSpecificationFile creates the .m file containing the first 
        %line and comments of the function file.
        %   The user is expected to write their own constraint functions in
        %   this file.    
            
            % get the cell array
            cellarr = obj.CreateSpecCellArrForFiles(specname,AlgSettings,SimSettings);
            
            % write
            obj.GenericWrite(obj.Specification,cellarr);
            
            % add the path (now not needed due to project folders)
            path = obj.Specification(1:end-length(specname)-3);
            addpath(path);
            
            % open the file for modification by the user
            open(obj.Specification);
            errored = false;
        end
        
        %% create the cell array for specification to write to file.
        %% @Param obj, this instance of class
        %% @Param specname, the name of the function
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns cellarr, cell array containing the lines to be written
        %% @Author Alex Irvine
        function cellarr = CreateSpecCellArr(obj,specname,AlgSettings,...
                SimSettings)
        %CreateSpecCellArr creates a cell array that can then be written 
        %using generic write.
        %   This function will separate information from settings to be
        %   written to the constraint function files. The returned cell
        %   array then contains, in order, all lines needing to be written
        %   for GenericWrite to handle writing.   
        
            cellarr = {};
            resNames = {};
            
            % create comma delimited list of response names
            for i=1:length(AlgSettings.ListOfResponses)
                if i==1 && i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf('%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i==1 && i==length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                else
                    resNames{1,i} = sprintf('%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                end
            end
            
            % add lines to cell array
            cellarr{1,1} = ['function y = ',specname,'(x',resNames{:},')'];
            cellarr{2,1} = ['%% Use response names as they are passed'...
                ' to the function to build your specifications below.'];
            cellarr{3,1} = '%% Specification will be treated as <= 0.';
            
            % if user has an interested frequency inform them in the
            % comments of the indices.
            if ~isempty(obj.FocusedFrequency)
                % get the comments
                temp = obj.CreateSimComments(AlgSettings,SimSettings);
                
                % add to cell array
                for i=1:length(temp)
                    cellarr{3+i,1} = temp{i};
                end
            end
        end
        
        %% create the cell array for specification to write to file.
        %% @Param obj, this instance of class
        %% @Param specname, the name of the function
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns cellarr, cell array containing the lines to be written
        %% @Author Alex Irvine
        function cellarr = CreateSpecCellArrForFiles(obj,specname,AlgSettings,...
                SimSettings)
        %CreateSpecCellArr creates a cell array that can then be written 
        %using generic write.
        %   This function will separate information from settings to be
        %   written to the constraint function files. The returned cell
        %   array then contains, in order, all lines needing to be written
        %   for GenericWrite to handle writing.   
        
            cellarr = {};
            resNames = {};
            
            % create comma delimited list of response names
            for i=1:length(AlgSettings.ListOfResponses)
                if i==1 && i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf('%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,',');
                elseif i==1 && i==length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf(',%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                else
                    resNames{1,i} = sprintf('%s',...
                        AlgSettings.ListOfResponses{i}.Name);
                end
            end
            
            % add lines to cell array
            cellarr{1,1} = ['function y = ',specname,'(x',resNames{:},')'];
            cellarr{2,1} = ['%% Use response names as they are passed'...
                ' to the function to build your specifications below.'];
            cellarr{3,1} = '%% Specification will be treated as <= 0.';
            
            % add member to comments
            for i = 1:length(AlgSettings.ListOfParameters)
                if i ~= length(AlgSettings.ListOfParameters)
                    listOfParamNames{1,i} = sprintf('%s%s',AlgSettings.ListOfParameters{i}.Name,', ');
                else
                    listOfParamNames{1,i} = sprintf('%s%s',AlgSettings.ListOfParameters{i}.Name,' ');
                end
            end
            if isempty(listOfParamNames)
                cellarr{end+1,1} = '%% x = parameters';
            else
                cellarr{end+1,1} = ['%% x = [ ',listOfParamNames{:},']'];
            end
            
            % add responses to comments
            for i=1:length(AlgSettings.ListOfResponses)
                if strcmp(AlgSettings.ListOfResponses{i}.FormulaOrSimulation,'Simulation')
                    fileNames = {};
                    for j=1:length(AlgSettings.ListOfResponses{i}.SimResponseFiles)
                        if j==length(AlgSettings.ListOfResponses{i}.SimResponseFiles)
                            fileNames{end+1}=AlgSettings.ListOfResponses{i}.SimResponseFiles{j};
                        else
                            fileNames{end+1}=[AlgSettings.ListOfResponses{i}.SimResponseFiles{j},', '];
                        end
                    end
                    cellarr{end+1,1} = ['%% ',AlgSettings.ListOfResponses{i}.Name,' = {',fileNames{:},'}'];
                end
            end
        end
        
        %% create the parent function which gathers responses and calls 
        %% objective and spec functions.
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Author Alex Irvine
        function CreateParentFile(obj,AlgSettings)
        %CreateParentFile creates a file that will gather the responses and
        %run the required functions.
        %   This function creates a file that will serve as the high level
        %   function for the optimisation algorithms to run. This high
        %   level file will return the objective value for minimisation by
        %   collecting the responses from either simulations or analytical
        %   functions, then pass the responses to the objective function
        %   and constraints before generating a fitness value based on
        %   constraints and objective values.
        
            % create cell arrays for each section
            responseSection = ...
                obj.CreateParentResponseSectionCellArrayForFiles(AlgSettings);
            objective = obj.CreateParentObjectiveCellArray(AlgSettings);
            cons = obj.CreateParentConstraintCellArray(AlgSettings);
            yval = obj.CreateParentYvalCellArray(AlgSettings);
            y = obj.CreateParentYCellArray(AlgSettings);
            
            % generate path and file name
            fullpath = [AlgSettings.ProjectDirectory,filesep,'get',...
                AlgSettings.ProjectName,'values.m'];
            file = fopen(fullpath,'wt');
            
            % print first lines
            fprintf(file,'%s\n','% If using Custom algorithm, this file serves as the objective function');
            fprintf(file,'%s%s%s\n','function y = get',AlgSettings.ProjectName,'values(x)');
            
            % if smart params use derive x
            if strcmp(AlgSettings.ParamType,'Smart')
                fprintf(file,'%s\n',['x = deriveXfor',...
                    AlgSettings.ProjectName,'(x);']);
            end
            
            % loop each cell array and print section
            for i=1:length(responseSection)
                fprintf(file,'%s\n',responseSection{i});
            end
            fprintf(file,'\n');
            for i=1:length(objective)
                fprintf(file,'%s\n',objective{i});
            end
            fprintf(file,'\n');
            if ~isempty(cons)
                for i=1:length(cons)
                    fprintf(file,'%s\n',cons{i});
                end
                fprintf(file,'\n');
            end
            if ~isempty(yval)
                for i=1:length(yval)
                    fprintf(file,'%s',yval{i});
                end
            fprintf(file,'\n');
            end
            fprintf(file,'\n');
            
            % print objective value line
            fprintf(file,'%s',y{:});
            
            % close
            fclose(file);
        end
        
        %% create a cell array containing response functions.
        %% @Param AlgSettings, algorithm settings
        %% @Returns responseSection, cell array containing the responses
        %% @Author Alex Irvine
        function responseSection = CreateParentResponseSectionCellArray...
                (~,AlgSettings)
        %responseSection creates a cell array that can be used to write the
        %response section to the parent function file.
            responseSection = {};
            writtenfiles = {};
            for i=1:length(AlgSettings.ListOfResponses)
                % if the response is an analytical formula
                if strcmp(AlgSettings.ListOfResponses{i}.FormulaOrSimulation,'Formula')
                    responseSection{1,i} = sprintf('%s%s%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,...
                        ' = ',...
                        AlgSettings.ListOfResponses{i}.AnalyticalFormula,...
                        '(x);');
                else % response is a simulation
                    simfile = strsplit(AlgSettings.ListOfResponses{i}.SimulationFile,filesep);
                    simfile = simfile{end};
                    if strcmp(simfile(end-3:end),'.cst') % if it is a cst sim
                        tempfile=AlgSettings.ListOfResponses{i}.SimulationFile;
                        if ~ismember(tempfile,writtenfiles) % if the response isn't written
                            responseSection{1,end+1} = ['response',num2str(i),...
                                ' = SimulationController.Run(x,','''',simfile,'''',');'];
                            respNo = 1;
                            writtenfiles{end+1} = tempfile; % resp is now written
                            for j=1:length(AlgSettings.ListOfResponses) % get responses that belong to this sim
                                if strcmp(AlgSettings.ListOfResponses{j}.FormulaOrSimulation,...
                                        'Simulation')
                                    if strcmp(AlgSettings.ListOfResponses{j}.SimulationFile,...
                                            tempfile) % if this response is the same sim file
                                        responseSection{1,end+1} = [AlgSettings.ListOfResponses{j}.Name,...
                                            ' = ','response',num2str(i),'{',num2str(respNo),'};'];
                                        respNo = respNo+1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        %% create a cell array containing response functions.
        %% @Param AlgSettings, algorithm settings
        %% @Returns responseSection, cell array containing the responses
        %% @Author Alex Irvine
        function responseSection = CreateParentResponseSectionCellArrayForFiles...
                (~,AlgSettings)
        %responseSection creates a cell array that can be used to write the
        %response section to the parent function file.
            responseSection = {};
            writtenfiles = {};
            for i=1:length(AlgSettings.ListOfResponses)
                % if the response is an analytical formula
                if strcmp(AlgSettings.ListOfResponses{i}.FormulaOrSimulation,'Formula')
                    responseSection{1,i} = sprintf('%s%s%s%s',...
                        AlgSettings.ListOfResponses{i}.Name,...
                        ' = ',...
                        AlgSettings.ListOfResponses{i}.AnalyticalFormula,...
                        '(x);');
                else % response is a simulation
                    simfile = strsplit(AlgSettings.ListOfResponses{i}.SimulationFile,filesep);
                    simfile = simfile{end};
                    if strcmp(simfile(end-3:end),'.cst') % if it is a cst sim
                        tempfile=AlgSettings.ListOfResponses{i}.SimulationFile;
                        if ~ismember(tempfile,writtenfiles) % if the response isn't written
                            responseSection{1,end+1} = ['path',num2str(i),...
                                ' = SimulationController.Run(x,','''',simfile,'''',');'];
                            writtenfiles{end+1} = tempfile; % resp is now written
                            for j=1:length(AlgSettings.ListOfResponses) % get responses that belong to this sim
                                if strcmp(AlgSettings.ListOfResponses{j}.FormulaOrSimulation,...
                                        'Simulation')
                                    if strcmp(AlgSettings.ListOfResponses{j}.SimulationFile,...
                                            tempfile) % if this response is the same sim file
                                        % create string for file names as
                                        % cell array
                                        fileNames = {};
                                        for k=1:length(AlgSettings.ListOfResponses{j}.SimResponseFiles)
                                            if k==length(AlgSettings.ListOfResponses{j}.SimResponseFiles)
                                                fileNames{end+1} = ['''',AlgSettings.ListOfResponses{j}.SimResponseFiles{k},''''];
                                            else
                                                fileNames{end+1} = ['''',AlgSettings.ListOfResponses{j}.SimResponseFiles{k},'''',','];
                                            end
                                        end
                                        responseSection{1,end+1} = [AlgSettings.ListOfResponses{j}.Name,...
                                            ' = ','SimulationController.GetResponse({',...
                                            fileNames{:},'},path',num2str(i),');'];
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        %% create a cell array containing objective function
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Returns objective, cell array containing objective section
        %% @Author Alex Irvine
        function objective = CreateParentObjectiveCellArray(obj,...
                AlgSettings)
        %CreateParentObjectiveCellArray creates a cell array containing the
        %objective functions for the parent file.
            objective = {};
            resNames = obj.CreateListOfResponses(AlgSettings);
            for i=1:length(AlgSettings.ListOfObjectiveFunctions)
                if ~isempty(resNames)
                    objective{1,i} = [...
                        'yobj(',num2str(i),',:) = ',...
                        AlgSettings.ListOfObjectiveFunctions{i}.Name,...
                        '(x,',...
                        resNames{1,:},...
                        ');'];
                else
                    objective{1,i} = [...
                        'yobj(',num2str(i),',:) = ',...
                        AlgSettings.ListOfObjectiveFunctions{i}.Name,...
                        '(x);'];
                end
            end
        end
        
        %% create a comma delimited list of response names.
        %% @Param AlgSettings, algorithm settings
        %% @Returns resNames, a cell array containing responses
        %% @Author Alex Irvine
        function resNames = CreateListOfResponses(~, AlgSettings)
        %CreateListOfResponses creates a comma delimited list of the
        %response names
        %   This function creates a cell array that can be used to write
        %   arguments to a function call in the form of a list of
        %   responses
            resNames = {};
            for i=1:length(AlgSettings.ListOfResponses)
                if i~=length(AlgSettings.ListOfResponses)
                    resNames{1,i} = sprintf('%s%s',AlgSettings.ListOfResponses{i}.Name,',');
                else
                    resNames{1,i} = sprintf('%s',AlgSettings.ListOfResponses{i}.Name);
                end
            end
        end
        
        %% create a cell array containing constraint functions
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Returns cons, a cell array containing constraints
        %% @Author Alex Irvine
        function cons = CreateParentConstraintCellArray(obj,AlgSettings)
        %CreateParentConstraintCellArray creates a cell array containing 
        %function calls to constraints
        %   The cell array created by this function can be used to write
        %   the constrain section of the parent file.
            cons = {};
            resNames = obj.CreateListOfResponses(AlgSettings);
            for i=1:length(AlgSettings.ListOfConstraints)
                if ~isempty(resNames)
                    cons{1,i} = [... 
                        'yc(',...
                        num2str(i),...
                        ') = ',...
                        AlgSettings.ListOfConstraints{i}.Name,...
                        '(x,',...
                        resNames{1,:},...
                        ');'];
                else
                    cons{1,i} = [... 
                        'yc(',...
                        num2str(i),...
                        ') = ',...
                        AlgSettings.ListOfConstraints{i}.Name,...
                        '(x);'];
                end
            end
        end
        
        %% create a cell array containing yval line for parent function.
        %% @Param AlgSettings, algorithm settings
        %% @Returns yval, cell array containing y value
        %% @Author Alex Irvine
        function yval = CreateParentYvalCellArray(~,AlgSettings)
        %CreateParentYvalCellArray creates a cell array containing the
        %objective value plus constraints added into one value.
        %   The value that this line creates is then the real objective
        %   value that can be minimised.
            yval = {};
            if ~isempty(AlgSettings.ListOfConstraints)
                if ~isempty(AlgSettings.ListOfObjectiveFunctions)
                    yval{1,1} = sprintf('%s','yval = yobj+');
                else
                    yval{1,1} = sprintf('%s','yval = ');
                end
            end
            for i=1:length(AlgSettings.ListOfConstraints)
                if i~=length(AlgSettings.ListOfConstraints)
                    yval{1,i+1} = sprintf('%d%s%d%s%d%s',...
                        AlgSettings.ListOfConstraints{i}.Penalty,...
                        '*max([yc(',...
                        i,...
                        '),',...
                        0,...
                        '])+');
                else
                    yval{1,i+1} = sprintf('%d%s%d%s%d%s',...
                        AlgSettings.ListOfConstraints{i}.Penalty,...
                        '*max([yc(',...
                        i,...
                        '),',...
                        0,...
                        ']);');
                end
            end
        end
        
        %% create end line for parent function.
        %% @Param AlgSettings, algorithm settings
        %% @Returns y, cell array containing the y line
        %% @Author Alex Irvine
        function y = CreateParentYCellArray(~,AlgSettings)
        %CreateParentYCellArray creates a cell array containing a line
        %where all values are added to a vector called y
            if isempty(AlgSettings.ListOfObjectiveFunctions)...
                    && ~isempty(AlgSettings.ListOfConstraints)
                y = {'y = [yval,yc];'};
            elseif ~isempty(AlgSettings.ListOfConstraints)...
                    && ~isempty(AlgSettings.ListOfObjectiveFunctions)
                y = {'y = [yval,yobj,yc];'};
            elseif ~isempty(AlgSettings.ListOfObjectiveFunctions)
                y = {'y = yobj;'};
            else
                y = {'y = ['};
                for i=1:length(AlgSettings.ListOfResponses)
                    if i~=length(AlgSettings.ListOfResponses)
                        y{end+1} = [AlgSettings.ListOfResponses{i}.Name,','];
                    else
                        y{end+1} = AlgSettings.ListOfResponses{i}.Name;
                    end
                end
                y{end+1} = '];';
            end
        end
        
        %% check if responses are sim if they are add comments indicating 
        %% and displaying FF ranges.
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Returns simComments, cell array containing additional comments
        %% @Author Alex Irvine
        function simComments = CreateSimComments(obj,AlgSettings,...
                SimSettings)
        %CreateSimComments checks is there are any simulation responses and
        %extracts the interested frequency for comments.
        %   This function can be used as a black box, if the cell array
        %   returned is empty then there were no simulation responses and
        %   if it contains comments then it has extracted the focused
        %   frequency.
            simComments = {};
            if ~isempty(obj.FocusedFrequency)
                for i=1:length(AlgSettings.ListOfResponses)
                    if strcmp(AlgSettings.ListOfResponses{i}.FormulaOrSimulation,'Simulation')
                        omega = CSTHelper.CreateOmega(SimSettings.FrequencyRange,SimSettings.FrequencyUnit);
                        FFi = CSTHelper.ExtractFFIndexFromOmega(omega,obj.FocusedFrequency,SimSettings.FrequencyUnit);
                        simComments{end+1} = sprintf('%s%s%s%s%s%d%s%d%s','%% ',AlgSettings.ListOfResponses{i}.Name,...
                            ' is a simulation response, your Focused Frequency is ',AlgSettings.ListOfResponses{i}.Name,...
                            '(',FFi(1),':',FFi(2),')');
                    end
                end
            end
        end
        
        %% write the setup.txt file for CST connection software to use.
        %% @Param obj, this instance of class
        %% @Param SimSettings, simulation settings
        %% @Param SourceModel, a string containing the name of the source
        %% model
        %% @Param ListOfResponses, a string containing responses
        %% @Returns file, the full path to the file created
        %% @Author Alex Irvine
        function file = WriteCSTSetupFile(obj,SimSettings,SourceModel,...
                ListOfResponses)
        %WriteCSTSetupFile writes a .txt file for the CST connection
        %   This function creates a txt file with information to generate a
        %   struct in the CST connection code. This function can be
        %   deprecated in the future in favour of modifying the CST code to
        %   accept the struct directly from SimSettings.
        
            % get formatted response names
            listOfResponseTypes = obj.GetListOfResponseTypes(ListOfResponses);
            
            % get formats
            listOfFormats = obj.GetListOfFormats(ListOfResponses);
            
            % generate path and create file
            filepath = sprintf('%s%s%s',SimSettings.SourceDirectory,filesep,'setup.txt');
            file = fopen(filepath,'wt');
            
            % write file
            fprintf(file,'%-20s%-s\n','SourceDirectory',SimSettings.SourceDirectory);
            fprintf(file,'%-20s%-s\n','WorkingDirectory',SimSettings.WorkingDirectory);
            fprintf(file,'%-20s%-s\n','SourceModel',SourceModel);
            fprintf(file,'%-20s%-s\n','SourceScript','runMacro.bas');
            fprintf(file,'%-20s%-s\n','DatabaseDirectory',SimSettings.DatabaseDirectory);
            fprintf(file,'%-20s%-s\n','DatabaseFile',SimSettings.DatabaseFile);
            fprintf(file,'%-20s%-s\n','NumberOfPorts',SimSettings.NumberOfPorts);
            fprintf(file,'%-20s%-s','ResponseType',listOfResponseTypes{1}); % res type (list)
            fprintf(file,'%s',listOfResponseTypes{2:end});
            fprintf(file,'\n');
            fprintf(file,'%-20s%-s','ResponseFormat',listOfFormats{1}); % res format (list)
            fprintf(file,'%s',listOfFormats{2:end});
            fprintf(file,'\n');
            fprintf(file,'%-20s%-s\n','RrawDirectory',SimSettings.RrawDirectory);
            fprintf(file,'%-20s%-s\n','ModifyFarfieldF','0');
            fprintf(file,'%-20s%-s\n','FrequencyUnit',SimSettings.FrequencyUnit);
            
            % close and return path
            fclose(file);
            file = filepath;
        end

                %% write the setup.txt file for CST connection software to use (for
        %% new CST link)
        %% @Param obj, this instance of class
        %% @Param SimSettings, simulation settings
        %% @Param SourceModel, a string containing the name of the source
        %% model
        %% @Param ListOfResponses, a string containing responses
        %% @Returns file, the full path to the file created
        %% @Author Alex Irvine
        function file = WriteCSTSetupFileForFiles(~,SimSettings,SourceModel)
        %WriteCSTSetupFile writes a .txt file for the CST connection
        %   This function creates a txt file with information to generate a
        %   struct in the CST connection code. This function can be
        %   deprecated in the future in favour of modifying the CST code to
        %   accept the struct directly from SimSettings.
        
            % generate path and create file
            filepath = sprintf('%s%s%s',SimSettings.SourceDirectory,filesep,'setup.txt');
            file = fopen(filepath,'wt');
            
            % write file
            fprintf(file,'%s\n','#CST/HFSS model configuration file v2');
            fprintf(file,'%s; %s\n','SourceDirectory',SimSettings.SourceDirectory);
            fprintf(file,'%s; %s\n','WorkingDirectory',SimSettings.WorkingDirectory);
            fprintf(file,'%s; %s\n','ModelType','$auto$');
            fprintf(file,'%s; %s\n','SourceModel',SourceModel);
            fprintf(file,'%s; %s\n','SourceScript',SimSettings.SourceScript);
            fprintf(file,'%s; %s\n','NumberOfPorts',SimSettings.NumberOfPorts);
            fprintf(file,'%s; %s\n','ModifyFarfieldF','0');
            fprintf(file,'%s; %s\n','GridComputing','0');
            % close and return path
            fclose(file);
            file = filepath;
        end
        
        %% write the setup.txt file for CST connection software to use (for
        %% new CST link)
        %% @Param obj, this instance of class
        %% @Param SimSettings, simulation settings
        %% @Param SourceModel, a string containing the name of the source
        %% model
        %% @Param ListOfResponses, a string containing responses
        %% @Returns file, the full path to the file created
        %% @Author Alex Irvine
        function file = WriteCSTSetupFileForNewLink(obj,SimSettings,SourceModel,...
                ListOfResponses)
        %WriteCSTSetupFile writes a .txt file for the CST connection
        %   This function creates a txt file with information to generate a
        %   struct in the CST connection code. This function can be
        %   deprecated in the future in favour of modifying the CST code to
        %   accept the struct directly from SimSettings.
        
            % get formatted response names
            listOfResponseTypes = obj.GetListOfResponseTypes(ListOfResponses);
            
            % get formats
            listOfFormats = obj.GetListOfFormats(ListOfResponses);
            
            % generate path and create file
            filepath = sprintf('%s%s%s',SimSettings.SourceDirectory,filesep,'setup.txt');
            file = fopen(filepath,'wt');
            
            % write file
            fprintf(file,'%s\n','#CST/HFSS model configuration file v2');
            fprintf(file,'%s; %s\n','SourceDirectory',SimSettings.SourceDirectory);
            fprintf(file,'%s; %s\n','WorkingDirectory',SimSettings.WorkingDirectory);
            fprintf(file,'%s; %s\n','ModelType','$auto$');
            fprintf(file,'%s; %s\n','SourceModel',SourceModel);
            fprintf(file,'%s; %s\n','SourceScript',SimSettings.SourceScript);
            fprintf(file,'%s; %s\n','DatabaseDirectory',SimSettings.DatabaseDirectory);
            fprintf(file,'%s; %s\n','DatabaseFile',SimSettings.DatabaseFile);
            fprintf(file,'%s; %s\n','NumberOfPorts',SimSettings.NumberOfPorts);
            fprintf(file,'%s; %s','ResponseType',listOfResponseTypes{1}); % res type (list)
            fprintf(file,'%s',listOfResponseTypes{2:end});
            fprintf(file,'\n');
            fprintf(file,'%s; %s','ResponseFormat',listOfFormats{1}); % res format (list)
            fprintf(file,'%s',listOfFormats{2:end});
            fprintf(file,'\n');
            fprintf(file,'%s; %s\n','RrawDirectory',SimSettings.RrawDirectory);
            fprintf(file,'%s; %s\n','ModifyFarfieldF','0');
            fprintf(file,'%s; %s\n','FrequencyUnit',SimSettings.FrequencyUnit);
            fprintf(file,'%s; %s\n','GridComputing','0');
            % close and return path
            fclose(file);
            file = filepath;
        end
        
        %% create a string list of response names.
        %% @Param ListOfResponses, a cell array containing responses
        %% @Returns listOfResponseTypes, a formated list of response names
        %% @Author Alex Irvine
        function listOfResponseTypes = GetListOfResponseTypes(~,...
                ListOfResponses)
        %GetListOfResponseTypes takes a list of responses and generates a
        %formatted list for the setup file
            listOfResponseTypes={};
            for i=1:length(ListOfResponses)
                if strcmp(ListOfResponses{i}.FormulaOrSimulation,'Simulation')
                    if i~=length(ListOfResponses)
                        listOfResponseTypes{i} = sprintf('%s ',ListOfResponses{i}.Name);
                    else
                        listOfResponseTypes{i} = sprintf('%s',ListOfResponses{i}.Name);
                    end
                end
            end
        end
        
        %% create a string list of response formats.
        %% @Param ListOfResponses, a list of responses
        %% @Returns listOfFormats, a list of the response formats
        %% @Author Alex Irvine
        function listOfFormats = GetListOfFormats(~,ListOfResponses)
        %GetListOfFormats creates a comma delimited string list of response
        %formats.
        %   The GUI no longer allows the user to select a format, this
        %   function will now set all formats to complex however the CST
        %   socket does not use this information and will return complex
        %   responses regardless of the format in the setup file. Once CST
        %   code has been modified this function will become obsolete and
        %   is included currently for version safety.
            listOfFormats={};
            for i=1:length(ListOfResponses)
                if strcmp(ListOfResponses{i}.FormulaOrSimulation,'Simulation')
                    if i~=length(ListOfResponses)
                        listOfFormats{i} = sprintf('%s ',ListOfResponses{i}.Format);
                    else
                        listOfFormats{i} = sprintf('%s',ListOfResponses{i}.Format);
                    end
                end
            end
        end
        
        %% modify responses on objective file
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns obj, updated object
        %% @Author Alex Irvine
        function obj = modifyObjResp(obj,AlgSettings,SimSettings)
        %modifyObjResp modifies the file already created when responses are
        %changed
        %   If the user creates objective functions and then changes
        %   responses the files will need modifying to reflect the new
        %   arguments. All file paths are stored in AlgSettings so this
        %   function can collect and modify any existing files.
        
            % for all the files
            for i=1:length(AlgSettings.ListOfObjectiveFunctions)
                % get FF if exists.
                obj.FocusedFrequency = AlgSettings.ListOfObjectiveFunctions{i}.FocusedFrequency;
                
                % open the file
                file = fopen(AlgSettings.ListOfObjectiveFunctions{i}.Function);
                tline = fgetl(file);
                fileArray = {};
                
                % create array out of file
                while ischar(tline)
                    fileArray{end+1} = tline;
                    tline = fgetl(file);
                end
                
                % get first lines as they should appear
                cellarr = obj.CreateObjCellArr(AlgSettings.ListOfObjectiveFunctions{i}.Name,...
                    AlgSettings,SimSettings);
                
                % find user written code in file
                userCode={};
                for j=2:length(fileArray)
                    if isempty(strfind(fileArray{j},'%%'))
                        for k=j:length(fileArray)
                            userCode{end+1} = fileArray{k};
                        end
                        break;
                    end
                end
                
                % add the user code to the array
                for j=1:length(userCode)
                    cellarr{end+1} = userCode{j};
                end
                fclose(file);
                
                % write the new file
                obj.GenericWrite(AlgSettings.ListOfObjectiveFunctions{i}.Function,cellarr);
            end
        end
        
        %% modify responses on specification file
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Param SimSettings, simulation settings
        %% @Returns obj, updated object
        %% @Author Alex Irvine
        function obj = modifySpecResp(obj,AlgSettings,SimSettings)
        %modifySpecResp modifies the file already created when responses are
        %changed
        %   If the user creates constraint functions and then changes
        %   responses the files will need modifying to reflect the new
        %   arguments. All file paths are stored in AlgSettings so this
        %   function can collect and modify any existing files.
        
            % for all the files
            for i=1:length(AlgSettings.ListOfConstraints)
                % get FF if exists.
                obj.FocusedFrequency = AlgSettings.ListOfConstraints{i}.FocusedFrequency;
                
                % open the file
                file = fopen(AlgSettings.ListOfConstraints{i}.Function);
                tline = fgetl(file);
                fileArray = {};
                
                % create array out of file
                while ischar(tline)
                    fileArray{end+1} = tline;
                    tline = fgetl(file);
                end
                
                % get first lines as they should appear
                cellarr = obj.CreateSpecCellArr(AlgSettings.ListOfConstraints{i}.Name,...
                    AlgSettings,SimSettings);
                
                % find user written code in file
                userCode={};
                for j=2:length(fileArray)
                    if isempty(strfind(fileArray{j},'%%'))
                        for k=j:length(fileArray)
                            userCode{end+1} = fileArray{k};
                        end
                        break;
                    end
                end
                
                % add the user code to the array
                for j=1:length(userCode)
                    cellarr{end+1} = userCode{j};
                end
                fclose(file);
                
                % write the new file
                obj.GenericWrite(AlgSettings.ListOfConstraints{i}.Function,cellarr);
            end
        end
        
        %% create parent file for testing (Sample verification)
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Returns closed, status of the closed file
        %% @Author Alex Irvine
        function closed = CreateParentForTesting(obj,AlgSettings)
        %CreateParentForTesting creates a parent file which will collect 
        %all data
        %   This file will gather more than just the objective values so
        %   sample verification can be checked by the user for all data. y
        %   will be created as a cell array where each cell is an item that
        %   would need to be checked. Data can be extracted from y in the
        %   order: responses, objective value(s), constraint(s), fitness
        %   value.
            
            % get response section 
            responseSection = obj.CreateParentResponseSectionCellArrayForFiles(AlgSettings);
            
            % get values section
            objective = obj.CreateParentObjectiveCellArray(AlgSettings);
            cons = obj.CreateParentConstraintCellArray(AlgSettings);
            yval = obj.CreateParentYvalCellArray(AlgSettings);
            y = obj.CreateParentYCellArray(AlgSettings);
            
            % generate path for file in project directory
            fullpath = [AlgSettings.ProjectDirectory,filesep,'getTestValuesFor',AlgSettings.ProjectName,'.m'];
            file = fopen(fullpath,'wt');
            
            % write function line
            fprintf(file,'%s%s%s\n','function y = getTestValuesFor',AlgSettings.ProjectName,'(x)');
            fprintf(file,'%s\n','y={};');
            
            % if smart params use derive x
            if strcmp(AlgSettings.ParamType,'Smart')
                fprintf(file,'%s\n',['x = deriveXfor',...
                    AlgSettings.ProjectName,'(x);']);
            end
            
            % write responses
            for i=1:length(responseSection)
                fprintf(file,'%s\n',responseSection{i});
            end
            fprintf(file,'\n');
%             for i=1:length(AlgSettings.ListOfResponses)
%                 fprintf(file,'%s%s%s\n','y{end+1} = ',AlgSettings.ListOfResponses{i}.Name,';');
%             end
            
            % write objectives
            for i=1:length(objective)
                fprintf(file,'%s\n',objective{i});
            end
            fprintf(file,'\n');
            fprintf(file,'%s%s%s\n','y{end+1} = ','yobj',';');
            
            % write constraints
            if ~isempty(cons)
                for i=1:length(cons)
                    fprintf(file,'%s\n',cons{i});
                end
                fprintf(file,'\n');
                fprintf(file,'%s\n','y{end+1} = yc;');
            end
            
            % write fitness
            if ~isempty(yval)
                for i=1:length(yval)
                    fprintf(file,'%s',yval{i});
                end
                fprintf(file,'\n');
                fprintf(file,'%s\n','y{end+1} = yval;');
            end
            
            % close
            closed = fclose(file);
        end
        
        %% create the derive x file for smart params
        %% @Param obj, this instance of class
        %% @Param AlgSettings, Algorithm Settings
        %% @Author Alex Irvine
        function WriteDeriveXFile(obj,AlgSettings)
        %WriteDeriveXFile writes the file for deriving the member x from 
        %the smart parameters
        %   This file should contain a function where the user can use
        %   their smart parameters to derive a real value x for simulation
        %   and evaluation.
            
            % create file path
            file = fullfile(AlgSettings.ProjectDirectory,...
                ['deriveXfor',AlgSettings.ProjectName,'.m']);
            
            % if the file already exists then there is no need to rewrite
            if exist(file,'file')
                return;
            end
            
            % create static lines
            firstLine = {['function x = deriveXfor',AlgSettings.ProjectName,'(x)']};
            comments = {'% derive real parameters from your smart parameters here';
                        '% x=x will evaluate smart parameters'};
            
            % create dynamic line
            params = {'['};
            for i=1:length(AlgSettings.ListOfParameters)
                if i~=length(AlgSettings.ListOfParameters)
                    params{end+1} = sprintf('%s%s',...
                        AlgSettings.ListOfParameters{i}.Name,',');
                else
                    params{end+1} = sprintf('%s%s',...
                        AlgSettings.ListOfParameters{i}.Name,']');
                end
            end
            comments{end+1} = ['% x = ',params{:}];
            
            % group cells together for writing
            cellArr={};
            cellArr{end+1} = firstLine{:};
            
            for i=1:length(comments)
                cellArr{end+1}=comments{i};
            end
            
            % write the file and open
            obj.GenericWrite(file,cellArr);
            open(file);
        end
        
        %% create the bat file to kill cst
        %% @Param obj, this instance of class
        %% @Param AlgSettings, Algorithm Settings
        %% @Param SimSettings, Simulation Settings
        %% @Author Alex Irvine
        function WriteKillerBat(obj,AlgSettings,SimSettings)
        %WRITEKILLERBAT writes the bat file to kill CST if the 
        %simulation fails on the new link
        
            % crete file path
            file = fullfile(...
                SimSettings.SourceDirectory,'timeout.bat');
            
            % get executable name
            exeName = strsplit(SimSettings.InstallationPath,filesep);
            exeName = exeName{end};
            
            timeoutnum = SimSettings.Timeout+10;
            cellArr={};
            cellArr{end+1} = ['ping localhost -n ',...
                num2str(timeoutnum),' -w 1000 >nul'];
            cellArr{end+1} = ['taskkill /f /im "',exeName,'"'];
            cellArr{end+1} = ['echo CST timed out: %date% %time% >> ',...
                fullfile(SimSettings.SourceDirectory,'CSTLog.txt')];
            
            % write file
            obj.GenericWrite(file,cellArr);
        end
        
        %% re write the derive x file if the project name changes
        %% @Param obj, this instance of class
        %% @Param AlgSettings, Algorithm Settings
        %% @Param file, the old file
        %% @Author Alex Irvine
        function ReWriteDeriveX(obj,AlgSettings,file)
        %REWRITEDERIVEX function to change the derive x file if the project
        %name is changed
            
            % open the file
            file = fopen(file);
            tline = fgetl(file);
            fileArray = {};
              
            % create array out of file
            while ischar(tline)
                fileArray{end+1} = tline;
                tline = fgetl(file);
            end
            
            % close file
            fclose(file);
            
            % change first line
            fileArray{1} = ['function x = deriveXfor',...
                AlgSettings.ProjectName,'(x)'];
            
            % new file name and location
            nfile = fullfile(AlgSettings.ProjectDirectory,...
                ['deriveXfor',AlgSettings.ProjectName,'.m']);
            
            % write the new file
            obj.GenericWrite(nfile,fileArray);
        end
        
        %% re write the bound_v file if the project name changes
        %% @Param obj, this instance of class
        %% @Param AlgSettings, Algorithm Settings
        %% @Param file, the old file
        %% @Author Alex Irvine
        function ReWriteBoundV(obj,AlgSettings,file)
        %REWRITEBOUNDV function to change the bound_v file if the project
        %name is changed
            
            % open the file
            file = fopen(file);
            tline = fgetl(file);
            fileArray = {};
              
            % create array out of file
            while ischar(tline)
                fileArray{end+1} = tline;
                tline = fgetl(file);
            end
            
            % close file
            fclose(file);
            
            % change first line
            fileArray{1} = ['function newx = bound_vFor',...
                AlgSettings.ProjectName,'(oldx)'];
            
            % new file name and location
            nfile = fullfile(AlgSettings.ProjectDirectory,...
                ['bound_vFor',AlgSettings.ProjectName,'.m']);
            
            % write the new file
            obj.GenericWrite(nfile,fileArray);
        end
        
        %% write the geometric constraints file
        %% @Param obj, this instance of class
        %% @Param AlgSettings, Algorithm Settings
        %% @Author Alex Irvine
        function WriteBoundV(obj,AlgSettings)
        %WRITEBOUNDV writes the bound_v file used to constrain a population
                
            cellArr = {};
            cellArr{end+1} = ['function newx = bound_vFor',AlgSettings.ProjectName,'(oldx)'];
            cellArr{end+1} = '% oldx = an algorithm generated member';
            cellArr{end+1} = '% newx = the constrained member';
            cellArr{end+1} = '% Please write a function which constrains one member';
            cellArr{end+1} = '% This function will be applied to the whole population';
            
            file = [AlgSettings.ProjectDirectory,filesep,'bound_vFor',...
                AlgSettings.ProjectName,'.m'];
            
            obj.GenericWrite(file,cellArr);
            open(file);
        end
        
        %% write a system information file for errors
        %% @Param obj, this instance of class
        %% @Param errDir, the directory to store the file
        %% @Author Alex Irvine
        function WriteErrorFile(obj,errDir)
        %WRITEERRORFILE writes a txt file with information to help debug 
        %errors    
            file = fullfile(errDir,'SystemInformation.txt');
            cellArr = {};
            
            cellArr{end+1} = ['Operating System: ',...
                system_dependent('getos'),', ',computer];
            cellArr{end+1} = ['Matlab Version: ',version];
            cellArr{end+1} = ['GUI Version: ',SystemConfig.Version];
            
            obj.GenericWrite(file,cellArr);
            
        end
        
        %% DEPRECATED USE WRITERESULTS INSTEAD
        %% Write the results of optimisation for single objective
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Param params, the design parameters
        %% @Param objvs, the objective values
        %% @Param perf, the other performance vectors
        %% @Returns file, path to the created file
        %% @Author Alex Irvine
        function file = WriteSOResults(obj,AlgSettings,params,objvs,perf)
        %WRITESORESULTS Writes the results from optimisation for single 
        %objective    
            file = fullfile(AlgSettings.ProjectDirectory,...
                [datestr(date,'yyyymmdd'),'_Results.txt']);
            
            cellArr = {};
            cellArr{end+1} = '========================';
            cellArr{end+1} = 'Parameters:';
            for i=1:length(params)
                cellArr{end+1} = [AlgSettings.ListOfParameters{i}.Name,...
                    ' = ',num2str(params(i))];
            end
            cellArr{end+1} = '========================';
            cellArr{end+1} = 'Objective value:';
            cellArr{end+1} = num2str(objvs);
            cellArr{end+1} = '========================';
            if ~isempty(perf)
                cellArr{end+1} = 'Performance:';
                cellArr{end+1} = num2str(perf(:)');
            end
            
            obj.GenericWrite(file,cellArr);
        end
        
        %% DEPRECATED USE WRITERESULTS INSTEAD
        %% Write the results of optimisation for multi objective 
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Param params, the design parameters
        %% @Param objvs, the objective values
        %% @Returns file, path to the created file
        %% @Author Alex Irvine
        function file = WriteMOResults(obj,AlgSettings,params,objvs)
        %WRITEMORESULTS Writes the results from optimisation for multi
        %objectives
            file = fullfile(AlgSettings.ProjectDirectory,...
                [datestr(date,'yyyymmdd'),'_Results.txt']);
            
            cellArr = {};
            cellArr{end+1} = '========================';
            for i=1:length(objvs)
                cellArr{end+1} = 'Member:';
                for j=1:size(params,1)
                    cellArr{end+1} = num2str(params(j,i));
                end
                cellArr{end+1} = 'Values:';
                cellArr{end+1} = num2str(objvs(1,i));
                cellArr{end+1} = num2str(objvs(2,i));
                cellArr{end+1} = '========================';
            end
            
            obj.GenericWrite(file,cellArr);
        end
        
        %% Write the results of pre processing
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Param allVals, struct containing values and members
        %% @Returns file, path to the created file
        %% @Author Alex Irvine
        function file = WritePreProcessingResults(obj,AlgSettings,allVals)
        %WRITEPREPROCESSINGRESULTS writes the members and results for pre
        %processing.
            file = fullfile(AlgSettings.ProjectDirectory,...
                [datestr(now,'yyyymmdd_HHMMSS'),'_TestResults.txt']);
            
            cellArr = {};
            for i=1:length(allVals)
                index=0;
                cellArr{end+1} = 'Member:';
                for j=1:length(AlgSettings.ListOfParameters)
                    cellArr{end+1} = [AlgSettings.ListOfParameters{j}.Name,...
                        ' = ',num2str(allVals{i}.member(j))];
                end
%                 if ~isempty(AlgSettings.ListOfResponses)
%                     cellArr{end+1} = '---------------------------------------------------------------------------';
%                     cellArr{end+1} = 'Responses:';
%                     for j=1:length(AlgSettings.ListOfResponses)
%                         cellArr{end+1} = AlgSettings.ListOfResponses{j}.Name;
%                         for k=1:length(allVals{i}.values{j})
%                             cellArr{end+1} = num2str(allVals{i}.values{j}(k));
%                         end
%                     end
%                     index = j;
%                 end
                if ~isempty(AlgSettings.ListOfObjectiveFunctions)
                    cellArr{end+1} = '---------------------------------------------------------------------------';
                    cellArr{end+1} = 'Objective values:';
                    for j=1:length(AlgSettings.ListOfObjectiveFunctions)
                        cellArr{end+1} = AlgSettings.ListOfObjectiveFunctions{j}.Name;
                        cellArr{end+1} = num2str(allVals{i}.values{1+index}(j));
                    end
                    index = index + j;
                end
                if ~isempty(AlgSettings.ListOfConstraints)
                    cellArr{end+1} = '---------------------------------------------------------------------------';
                    cellArr{end+1} = 'Constraints:';
                    for j=1:length(AlgSettings.ListOfConstraints)
                        cellArr{end+1} = AlgSettings.ListOfConstraints{j}.Name;
                        cellArr{end+1} = num2str(allVals{i}.values{index+1}(j));
                    end
                end
                cellArr{end+1} = '===========================================================================';
            end
            
            obj.GenericWrite(file,cellArr);
        end
        
        %% Write the results of optimisation
        %% @Param obj, this instance of class
        %% @Param AlgSettings, algorithm settings
        %% @Param allVals, struct containing values and members
        %% @Returns file, path to the created file
        %% @Author Alex Irvine
        function file = WriteResults(obj,AlgSettings,allVals)
        %WRITERESULTS writes the members and results to a txt file
        
            file = fullfile(AlgSettings.ProjectDirectory,...
                [datestr(now,'yyyymmdd_HHMMSS'),'_TestResults.txt']);
            
            cellArr = {};
            for i=1:length(allVals)
                index=0;
                cellArr{end+1} = 'Member:';
                for j=1:length(AlgSettings.ListOfParameters)
                    cellArr{end+1} = [AlgSettings.ListOfParameters{j}.Name,...
                        ' = ',num2str(allVals{i}.member(j))];
                end
                if ~isempty(AlgSettings.ListOfConstraints)
                    cellArr{end+1} = '---------------------------------------------------------------------------';
                    cellArr{end+1} = 'Result:';
                    cellArr{end+1} = num2str(allVals{i}.values{1});
                    index = index + 1;
                end
                if ~isempty(AlgSettings.ListOfObjectiveFunctions)
                    cellArr{end+1} = '---------------------------------------------------------------------------';
                    cellArr{end+1} = 'Objective values:';
                    for j=1:length(AlgSettings.ListOfObjectiveFunctions)
                        cellArr{end+1} = AlgSettings.ListOfObjectiveFunctions{j}.Name;
                        cellArr{end+1} = num2str(allVals{i}.values{1+index}(j));
                    end
                    index = index + j;
                end
                if ~isempty(AlgSettings.ListOfConstraints)
                    cellArr{end+1} = '---------------------------------------------------------------------------';
                    cellArr{end+1} = 'Constraints:';
                    for j=1:length(AlgSettings.ListOfConstraints)
                        cellArr{end+1} = AlgSettings.ListOfConstraints{j}.Name;
                        cellArr{end+1} = num2str(allVals{i}.values{index+1}(j));
                    end
                end
                cellArr{end+1} = '===========================================================================';
            end
            
            obj.GenericWrite(file,cellArr);
        end
    end    
end

