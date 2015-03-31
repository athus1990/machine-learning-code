classdef DecisionTreeNode < handle
    %DecisionTreeNode class: Nodes of entropy-based binary decision tree.
    %   For 24-787 HW1, you need to complete the following functions in
    %   this file: find_decision_attrib, train, classify, entropy, and
    %   entropy_of_class.
    
    properties
        decision_attrib;        % the index of the attrib where split occurs
        available_attribs;      % the indices of available attributes
        decision;               % the class for all input data, if no split occours
        left_node;              % handle to the left leaf
        right_node;             % handle to the right leaf
        parent_node;            % handle to the parent leaf
    end
    methods
        function this = DecisionTreeNode()
            this.decision_attrib = -1;
            this.decision = -1;
            this.parent_node = [];
            this.available_attribs = [];
        end
        function find_decision_attrib(this,attrib,class)
            h = DecisionTreeNode.entropy_of_class(class);
            info_gain = zeros(size(this.available_attribs));
            
            % From available_attribs, you want to find the attribute that 
            % best splits the data with maximum info gain. 
            % You will need to split the data per each available attribute.            
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
             allinone=[attrib class];%% make a full matrix
             for i = 1:15
                 
                     ps1 = allinone((allinone(:,i) == 1),:);
                     ps2 = allinone((allinone(:,i) == 0),:);
                     p1 = [sum(ps1(:,16))/size(ps1,1),size(ps1,1)-sum(ps1(:,16))/size(ps1,1)];
                     p2 = [sum(ps2(:,16))/size(ps2,1) size(ps2,1)-sum(ps2(:,16))/size(ps2,1)];
                     info_gain(i) = h - ((size(ps1,1)/(size(ps1,1)+size(ps2,1)))*DecisionTreeNode.entropy(p1)+ (size(ps2,1)/(size(ps1,1)+size(ps2,1)))*DecisionTreeNode.entropy(p2));
               
             end
             
            %%Find maximum info gain and set its index to decision_attrib 
            [C,I]=max(max(info_gain));
            this.decision_attrib=I;
            
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

        end
        function train(this,attrib,class)
        % Learn decision tree from training data
        % HINT: this will be a recursive function
            
            % If the examples are perfectly split, then assign the
            % appropriate class label and return from this node.
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            if sum(class==0)
                this.decision=0;
            elseif sum(class)==length(class)
                this.decision=1;
            end
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            
            
            % If no available attributes remain, but the data is not
            % perfectly split, use the majority vote to assign the class
            % and return from this node.
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            if isempty(this.available_attribs)
                    pos=sum(class);
                    neg=length(class)-sum(class);
                    if pos>neg
                        this.decision=1;
                    end
                    if pos<neg
                            this.decision=0;
                    end
            end
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                        
            
            % If the program makes it this far, then choose the "best"
            % attribute, split the data, and initiate the recursion.
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
           find_decision_attrib(this,attrib,class)
                this.left_node = DecisionTreeNode();
                this.right_node = DecisionTreeNode();

                next_available_attribs = this.available_attribs(this.available_attribs~=this.decision_attrib);%%Remove the attribute if  decision
                this.left_node.available_attribs = next_available_attribs;
                this.right_node.available_attribs = next_available_attribs;
                
                a_left = attrib(attrib(:,this.decision_attrib)==1,:);
                a_right = attrib(attrib(:,this.decision_attrib)==0,:);
                c_left = class(attrib(:,this.decision_attrib)==1,:);
                c_right = class(attrib(:,this.decision_attrib)==0,:);
                this.left_node.train(this,a_left,c_left);
                this.right_node.train(this,a_right,c_right);
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\      
            
            
        end
        
        function class = classify(this,attrib)
        % Label test data based on the given attributes
        % HINT: this will be a recursive function
        
            class = -ones(size(attrib,1),1); %initialize class labels to -1
            
            % Check to see if we are at a leaf node. If so, assign the correct label to the output.
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            if this.decision_attrib == -1
                class = this.decision * ones(size(attrib,1),1);
                %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                
                
                % If we are not at leaf node, split the data and initiate recursion
                %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            else
                left = attrib(:, this.decision_attrib) == 1;
                right = attrib(:,this.decision_attrib) == 0;
                class(left,:) = this.left_node.classify(attrib(left,:));
                class(right,:) = this.right_node.classify(attrib(right,:));
            end
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

            
        end
    end
    
    %% Static methods can be called without object instantiation
    methods (Static)
        function h = entropy(p)
        % Compute the entropy (h) given the vector of probabilities (p)
        
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            h=-1*p(1)*log2(p(1))+-1*p(2)*log2(p(2));
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            
        end
        function h = entropy_of_class(class)
        % Compute the entropy of (h) given a binary vector of labels 
        % (class), in which Joy = 1 and Despair = 0
            
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            t=15;
            ppp=sum(class);
            nnn=15-ppp;
            h=-(ppp/t)*log2(ppp/t)-(nnn/t)*log2(nnn/t);
            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            
        end
    end
end