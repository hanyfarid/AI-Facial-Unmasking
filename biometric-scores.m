clear;

% ----------------------------------------------
% load data
fn = "biometric-scores-arcface.txt";
opts = detectImportOptions(fn,"FileType","text");
opts.VariableNamesLine = 0;
opts.VariableTypes = ["int32","string","double"];
T = readtable(fn,opts);

code = T{:,1};
name = T{:,2};
score = T{:,3};
bins  = linspace(-0.2,1,40);

% ----------------------------------------------
% parse date based on condition (code)
ind1 = find( code == 1 ); vals = score(ind1); vals = vals(vals > -1); [N1,X1] = hist( vals, bins ); N1 = N1 / sum(N1); % same identity
ind2 = find( code == 2 ); vals = score(ind2); vals = vals(vals > -1); [N2,X2] = hist( vals, bins ); N2 = N2 / sum(N2); % different identity (same race/gender)
ind3 = find( code == 3 ); vals = score(ind3); vals = vals(vals > -1); [N3,X3] = hist( vals, bins ); N3 = N3 / sum(N3); % same identity (chatGPT unmasked)
ind4 = find( code == 4 ); vals = score(ind4); vals = vals(vals > -1); [N4,X4] = hist( vals, bins ); N4 = N4 / sum(N4); % same identity (chatGPT unmasked US Senators)
ind5 = find( code == 5 ); vals = score(ind5); vals = vals(vals > -1); [N5,X5] = hist( vals, bins ); N5 = N5 / sum(N5); % same identity (Grok unmasked)
ind6 = find( code == 6 ); vals = score(ind6); vals = vals(vals > -1); [N6,X6] = hist( vals, bins ); N6 = N6 / sum(N6); % same identity (Gemini unmasked)
ind7 = find( code == 7 ); vals = score(ind7); vals = vals(vals > -1); [N7,X7] = hist( vals, bins ); N7 = N7 / sum(N7); % same identity (Gemini unmasked US Senators)

% ----------------------------------------------
% display biometric-score densities
vals = score(ind1); vals = vals(vals > -1); thresh1 = mean(vals); % mean "same" score
vals = score(ind2); vals = vals(vals > -1); thresh2 = mean(vals); % mean "different" score

figure(1); subplot(511); cla; hold on; set(gca,'FontSize',24); set(gcf,'Color','w');
h1 = bar(X1,N1); set(h1,'FaceAlpha',0.5,'FaceColor','g');
h2 = bar(X2,N2); set(h2,'FaceAlpha',0.5,'FaceColor','r');
%h8 = bar(X8,N8); set(h8,'FaceAlpha',0.5,'FaceColor','y');
l1 = line( [thresh1 thresh1], [0 0.25] ); set(l1,'LineWidth',2,'Color','k' );
l2 = line( [thresh2 thresh2], [0 0.25] ); set(l2,'LineWidth',2,'Color','k' );
hold off; grid on; box on; axis( [-0.3 1.01 0.0 0.25]); ylabel('Density');
%legend( sprintf('Same-ID (N=%d)',length(ind1)), sprintf('Different-ID (N=%d)',length(ind2)), sprintf('Dooplegangers (N=%d)',length(ind8)), 'Location','NorthWest' );
legend( sprintf('Same-ID (N=%d)',length(ind1)), sprintf('Different-ID (N=%d)',length(ind2)), 'Location','NorthWest' );
set(gca,'Xtick',[],'Ytick',[0 0.1 0.2]); 
h = text( 0.925, 0.225, '(A)'); set(h,'FontSize',32);

figure(1); subplot(512); cla; hold on; set(gca,'FontSize',24);
h5 = bar(X5,N5); set(h5,'FaceAlpha',0.5,'FaceColor','c');
l1 = line( [thresh1 thresh1], [0 0.25] ); set(l1,'LineWidth',2,'Color','g' );
l2 = line( [thresh2 thresh2], [0 0.25] ); set(l2,'LineWidth',2,'Color','r' );
hold off; grid on; box on; axis( [-0.3 1.01 0.0 0.25]);  ylabel('Density');
legend( sprintf('GrokAI (N=%d)',length(ind5)), 'Location','NorthWest' );
set(gca,'Xtick',[],'Ytick',[0 0.1 0.2]); 
h = text( 0.925, 0.225, '(B)'); set(h,'FontSize',32);

figure(1); subplot(513); cla; hold on; set(gca,'FontSize',24);
h3 = bar(X3,N3); set(h3,'FaceAlpha',0.5,'FaceColor','b');
l1 = line( [thresh1 thresh1], [0 0.25] ); set(l1,'LineWidth',2,'Color','g' );
l2 = line( [thresh2 thresh2], [0 0.25] ); set(l2,'LineWidth',2,'Color','r' );
hold off; grid on; box on; axis( [-0.3 1.01 0.0 0.25]);  ylabel('Density');
legend( 'ChatGPT (N=400)', 'Location','NorthWest' );
set(gca,'Xtick',[],'Ytick',[0 0.1 0.2]); 
h = text( 0.925, 0.225, '(C)'); set(h,'FontSize',32);

figure(1); subplot(514); cla; hold on; set(gca,'FontSize',24);
h6 = bar(X6,N6); set(h6,'FaceAlpha',0.5,'FaceColor','m');
l1 = line( [thresh1 thresh1], [0 0.25] ); set(l1,'LineWidth',2,'Color','g' );
l2 = line( [thresh2 thresh2], [0 0.25] ); set(l2,'LineWidth',2,'Color','r' );
hold off; grid on; box on; axis( [-0.3 1.01 0.0 0.25]);  ylabel('Density');
legend( sprintf('Gemini (N=%d)', length(ind6)), 'Location','NorthWest' );
set(gca,'Xtick',[],'Ytick',[0 0.1 0.2]); 
h = text( 0.925, 0.225, '(D)'); set(h,'FontSize',32);

figure(1); subplot(515); cla; hold on; set(gca,'FontSize',24);
h4 = bar(X4,N4); set(h4,'FaceAlpha',0.5,'FaceColor','b');
h7 = bar(X7,N7); set(h7,'FaceAlpha',0.5,'FaceColor','m');
l1 = line( [thresh1 thresh1], [0 0.25] ); set(l1,'LineWidth',2,'Color','g' );
l2 = line( [thresh2 thresh2], [0 0.25] ); set(l2,'LineWidth',2,'Color','r' );
hold off; grid on; box on; axis( [-0.3 1.01 0.0 0.25]); xlabel('Biometric score'); ylabel('Density');
legend( sprintf('ChatGPT: US-Senators (N=%d)',length(ind4)), sprintf('Gemini: US-Senators (N=%d)',length(ind7)), 'Location','NorthWest' );
set(gca,'Ytick',[0 0.1 0.2]); 
h = text( 0.925, 0.225, '(E)'); set(h,'FontSize',32);

% ----------------------------------------------
% save densities.png
axs = gobjects(5,1);
for k = 1:5
    axs(k) = subplot(5,1,k);
end
gap = 0.01;        % vertical gap (normalized units)
top = 0.98;
bottom = 0.06;
height = (top - bottom - gap*4) / 5;
for k = 1:5
    axs(k).Position = [ 0.1, top - k*(height+gap)+gap, 0.85, height];
end
fig = gcf;
set(gcf,'Position', [1000 149 900 1188]);
set(fig, 'Units','pixels');
fig.Position(3:4) = fig.Position(3:4); % touch to refresh layout
exportgraphics(fig, 'densities.png', 'Resolution', 300);

% ----------------------------------------------
% ChatGPT: compute biometric scores per gender/race
vals = score(ind2); vals = vals(vals > -1); thresh = prctile(vals, 99.95); % score at which 99.95% of different identites are correctly identified (i.e., score > thresh)

gender = ["Female", "Male"];
race = ["Black","EastAsian","SouthAsian","White"];
for g = gender
    for r = race
        S = [];
        for k = 1:length(ind3)
            if( strfind(name(ind3(k)),g) & strfind(name(ind3(k)),r) )
                if( score(ind3(k)) > -1 )
                    S = [S score(ind3(k)) ];
                end
            end
        end
        fprintf( '%20s %10s %5.2f %5.2f %5.2f\n', g, r, mean(S), std(S), 100*length(find(S<thresh))/length(S) );
    end
end
fprintf('\n\n')

% ----------------------------------------------
% Gemini: compute biometric scores per gender/race
gender = ["Female", "Male"];
race = ["Black","EastAsian","SouthAsian","White"];
for g = gender
    for r = race
        S = [];
        for k = 1:length(ind6)
            if( strfind(name(ind6(k)),g) & strfind(name(ind6(k)),r) )
                if( score(ind6(k)) > -1 )
                    S = [S score(ind6(k)) ];
                end
            end
        end
        fprintf( '%20s %10s %5.2f %5.2f %5.2f\n', g, r, mean(S), std(S), 100*length(find(S<thresh))/length(S) );
    end
end

% ----------------------------------------------
% Cohen's D for difference in distributions
ind1 = find( code == 1 ); vals1 = score(ind1); vals1 = vals1(vals1 > -1); % same identity
ind2 = find( code == 2 ); vals2 = score(ind2); vals2 = vals2(vals2 > -1); % different identity (same race/gender)
ind3 = find( code == 3 ); vals3 = score(ind3); vals3 = vals3(vals3 > -1); % same identity (chatGPT unmasked)
ind4 = find( code == 4 ); vals4 = score(ind4); vals4 = vals4(vals4 > -1); % same identity (chatGPT unmasked US Senators)
ind5 = find( code == 5 ); vals5 = score(ind5); vals5 = vals5(vals5 > -1); % same identity (Grok unmasked)
ind6 = find( code == 6 ); vals6 = score(ind6); vals6 = vals6(vals6 > -1); % same identity (Gemini unmasked)
ind7 = find( code == 7 ); vals7 = score(ind7); vals7 = vals7(vals7 > -1); % same identity (Gemini unmasked US Senators)

meanEffectSize(vals1,vals5,Effect="cohen")
meanEffectSize(vals1,vals3,Effect="cohen")
meanEffectSize(vals1,vals6,Effect="cohen")

% ---------------------------------------------
% Fit normal distribution to same/different and compute TP/FP for different FP thresholds
%close all;
vals = score(ind1); vals = vals(vals > -1); pd = fitdist(vals, 'Normal'); mu_same = pd.mu; sig_same = pd.sigma; % same
vals = score(ind2); vals = vals(vals > -1); pd = fitdist(vals, 'Normal'); mu_diff = pd.mu; sig_diff = pd.sigma; % different
ind4 = find( code == 4 ); vals = score(ind4); vals4 = vals(vals > -1); % Senators: ChatGPT
ind7 = find( code == 7 ); vals = score(ind7); vals7 = vals(vals > -1); % Senators: Gemini
vals = [vals4 ; vals7]; pd = fitdist(vals, 'Normal'); mu_senators = pd.mu; sig_senators = pd.sigma; % Senators

for fm = [0.99 0.999 0.9999 0.99999 0.999999]
    t = mu_diff + norminv(fm)*sig_diff;
    false_match = normcdf(t, mu_diff, sig_diff, 'upper');
    non_match_no_unmask = 1-normcdf(t, mu_same, sig_same, 'upper');
    non_match_unmask = 1-normcdf(t, mu_senators, sig_senators, 'upper');
    fprintf( '%5.5f %5.5f %5.5f\n', 100*false_match, 100*non_match_no_unmask, 100*non_match_unmask );
end

