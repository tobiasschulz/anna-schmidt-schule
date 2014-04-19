function dtml(elAnker, strAlias) {
	var strLink = "m a. ...i. .. .l. t..o...:.. " + strAlias;
	var strMlDmn = "sc ha u.. spi.e..lfr.an  k. fu. rt../ d.. e"

	strLink += (strLink.split("//").length > 1) ? ((strLink.split("//")[1] == "") ? strMlDmn : "") : ("//" + strMlDmn);
	strLink = ("" + strLink).split("//").join("... .@. ....");
	strLink = strLink.split(".").join("").split(" ").join("").split("/").join(".");

	elAnker.href = (elAnker.focus) ? strLink : "#";
}