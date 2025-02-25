clear all;
close all % Clean the workspace

%%% PROBLEM 1

%% PART A

possibilities_X = [0, -1, 1, -2, 2]; % Assign possible X values

probabilities_X = [0.1, 0.25, 0.25, 0.2, 0.2]; % Assign corresponding probabilities

X_sampling = randsample(possibilities_X, 10000, true, probabilities_X); % Sample X randomly

Y_sampling = .5 * X_sampling.^2; % Recompute the sampled X values to Y

%% PART B

figure; % Begin plot of PMF of X

histogram(X_sampling, 'Normalization', 'probability', 'BinEdges', [-2.5,-1.5,-0.5,0.5,1.5,2.5]); % Apply histogram values for X
title('PMF Estimate (X)'); % Assign histogram title 
xlabel('X'); % Label x-axis as X
ylabel('Probability'); % Label y-axis as Probability

pause;

figure; % Begin plot of PMF of Y

histogram(Y_sampling, 'Normalization', 'probability'); % Apply histogram values for Y
title('PMF Estimate (Y)'); % Assign histogram title
xlabel('Y'); % Label x-axis as Y
ylabel('Probability'); % Label y-axis as Probability

%%% PROBLEM 2

num_packets = 1000; % Assign packet quantity
correct_decoding = 0; % Create a zeroed variable to store the quantity of correctly decoded packets

for i = 1:num_packets % Create a for loop to analyze each packet sent

  n = 64; % Set quantity of bits per packet
  errors = 0; % Create an error counter

  raw_packet = randsample([0,1], n, true); % Create a random packet containing n = 64 bits
  corrected_packet = raw_packet; % Create a template packet to modify if error detected

  for j = 1:n % Create for loop to analyze the randomly-generated packet

    if (corrected_packet(j) == 1) % Check if value of a bit is 1 -- if yes, randomly analyze whether an error occurs (with probability .01)

      if rand(1) < .01 % Check if the 1 is received as a 0

        corrected_packet(j) = 0; % Correct the bit if there is an error
        errors = errors + 1; % Increase error count

      end

    else % Otherwise, value of the bit is 0 -- randomly analyze whether an error occurs (with probability .03)

      if rand(1) < .03 % Check if the 0 is received as a 1

        corrected_packet(j) = 1; % Correct the bit if there is an error
        errors = errors + 1; % Increase error count

      end

    end

  end

  if errors <= 5 % Check if 5 or fewer bits were received in error

      correct_decoding = correct_decoding + 1; % Increase corrected packets decoded count by 1 if there are less than or equal to 5 errors

  end

end

fprintf('%g Packets Were Received Correctly in the Uncongested Network\n',  correct_decoding);

% Note: Simulating 5 times for 100, 1000, and 10000 packets respectively (without congestion modifications produced:
% For 100: [100, 100, 98, 100, 98] packets without errors, or relative frequencies of [0,0,2,0,2] percent
% For 1000: [999, 1000, 999, 1000, 999] packets without errors, or relative frequencies of [.1,0,.1,0,.1] percent
% For 10000: [9980, 9990, 9981, 9983, 9988] packets without errors, or relative frequencies of [.2,.1,.19,.17,.12] percent
% We may observe that with 100 and 1000, it is difficult to tell error frequency, while 10000 shows errors more often. With lower sample sizes, the variability is much greater. Thus, we may conclude 10000 (the largest sample size) produces the most stable error percentages

%% Congested Network Simulation

correct_decoding = 0; % Create a zeroed variable to store the quantity of correctly decoded packets

for i = 1:num_packets % Create a for loop to analyze each packet sent

  n = 64; % Set quantity of bits per packet
  errors = 0; % Create an error counter

  raw_packet = randsample([0,1], n, true); % Create a random packet containing n = 64 bits
  corrected_packet = raw_packet; % Create a template packet to modify if error detected

  for j = 1:n % Create for loop to analyze the randomly-generated packet

    if (corrected_packet(j) == 1) % Check if value of a bit is 1 -- if yes, randomly analyze whether an error occurs (with probability .01)

      error_probability = .01; % Set uncongested error probability

      if rand(1) < .2 % Check for congested network

          error_probability = .03; % If the network is congested, increase error probability

      end

      if rand(1) < error_probability % Check if the 1 is received as a 0

        corrected_packet(j) = 0; % Correct the bit if there is an error
        errors = errors + 1; % Increase error count

      end

    else % Otherwise, value of the bit is 0 -- randomly analyze whether an error occurs (with probability .03)

      error_probability = .03; % Set uncongested error probability

      if rand(1) < .2 % Check for congested network

          error_probability = .05; % If the network is congested, increase error probability

      end

      if rand(1) < error_probability % Check if the 0 is received as a 1

        corrected_packet(j) = 1; % Correct the bit if there is an error
        errors = errors + 1; % Increase error count

      end

    end

  end

  if errors <= 5 % Check if 5 or fewer bits were received in error

      correct_decoding = correct_decoding + 1; % Increase corrected packets decoded count by 1 if there are less than or equal to 5 errors

  end

end

fprintf('%g Packets Were Received Correctly in the (Possibly) Congested Network\n',  correct_decoding);

% Note: evidently, error rate increases when there is congestion in the network
% Running the simulation 5 times showed [2, 2, 1, 7, 1] more errors in the possibly congested network for 1000 packets
