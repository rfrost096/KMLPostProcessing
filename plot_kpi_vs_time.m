clear all
close all

C0 = "#0072BD";
C1 = "#D95319";	

PAWPRINTS_LOG = "../Logs/pawprints_5G_NR.csv";
KPI_PawPrints = 'ss_rsrp';
NEMO_LOG = "../Logs/nemo_5G_NR.csv"
KPI_NEMO = "RSRP_NRSpCell_";
ALT_COL = "altitude";

PLOT_BS_DIST = false;
PLOT_ALTITUDE = true;

LINE_WIDTH = 3;
FONT_SIZE = 24;
MARKER_SIZE = 8;

PAWPRINTS_LABEL = "PawPrints 5G SS RSRP";
NEMO_LABEL = "Nemo 5G SS RSRP)";
KPI_AXIS_LABEL = "5G SS RSRP (dBm)";

BS_DISTANCE_COL = "bs_distance";
TIME_COL = "companion_abs_time";

pawprints_table = readtable(PAWPRINTS_LOG);

nemo_table = readtable(NEMO_LOG);
nemo_table = nemo_table(find(~isnan(nemo_table{:, KPI_NEMO})), :);


pawprints_kpi = pawprints_table{:, KPI_PawPrints};
nemo_kpi = nemo_table{:, KPI_NEMO};

pawprints_alt = pawprints_table{:, ALT_COL};
nemo_alt = nemo_table{:, ALT_COL};

pawprints_dist = pawprints_table{:, BS_DISTANCE_COL};
nemo_dist = nemo_table{:, BS_DISTANCE_COL};

pawprints_time = pawprints_table{:, TIME_COL};
pawprints_time = (pawprints_time - pawprints_time(1))/1000.0;

nemo_time = nemo_table{:, TIME_COL};
nemo_time = (nemo_time - nemo_time(1))/ 1000.0;

% Plot KPIs
yyaxis left
ax = gca;
ax.YColor = 'black';  % Set color for left y-axis ticks
plot(pawprints_time, pawprints_kpi, 'LineStyle', "--", 'DisplayName', PAWPRINTS_LABEL, 'Color', C0, 'LineWidth', LINE_WIDTH);
hold on
plot(nemo_time, nemo_kpi, 'DisplayName', NEMO_LABEL, 'Color', C1, 'LineWidth', LINE_WIDTH);
hold on
ylabel(KPI_AXIS_LABEL, 'Color', 'k')

yyaxis right
if (PLOT_ALTITUDE)
    ax = gca;
    ax.YColor = 'black';  % Set color for left y-axis ticks
    plot(pawprints_time, pawprints_alt, "LineStyle", ":", 'DisplayName', "PawPrints Altitude", 'Color', C0, 'LineWidth', LINE_WIDTH);
    hold on
    plot(nemo_time, nemo_alt, "LineStyle", ":", 'DisplayName', "Nemo Altitude", 'Color', C1, 'LineWidth', LINE_WIDTH);
    hold on
    ylabel("Altitude (m)", 'Color', 'k');
end

if (PLOT_BS_DIST)
    plot(pawprints_time, pawprints_dist, 'DisplayName', "PawPrints Distance from BS", 'Color', C0, 'LineWidth', LINE_WIDTH);
    hold on
    plot(nemo_time, nemo_dist, 'DisplayName', "Nemo Distance from BS", "Color", C1, 'LineWidth', LINE_WIDTH);
    grid on;
    ylabel("Distance (m)", 'Color', 'k');
end

xlabel("Elapsed time (s)");

set(gca, 'FontSize', FONT_SIZE);
legend show;
grid on;