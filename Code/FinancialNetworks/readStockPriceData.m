clear;

load('stockdata.mat');

[n,T] = size(price);

n_str = num2str(n);
T_str = num2str(T);

% calculate logarithmic returns for stock price data
logReturns = calculateLogarithmicReturns(price);

% calculate calculate time average and sample variance of logarithmic returns
timeAverage = calculateTimeAverage(logReturns);
meanSquareTimeAverage = calculateMeanSquareTimeAverage(logReturns);
sampleVariance = calculateSampleVariance(logReturns);

% calculate filtered logarithmic returns
logReturns = calculateFilteredLogarithmicReturns(logReturns);

% calculate sample cross-correlation matrix of filtered logarithmic returns
meanProductTimeAverage = calculateMeanProductTimeAverage(logReturns);
sampleCrossCorrelationMatrix = calculateSampleCrossCorrelationMatrix(logReturns);

% write sample cross-correlation returns to file
% filename_str = sprintf('../data_files/financialNetworks/crossCorrelation_n_%s_T_%s.dat',n_str,T_str);
% fileID = fopen(filename_str,'w');
% for i=1:n
%     for j=1:n
%         fprintf(fileID,'%d ',sampleCrossCorrelationMatrix(i,j));
%     end
%     fprintf(fileID,'\n');
% end
% fclose(fileID);

% plot density of eigenvalues of sample cross-correlation matrix
eigenvalues = [];
% Take real part to compensate for numerical issues
eigenvalues = [eigenvalues; real(eig(sampleCrossCorrelationMatrix))];

maxEmpiricalEigenvalue = max(eigenvalues);
minEmpiricalEigenvalue = min(eigenvalues);
maxTheoreticalEigenvalue = (1 + sqrt(n/T))^2;
minTheoreticalEigenvalue = (1 - sqrt(n/T))^2;
noEigenvalues = 1000;
eigenvalueStep = (maxEmpiricalEigenvalue - minEmpiricalEigenvalue) / noEigenvalues;

theoreticalSpectrum = zeros(noEigenvalues,2);
it = 1;
eigenvalue = minEmpiricalEigenvalue;
while eigenvalue <= maxEmpiricalEigenvalue
    theoreticalSpectrum(it,1) = eigenvalue;
    if (minTheoreticalEigenvalue <= eigenvalue) && (eigenvalue <= maxTheoreticalEigenvalue)
        theoreticalSpectrum(it,2) = (T/(2*pi*n*eigenvalue))*sqrt((maxTheoreticalEigenvalue - eigenvalue)*(eigenvalue - minTheoreticalEigenvalue));
    else
        theoreticalSpectrum(it,2) = 0;
    end
    it = it + 1;
    eigenvalue = eigenvalue + eigenvalueStep;
end

nbins = 200;
[spectrum,lambda] = hist(eigenvalues,nbins);
plot(lambda,spectrum/trapz(lambda,spectrum),'red','LineWidth',2);
hold on;
plot(theoreticalSpectrum(:,1),theoreticalSpectrum(:,2),'blue','LineWidth',2);
