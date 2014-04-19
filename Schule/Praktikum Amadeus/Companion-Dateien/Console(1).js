//for default properties setup when creating a new channel
var IDS_WIN_CREATECHANNELDLG_NAME = "WBC_winCreateChannelDlg";
var IDS_WIN_CREATECHANNELDLG_FEATURES = "width=650,height=280,resizable,scrollbars,status=yes" + IDS_DEFAULT_OPEN_POSITION;

//Delete Channel confirm UI dialogs
var IDS_DELETE_CHANNEL_CONFIRM = "Deleting this Channel will remove it permanently from the system. Continue?";

/// <summary>
/// Javascript function in repsonse to "Delete Channel" Console link in
/// the PresentationUnpublished mode.
/// </summary>
function CMS_onClickChannelDelete()
{
	// put up confirm() dialog first!
	return confirm(IDS_DELETE_CHANNEL_CONFIRM);
}

/// <summary>
/// Javascript function in response to "Create Channel"
/// Console link clicked in any Authoring case.
/// </summary>
function CMS_openWindowCreateChannel( strDlgURL )
{	
	// open a blank window and set the form target to that window
	WBC_openWindowOnFocus(strDlgURL, IDS_WIN_CREATECHANNELDLG_NAME, IDS_WIN_CREATECHANNELDLG_FEATURES);
}