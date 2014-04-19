var objDialogFenster;
function DialogOeffnen(strURL, intBreite, intHoehe) {
	if (!intBreite) intBreite = 400;
	if (!intHoehe) intHoehe = 240;
	objDialogFenster = window.open(strURL, "Dialog", "left=250,top=30,screenX=250,screenY=30,width=" + intBreite + ",height=" + intHoehe + ",resizable=1,scrollbars=1,toolbar=0,status=0,menubar=0,titlebar=0");
	if (parseInt(navigator.appVersion) > 2) 
		objDialogFenster.focus();
}
function DialogSchliessen(boolNeuLaden) {
	objDialogFenster.close();
	if (boolNeuLaden) {
		SpeichernNachfrage("Das Formular wird nun neu angefordert.");
		document.Formular.submit();
	}
}
function OeffneGaleriefenster(strURL) {
	objDialogFenster = window.open(strURL, "Galeriefenster", "left=100,top=80,screenX=100,screenY=80,width=520,height=540,resizable=1,scrollbars=1,toolbar=0,status=0,menubar=0,titlebar=0");
	if (parseInt(navigator.appVersion) > 2) 
		objDialogFenster.focus();
}

function ShowPopup()
{
    var tempstr = location.pathname;
    var loc1 = tempstr.indexOf("/", 1);
    var relpath = tempstr.substring(0, loc1+1);

    var popupURL1 = "/ticketing/popup_ostern2007.html";
                var popup1 = window.open(popupURL1,"Popup",'titlebar=0,toolbar=1,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=1,width=460,height=315,left=0,top=0');
    popup1.focus();
}

// ff. spezialfenster

function open_sms(obj_a) {
	var name_target = 'sms';
	if (obj_a) obj_a.target = name_target;
	f_sms=window.open('', name_target, 'scrollbars=0, toolbar=0, titlebar=1, status=0, resizable=1, width=600, height=450, left=180, top=130'); 
	f_sms.focus();
}

function open_lageplan(obj_a) {
	var name_target = 'lageplan';
	if (obj_a) obj_a.target = name_target;
	f_lp=window.open('',name_target,'scrollbars=0,toolbar=0,menubar=0,location=0,status=0,resizable=0,width=920,height=460,print=yes,left=0,top=0');
	f_lp.focus();
}
	
function open_scrolltext(obj_a) {
	var name_target = 'scrolltext';
	if (obj_a) obj_a.target = name_target;
	f_sct=window.open('', name_target, 'scrollbars=1, toolbar=0, titlebar=1, status=0, resizable=1, width=600, height=600, left=180, top=130'); 
	f_sct.focus();
}

	
function open_ecards(obj_a) {
	var name_target = 'ecards';
	if (obj_a) obj_a.target = name_target;
	f_ec=window.open('', name_target, 'scrollbars=0, toolbar=0, titlebar=1, status=0, resizable=1, width=786, height=572, left=180, top=130'); 
	f_ec.focus();
}

function open_spielplan_pp(obj_a) {
	var name_target = 'spielplan_pp';
	if (obj_a) obj_a.target = name_target;
	f_sppp=window.open('', name_target, 'scrollbars=1,toolbar=0,menubar=0,location=0,status=0,resizable=1,width=320,height=500,print=yes,left=180,top=130'); 
	f_sppp.focus();
}

function open_print(obj_a) {
	var name_target = 'print';
	if (obj_a) obj_a.target = name_target;
	f_pr=window.open('', name_target, 'menubar=1,scrollbars=1,toolbar=1,titlebar=1,status=0,resizable=1,width=640,height=580,left=50,top=20'); 
	f_pr.focus();
}

function open_recommend(obj_a) {
	var name_target = 'recommend';
	if (obj_a) obj_a.target = name_target;
	f_rec=window.open('', name_target, 'scrollbars=0,toolbar=0,menubar=0,location=0,status=0,resizable=1,width=440,height=420,print=yes,left=180,top=130'); 
	f_rec.focus();
}

function open_impressum(obj_a) {
	var name_target = 'impressum';
	if (obj_a) obj_a.target = name_target;
	f_imp=window.open('', name_target, 'scrollbars=0,menubar=0,titlebar=0,status=0,resizable=1,width=557,height=580,left=180,top=180'); 
	f_imp.focus();
}

function open_board(obj_a) {
	var name_target = 'board';
	if (obj_a) obj_a.target = name_target;
	f_brd=window.open('', name_target, 'scrollbars=1,menubar=0,titlebar=0,status=0,resizable=1,width=612,height=440,left=50,top=200'); 
	f_brd.focus();
}

function open_newsletter(obj_a) {
	var name_target = 'newsletter';
	if (obj_a) obj_a.target = name_target;
	f_nl=window.open('', name_target, 'scrollbars=0,toolbar=0,titlebar=1,status=0,resizable=1,width=410,height=280,left=180,top=130'); 
	f_nl.focus();
}

function open_abotermine(obj_a) {
	var name_target = 'abotermine';
	if (obj_a) obj_a.target = name_target;
	f_abo=window.open('', name_target, 'titlebar=0,toolbar=1,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=740,height=420,left=0,top=0'); 
	f_abo.focus();
}

function open_copyright(obj_a) {
	var name_target = 'copyright';
	if (obj_a) obj_a.target = name_target;
	f_cr=window.open('', name_target, 'scrollbars=1,menubar=0,titlebar=0,status=0,resizable=1,width=300,height=220,left=180,top=180'); 
	f_cr.focus();
}

