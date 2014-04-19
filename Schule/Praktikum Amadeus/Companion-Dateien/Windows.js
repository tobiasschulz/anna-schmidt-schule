// ********************************************************************
// Copyright (C) 2001 Microsoft Corporation. All rights reserved.
//
//	IMPORTANT.  Please read the legal.txt file, located in the 
//	"<CMS Install Directory>\Server\httpexec\WBC\Internals" 
//	directory, governing the use of this internal file."
// ********************************************************************
//	This file provides all the windows related helper function such as
//	calculating the window size, pop up a new windows.

var IDS_WIDTH_OFFSET = 30;
var IDS_HEIGHT_OFFSET = 30;

// ---- [Public] Returns whether the Opener browser window is closed or not
function WBC_isOpenerWindowClosed()
{
	// The implementation doesn't seem to work on all browsers!
	return !(window.top.opener.top && !window.top.opener.top.closed);
}


// ---- [Public] Open a new window and focus it
function WBC_openWindowOnFocus(strURL, strWinTarget, strWinFeatures) 
{
	var pWindow = window.top.open(strURL, strWinTarget, strWinFeatures);
	if (pWindow)
		pWindow.focus();
}


// ---- [Public] refresh the current window
function WBC_refreshOpenerWindow()
{
    // We cannot use: window.top.history.go(0)
    // because the current browser view could have come from a postback, 
    // doing so will cause browser to pop up "Confirm Resend Information" dialog.

    // BUGBUG: This is used to handle the special case in which the RevisionHistory window is
    // the opener window.
    var RevisionHistoryForm = document.all['WBC_formPageRevisionHistory'];
    if (RevisionHistoryForm)
    {
        // In this case, the window which launches the Revision History dialog should
        // also be refreshed
		if (!WBC_isOpenerWindowClosed())
		{
			var pFuncWin = WBC_getFuncWin("WBC_refreshOpenerWindow", window.opener );
			if (pFuncWin != null)
			{
				pFuncWin.WBC_refreshOpenerWindow();
			}
		}

        RevisionHistoryForm.submit();        
    }
    else
    {
        __CMS_PostbackForm.submit();        
    }
}



// ---- [Public] Return default features if input feature is ""
function WBC_getPoppedUpWindowFeatures(strWindowFeature, pWindowBasedOn)
{
	var strFeature; 
	
	if (strWindowFeature == "")
	{
		strFeature = WBC_UseDefaultSizing(pWindowBasedOn);
	}
	else 
	{
		strFeature = strWindowFeature;
	}
	return strFeature;
}	



// ---- [Public] Return default window size 
function WBC_UseDefaultSizing(pWindow)
{
	var	lWidth = WBC_getWindowWidth(pWindow);
	var lHeight = WBC_getWindowHeight(pWindow);
	var strFeature;
	var lLeft;
	var lTop;

	if (WBC_isIE())
	{
		// IE case
		lTop = pWindow.screenTop + IDS_HEIGHT_OFFSET;
		lLeft = pWindow.screenLeft + IDS_WIDTH_OFFSET;
		
		strFeature = "left=" + lLeft + ",top=" + lTop + ",width=" + lWidth + ",height=" + lHeight + ",resizable,scrollbars,status=yes";
	}
	else
	{
		// Netscape case	
		lTop = pWindow.screenY + IDS_HEIGHT_OFFSET;
		lLeft = pWindow.screenX + IDS_WIDTH_OFFSET;
		strFeature = "screenX=" + lLeft + ",screenY=" + lTop + ",outerWidth=" + lWidth + ",outerHeight=" + lHeight + ",resizable,scrollbars,status=yes";
	}

	return strFeature;
}

// ---- [Private] get the window width
function WBC_getWindowWidth(pWin)
{
	if (WBC_isIE()) 
	{
		return pWin.document.body.clientWidth;
	} 
	else if (WBC_isNetscape()) 
	{
		return pWin.outerWidth;
	}
}

// ---- [Private] get the window height
function WBC_getWindowHeight(pWin)
{
	if (WBC_isIE()) 
	{
		return pWin.document.body.clientHeight;
	} 
	else if (WBC_isNetscape()) 
	{
		return pWin.outerHeight;
	}
}

function AppendQueryString(strBaseUrl, strQueryParam, strQueryValue)
{
    if (strBaseUrl.indexOf(strQueryParam + "=") >= 0)
    { 
        return strBaseUrl;
    }
    else
    {
        var chSeparator = '&';
                
        if (strBaseUrl.indexOf('?') < 0 )
        {
            chSeparator = '?';
        }
        
        return strBaseUrl + chSeparator + strQueryParam + '=' + strQueryValue;               
    }
}

function RemoveQueryString(strUrl, strParamName)
{
    var retVal;
    
    // have to impose it on both noraml querystring and the UrlEncoded
    // Url which is in the NRORIGINALURL value
    retVal = RemoveQueryStringWithDelimiters(strUrl, strParamName, '?', '&', '=');
    
    return retVal;
}

function RemoveQueryStringWithDelimiters(strUrl, strParamName, cQuestionMark, cAmpersand, cEquals)
{
    var twoPartUrl = strUrl.split(cQuestionMark);
    
    if (twoPartUrl.length > 1)
    {
        // a[1] got to be the querystring part of the Url
        var queryStrings = twoPartUrl[1].split(cAmpersand);
        
        // loop through queryStrings array and look for strParamName
        for (var i = 0; i < queryStrings.length; i++)
        {
            if (queryStrings[i].indexOf(strParamName + cEquals) >= 0)
            {
                // found! Set the item to be blank so it won't
                // be added back in later during Url re-construction
                queryStrings[i] = "";
            }
        }
        
        // reconstruct Url using modified queryStrings array
        var retVal = twoPartUrl[0];  // base Url part
        var prefixQuestionMark = true;
        var prefixAmpersand = false;
        for (var i = 0; i < queryStrings.length; i++)
        {
            if (queryStrings[i] != "")  // non-empty means should be added back in
            {
                // add '?' if this is the first querystring param
                if (prefixQuestionMark)
                {
                    retVal += cQuestionMark;
                    prefixQuestionMark = false; // never add '?' again
                }
                
                // see if last param told us to add '&'
                if (prefixAmpersand)
                {
                    retVal += cAmpersand;
                    prefixAmpersand = false;
                }
                
                retVal += queryStrings[i];
                prefixAmpersand = true; // next time prefix '&'
            }
        }
        
        return retVal;
    }
    else
    {
        return strUrl;
    } 
}
