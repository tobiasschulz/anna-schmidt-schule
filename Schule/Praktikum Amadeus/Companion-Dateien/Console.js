/// ---------------------------------------------------------------------------
///
///		Console.js
///
///		This file contains the Javascript handlers for CMS2002 WebAuthor Console
///
///		Copyright (c) 2002 Microsoft Corporation. All rights reserved.
///
/// ---------------------------------------------------------------------------

/// <summary>
/// Prepare postback Url for all PostbackActions
/// </summary>
function CMS_preparePostbackUrl( urlPostback )
{
	__CMS_PostbackForm.action = urlPostback;
}

/// <summary>
/// Javascript function in repsonse to "Delete" Console link in
/// the PresentationUnpublished mode.
/// </summary>
function CMS_onClickDelete()
{
	// put up confirm() dialog first!
	var confirmedDelete = confirm(L_DeleteConfirm_Message);
	if (confirmedDelete == true)
	{
		__CMS_PostbackForm.__CMS_ConfirmedDelete.value = "true";
	}

	return confirmedDelete;
}

/// <summary>
/// Javascript function in repsonse to "Exit" Console link in
/// the Save New Page or Edit Page properties 
/// </summary>
function CMS_onClickExit()
{
	// put up confirm() dialog first!
	return confirm(L_ExitConfirm_Message);
}

var g_strOriginalFormAction;
var g_strOriginalFormTarget;

/// <summary>
/// Javascript function to prepare for the Preview cases:
///	AuthoringPreivew, PresentationUnpublishedPreview
/// </summary>
function CMS_preparePreviewPostback( strUrl )
{
	// cache original state of the Form
	g_strOriginalFormAction = __CMS_PostbackForm.action;
	g_strOriginalFormTarget = __CMS_PostbackForm.target;

	__CMS_PostbackForm.action = strUrl;
	__CMS_PostbackForm.target = "WBC_winPreview";
	
	// open a blank window for the target Preview postback
	WBC_openWindowOnFocus("about:blank", "WBC_winPreview", WBC_UseDefaultSizing(window.top));
}

/// <summary>
/// Javascript function to restore state of page after the Preview cases:
///	AuthoringPreivew, PresentationUnpublishedPreview
/// </summary>
function CMS_restoreAfterPreviewPostback()
{
	// restore state of form
	__CMS_PostbackForm.action = g_strOriginalFormAction;
	__CMS_PostbackForm.target = g_strOriginalFormTarget;
	g_bWarnBeforeLeave = true;
}

/// <summary>
/// Javascript function to update all sibling frames to Unpublished
/// mode after "Switch To Live Site" has been clicked. This is done
/// in case the action is in a framed site.
/// </summary>
function UpdateSiblingFramesInPublishedMode()
{
	for (i=0; i < window.top.frames.length; i++) 
	{
		if (window.top.frames[i] != window)
		{
			// refresh it with Published mode URL
			window.top.frames[i].location.href = GetUrlModePublished( window.top.frames[i].location.href );
		}
	}
}

/// <summary>
/// Javascript function to update all sibling frames to Unpublished
/// mode after "Switch To Edit Site" has been clicked. This is done
/// in case the action is in a framed site.
/// </summary>
function UpdateSiblingFramesInUnpublishedMode()
{
	for (i=0; i < window.top.frames.length; i++) 
	{
		if (window.top.frames[i] != window)
		{
			// refresh it with Unpublished mode URL
			window.top.frames[i].location.href = GetUrlModeUnpublished( window.top.frames[i].location.href );
		}
	}
}

/// <summary>
/// Javascript function to return a Url in Published mode, based
/// on the passed in URL. 
/// </summary>
function GetUrlModePublished( strUrl )
{
	if (strUrl.indexOf("NRMODE=") > 0)
	{
		strUrl = strUrl.replace(/NRMODE=Unpublished/, "NRMODE=Published");
		strUrl = strUrl.replace(/NRMODE%3dUnpublished/, "NRMODE%3dPublished");
		strUrl = strUrl.replace(/NRMODE=Update/, "NRMODE=Published");
		strUrl = strUrl.replace(/NRMODE%3dUpdate/, "NRMODE%3dPublished");
	}
	else
	{
		strUrl = AppendQueryString( strUrl, "NRMODE", "Published" );
	}

    // need to get rid of WBCMODE and wbc_purpose in query string
	strUrl = RemoveQueryString( strUrl, "WBCMODE");
	strUrl = RemoveQueryString( strUrl, "wbc_purpose");
    
	return strUrl;
}

/// <summary>
/// Javascript function to return a Url in Unpublished mode, based
/// on the passed in URL. 
/// </summary>
function GetUrlModeUnpublished( strUrl )
{
	if (strUrl.indexOf("NRMODE=") > 0)
	{
		strUrl = strUrl.replace(/NRMODE=Published/, "NRMODE=Unpublished");
		strUrl = strUrl.replace(/NRMODE%3dPublished/, "NRMODE%3dUnpublished");
		strUrl = strUrl.replace(/NRMODE=Update/, "NRMODE=Unpublished");
		strUrl = strUrl.replace(/NRMODE%3dUpdate/, "NRMODE%3dUnpublished");
	}
	else
	{
		strUrl = AppendQueryString( strUrl, "NRMODE", "Unpublished" );
	}

    // need to append WBCMODE and wbc_purpose querystring parameters
    // for PresentationUnpublished mode.
	strUrl = AppendQueryString( strUrl, "WBCMODE", "PresentationUnpublished" );
	strUrl = AppendQueryString( strUrl, "wbc_purpose", "Basic" );

	return strUrl;
}

/// --------------------------------------
///
///		Actions that open new window
///
/// --------------------------------------


/// <summary>
///		Javascript function in repsonse to "Production Manager" Console link clicked
/// </summary>
function CMS_openWindowProductionManager( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winProductionManager", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Approval Assistant" Console link clicked
/// </summary>
function CMS_openWindowApprovalAssistant( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winApprovalAssistant", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Resource Manager" Console link clicked
/// </summary>
function CMS_openWindowResourceManager( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winResourceManager", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Resource Manager" Console link clicked
/// </summary>
function CMS_openWindowPresentationPreview( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winPreview", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Resource Manager" Console link clicked
/// </summary>
function CMS_openWindowGoToConnected( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winGoToConnected", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Create New Page" Console link clicked
/// </summary>
function CMS_openWindowCreateNewPage( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winPageCreationWizard", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Create Connected Page" Console link clicked
/// </summary>
function CMS_openWindowCreateConnectedPage( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winPageCreationWizard", WBC_UseDefaultSizing(window.top));
}

/// <summary>
///		Javascript function in repsonse to "Copy" Console link clicked
/// </summary>
function CMS_openWindowCopy( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winCopyDlg", IDS_WIN_PAGECOPYDLG_FEATURES);
}

/// <summary>
///		Javascript function in repsonse to "Move" Console link clicked
/// </summary>
function CMS_openWindowMove( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winMoveDlg", IDS_WIN_PAGEMOVEDLG_FEATURES);
}

/// <summary>
///		Javascript function in repsonse to "Page Properties" Console link clicked
/// </summary>
function CMS_openWindowPageProperties( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winPagePropsDlg", IDS_WIN_PAGEPROPS_FEATURES);
}

/// <summary>
///		Javascript function in repsonse to "Revision History" Console link clicked
/// </summary>
function CMS_openWindowRevisionHistory( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winRevisionHistoryDlg", IDS_WIN_PAGEREVISION_FEATURES);
}

/// <summary>
///		Javascript function in repsonse to "View Revision By Date" Console link clicked
/// </summary>
function CMS_openWindowViewRevisionByDate( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winViewRevisionByDateDlg", IDS_WIN_PAGEREVISION_BY_DATE_FEATURES);
}

/// <summary>
///		Javascript function in repsonse to "Channel Properties" Console link clicked
/// </summary>
function CMS_openWindowChannelProperties( strDlgURL )
{
	WBC_openWindowOnFocus(strDlgURL, "WBC_winChannelPropsDlg", IDS_WIN_PAGEPROPS_FEATURES);
}

/// <summary>
/// Javascript function to open the "Save New Page" dialog
/// for filling out Name and Display Name.
/// </summary>
function CMS_openWindowAuthoringSaveNew( strNavigateUrl )
{
	WBC_openWindowOnFocus( strNavigateUrl, "WBC_winSaveNewPageDlg", IDS_WIN_NEWPAGESAVEDLG_FEATURES );
}

/// <summary>
/// Javascript function in repsonse to "Preview Other Connected Pages"
/// Console link clicked in any Authoring case.
/// </summary>
function CMS_openWindowAuthoringPreviewConnected( strDlgURL )
{	
	// open a blank window and set the form target to that window
	WBC_openWindowOnFocus(strDlgURL, "WBC_winPreviewConnected", WBC_UseDefaultSizing(window.top));
}