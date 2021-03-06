function [ communityAssignments ] = spectralClusteringAMP( adjacencyMatrix, pout, noIterations )
%spectralClusteringAMP: Implements Spectral Clustering based on Approximate
%Message Passing (AMP) algorithm
%   Inputs: Adjacency matrix of a graph -> adjacencyMatrix
%           Probability of an edge between two nodes NOT in the same community -> pout
%           Number of iterations to run -> noIterations
%   Outputs: Indicators vector -> communityAssignments

    [noRows, noCols] = size(adjacencyMatrix);
    n = noRows;

    poutMatrix = pout .* ones(n,n);
    if pout ~= 0
        normalisationConstant = 1/sqrt(n*pout*(1-pout));
    else
        normalisationConstant = 1;
    end
        
    normalisedAdjacencyMatrix = normalisationConstant .* (adjacencyMatrix - poutMatrix);
    
    u = zeros(n,1);
    z = rand(n,1);
    
    for t=1:noIterations
        % keep theta non-negative
%         theta = abs(mean(z));
%         u = etaThresholdingSoft(z, theta);
        u = etaThresholdingPositivePart(z);
        z = (normalisedAdjacencyMatrix * u);
    end
    
    communityAssignments = zeros(n,1);
    epsilon = 0.1;
    for i=1:n
        if u(i) > epsilon
            communityAssignments(i) = 1;%1;
        else
            communityAssignments(i) = 0;%2;
        end
    end

end