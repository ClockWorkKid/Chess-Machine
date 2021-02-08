classdef Piece
    
    properties
        name=null(1);
        color=null(1);
    end
    
    methods
        function P = Piece(n,c)
            if nargin~=0
                P.name = n;
                P.color = c;
            end     
        end    
    end
end

