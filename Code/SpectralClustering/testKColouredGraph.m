clear;

k = 3;

[eigVecM, eigValM] = eig(laplacian2);
% [eigVecM, eigValM] = eig(laplacian);

% only consider first k eigenvectors and eigenvalues
[rows, cols] = size(eigVecM);
eigVec = zeros(rows, k-1);
eigVal = zeros(k-1, 1);

% for i = cols-k+1:cols
%     eigVec(:, -i + cols + 1) = eigVecM(:, i);
%     eigVal(-i + cols + 1, 1) = eigValM(i, i);
% end

for i = 2:k
    eigVec(:, i-1) = eigVecM(:, i);
    eigVal(i-1, 1) = eigValM(i, i);
end

% create embedded vectors
embedVec = transpose(eigVec);

title('embedded vectors plot for vertices 0.6 probability of edges between community','FontSize',18);
xlabel('u1','FontSize',18);
ylabel('u2','FontSize',18);
circlePlotSize = 100;
for v=1:rows
    hold on;
    if mod((v-1), k) == 0
        scatter(embedVec(1,v),embedVec(2, v),circlePlotSize,'r')
    elseif mod((v-1), k) == 1
        scatter(embedVec(1,v),embedVec(2, v),circlePlotSize,'b')
    else
        scatter(embedVec(1,v),embedVec(2, v),circlePlotSize,'g')
    end
end

% [model, y] = cmeans(embedVec, k);
