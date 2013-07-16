function varargout = AudapterIO(action,params,inFrame,varargin)
%
persistent p

toPrompt=0; % set to 1 when necessary during debugging

switch(action)
    case 'init',
        p=params;
  
        Audapter(3,'srate',p.sr, toPrompt);
        Audapter(3,'framelen',p.frameLen, toPrompt);
        
        Audapter(3,'ndelay',p.nDelay, toPrompt);
        Audapter(3,'nwin',p.nWin, toPrompt);
        Audapter(3,'nlpc',p.nLPC, toPrompt);
        Audapter(3,'nfmts',p.nFmts, toPrompt);
        Audapter(3,'ntracks',p.nTracks, toPrompt);        
        Audapter(3,'scale',p.dScale, toPrompt);
        Audapter(3,'preemp',p.preempFact, toPrompt);
        Audapter(3,'rmsthr',p.rmsThresh, toPrompt);
        Audapter(3,'rmsratio',p.rmsRatioThresh, toPrompt);
        Audapter(3,'rmsff',p.rmsForgFact, toPrompt);
        Audapter(3,'dfmtsff',p.dFmtsForgFact, toPrompt);
        Audapter(3,'bgainadapt',p.gainAdapt, toPrompt);
        Audapter(3,'bshift',p.bShift, toPrompt);
        Audapter(3,'btrack',p.bTrack, toPrompt);
        Audapter(3,'bdetect',p.bDetect, toPrompt);      
        Audapter(3,'avglen',p.avgLen, toPrompt);        
        Audapter(3,'bweight',p.bWeight, toPrompt);    
        
        if (isfield(p,'minVowelLen'))
            Audapter(3,'minvowellen',p.minVowelLen, toPrompt);
        end
        
        if (isfield(p,'bRatioShift'))
            Audapter(3,'bratioshift',p.bRatioShift, toPrompt);
        end
        if (isfield(p,'bMelShift'))
            Audapter(3,'bmelshift',p.bMelShift, toPrompt);
		end
		
%% SC(2009/02/06) RMS Clipping protection
		if (isfield(p,'bRMSClip'))
			Audapter(3,'brmsclip',p.bRMSClip, toPrompt);
		end
		if (isfield(p,'rmsClipThresh'))
			Audapter(3,'rmsclipthresh',p.rmsClipThresh, toPrompt);
        end
        
%% SC(2013/04/08) Option to bypass the formant tracking / shifting for speed
        if isfield(p, 'bBypassFmt')
            Audapter(3, 'bbypassfmt', p.bBypassFmt, toPrompt);
        end
		
%% SC-Mod(2008/05/15) Cepstral lifting related
        if (isfield(p,'bCepsLift'))
            Audapter(3,'bcepslift',p.bCepsLift, toPrompt);
        else
            Audapter(3,'bcepslift',0, toPrompt);
        end
        if (isfield(p,'cepsWinWidth'))
            Audapter(3,'cepswinwidth',p.cepsWinWidth, toPrompt);
        end      
        if (isfield(p,'bRatioShift'))
            Audapter(3,'bratioshift',p.bRatioShift, toPrompt);
        else
            Audapter(3,'bratioshift',p.bRatioShift, toPrompt);
        end   

%% SC-Mod(2008/04/04) Perturbatoin field related 
        if (isfield(p,'pertField') && isfield(p.pertField,'F2LB'))  % Mel
            Audapter(3,'f2lb',p.pertField.F2LB, toPrompt);
        end
        if (isfield(p,'pertField') && isfield(p.pertField,'F2UB'))  % Mel
           Audapter(3,'f2ub',p.pertField.F2UB, toPrompt);
        end
        if (isfield(p,'LBk'))
            Audapter(3,'lbk',p.LBk, toPrompt);
        end
        if (isfield(p,'LBb'))
            Audapter(3,'lbb',p.LBb, toPrompt);
        end
        if (isfield(p,'pertField') && isfield(p.pertField,'fieldF2'))  % Mel
           Audapter(3,'fieldf2',p.pertField.fieldF2, toPrompt);
        end        
        if (isfield(p,'pertField') && isfield(p.pertField,'pVecF1'))  % Mel
           Audapter(3,'pvecf1',p.pertField.pVecF1, toPrompt);
        end
        if (isfield(p,'pertField') && isfield(p.pertField,'pVecF2'))  % Mel
           Audapter(3,'pvecf2',p.pertField.pVecF2, toPrompt);
        end        
%         if (isfield(p,'pertAmp'))   % Mel, 257 points
%             Audapter(3,'pertamp',p.pertAmp, toPrompt);
%         end   
%         if (isfield(p,'pertPhi'))   % Mel, 257 points
%             Audapter(3,'pertphi',p.pertPhi, toPrompt);
%         end       
        
        if (isfield(p,'fb'))    % 2008/06/18
            Audapter(3,'fb',p.fb, toPrompt);
		end
        if (isfield(p,'trialLen'))  %SC(2008/06/22)
            Audapter(3,'triallen',p.trialLen, toPrompt);
        else
            Audapter(3,'triallen',2.5, toPrompt);
        end
        if (isfield(p,'rampLen'))  %SC(2008/06/22)
            Audapter(3,'ramplen',p.rampLen, toPrompt);
        else
            Audapter(3,'ramplen',0.05, toPrompt);
        end
        
        %SC(2008/07/16)
        if (isfield(p,'aFact'))
            Audapter(3,'afact',p.aFact, toPrompt);
        else
            Audapter(3,'afact',1, toPrompt);
        end
        if (isfield(p,'bFact'))
            Audapter(3,'bfact',p.bFact, toPrompt);
        else
            Audapter(3,'bfact',0.8, toPrompt);
        end
        if (isfield(p,'gFact'))
            Audapter(3,'gfact',p.gFact, toPrompt);
        else
            Audapter(3,'gfact',1, toPrompt);
        end
        
        if (isfield(p,'fn1'))
            Audapter(3,'fn1',p.fn1, toPrompt);
        else
            Audapter(3,'fn1',500, toPrompt);
        end
        if (isfield(p,'fn2'))
            Audapter(3,'fn2',p.fn2, toPrompt);
        else
            Audapter(3,'fn2',1500, toPrompt);
        end
        
        %SC(2012/03/05) Frequency/pitch shifting
        if (isfield(p, 'bPitchShift'))
            Audapter(3, 'bpitchshift', p.bPitchShift, toPrompt);
        end
        if (isfield(p, 'pitchShiftRatio'))
            Audapter(3, 'pitchshiftratio', p.pitchShiftRatio, toPrompt);
        end
        if (isfield(p, 'gain'))
            Audapter(3, 'gain', p.gain, toPrompt);
        end
        
        if (isfield(p, 'mute'))
            Audapter(3, 'mute', p.mute, toPrompt);
        end
        
        if (isfield(p, 'pvocFrameLen'))
            Audapter(3, 'pvocframelen', p.pvocFrameLen, toPrompt);
        end
        if (isfield(p, 'pvocHop'))
            Audapter(3, 'pvochop', p.pvocHop, toPrompt);
        end
        
        if (isfield(p, 'bDownSampFilt'))
            Audapter(3, 'bdownsampfilt', p.bDownSampFilt, toPrompt);
        end
%         if (isfield(p,'fitLen'))
%             Audapter(3,'fitlen',p.fitLen, toPrompt);
%         else
%             Audapter(3,'fitlen',15, toPrompt);
%         end
%         if (isfield(p,'sylDurLB'))
%             Audapter(3,'syldurlb',p.sylDurLB, toPrompt);
%         else
%             Audapter(3,'syldurlb',38, toPrompt);
%         end
        
%         if (isfield(p,'iF2LB'))
%             Audapter(3,'if2lb',p.iF2LB, toPrompt);
%         else
%             Audapter(3,'if2lb',1600, toPrompt);
%         end
%         if (isfield(p,'uF2UB'))
%             Audapter(3,'uf2ub',p.uF2UB, toPrompt);
%         else
%             Audapter(3,'uf2ub',1500, toPrompt);
%         end
%         if (isfield(p,'dF2Lim'))
%             Audapter(3,'df2lim',p.dF2Lim, toPrompt);
%         else
%             Audapter(3,'df2lim',25, toPrompt);
%         end
        
        % SC(2009/06/24): Auto-stop functionality 
%         if (isfield(p,'bAutoStop'))
%             Audapter(3,'bautostop',p.bAutoStop, toPrompt);
%         else
%             Audapter(3,'bautostop',0, toPrompt);
%         end
%         if (isfield(p,'voiceDurThresh'))
%             Audapter(3,'voicedurthresh',p.voiceDurThresh, toPrompt);
%         else
%             Audapter(3,'voicedurthresh',0.3, toPrompt);
%         end
%         if (isfield(p,'silDurThresh'))
%             Audapter(3,'sildurthresh',p.silDurThresh, toPrompt);
%         else
%             Audapter(3,'sildurthresh',2, toPrompt);
%         end


        return;
%%            
    case 'process',
        Audapter(5,inFrame);
        return;

    case 'getData',
        nout=nargout;
        [signalMat,dataMat]=Audapter(4);        
        data=[];

        switch(nout)
            case 1,
%                 data.signalIn       = signalMat(:,1);
%                 data.signalOut      = signalMat(:,2);
% 
%                 data.intervals      = dataMat(:,1);
%                 data.rms            = dataMat(:,2:4);
%                 
%                 offS = 5;
%                 data.fmts           = dataMat(:, offS : offS+p.nTracks-1);
%                 data.rads           = dataMat(:, offS+p.nTracks : offS+2*p.nTracks-1);
%                 data.dfmts          = dataMat(:, offS+2*p.nTracks : offS+2*p.nTracks+1);
%                 data.sfmts          = dataMat(:, offS+2*p.nTracks+2 : offS+2*p.nTracks+3);
% %                 data.df1            = dataMat(:,offS+2*p.nTracks+4);
% %                 data.df2            = dataMat(:,offS+2*p.nTracks+5);
%                 
%                 
%                 offS = offS + 2 * p.nTracks + 2 * 2 + p.nLPC;
%                 data.rms_slp        = dataMat(:, offS);
%                 data.sentStat       = dataMat(:, offS + 1);
%                 
%                 %offS = offS+2*p.nTracks+4;
%                 %data.ai             = dataMat(:,offS:offS+p.nLPC);
%                 data.params         = p;
%                 varargout(1)        = {data};
                data.signalIn       = signalMat(:,1);
                data.signalOut      = signalMat(:,2);

                data.intervals      = dataMat(:,1);
                data.rms            = dataMat(:,2:4);
                
                offS = 5;
                data.fmts           = dataMat(:,offS:offS+p.nTracks-1);
                data.rads           = dataMat(:,offS+p.nTracks:offS+2*p.nTracks-1);
                data.dfmts          = dataMat(:,offS+2*p.nTracks:offS+2*p.nTracks+1);
                data.sfmts          = dataMat(:,offS+2*p.nTracks+2:offS+2*p.nTracks+3);

                offS = offS + 2 * p.nTracks + 4;
%                 data.ai             = dataMat(:,offS:offS+p.nLPC);
                
                offS = offS + p.nLPC + 1;
                data.rms_slope      = dataMat(:, offS);
                              
                offS = offS + 1;
                data.ost_stat       = dataMat(:, offS);
                
                data.params         = p;
                varargout(1)        = {data};

                return;

            case 2,
                varargout(1)        = {signalMat(:,1)};
                varargout(2)        = {signalMat(:,2)};
                return;

            case 3,
                varargout(1)        = {transdataMat(1:2,2)'};
                varargout(2)        = {transdataMat(1:2,3)'};
                varargout(3)        = {transdataMat(2,1)-transdataMat(1,1)};
                return;

            otherwise,

        end
    case 'reset',
        Audapter(6);
    otherwise,
        
    uiwait(errordlg(['No such action : ' action ],'!! Error !!'));

end
