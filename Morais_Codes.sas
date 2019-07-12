


%MACRO IDENTIFICA_SEMANA(DATA);
DATA _NULL_;
	DT_INI = %SYSFUNC(INPUTN(&DATA., YYMMDD10.));				/*Transforma em Data do SAS              */
	DT_ULTM_DIA = INTNX('MONTH', DT_INI, 1) - 1;				/*Obtem ultimo dia do Mes                */
	SOMA_SEMANA = 11 - MOD(WEEKDAY(DT_INI)+3,7);				/*Será utilizado para o tamanho da semana*/
	TESTE = DT_ULTM_DIA - DT_INI;

	IF SOMA_SEMANA > DT_ULTM_DIA - DT_INI THEN DT_FIM = DT_ULTM_DIA;
	ELSE DT_FIM = DT_INI + SOMA_SEMANA;

	CALL SYMPUT('DT_INI', DT_INI);
	CALL SYMPUT('DT_FIM', DT_FIM);
RUN; 

%put NOTE: >>>> DATA DE INICIO: %sysfunc(INPUTN(&DT_INI.,worddate32.),DATE9.) - %sysfunc(INPUTN(&DT_INI.,worddate32.),DOWNAME.);
%put NOTE: >>>> DATA FINAL    : %sysfunc(INPUTN(&DT_FIM.,worddate32.),DATE9.) - %sysfunc(INPUTN(&DT_FIM.,worddate32.),DOWNAME.);
%MEND IDENTIFICA_SEMANA;


%IDENTIFICA_SEMANA(20190728);

%MACRO L;
%DO DT = 20190701 %TO 20190731;
 	%IDENTIFICA_SEMANA(&DT.);
%END;
%MEND;
%L;
