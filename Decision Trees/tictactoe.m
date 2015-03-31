classdef tictactoe < handle
% TICTACTOE A simple class file for playing tic-tac-toe against the
% computer. This file demonstrates the general structure of classes,
% including properties and methods, and also how to create simple graphical
% user interfaces.
%
% The following code can be typed into the Command Window to generate and
% play the game.
%   Create an object called 't' (an instance of the tictactoe class)
%   >> t = tictactoe;
%
%   Call the method 'play' in order to start a game. All three of the
%   following commands do the same thing.
%   >> play(t);
%   >> t.play();
%   >> t.play;
%
% NOTES SPECIFIC TO THIS CLASS (TICTACTOE)
%   There are two properties: BOARD is a 3x3 array representing the
%   state of the board, and PLAYER is a scalar indicating which player you
%   want to be (1 --> X; -1 --> O). A zero in BOARD indicates an empty
%   spot.
%
% Created by M. Eicholtz for 24-787
% 2/1/14

    properties
        % Properties are variables stored in each instance of the class.
        % They can be scalars, numeric arrays, cell arrays, structures, or
        % other objects. They can be logicals, integers, real numbers, or
        % strings. You can name them whatever you want (as long as it meets
        % MATLAB standards).
        board
        player
    end
    
    methods
        % Methods are just functions associated with a class. They can be
        % called in two ways in general:
        %   >> objectname.methodname(inputs);
        %   >> methodname(objectname,inputs);
        % The first input in the function must be the object itself. Once
        % again, the name does not matter. If you call it 'obj', then you
        % can reference properties or methods of the object in the method
        % by calling obj.propertyname or obj.methodname.
        %
        % Methods can have outputs, but they are not required. There are a
        % couple important types of method that you will see below,
        % including a constructor and destructor.
        
        function obj = tictactoe()
            % This is the constructor. It is the function that creates an
            % object. It must have the name of the class (in this case,
            % tictactoe is the class name given on line 1) and one output.
            % The output is the object, and it can have any name you choose
            % ('obj' and 'this' are popular choices, but there is no
            % significance to the name)
            
            obj.board = zeros(3); %initialize an empty board
            obj.player = 1; %default is for the human player to be X's
        end
        function show(obj)
            % The purpose of this method is just to visualize the board. It
            % does not need any output. Also, other than the required first
            % input, notice that you do not need additional inputs (for
            % example, you may think BOARD should be an input, but it is
            % already included in the input OBJ as a property).
            
            %***You do not need to know the specifics of this method, but
            %feel free to look at the various functions used and ask me if
            %you are interested to learn more***
            figure(sum(mfilename+0));
            clf;
            set(gcf,...
                'NumberTitle','off',...
                'Name',mfilename,...
                'Color',[1 1 1],...
                'MenuBar','none',...
                'Toolbar','none');%,...
%                 'Position',[100 100 600 600]);
            axes(...
                'Box','off',...
                'Position',[0.05 0.05 0.9 0.9],...
                'YDir','reverse',...
                'XLim',[0.5 3.5],...
                'YLim',[0.5 3.5],...
                'XTick',[],...
                'YTick',[],...
                'Visible','off');
            
            line([1.5 1.5],[0.5 3.5],'Color','k','LineWidth',6);
            line([2.5 2.5],[0.5 3.5],'Color','k','LineWidth',6);
            line([0.5 3.5],[1.5 1.5],'Color','k','LineWidth',6);
            line([0.5 3.5],[2.5 2.5],'Color','k','LineWidth',6);
            
            hold on;
            [row,col] = find(obj.board==1);
            scatter(col,row,8000,'rx','LineWidth',10);
            
            [row,col] = find(obj.board==-1);
            scatter(col,row,5000,'bo','LineWidth',10);
            hold off;
        end
        function reset(obj)
            % This method resets the board to start a new game
            obj.board = zeros(3);
            show(obj);
        end
        function play(obj)
            % This is the method to play a game
            reset(obj); %first, make sure the board is reset
            turn = 1; %X goes first
            while any(obj.board(:)==0) && obj.isitover(obj.board)==0
                if obj.player==turn
                    waiting = 1;
                    while waiting
                        [x,y] = ginput(1); %user clicks on a space with the mouse
                        x = round(x);
                        y = round(y);
%                         fprintf('%d\t%d\n',y,x);
                        if x>0 && x<=3 && y>0 && y<=3 %make sure the user clicked on the board
                            if obj.board(y,x)==0 %make sure the user clicked on an empty space
                                obj.board(y,x) = turn;
                                waiting = 0;
                            end
                        end
                    end
                else %it is the computer's turn
                    %put AI code here; right now, the computer randomly
                    %picks an open space.
                    [row,col] = find(obj.board==0);
                    ind = randperm(length(row),1);
                    obj.board(row(ind),col(ind)) = turn;
                end
                show(obj); %update the board
                turn = -turn; %switch turns; this toggles the variable between -1 and 1
            end
            winner = obj.isitover(obj.board); %check if there is a winner
            if winner==0
                fprintf('Stalemate. Bummer.\n');
            elseif winner==obj.player
                fprintf('You win! Good game.\n');
            else
                disp('Haha! I beat you! Nice try.');
            end
        end
        function exit(obj)
            response = input('Are you sure? [y]/n: ','s');
            if ~strcmp(response,'n') 
                delete(obj);
            end
        end
        function delete(obj)
            % This is a destructor method. The function contents execute
            % when you try to delete or clear an object.
            close(sum(mfilename+0)); %close the figure
        end
    end
    
    methods (Static)
        % A static method is one that does not require an instance of the
        % object. To run a static object, use the following code:
        %   >> classname.staticmethodname
        %
        % So for this problem, the static method could be called as:
        %   >> tictactoe.isitover(board) %board is a 3x3 array
        
        function winner = isitover(board)
            % This method checks whether there is a winner or not
            
            check = [sum(board),sum(board'),sum(diag(board)),sum(diag(fliplr(board)))];
            if any(check==-3) %this means that there are three -1's in a row somewhere
                winner = -1; %O wins!
            elseif any(check==3) %this means that there are three 1's in a row somewhere
                winner = 1; %X wins!
            else
                winner = 0; %no winner yet
            end
        end 
    end
    
    
end