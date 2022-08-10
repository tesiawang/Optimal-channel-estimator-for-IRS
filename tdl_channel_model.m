%% test TDL channel model specified in 38.901

v = 30.0;                    % UE velocity in km/h
fc = 4e9;                    % carrier frequency in Hz
c = physconst('lightspeed'); % speed of light in m/s
fd = (v*1000/3600)/c*fc;     % UE max Doppler frequency in Hz

tdl = nrTDLChannel;
tdl.DelayProfile = 'TDL-C';
tdl.DelaySpread = 300e-9;
tdl.MaximumDopplerShift = 0;

% create TX waveform
SR = 30.72e6;
T = SR * 1e-3; % the number of samples within one ms
tdl.SampleRate = SR;
tdlinfo = info(tdl);
Nt = tdlinfo.NumTransmitAntennas;
 
txWaveform = complex(randn(T,Nt),randn(T,Nt));

% get the rx waveform
[rxWaveform, H] = tdl(txWaveform);

% analyze the frequency domain of the rxwaveform
analyzer = dsp.SpectrumAnalyzer('SampleRate',tdl.SampleRate,...
    'AveragingMethod','Exponential','ForgettingFactor',0.99 );
analyzer.Title = ['Received Signal Spectrum ' tdl.DelayProfile];
analyzer(rxWaveform);


%% test self-defined channel model
% First tap: Rician with average power 0 dB, K-factor 10 dB, and zero delay.
% Second tap: Rayleigh with average power −5 dB, and 45 ns path delay using TDL-D.

tdl = nrTDLChannel;
tdl.NumTransmitAntennas = 1;
tdl.DelayProfile = 'Custom';
tdl.FadingDistribution = 'Rician';
tdl.KFactorFirstTap = 10.0;
tdl.PathDelays = [0.0 45e-9];
tdl.AveragePathGains = [0.0 -5.0];

SR = 30.72e6;
T = SR * 1e-3;
tdl.SampleRate = SR;
tdlinfo = info(tdl);
Nt = tdlinfo.NumTransmitAntennas;
 
txWaveform = complex(randn(T,Nt),randn(T,Nt));
rxWaveform = tdl(txWaveform);
