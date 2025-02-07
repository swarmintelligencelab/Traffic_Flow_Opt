% Written by Daniel Burbano 
% Last Update: 02//07/2025
%% Initialize Environment
clc;
close all;
clear;

%% Define Plot Parameters
fs = 20; % Font size
fs2 = 20;
LW = 2;  % Line width
markerSize = 36; % Marker size

%% Load Data
W = readmatrix('Adjacency_Matrix.csv');
Data = readmatrix('Curated_Data.csv');

% Remove first row and column (assumed NaN values)
W(1,:) = [];
W(:,1) = [];

% Transpose adjacency matrix to match paper's convention
W = W';

% Extract relevant data columns
ID = Data(2:end,13) + 1; % Convert zero-based indexing to one-based indexing
Vol = Data(2:end,9); % Traffic volume
HH = Data(2:end,7); % Hour (0-24)
MM = Data(2:end,8); % Minute (0,15,30,45)

%% Organize Data by Time Intervals
unique_IDs = unique(ID);
unique_HH = unique(HH);
selected_MM = [0, 15, 30, 45];
num_columns = length(unique_HH) * length(selected_MM);

% Initialize matrices to store results
avg_volume_min = NaN(length(unique_IDs), num_columns);
std_volume_min = NaN(length(unique_IDs), num_columns);
Data_ij = cell(length(unique_IDs), num_columns);

% Generate labels for each hour-minute combination
hour_minute_labels = cell(1, num_columns);

% Loop through each unique ID, hour, and minute
for i = 1:length(unique_IDs)
    column_idx = 1;
    for j = 1:length(unique_HH)
        for k = 1:length(selected_MM)
            idx = (ID == unique_IDs(i)) & (HH == unique_HH(j)) & (MM == selected_MM(k));
            if any(idx)
                avg_volume_min(i, column_idx) = mean(Vol(idx), 'omitnan');
                std_volume_min(i, column_idx) = std(Vol(idx), 'omitnan');
                Data_ij{i, column_idx} = Vol(idx);
            end
            hour_minute_labels{column_idx} = sprintf('%02d:%02d', unique_HH(j), selected_MM(k));
            column_idx = column_idx + 1;
        end
    end
end

%% Interpolate Missing Values
for i = 1:size(avg_volume_min, 1)
    time_series = avg_volume_min(i, :);
    x_non_nan = find(~isnan(time_series));
    x_nan = find(isnan(time_series));
    if ~isempty(x_non_nan) && length(x_non_nan) > 1
        avg_volume_min(i, x_nan) = interp1(x_non_nan, time_series(x_non_nan), x_nan, 'makima');
    end
end

%% Plot Time Series Data
xhours = 0:15:15*95; % 15-minute intervals over 24 hours
figure('Position', [100, 100, 1100, 300]);
hold on;
base_colors = lines(8);
x_base = linspace(1, 8, 8);
x_interp = linspace(1, 8, 19);
extended_colors = interp1(x_base, base_colors, x_interp);
for i = 1:19
    plot(xhours, avg_volume_min(i, :), 'LineWidth', LW, 'Color', extended_colors(i, :));
end
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', fs, 'FontWeight', 'bold');
set(gcf, 'Color', 'w');
axis([xhours(1) xhours(end), 0 450]);
xticks(0:60:1440);
xticklabels(arrayfun(@(h) sprintf('%02d:00', h), 0:23, 'UniformOutput', false));
ylabel('$u_i(t)$', 'Interpreter', 'latex', 'FontSize', fs2);
xlabel('$t\,(s)$', 'Interpreter', 'latex', 'FontSize', fs2);
grid on;

%% Compute Hourly Averages
num_hours = 24;
avg_per_hour = NaN(size(avg_volume_min, 1), num_hours);
for hour = 0:num_hours-1
    col_idx = (hour * 4 + 1):(hour * 4 + 4);
    avg_per_hour(:, hour+1) = nansum(avg_volume_min(:, col_idx), 2);
end
mean_vol = nansum(avg_per_hour);

%% Load Parameters for Optimization Model
Parameters_a = readmatrix('parameters_a.csv');
M_alpha = Parameters_a(2:end,2:end);
Parameters_b = readmatrix('parameters_b.csv');
M_beta = Parameters_b(2:end,2:end);

%% Plot Optimization Results
figure('Position', [100, 100, 640, 240]);
boxplot(M_alpha);
hold on;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),[0 0.4470 0.7410],'FaceAlpha',.5);
end
outliers = findobj(gca, 'Tag', 'Outliers');
for j = 1:length(outliers)
    outliers(j).MarkerEdgeColor = [0.6350 0.0780 0.1840];
end
set(gca, 'XTick', 1:24, 'XTickLabel', arrayfun(@(x) sprintf('%02d', x-1), 1:24, 'UniformOutput', false), ...
    'TickLabelInterpreter', 'latex', 'FontSize', fs, 'FontWeight', 'bold');
set(gcf, 'Color', 'w');
grid on;

%% Simulation
Dat = load('Data_Calibration_model.mat');
Nt = 10;
N = length(W);
dt = 0.001;
vt = 0:dt:(Nt-1)*dt;
VehiCumulative_yss = zeros(1,24);
VehiCumulative_real = zeros(1,24);

for i=1:24
    Time = i;
    X = zeros(N,Nt);
    A = diag(M_alpha(:,i));
    B = M_beta(:,i);
    Dout = diag(ones(1,N)*W);
    for t=1:length(vt)
        X(:,t+1) = -(A+Dout - W)*X(:,t)*dt + B;
    end
    C = Dat.Cc{1,Time};
    Yss = C*X(:,end);
    VehiCumulative_yss(i) = sum(Yss)*(60*60);
    VehiCumulative_real(i) = sum(Dat.Uss{1,Time})*(60*60);
end

%% Plot Simulation Results
vtime = 0:1:23;
figure('Position', [100, 100, 688, 460]);
colors = lines(2);
plot(vtime, VehiCumulative_real, '--', 'Color', colors(1, :), 'LineWidth', LW);
hold on;
scatter(vtime, VehiCumulative_real, markerSize, 'o', 'MarkerEdgeColor', colors(1, :), 'MarkerFaceColor', colors(1, :));
plot(vtime, VehiCumulative_yss, '--', 'Color', colors(2, :), 'LineWidth', LW);
scatter(vtime, VehiCumulative_yss, markerSize, '^', 'MarkerEdgeColor', colors(2, :), 'MarkerFaceColor', colors(2, :));
set(gca, 'XTick', 0:1:23, 'XTickLabel', arrayfun(@(x) sprintf('%02d', x), vtime, 'UniformOutput', false), ...
    'TickLabelInterpreter', 'latex', 'FontSize', fs, 'FontWeight', 'bold');
set(gcf, 'Color', 'w');
grid on;
