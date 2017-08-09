function [matTrials] = funGenTrials_Peter(iPart)
    
      %iPart='p01'
     
    vNrMeas=2;

    vNrSamples = 2 * vNrMeas;
    
    load /Users/jamesenns/Documents/MusicSoft/TrialLists/matSegDub
    load /Users/jamesenns/Documents/MusicSoft/TrialLists/matSegMix
    load /Users/jamesenns/Documents/MusicSoft/TrialLists/matSegLv2
    load /Users/jamesenns/Documents/MusicSoft/TrialLists/matSegLiv
     

    matMix = matSegMix;
    matDub = matSegDub;
    matLiv = matSegLiv;
    matLv2 = matSegLv2;
    
    matMixSeg = matMix (1:vNrSamples);
    matDubSeg = matDub (1:vNrSamples);
    matLivSeg = matLiv (1:vNrSamples);
    matLv2Seg = matLv2 (1:vNrSamples);
    
    
    for i=1:vNrSamples
           
        cMixSegment=char(matMix(1,i));  %e.g., 'BeLove_dub_32bars_6_qD_tC_HR.wav
        cMixCondition=cMixSegment([8:10]);
        cMixHeader=cMixSegment([1:6]);
        
%         matMixCon(1,i)=cellstr(cMixCondition);
%         matMixHead(1,i)=cellstr(cMixHeader);
        [matMixCon{1,(i-1)*4+1:(i*4)}]=deal(cMixCondition);
        [matMixHead{1,(i-1)*4+1:(i*4)}]=deal(cMixHeader);        
        matMixSeg2(1, (i-1)*4+1:(i*4))=cellstr(matMixSeg(1, i));
        
        
        cDubSegment=char(matDub(1,i));
        cDubCondition=cDubSegment([8:10]);
        cDubHeader=cDubSegment([1:6]);
        
%         matDubCon(1,i)=cellstr(cDubCondition);
%         matDubHead(1,i)=cellstr(cDubHeader);
        [matDubCon{1,(i-1)*4+1:(i*4)}]=deal(cDubCondition);
        [matDubHead{1,(i-1)*4+1:(i*4)}]=deal(cDubHeader);        
        matDubSeg2(1,(i-1)*4+1:(i*4))=cellstr(matDubSeg(1,i));
        
        
        cLivSegment=char(matLiv(1,i));
        cLivCondition=cLivSegment([8:10]);
        cLivHeader=cLivSegment([1:6]);
        
%         matLivCon(1,i)=cellstr(cLivCondition);
%         matLivHead(1,i)=cellstr(cLivHeader);
        [matLivCon{1,(i-1)*4+1:(i*4)}]=deal(cLivCondition);
        [matLivHead{1,(i-1)*4+1:(i*4)}]=deal(cLivHeader);        
        matLivSeg2(1,(i-1)*4+1:(i*4))=cellstr(matLivSeg(1,i));
        
        cLv2Segment=char(matLv2(1,i));
        cLv2Condition=cLv2Segment([8:10]);
        cLv2Header=cLv2Segment([1:6]);
        
%         matLv2Con(1,i)=cellstr(cLv2Condition);
%         matLv2Head(1,i)=cellstr(cLv2Header);
        [matLv2Con{1,(i-1)*4+1:(i*4)}]=deal(cLv2Condition);
        [matLv2Head{1,(i-1)*4+1:(i*4)}]=deal(cLv2Header);        
        matLv2Seg2(1,(i-1)*4+1:(i*4))=cellstr(matLv2Seg(1,i));
    end;
    
    
    
    
    matSynPos=[cellstr('in synch?'), cellstr('teamwork?'), cellstr('has synergy?'), cellstr('conversational?')];
    matSynNeg=[cellstr('out of synch?'), cellstr('individual effort?'), cellstr('no synergy?'), cellstr('one sided?')];
    iNrSynPos=length(matSynPos);
    iNrSynNeg=length(matSynNeg);
    
    matCrePos=[cellstr('innovative?'), cellstr('stylized?'), cellstr('sophisticated?'), cellstr('masterful?')];
    matCreNeg=[cellstr('rigid?'), cellstr('formulaic?'), cellstr('simple?'), cellstr('student-like?')];
    iNrCrePos=length(matCrePos);
    iNrCreNeg=length(matCreNeg);
    
    matEmoPos=[cellstr('good vibe?'), cellstr('toe-tapping?'), cellstr('groovy?'), cellstr('energetic?')];
    matEmoNeg=[cellstr('bad vibe?'), cellstr('dull?'), cellstr('lifeless?'), cellstr('boring?')];
    iNrEmoPos=length(matEmoPos);
    iNrEmoNeg=length(matEmoNeg);
    
    matEngPos=[cellstr('live concert?'), cellstr('immersive?'), cellstr('attractive?'), cellstr('easy to follow?')];
    matEngNeg=[cellstr('studio recording?'), cellstr('distant?'), cellstr('distracting?'), cellstr('hard to follow?')];
    iNrEngPos=length(matEngPos);
    iNrEngNeg=length(matEngNeg);
    
    %needs adjusment if number of measurments changes
    matAllMix=vertcat(matMixSeg2, matMixHead, matMixCon); 
    %now have 16 cols or mix, [1 5 9 13] are where each of the 4 segments
    %of mix begin
    
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([1 5]);
    
    matAllMix(4,[o(1)+mults])=cellstr('Syn');
    matAllMix(5,o(1)+mults(1))=matSynPos(randi(iNrSynPos));
    matAllMix(5,o(1)+mults(2))=matSynNeg(randi(iNrSynNeg));
    matAllMix(6,[o(1)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllMix(4,[o(2)+mults])=cellstr('Cre');
    matAllMix(5,o(2)+mults(1))=matCreNeg(randi(iNrCreNeg));
    matAllMix(5,o(2)+mults(2))=matCrePos(randi(iNrCrePos));
    matAllMix(6,[o(2)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllMix(4,[o(3)+mults])=cellstr('Emo');
    matAllMix(5,o(3)+mults(1))=matEmoPos(randi(iNrEmoPos));
    matAllMix(5,o(3)+mults(2))=matEmoNeg(randi(iNrEmoNeg));
    matAllMix(6,[o(3)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllMix(4,[o(4)+mults])=cellstr('Eng');
    matAllMix(5,o(4)+mults(1))=matEngNeg(randi(iNrEngNeg));
    matAllMix(5,o(4)+mults(2))=matEngPos(randi(iNrEngPos));
    matAllMix(6,[o(4)+mults])=[cellstr('Neg') cellstr('Pos')];
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([9 13]);
     
    matAllMix(4,[o(1)+mults])=cellstr('Syn');
    matAllMix(5,[o(1)+mults])=[matSynNeg(randi(iNrSynNeg)) matSynPos(randi(iNrSynPos))];
    matAllMix(6,[o(1)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllMix(4,[o(2)+mults])=cellstr('Cre');
    matAllMix(5,[o(2)+mults])=[matCrePos(randi(iNrCrePos)) matCreNeg(randi(iNrCreNeg))];
    matAllMix(6,[o(2)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllMix(4,[o(3)+mults])=cellstr('Emo');
    matAllMix(5,[o(3)+mults])=[matSynNeg(randi(iNrSynNeg)) matSynPos(randi(iNrSynPos))];
    matAllMix(6,[o(3)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllMix(4,[o(4)+mults])=cellstr('Eng');
    matAllMix(5,[o(4)+mults])=[matCrePos(randi(iNrCrePos)) matCreNeg(randi(iNrCreNeg))];
    matAllMix(6,[o(4)+mults])=[cellstr('Pos') cellstr('Neg')];
    
%     o=shuffle([4 6 8 10]);
%     
%     matAllMix(o(1),[5:6])=cellstr('Syn');
%     matAllMix(o(1)+1,5)=matSynPos(randi(iNrSynPos));
%     matAllMix(o(1)+1,6)=matSynNeg(randi(iNrSynNeg));
%     matAllMix(o(2),[5:6])=cellstr('Cre');
%     matAllMix(o(2)+1,5)=matCrePos(randi(iNrCrePos));
%     matAllMix(o(2)+1,6)=matCreNeg(randi(iNrCreNeg));
%     matAllMix(o(3),[5:6])=cellstr('Emo');
%     matAllMix(o(3)+1,5)=matEmoPos(randi(iNrEmoPos));
%     matAllMix(o(3)+1,6)=matEmoNeg(randi(iNrEmoNeg));
%     matAllMix(o(4),[5:6])=cellstr('Eng');
%     matAllMix(o(4)+1,5)=matEngPos(randi(iNrEngPos));
%     matAllMix(o(4)+1,6)=matEngNeg(randi(iNrEngNeg));
    
%     o=shuffle([4 6 8 10]);
%     
%     matAllMix(o(1),[7:8])=cellstr('Syn');
%     matAllMix(o(1)+1,7)=matSynPos(randi(iNrSynPos));
%     matAllMix(o(1)+1,8)=matSynNeg(randi(iNrSynNeg));
%     matAllMix(o(2),[7:8])=cellstr('Cre');
%     matAllMix(o(2)+1,7)=matCrePos(randi(iNrCrePos));
%     matAllMix(o(2)+1,8)=matCreNeg(randi(iNrCreNeg));
%     matAllMix(o(3),[7:8])=cellstr('Emo');
%     matAllMix(o(3)+1,7)=matEmoPos(randi(iNrEmoPos));
%     matAllMix(o(3)+1,8)=matEmoNeg(randi(iNrEmoNeg));
%     matAllMix(o(4),[7:8])=cellstr('Eng');
%     matAllMix(o(4)+1,7)=matEngPos(randi(iNrEngPos));
%     matAllMix(o(4)+1,8)=matEngNeg(randi(iNrEngNeg));
    
    
    matAllDub=vertcat(matDubSeg2, matDubHead, matDubCon); 
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([1 5]);
    
    matAllDub(4,[o(1)+mults])=cellstr('Syn');
    matAllDub(5,[o(1)+mults])=[matSynPos(randi(iNrSynPos)) matSynNeg(randi(iNrSynNeg))];
    matAllDub(6,[o(1)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllDub(4,[o(2)+mults])=cellstr('Cre');
    matAllDub(5,[o(2)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllDub(6,[o(2)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllDub(4,[o(3)+mults])=cellstr('Emo');
    matAllDub(5,[o(3)+mults])=[matEmoPos(randi(iNrEmoPos)) matEmoNeg(randi(iNrEmoNeg))];
    matAllDub(6,[o(3)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllDub(4,[o(4)+mults])=cellstr('Eng');
    matAllDub(5,[o(4)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllDub(6,[o(4)+mults])=[cellstr('Neg') cellstr('Pos')];
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([9 13]);
    
    matAllDub(4,[o(1)+mults])=cellstr('Syn');
    matAllDub(5,[o(1)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllDub(6,[o(1)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllDub(4,[o(2)+mults])=cellstr('Cre');
    matAllDub(5,[o(2)+mults])=[matCrePos(randi(iNrCrePos)) matCreNeg(randi(iNrCreNeg))];
    matAllDub(6,[o(2)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllDub(4,[o(3)+mults])=cellstr('Emo');
    matAllDub(5,[o(3)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllDub(6,[o(3)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllDub(4,[o(4)+mults])=cellstr('Eng');
    matAllDub(5,[o(4)+mults])=[matEngPos(randi(iNrEngPos)) matEngNeg(randi(iNrEngNeg))];
    matAllDub(6,[o(4)+mults])=[cellstr('Pos') cellstr('Neg')];
    
%     o=shuffle([4 6 8 10]);
%     
%     matAllDub(o(1),[5:6])=cellstr('Syn');
%     matAllDub(o(1)+1,5)=matSynPos(randi(iNrSynPos));
%     matAllDub(o(1)+1,6)=matSynNeg(randi(iNrSynNeg));
%     matAllDub(o(2),[5:6])=cellstr('Cre');
%     matAllDub(o(2)+1,5)=matCrePos(randi(iNrCrePos));
%     matAllDub(o(2)+1,6)=matCreNeg(randi(iNrCreNeg));
%     matAllDub(o(3),[5:6])=cellstr('Emo');
%     matAllDub(o(3)+1,5)=matEmoPos(randi(iNrEmoPos));
%     matAllDub(o(3)+1,6)=matEmoNeg(randi(iNrEmoNeg));
%     matAllDub(o(4),[5:6])=cellstr('Eng');
%     matAllDub(o(4)+1,5)=matEngPos(randi(iNrEngPos));
%     matAllDub(o(4)+1,6)=matEngNeg(randi(iNrEngNeg));
%     
%     o=shuffle([4 6 8 10]);
%     
%     matAllDub(o(1),[7:8])=cellstr('Syn');
%     matAllDub(o(1)+1,7)=matSynPos(randi(iNrSynPos));
%     matAllDub(o(1)+1,8)=matSynNeg(randi(iNrSynNeg));
%     matAllDub(o(2),[7:8])=cellstr('Cre');
%     matAllDub(o(2)+1,7)=matCrePos(randi(iNrCrePos));
%     matAllDub(o(2)+1,8)=matCreNeg(randi(iNrCreNeg));
%     matAllDub(o(3),[7:8])=cellstr('Emo');
%     matAllDub(o(3)+1,7)=matEmoPos(randi(iNrEmoPos));
%     matAllDub(o(3)+1,8)=matEmoNeg(randi(iNrEmoNeg));
%     matAllDub(o(4),[7:8])=cellstr('Eng');
%     matAllDub(o(4)+1,7)=matEngPos(randi(iNrEngPos));
%     matAllDub(o(4)+1,8)=matEngNeg(randi(iNrEngNeg));

    
    
    
    
    
    matAllLiv=vertcat(matLivSeg2, matLivHead, matLivCon); 
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([1 5]);
    
    matAllLiv(4,[o(1)+mults])=cellstr('Syn');
    matAllLiv(5,[o(1)+mults])=[matSynPos(randi(iNrSynPos)) matSynNeg(randi(iNrSynNeg))];
    matAllLiv(6,[o(1)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllLiv(4,[o(2)+mults])=cellstr('Cre');
    matAllLiv(5,[o(2)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLiv(6,[o(2)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllLiv(4,[o(3)+mults])=cellstr('Emo');
    matAllLiv(5,[o(3)+mults])=[matEmoPos(randi(iNrEmoPos)) matEmoNeg(randi(iNrEmoNeg))];
    matAllLiv(6,[o(3)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllLiv(4,[o(4)+mults])=cellstr('Eng');
    matAllLiv(5,[o(4)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLiv(6,[o(4)+mults])=[cellstr('Neg') cellstr('Pos')];
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([9 13]);
    
    matAllLiv(4,[o(1)+mults])=cellstr('Syn');
    matAllLiv(5,[o(1)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLiv(6,[o(1)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllLiv(4,[o(2)+mults])=cellstr('Cre');
    matAllLiv(5,[o(2)+mults])=[matCrePos(randi(iNrCrePos)) matCreNeg(randi(iNrCreNeg))];
    matAllLiv(6,[o(2)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllLiv(4,[o(3)+mults])=cellstr('Emo');
    matAllLiv(5,[o(3)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLiv(6,[o(3)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllLiv(4,[o(4)+mults])=cellstr('Eng');
    matAllLiv(5,[o(4)+mults])=[matEngPos(randi(iNrEngPos)) matEngNeg(randi(iNrEngNeg))];
    matAllLiv(6,[o(4)+mults])=[cellstr('Pos') cellstr('Neg')];
    
%     o=shuffle([4 6 8 10]);
%     
%     matAllLiv(o(1),[5:6])=cellstr('Syn');
%     matAllLiv(o(1)+1,5)=matSynPos(randi(iNrSynPos));
%     matAllLiv(o(1)+1,6)=matSynNeg(randi(iNrSynNeg));
%     matAllLiv(o(2),[5:6])=cellstr('Cre');
%     matAllLiv(o(2)+1,5)=matCrePos(randi(iNrCrePos));
%     matAllLiv(o(2)+1,6)=matCreNeg(randi(iNrCreNeg));
%     matAllLiv(o(3),[5:6])=cellstr('Emo');
%     matAllLiv(o(3)+1,5)=matEmoPos(randi(iNrEmoPos));
%     matAllLiv(o(3)+1,6)=matEmoNeg(randi(iNrEmoNeg));
%     matAllLiv(o(4),[5:6])=cellstr('Eng');
%     matAllLiv(o(4)+1,5)=matEngPos(randi(iNrEngPos));
%     matAllLiv(o(4)+1,6)=matEngNeg(randi(iNrEngNeg));
%     
%     o=shuffle([4 6 8 10]);
%     
%     matAllLiv(o(1),[7:8])=cellstr('Syn');
%     matAllLiv(o(1)+1,7)=matSynPos(randi(iNrSynPos));
%     matAllLiv(o(1)+1,8)=matSynNeg(randi(iNrSynNeg));
%     matAllLiv(o(2),[7:8])=cellstr('Cre');
%     matAllLiv(o(2)+1,7)=matCrePos(randi(iNrCrePos));
%     matAllLiv(o(2)+1,8)=matCreNeg(randi(iNrCreNeg));
%     matAllLiv(o(3),[7:8])=cellstr('Emo');
%     matAllLiv(o(3)+1,7)=matEmoPos(randi(iNrEmoPos));
%     matAllLiv(o(3)+1,8)=matEmoNeg(randi(iNrEmoNeg));
%     matAllLiv(o(4),[7:8])=cellstr('Eng');
%     matAllLiv(o(4)+1,7)=matEngPos(randi(iNrEngPos));
%     matAllLiv(o(4)+1,8)=matEngNeg(randi(iNrEngNeg));

       
  
    
    
    matAllLv2=vertcat(matLv2Seg2, matLv2Head, matLv2Con); 
    
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([1 5]);
    
    matAllLv2(4,[o(1)+mults])=cellstr('Syn');
    matAllLv2(5,[o(1)+mults])=[matSynPos(randi(iNrSynPos)) matSynNeg(randi(iNrSynNeg))];
    matAllLv2(6,[o(1)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllLv2(4,[o(2)+mults])=cellstr('Cre');
    matAllLv2(5,[o(2)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLv2(6,[o(2)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllLv2(4,[o(3)+mults])=cellstr('Emo');
    matAllLv2(5,[o(3)+mults])=[matEmoPos(randi(iNrEmoPos)) matEmoNeg(randi(iNrEmoNeg))];
    matAllLv2(6,[o(3)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllLv2(4,[o(4)+mults])=cellstr('Eng');
    matAllLv2(5,[o(4)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLv2(6,[o(4)+mults])=[cellstr('Neg') cellstr('Pos')];
    
%     o=shuffle([4 6 8 10]);
    o=shuffle([0 1 2 3]);
    mults=([9 13]);
    
    matAllLv2(4,[o(1)+mults])=cellstr('Syn');
    matAllLv2(5,[o(1)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLv2(6,[o(1)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllLv2(4,[o(2)+mults])=cellstr('Cre');
    matAllLv2(5,[o(2)+mults])=[matCrePos(randi(iNrCrePos)) matCreNeg(randi(iNrCreNeg))];
    matAllLv2(6,[o(2)+mults])=[cellstr('Pos') cellstr('Neg')];
    matAllLv2(4,[o(3)+mults])=cellstr('Emo');
    matAllLv2(5,[o(3)+mults])=[matCreNeg(randi(iNrCreNeg)) matCrePos(randi(iNrCrePos))];
    matAllLv2(6,[o(3)+mults])=[cellstr('Neg') cellstr('Pos')];
    matAllLv2(4,[o(4)+mults])=cellstr('Eng');
    matAllLv2(5,[o(4)+mults])=[matEngPos(randi(iNrEngPos)) matEngNeg(randi(iNrEngNeg))];
    matAllLv2(6,[o(4)+mults])=[cellstr('Pos') cellstr('Neg')];
    
%     o=shuffle([4 6 8 10]);
%     
%     matAllLv2(o(1),[5:6])=cellstr('Syn');
%     matAllLv2(o(1)+1,5)=matSynPos(randi(iNrSynPos));
%     matAllLv2(o(1)+1,6)=matSynNeg(randi(iNrSynNeg));
%     matAllLv2(o(2),[5:6])=cellstr('Cre');
%     matAllLv2(o(2)+1,5)=matCrePos(randi(iNrCrePos));
%     matAllLv2(o(2)+1,6)=matCreNeg(randi(iNrCreNeg));
%     matAllLv2(o(3),[5:6])=cellstr('Emo');
%     matAllLv2(o(3)+1,5)=matEmoPos(randi(iNrEmoPos));
%     matAllLv2(o(3)+1,6)=matEmoNeg(randi(iNrEmoNeg));
%     matAllLv2(o(4),[5:6])=cellstr('Eng');
%     matAllLv2(o(4)+1,5)=matEngPos(randi(iNrEngPos));
%     matAllLv2(o(4)+1,6)=matEngNeg(randi(iNrEngNeg));
%     
%     o=shuffle([4 6 8 10]);
%     
%     matAllLv2(o(1),[7:8])=cellstr('Syn');
%     matAllLv2(o(1)+1,7)=matSynPos(randi(iNrSynPos));
%     matAllLv2(o(1)+1,8)=matSynNeg(randi(iNrSynNeg));
%     matAllLv2(o(2),[7:8])=cellstr('Cre');
%     matAllLv2(o(2)+1,7)=matCrePos(randi(iNrCrePos));
%     matAllLv2(o(2)+1,8)=matCreNeg(randi(iNrCreNeg));
%     matAllLv2(o(3),[7:8])=cellstr('Emo');
%     matAllLv2(o(3)+1,7)=matEmoPos(randi(iNrEmoPos));
%     matAllLv2(o(3)+1,8)=matEmoNeg(randi(iNrEmoNeg));
%     matAllLv2(o(4),[7:8])=cellstr('Eng');
%     matAllLv2(o(4)+1,7)=matEngPos(randi(iNrEngPos));
%     matAllLv2(o(4)+1,8)=matEngNeg(randi(iNrEngNeg));


    
    
    matAllTrials=horzcat(matAllMix, matAllDub, matAllLiv, matAllLv2);
%     matAllTrials(12,:)=cellstr(iPart);
    matAllTrials(7,:)=cellstr(iPart);

    
%      matTrials=cell(13,length(matAllTrials));
     matTrials=cell(8,length(matAllTrials));
     
     %have to do 4 trials at a time for the 4cols/4 dimensions (cre, eng,
     %etc.)
%      aOrder=randperm(length(matAllTrials));
%      for t=1:length(matAllTrials);        
%         eval(strcat('matTrials([1:12],',num2str(t),')=matAllTrials([1:12],',num2str(aOrder(t)),');'));
%         matTrials(13,t)=mat2cell(t); 
%      end; 
     aOrder=randperm(16);
     for t=1:16;        
        eval(strcat('matTrials([1:7],',num2str((t-1)*4+1),')=matAllTrials([1:7],',num2str((aOrder(t)-1)*4+1),');'));
        eval(strcat('matTrials([1:7],',num2str((t-1)*4+2),')=matAllTrials([1:7],',num2str((aOrder(t)-1)*4+2),');'));
        eval(strcat('matTrials([1:7],',num2str((t-1)*4+3),')=matAllTrials([1:7],',num2str((aOrder(t)-1)*4+3),');'));
        eval(strcat('matTrials([1:7],',num2str((t-1)*4+4),')=matAllTrials([1:7],',num2str((aOrder(t)-1)*4+4),');'));
        matTrials(8,(t-1)*4+1)=mat2cell(t); 
        matTrials(8,(t-1)*4+2)=mat2cell(t);         
        matTrials(8,(t-1)*4+3)=mat2cell(t); 
        matTrials(8,(t-1)*4+4)=mat2cell(t); 
     end;      
    
    %eval(strcat('save(''/Users/anapesquita/Dropbox/Projects/MusicCognition/MusicSoft/TrialLists/matTrials_',num2str(iPart), ''',''matAllTrials'')'));
    eval(strcat('save(''/Users/jamesenns/Documents/MusicSoft/TrialLists_',num2str(iPart), ''',''matAllTrials'')'));

%end