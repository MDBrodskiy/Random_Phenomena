clear all;
close all % Clean the workspace

%%% PROBLEM 1

%% PART I

% Subpart a - Uniform(2,4)
N = 10000; % Set sample size as specified
a = 2; b = 4; % Set upper and lower bounds as specified

% Using the random function
X1 = random('uniform', a, b, N, 1);

% Using the PDF approach
pd_x1 = makedist('uniform', 'lower', a, 'upper', b);
X1 = random(pd_x1, N, 1);

% Evaluate the PDF
X_sort1 = sort(X1);
fx1 = pdf(pd_x1, X_sort1);
plot(X_sort1, fx1, 'b', 'LineWidth', 2);
title("Probability Density Function of X = Uniform(2, 4)");

pause; % Hold the plot

% Evaluate the CDF
FX1 = cdf(pd_x1, X_sort1);
plot(X_sort1, FX1, 'g', 'LineWidth', 2);
title("Cumulative Density Function of X = Uniform(2, 4)");

pause; % Hold the plot

% Subpart b - Gaussian(2, 1)

mu = 2; sigma = 1; % Create parameters

X2 = random('normal', mu, sigma, N, 1); % Create the random variable

% Create object to evaluate PDF/CDF
pd_x2 = makedist('normal', 'mu', mu, 'sigma', sigma);

% Evaluate the PDF
X_sort2 = sort(X2);
fx2 = pdf(pd_x2, X_sort2);
plot(X_sort2, fx2, 'b', 'LineWidth', 2);
title("Probability Density Function of X = Gaussian(2, 1)");

pause; % Hold the plot

% Evaluate the CDF
FX2 = cdf(pd_x2, X_sort2);
plot(X_sort2, FX2, 'g', 'LineWidth', 2);
title("Cumulative Density Function of X = Gaussian(2, 1)");

pause; % Hold the plot

% Subpart c - Exponential(.5)

lambda = 0.5; % Create parameters

% Generate RV
X3 = random('exp', 1/lambda, N, 1);

% Create object to evaluate PDF/CDF
pd_x3 = makedist('exponential', 'mu', 1/lambda);

% Evaluate the PDF
X_sort3 = sort(X2);
fx3 = pdf(pd_x3, X_sort3);
plot(X_sort3, fx3, 'b', 'LineWidth', 2);
title("Probability Density Function of X = Exponential(.5)");

pause; % Hold the plot

% Evaluate the CDF
FX3 = cdf(pd_x3, X_sort3);
plot(X_sort3, FX3, 'g', 'LineWidth', 2);
title("Cumulative Density Function of X = Exponential(.5)");

pause; % Hold the plot

%% PART II

% Repeat mean and variance calculation for each variable (X1, X2, X3)

% Calculate values based on generated distributions
calculated_mean1 = mean(X1);
calculated_var1 = var(X1);
calculated_mean2 = mean(X2);
calculated_var2 = var(X2);
calculated_mean3 = mean(X3);
calculated_var3 = var(X3);

% Hard-code expected values
expected_mean1 = 3;
expected_var1 = 1/3;
expected_mean2 = 2;
expected_var2 = 1;
expected_mean3 = 2;
expected_var3 = 14;

% Print out results
fprintf("The Generated Uniform Distribution of Sample Size n = %f has Mean = %.4f and Variance = %.4f, with Expected Mean = %.4f and Variance = %.4f\n", N, calculated_mean1, calculated_var1, expected_mean1, expected_var1);
fprintf("The Generated Gaussian Distribution of Sample Size n = %f has Mean = %.4f and Variance = %.4f, with Expected Mean = %.4f and Variance = %.4f\n", N, calculated_mean2, calculated_var2, expected_mean2, expected_var2);
fprintf("The Generated Exponential Distribution of Sample Size n = %f has Mean = %.4f and Variance = %.4f, with Expected Mean = %.4f and Variance = %.4f\n", N, calculated_mean3, calculated_var3, expected_mean3, expected_var3);
fprintf("We may observe that, as the sample size increases, the calculated values approach the expected values.\n")

%% PART III

Y1 = 2 * X1 - 1; % Create Y1
Y2 = 3 * X2 - 6; % Create Y2

% Calculate values based on generated distributions
calculated_mean_y1 = mean(Y1);
calculated_var_y1 = var(Y1);
calculated_mean_y2 = mean(Y2);
calculated_var_y2 = var(Y2);

% Hard-code expected values
expected_mean_y1 = 5;
expected_var_y1 = 4/3;
expected_mean_y2 = 0;
expected_var_y2 = 9;

% Print out results
fprintf("Y1 has Mean = %.4f and Variance = %.4f, with Expected Mean = %.4f and Variance = %.4f\n", calculated_mean_y1, calculated_var_y1, expected_mean_y1, expected_var_y1);
fprintf("Y2 has Mean = %.4f and Variance = %.4f, with Expected Mean = %.4f and Variance = %.4f\n", calculated_mean_y2, calculated_var_y2, expected_mean_y2, expected_var_y2);

%% PART IV

histogram(Y1, 'Normalization', 'pdf');
title('PDF of Y1');
% As expected, Y1 is Uniform(3,7) with range of [3,7]

pause; % Hold the plot

%% PART V

figure;
histogram(Y2, 'Normalization', 'pdf');
title('PDF of Y2');
% As expected, Y2 is Gaussian(0,9) with range of (roughly) [-10,10]

pause; % Hold the plot

clear all;
close all; % Clear everything for Problem 2

%%% PROBLEM 2

expected_mean = 5; % Establish exponential means
N = 10000; % Establish sample size

%% Part a

X1 = random('exp', expected_mean, N, 1);
X2 = random('exp', expected_mean, N, 1);
X3 = random('exp', expected_mean, N, 1);
X4 = random('exp', expected_mean, N, 1);

%% Part b

T = X1 + X2 + X3 + X4; % Establish the wait time random variable

waitTime = mean(T); % Calculate estimated wait time
stdTime = sqrt(var(T)); % Calculate standard deviation of wait time

histogram(T, 'Normalization', 'pdf'); % Generate histogram
title("PDF of T"); % Assign title

pause; % Hold the plot

fprintf("The estimated expectation value is %.4f seconds and the standard deviation is %.4f seconds, with theoretical expected value %.4f\n", waitTime, stdTime, 4 * expected_mean)
fprintf("We expect the distribution to be concentrated around a mean of 20 seconds.\n") % State expectation and standard deviation findings

%% Part c

fprintf("The theoretical and expected wait times differ by %.4f seconds.\n", abs(4 * expected_mean - waitTime)) % State the difference in theoretical versus expected value

%% Part d

T2 = min(X1 + X2, X3 + X4); % Create variable T2

waitTime2 = mean(T2); % Calculate T2 estimated wait time
stdTime2 = sqrt(var(T2)); % Calculate standard deviation of wait time of T2

histogram(T2, 'Normalization', 'pdf'); % Generate histogram
title("PDF of T2"); % Assign title

pause; % Hold the plot

fprintf("The expected wait time for the parallel server case is %.4f seconds with standard deviation %.4f.\n", waitTime2, stdTime2) % State the expected wait time for parallel servers
fprintf("The expected wait time for the parallel versus single server case differ by %.4f seconds.\n", abs(waitTime2 - waitTime)) % State the difference in theoretical versus expected value
fprintf("The parallel case is always less than half of the single case since the minimum value of the sum of two of the random variables is likely less than half of the sum of all of them. A new task is able to start as soon as one of the parallel servers is done processing.\n") % Reasoning for why E[T2] < .5E[T1]

%% Part e

T3 = max(X1, X2); % Create T3

waitTime3 = mean(T3); % Calculate T3 estimated wait time
stdTime3 = sqrt(var(T3)); % Calculate standard deviation of wait time of T3

histogram(T3, 'Normalization', 'pdf'); % Generate histogram
title("PDF of T3"); % Assign title

pause; % Hold the plot

fprintf("The expected wait time for the third server case is %.4f seconds with standard deviation %.4f.\n", waitTime3, stdTime3) % State the expected wait time for parallel servers
fprintf("The expected wait time is between E[T] and E[T2], since waiting time will be reduced, though not as efficiently as the parallel computing case.") % State expected wait time relative to E[T] and E[T2]
fprintf("The standard deviation of this case is a bit larger than the others.");
