function route = DijkstraGraph (edges,edge_lengths,start_node, dest_node)
% Run Dijkstra's algorithm on a graph.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%      the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%       respectively, the first entry is the row and the second the column.
% Output :
%   route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route.

% set up map
% 1 - clear cell
% 3 - visited
% 5 - start
% 6 - destination

nedge = length(edges);
nnode = max(edges(:));

% map - a table that keeps track of the state of each node
map = ones(1,nnode);
Pathmatrix = inf(nnode);
for edge_index = 1:nedge
    Pathmatrix(edges(edge_index, 1),edges(edge_index, 2)) = edge_lengths(edge_index,1);
    Pathmatrix(edges(edge_index, 2),edges(edge_index, 1)) = edge_lengths(edge_index,1);
end

% Generate linear indices of start and dest nodes
map(1,start_node) = 5;
map(1, dest_node) = 6;

% Initialize distance array
distances = Pathmatrix(start_node,:);

% For each grid cell this array holds the index of its parent
parent = zeros(1,nnode);
parent(distances < Inf) = start_node;
parent(1,start_node)= 0;

distances(1,start_node) = 0;

% Main Loop
while true
    
    map(1,start_node) = 5;
    map(1, dest_node) = 6;
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distances(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end
    
    % Update map
    map(1,current) = 3;         % mark current node as visited
    distances(1,current) = Inf; % remove this node from further consideration
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
    % *******************************************************************
    for node_index = 1:nnode
        if Pathmatrix(current,node_index) ~= Inf
            update(node_index,current,min_dist);
        end
    end
    % *******************************************************************
end

if (isinf(distances(1,dest_node)))
    route = [];
else
    route = [dest_node];  
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
end

    function update(node_index,current, min_dist)
        if ((map(1,node_index) ~= 3) && (map(1,node_index) ~= 5) && (distances(1,node_index) > (min_dist + Pathmatrix(current, node_index))))
            distances(1,node_index) = min_dist + Pathmatrix(current, node_index);
            parent(1,node_index) = current;
        end
    end

end
