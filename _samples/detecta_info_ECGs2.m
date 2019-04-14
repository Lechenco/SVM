clear all
close all
clc

% %---------295 ECGs (ID)-----------%
numeros = 1:295; %2655 janels c fs = 500
% %---------295 ECGs (ID)-----------%

%---------48 ECGs (Arritmia)-----------%
numeros = [numeros 301:348];
%---------48 ECGs (Arritmia)-----------%

%---------22 ECGs (Arritmia ventr. maligna)-----------%
numeros = [numeros 501:522];
%---------22 ECGs (Arritmia ventr. maligna)-----------%

%---------26 ECGs (Taquiarr. Ventr.)-----------%
numeros = [numeros 701:726];
%---------26 ECGs (Taquiarr. Ventr.)-----------%

%---------78 ECGs (Arr. Supraventr)-----------%
numeros = [numeros 901:978]; %fs 128
%---------78 ECGs (Arr. Supraventr)-----------%

%---------23 ECGs (Fibrila Atrial)-----------%
numeros = [numeros 1101:1123];
%---------23 ECGs (Fibrila Atrial)-----------%

%---------18 ECGs (Ritmo Sinusal Normal)-----------%
numeros = [numeros 1301:1317];
%---------18 ECGs (Ritmo Sinusal Normal)-----------%

%---------23 ECGs (Morte Cardiaca Subita)-----------%
numeros = [numeros 1501:1523];
%---------23 ECGs (Morte Cardiaca Subita)-----------%

for ii=1:length(numeros)
        
    
    [ann,anntype,subtype,chan,num,comments]=rdann(num2str(numeros(ii)),'atr');
    
    nome = strcat(num2str(numeros(ii)));
    [sig,Fs,tm]=rdsamp(nome);
    
    %     plot(tm,sig);
    %     pause(0.1);
    
    vetType = unique(anntype)';
    disp('-----------------------')
    disp(['Tipos de ECGs: ',num2str(vetType)])
    disp('-----------------------')
    for i=1:length(vetType)
        loc = find(anntype==(vetType(i)));
        switch vetType(i)
            case'N'
                locN = loc;
                disp(['Batimento normal: ',num2str(length(locN))])
            case'L'
                locL = loc;
                disp(['Bloqueio de ramo esquerdo (BRE): ',num2str(length(locL))])
            case'R'
                locR = loc;
                disp(['Bloqueio de ramo direito (BRD): ',num2str(length(locR))])
            case'B'
                locB = loc;
                disp(['Bloqueio de ramo (não especificado): ',num2str(length(locB))])
            case'A'
                locA = loc;
                disp(['Contração atrial prematura (PAC) - Batimento atrial prematuro (APB): ',num2str(length(locA))])
            case'a'
                loca = loc;
                disp(['Contração atrial prematura Aberrante: ',num2str(length(loca))])
            case'J'
                locJ = loc;
                disp(['Contração prematura nodal (juncional) (CPJ): ',num2str(length(locJ))])
            case'S'
                locS = loc;
                disp(['Batimento prematuro ou ectópico supraventricular (atrial ou nodal): ',num2str(length(locS))])
            case'V'
                locV = loc;
                disp(['Contração ventricular prematura: ',num2str(length(locV))])
            case'r'
                locr = loc;
                disp(['Contração ventricular prematura (PVC) R-on-T: ',num2str(length(locr))])
            case'F'
                locF = loc;
                disp(['Fusão de batimentos ventriculares e normais: ',num2str(length(locF))])
            case'e'
                loce = loc;
                disp(['Batimendo de escape atrial: ',num2str(length(loce))])
            case'j'
                locj = loc;
                disp(['Batimento de escape nodal (juncional): ',num2str(length(locj))])
            case'n'
                locn = loc;
                disp(['Batimento de escape supraventricular (atrial ou nodal): ',num2str(length(locn))])
            case'E'
                locE = loc;
                disp(['Batimento de escape ventricular: ',num2str(length(locE))])
            case'/'
                locBar = loc;
                disp(['Batida ritmada: ',num2str(length(locBar))])
            case'f'
                locf = loc;
                disp(['Fusão de batida ritmada e normal: ',num2str(length(locf))])
            case'Q'
                locQ = loc;
                disp(['Batimento inclassificável: ',num2str(length(locQ))])
            case'?'
                locInt = loc;
                disp(['Batida não classificada durante a aprendizagem: ',num2str(length(locInt))])
            case'['
                locChaDir = loc;
                disp(['Início do flutter ventricular / fibrilação: ',num2str(length(locChaDir))])
            case'!'
                locEscla = loc;
                disp(['Onda de flutter ventricular: ',num2str(length(locEscla))])
            case']'
                locChaEsq = loc;
                disp(['Fim do flutter ventricular / fibrilação: ',num2str(length(locChaEsq))])
            case'x'
                locx = loc;
                disp(['Onda P não conduzida (APC bloqueada): ',num2str(length(locx))])
            case'('
                locParDir = loc;
                disp(['Início da forma de onda: ',num2str(length(locParDir))])
            case')'
                locParEsq = loc;
                disp(['Final da forma de onda: ',num2str(length(locParEsq))])
            case'p'
                locp = loc;
                disp(['Pico da onda P: ',num2str(length(locp))])
            case't'
                loct = loc;
                disp(['Pico da onda T: ',num2str(length(loct))])
            case'u'
                locu = loc;
                disp(['Pico da onda U: ',num2str(length(locu))])
            case 'aspSimpl'
                locAspSimpl = loc;
                disp(['Junção PQ: ',num2str(length(locAspSimp))])
            case'^'
                locCh = loc;
                disp(['Artefato de marcapasso (não capturado): ',num2str(length(locCh))])
            case'|'
                locBarVert = loc;
                disp(['Artefato semelhante a QRS isolado: ',num2str(length(locBarVert))])
            case'~'
                locTiu = loc;
                disp(['Mudança na qualidade do sinal: ',num2str(length(locTiu))])
            case'+'
                locMais = loc;
                disp(['Mudança de ritmo: ',num2str(length(locMais))])
            case's'
                locs = loc;
                disp(['Mudança do segmento ST: ',num2str(length(locs))])
            case'T'
                locT = loc;
                disp(['Mudança de onda T: ',num2str(length(locT))])
            case'*'
                locAster = loc;
                disp(['Sístole: ',num2str(length(locAster))])
            case'D'
                qntD = qnt;
                disp(['Diástole: ',num2str(length(qntD))])
            case'='
                locEq = loc;
                disp(['Anotação de medição: ',num2str(length(locEq))])
            case'"'
                locAspDupl = loc;
                disp(['Anotação de comentários: ',num2str(length(locAspDupl))])
            case'@'
                locArrob = loc;
                disp(['Link to external data: ',num2str(length(locArrob))])
        end
    end
    disp('-----------------------')
    val = string(cellfun('isempty',comments));
    [l,~] = find(val~='true');
    commeTypeAux = comments(l)';
    commeType = string(commeTypeAux);
    UcommeType = unique(commeType);
    disp(['Tipos: ',(UcommeType)])
    disp('-----------------------')
    
    for co=1:length(commeType)
        val(l(co))=commeType(co);
    end
    
   for ij=1:length(UcommeType)
        loc_non = find(val==(UcommeType(ij)));
        switch UcommeType(ij)
            case'(AB'
                loc_AB = loc_non;
                disp(['Atrial bigeminy: ',num2str(length(loc_AB))])
            case'(AFIB'
                loc_AFIB = loc_non;
                disp(['Atrial fibrillation: ',num2str(length(loc_AFIB))])
            case'(AFL'
                loc_AFL = loc_non;
                disp(['Atrial flutter: ',num2str(length(loc_AFL))])
            case'(B'
                loc_B = loc_non;
                disp(['Ventricular bigeminy: ',num2str(length(loc_B))])
            case'(BII'
                loc_BII = loc_non;
                disp(['2° heart block: ',num2str(length(loc_BII))])
            case'(IVR'
                loc_IVR = loc_non;
                disp(['Idioventricular rhythm: ',num2str(length(loc_IVR))])
            case'(N'
                loc_N = loc_non;
                disp(['Normal sinus rhythm: ',num2str(length(loc_N))])
            case'(NOD'
                loc_NOD = loc_non;
                disp(['Nodal (A-V junctional) rhythm: ',num2str(length(loc_NOD))])
            case'(P'
                loc_P = loc_non;
                disp(['Paced rhythm: ',num2str(length(loc_P))])
            case'(PREX'
                loc_PREX = loc_non;
                disp(['Pre-excitation (WPW): ',num2str(length(loc_PREX))])
            case'(SBR'
                loc_SBR = loc_non;
                disp(['Sinus bradycardia: ',num2str(length(loc_SBR))])
            case'(SVTA'
                loc_SVTA = loc_non;
                disp(['Supraventricular tachyarrhythmia: ',num2str(length(loc_SVTA))])
            case'(T'
                loc_T = loc_non;
                disp(['Ventricular trigeminy: ',num2str(length(loc_T))])
            case'(VFL'
                loc_VFL = loc_non;
                disp(['Ventricular flutter: ',num2str(length(loc_VFL))])
            case'(VT'
                loc_VT = loc_non;
                disp(['Ventricular tachycardia: ',num2str(length(loc_VT))])
        end
    end
end


