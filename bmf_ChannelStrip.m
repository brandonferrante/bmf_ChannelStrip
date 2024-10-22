classdef bmf_ChannelStrip < audioPlugin
    % downloaded from: bennettaudio.com
    
    properties
        % a property is a public variable that usually has a parameter
        % associated with it

        % PARAMETER_NAME = some value;

        BYPASS = 'OFF'; % ON or OFF

        % gain params
        GAIN_DB = 0;

        % compressor params
        ATTACK = 10;        % ms
        RELEASE = 50;       % ms
        MAKEUP = 0;         % dB
        THRESHOLD = -20;    % dBFS
        RATIO = 2;

        % EQ params
        LF_SHELF = 100;     % low frequency shelf
        MF_FREQ = 1000;     % mid bell
        HF_SHELF = 10000;   % high frequency shelf

        LF_GAIN = 0;        % low frequency gain
        MF_GAIN = 0;        % mid frequency gain
        HF_GAIN = 0;        % high frequency gain

        % Reverb params
        DECAY = 0.5;        % decay (small val = big room)
        MIX = 100;          % dry/wet
        PREDELAY = 0;       % pre delay

    end

    properties (Constant)
        % this contains instructions to build your plugin GUI, usually
        % populated with audioPluginParamters that link to properties
        
        % parameters have:
        % a function call - audioPluginParameter('PARAMETER_NAME',...
        %'DisplayName'
        %'Label'
        %'Mapping': 'lin', 'log', 'pow', 'int', 'enum'

        PluginInterface = audioPluginInterface('PluginName', ...
            'ChannelStrip', 'VendorName', 'bmfAudio', 'VendorVersion', ...
            '1.0.0', 'UniqueId', 'BMFs','BackgroundImage', 'test.png',  ...
                         ...
                         ...
                audioPluginParameter('BYPASS', 'DisplayName', 'Bypass', ...
                'Mapping', {'enum', 'OFF', 'ON'}, 'Style', 'vtoggle', ...
                'Layout', [2,1], 'DisplayNameLocation', 'none',  ...
                'Filmstrip', 'switch_press2.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                                                ...
                audioPluginParameter('GAIN_DB', 'DisplayName', 'Trim', ...
                'Label', 'dB', 'Mapping', {'lin', -12, 12}, 'Style', 'rotaryknob', ...
                'Layout', [4,1],  'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                         ...
                         ...
                audioPluginParameter('ATTACK', 'DisplayName', 'Attack', ...
                'Label', 'ms', 'Mapping', {'lin', 0, 50}, 'Style', 'rotaryknob', ...
                'Layout', [6,5], 'DisplayNameLocation', 'none', ... 
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                                                ...
                audioPluginParameter('RELEASE', 'DisplayName', 'Release', ...
                'Label', 'ms', 'Mapping', {'lin', 0, 200}, 'Style', 'rotaryknob', ...
                'Layout', [6,7], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                                                ...
                audioPluginParameter('THRESHOLD', 'DisplayName', 'Threshold', ...
                'Label', 'dBFS', 'Mapping', {'lin', -50, 0}, 'Style', 'rotaryknob', ...
                'Layout', [6,1], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                                                ...
                audioPluginParameter('RATIO', 'DisplayName', 'Ratio', ...
                'Label', ':1', 'Mapping', {'int', 1, 10}, 'Style', 'rotaryknob', ...
                'Layout', [6,3], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                        ...
                        ...
                audioPluginParameter('LF_SHELF', 'DisplayName', 'LF Shelf', ...
                'Label', 'Hz', 'Mapping', {'log', 20, 400}, 'Style', 'rotaryknob', ...
                'Layout', [2,3], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param  
                                                ...
                audioPluginParameter('LF_GAIN', 'DisplayName', 'LF Gain', ...
                'Label', 'dB', 'Mapping', {'lin', -12, 12}, 'Style', 'rotaryknob', ...
                'Layout', [4,3], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param
                                                ...
                audioPluginParameter('MF_FREQ', 'DisplayName', 'MF Freq', ...
                'Label', 'Hz', 'Mapping', {'log', 200, 10000}, 'Style', 'rotaryknob', ...
                'Layout', [2,5], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param       
                                                ...
                audioPluginParameter('MF_GAIN', 'DisplayName', 'MF Gain', ...
                'Label', 'dB', 'Mapping', {'lin', -12, 12}, 'Style', 'rotaryknob', ...
                'Layout', [4,5], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param  
                                                ...
                audioPluginParameter('HF_SHELF', 'DisplayName', 'HF Shelf', ...
                'Label', 'Hz', 'Mapping', {'log', 4000, 18000}, 'Style', 'rotaryknob', ...
                'Layout', [2,7], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param 
                                                ...
                audioPluginParameter('HF_GAIN', 'DisplayName', 'HF Gain', ...
                'Label', 'dB', 'Mapping', {'lin', -12, 12}, 'Style', 'rotaryknob', ...
                'Layout', [4,7], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param     
                        ...
                        ...
                audioPluginParameter('DECAY', 'DisplayName', 'Absorption', ...
                 'Mapping', {'lin', 0, 1}, 'Style', 'rotaryknob', ...
                'Layout', [8,5], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param 
                                                ...
                audioPluginParameter('MIX', 'DisplayName', 'Mix', ...
                'Label', '%', 'Mapping', {'int', 0, 100}, 'Style', 'rotaryknob', ...
                'Layout', [8,7], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param  
                                                ...
                audioPluginParameter('PREDELAY', 'DisplayName', 'Pre Delay', ...
                'Label', 'ms', 'Mapping', {'int', 0, 1000}, 'Style', 'rotaryknob', ...
                'Layout', [8,3], 'DisplayNameLocation', 'none', ...
                'Filmstrip', 'redknob.png', 'FilmstripFrameSize', [64 64]), ... % end of param   
                ...
                ...
                ...
                ...
                audioPluginGridLayout(...
                'RowHeight', [35, 85, 35, 85, 35, 85, 35, 85],...
                'ColumnWidth', [85, 35, 85, 35, 85, 35, 85] ... 
                ) ...% end grid
        ); % end of interface
   
    end

    properties (Access = private)
        %internal filter variables, such as coefficient values
        FS = 44100;
        gain_linear;
        compressor;
        EQ;
        reverb;
        
        prev_frameSize;

        
    end
    
    methods
        % Constructor
        function plugin = bmf_ChannelStrip()
            % Do any initializing that needs to occur BEFORE the plugin runs
            
            % Initialize gain
            updateGain(plugin);

            % Initialize EQ
            plugin.EQ = multibandParametricEQ('SampleRate', plugin.FS, 'HasHighShelfFilter', true, 'HasLowShelfFilter', true);
            updateEQ(plugin);

            % Initialize compressor
            plugin.compressor = compressor('MakeUpGainMode', 'Auto');
            updateCompressor(plugin);

            % Initialize Reverb
            plugin.reverb = reverberator();
            updateReverb(plugin);

        end

        % Process
        function out = process(plugin,in)
            % DSP section

            % check bypass
            if strcmp(plugin.BYPASS, "ON")
                out = in;
                return;
            end

            % frameSize = size(in, 1);
            % if (frameSize ~= plugin.prev_frameSize)
            %     plugin.prev_frameSize = frameSize;
            % 
            % end
            
            % allocate memory
            out1 = coder.nullcopy(zeros(size(in)));
            out2 = coder.nullcopy(zeros(size(in)));
            out3 = coder.nullcopy(zeros(size(in, 1), 2));
            out = coder.nullcopy(zeros(size(in)));

            % apply DSP
            out1(:,:) = plugin.EQ(in * plugin.gain_linear);
            out2(:,:) = plugin.compressor(out1);
            out3(:,:) = plugin.reverb(out2);
            
            out = out3;
            
        end
        
        function reset(plugin)
            % this gets called if the sample rate changes or if the plugin
            % gets reloaded
            
            plugin.FS = getSampleRate(plugin);

        end

        %% Update functions
        function updateGain(plugin)
            plugin.gain_linear = db2mag(plugin.GAIN_DB);
        end

        function updateEQ(plugin)
            plugin.EQ.Frequencies = [plugin.LF_SHELF, plugin.MF_FREQ, plugin.HF_SHELF];
            plugin.EQ.PeakGains = [plugin.LF_GAIN, plugin.MF_GAIN, plugin.HF_GAIN];
        end

        function updateCompressor(plugin)
            plugin.compressor.Threshold = plugin.THRESHOLD;
            plugin.compressor.Ratio = plugin.RATIO;
            plugin.compressor.AttackTime = plugin.ATTACK/1000;
            plugin.compressor.ReleaseTime = plugin.RELEASE/1000;
        end

        function updateReverb(plugin)
            plugin.reverb.WetDryMix = plugin.MIX / 100;
            plugin.reverb.DecayFactor = plugin.DECAY;
            plugin.reverb.PreDelay = plugin.PREDELAY / 1000;
        end

        %% Set functions

        % GAIN parameters set
        function set.GAIN_DB(plugin, val)
            plugin.GAIN_DB = val;
            updateGain(plugin);
        end


        % COMPRESSOR parameters set
        function set.ATTACK(plugin, val)
            plugin.ATTACK = val;
            updateCompressor(plugin);
        end

        function set.RELEASE(plugin, val)
            plugin.RELEASE = val;
            updateCompressor(plugin);
        end

        function set.THRESHOLD(plugin, val)
            plugin.THRESHOLD = val;
            updateCompressor(plugin);
        end

        function set.RATIO(plugin, val)
            plugin.RATIO = val;
            updateCompressor(plugin);
        end


        % EQ parameters set
        function set.LF_SHELF(plugin, val)
            plugin.LF_SHELF = val;
            updateEQ(plugin);
        end

        function set.MF_FREQ(plugin, val)
            plugin.MF_FREQ = val;
            updateEQ(plugin);
        end

        function set.HF_SHELF(plugin, val)
            plugin.HF_SHELF = val;
            updateEQ(plugin);
        end

        function set.LF_GAIN(plugin, val)
            plugin.LF_GAIN = val;
            updateEQ(plugin);
        end

        function set.MF_GAIN(plugin, val)
            plugin.MF_GAIN = val;
            updateEQ(plugin);
        end

        function set.HF_GAIN(plugin, val)
            plugin.HF_GAIN = val;
            updateEQ(plugin);
        end


        % Reverb parameters set
        function set.MIX(plugin, val)
            plugin.MIX = val;
            updateReverb(plugin);
        end

        function set.DECAY(plugin, val)
            plugin.DECAY = val;
            updateReverb(plugin);
        end

        function set.PREDELAY(plugin, val)
            plugin.PREDELAY = val;
            updateReverb(plugin);
        end
    end
end