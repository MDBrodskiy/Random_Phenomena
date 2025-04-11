clear all;
close all % Clean the workspace

%% Part A

fprintf('Given that p = 0.5, S1 and S2 occur with equal probabilities\n');
fprintf('As stated, this means the threshold voltage is given by (S1 + S2)/2\n');
fprintf('Thus, we may find Vth = [A + (-A)] / 2 = 0\n');
fprintf('As such, we see that the threshold voltage is 0 Volts\n\n'); % Print process to calculate Vth

%% Part B

p = .5; % Assign specified p value
A = 5; % Assign specified voltage values
Vth = (p * A + (1 - p) * -A) / 2; % Calculate threshold voltage
N = 10000; % Assign arbitrary sample size, N

X1 = rand(1, N); % Uniform random variable from 0 to 1
index = (X1 <= p); % Generate a binary outcome

X_sampling = A * index - A * ~index; % X is either A or -A

mu = 0; % Specify noise mean
sigma = 2; % Specify noise standard dev
noise = random('normal', mu, sigma, N, 1); % Create the noise variable

Y = X_sampling + noise; % Create the distribution of Y

error_s1 = normcdf((Vth - A) / sigma); % Calculate probability given S1
error_s0 = 1 - normcdf((Vth + A) / sigma); % Calculate probability given S0

prob_error_for_std2 = (1 - p) * error_s0 + (p) * error_s1; % Calculate the error probability

fprintf('The probability of error is %.4f\n\n', prob_error_for_std2); % State the probability of error

%% Part C

rho_for_std2 = mean(((Y - mean(Y)) .* (X_sampling - mean(X_sampling))) / (std(X_sampling) * std(Y))); % Calculate the correlation coefficient between X and Y

fprintf('The correlation coefficient between X and Y is %.4f\n\n', rho_for_std2) % State the correlation coefficient

%% Part D

sigmas = [1, 2, 4];

for i = 1:3
  
  noise = random('normal', mu, sigmas(i), N, 1); % Create the noise variable

  Y = X_sampling + noise; % Create the distribution of Y

  error_s1 = normcdf((Vth - A) / sigmas(i)); % Calculate probability given S1
  error_s0 = 1 - normcdf((Vth + A) / sigmas(i)); % Calculate probability given S0
  
  if i == 2
    
    fprintf('The probability of error is %.4f with standard deviation %.4f\n', prob_error_for_std2, sigmas(i)); % State the probability of error
    fprintf('The correlation coefficient is %.4f with standard deviation %.4f\n\n', rho_for_std2, sigmas(i)); % State the correlation coefficient
    
  else
  
    prob_error = (1  - p) * error_s0 + p * error_s1; % Calculate the error probability

    fprintf('The probability of error is %.4f with standard deviation %.4f\n', prob_error, sigmas(i)); % State the probability of error
  
    rho = mean(((Y - mean(Y)) .* (X_sampling - mean(X_sampling))) / (std(X_sampling) * std(Y))); % Calculate the correlation coefficient between X and Y
  
    fprintf('The correlation coefficient is %.4f with standard deviation %.4f\n\n', rho, sigmas(i)); % State the correlation coefficient
    
  end
  
end
 
fprintf('We may observe that a greater standard deviation yields more variability and less correlation in the data\n\n');
 
%% Part E
 
fprintf('As shown above, P(e) is %.4f and the correlation coefficient is %.4f\n', prob_error_for_std2, rho_for_std2);

X2 = rand(1, N); % Uniform random variable from 0 to 1
index = (X1 <= p); % Generate a binary outcome

X2_sampling = A * index; % X is either A or 0
rho_example = mean(((Y - mean(Y)) .* (X2_sampling - mean(X2_sampling))) / (std(X2_sampling) * std(Y))); % Calculate rho from example values

fprintf('In the case presented in the examples, P(e) is %.4f and the correlation coefficient is %.4f\n', 1 - normcdf(A / (2 * sigma)), rho_example);
fprintf('The lesser probability occurs because the power of the this case is greater than the example\n');
fprintf('This occurs because there is greater deviation in X for this case, which causes the probability of a Type II error to be dependent on A\n\n');

%% Part F

clear; % Clear workspace
load Noise_Samples.mat; % Load the samples
N = 10000; % Assign arbitrary sample size, N
clf;
nbins=100; % Create histogram bins

% Using the histogram function to obtain and sketch the CDF of the noise samples
Hz = histogram(Z_samples, nbins, 'normalization', 'CDF', 'Edgecolor',[0.4 0.4 0.4]);
Fz = Hz.Values; % CDF values
Z_values = Hz.BinEdges(1: end - 1) + Hz.BinWidth/2; % Obtain Z values
xlabel('Z', 'interpreter', 'latex') % Label the X axis
ylabel('$$F_Z(z)$$', 'interpreter', 'latex') % Label the Y axis

% Generating N samples of the random variable Z, given the CDF
Z = myRVSampleValues(Fz, Z_values, N);

p = .55; % Assign specified p value
A = 5; % Assign specified voltage values
Vth = (p * A + (1 - p) * -A) / 2; % Calculate threshold voltage

X_sampling = rand(1, N); % uniform rv from 0-1
index = (X_sampling <= p); % binary outcome,1 or 0 and also indices of logic ones

X = A * index - A * ~index; % Make X a series of As or -As

% Establish a variable Y

Y = X + Z; % received signal plus noise
Y_H1 = Y(index); % received signal given H1, choosing values equal to A
Y_Ho = Y(~index); % received signal given Ho, choosing -A

% Sketching the histogram of Y|Ho and Y|H1 using the histogram function
figure(1);
clf;
ho = histogram(Y_Ho, nbins, 'normalization', 'pdf', 'Edgecolor',[0.4 0.4 0.4]);
fy_Ho = ho.Values;
y_values_Ho = ho.BinEdges(1:end - 1) + ho.BinWidth/2;
hold on; % Hold the Figure

h1 = histogram(Y_H1, nbins, 'normalization', 'pdf', 'Edgecolor',[0.4 0.4 0.4]);
fy_H1 = h1.Values;
y_values_H1 = h1.BinEdges(1:end - 1) + h1.BinWidth/2;
xlabel('y', 'interpreter', 'latex');
legend([h1,ho], {'$f_{Y|H_1}(y)$ ' '$f_{Y|H_o}(y)$'},'interpreter', 'latex');

%% Plotting the P[Ho]f_y_Ho versus P[Ho]f_y_Ho
figure(2);
plot(y_values_H1, p*fy_H1, y_values_Ho, (1 - p) * fy_Ho);
xlabel('y', 'interpreter', 'latex');
legend({'$P[H_1]f_{Y|H_1}(y)$ ' '$P[H_0] f_{Y|H_o}(y)$'},'interpreter', 'latex');

%% The following function returns an array of Ns sample values of a random variable where the CDF is given as Fz(z) and the Values are the z values where the CDF is evaluated
function SampleValues = myRVSampleValues(CDF, Values, Ns)

  SampleValues = zeros(1, Ns); % Create empty sample values

  for k = 1:Ns

    r = rand(1,1); % A single element of a uniform random variable in the interval 0 to 1
    check = r > CDF; % compare r to CDF

    idx = nnz(check) + 1; % index of the value in sample space is equal to number of ones plus one

    SampleValues(k) = Values(idx); % select value of x based on index

  end

end