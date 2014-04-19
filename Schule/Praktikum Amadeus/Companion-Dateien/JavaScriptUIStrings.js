// ****************************************************************************
//
//	Client-side JavaScript UI Strings 
//
// ****************************************************************************
 

// -- Generic UI strings
var L_FunctionNotFound_ErrorMessage = "Function not found.";
var L_InvalidName_ErrorMessage = "Name cannot be all blanks and cannot contain characters #, &, %, +, /,' and |.";



// ----------------------------------------------------------------------------
//
//	Delete (purge) confirm UI dialogs
//
// ----------------------------------------------------------------------------
var L_DeleteConfirm_Message = "Deleting this Page will remove it permanently from the system. Continue?";
var L_DeleteResourcesConfirm_Message = "Deleting the Resource will remove it permanently from the system. Continue?";


// ----------------------------------------------------------------------------
//
//	New Page creation UI dialogs
//
// ----------------------------------------------------------------------------

var L_ExitConfirm_Message = "Exiting now will cancel any unsaved changes.  Continue?";

// ---------------------------------------------------------------------------- 
//
//	Page/Channel Properties dialog
//
// ---------------------------------------------------------------------------- 
var L_InvalidStartDate_ErrorMessage = "Invalid start date.";
var L_InvalidExpiryDate_ErrorMessage = "Invalid expiry date.";
var L_ExpiryDateLessThenStartDate_ErrorMessage = "Expiry date must occur after start date.";

// PropsCommonClient.js
var L_MissingElement_ErrorMessage = "Error: the element is undefined.";
var L_WaitUntilFinishLoading_Message = "Please wait until the page is finished loading.";
var L_YearEq_Message = "Year=";

//EopMidifyClient.js
// Error message when the user input is exceeded 2001 character for EOP
var L_InvalidNumChars_ErrorMessage = "Enter text cannot be exceeded 2,000 characters.";
var L_InvalidChars_ErrorMessage = "Enter text cannot contain ']]>'.";

var L_EOPLabelEnterText_Text = "Enter Text:";
var L_EOPLabelSelValue_Text = "Select Value:";
// ---------------------------------------------------------------------------- 
//
//	Resource Browser dialogs
//
// ---------------------------------------------------------------------------- 
var L_InvalidImageType_ErrorMessage = "The selected file is not recognized as a valid image file by its file extension. Do you want to proceed?";
var L_InvalidVideoType_ErrorMessage = "The selected file is not recognized as a valid video file by its file extension. Do you want to proceed?";
var L_NoAttachmentSelected_ErrorMessage = "No attachment is selected.";
var L_NoFileSelected_ErrorMessage = "No file is selected.";
var L_NoImageSelected_ErrorMessage = "No image is selected.";
var L_NoResourceSelected_ErrorMessage = "No resource is selected.";
var L_InvalidDispText_ErrorMessage = "Invalid display text.";
var L_UploadInprogressAlready_ErrorMessage = "Upload in progress already.";

// ---------------------------------------------------------------------------- 
//
//	UI Strings used in WBC Authoring Mode
//
// ---------------------------------------------------------------------------- 

var L_WarnBeforeLeave_Message = "Refreshing or leaving this page will lose all unsaved changes.";

var L_WindowOpenerNotFound_Message = "Launching window cannot be found.";

// ---------------------------------------------------------------------------- 
//
//	For the Insert Table dialog
//
// ---------------------------------------------------------------------------- 
var L_InvalidRows_ErrorMessage = "Number of rows must be a number.";
var L_InvalidColumns_ErrorMessage = "Number of columns must be a number.";
var L_InvalidColumnsRange_ErrorMessage = "Number of columns must be a number greater than zero.";
var L_InvalidRowsRange_ErrorMessage = "Number of rows must be a number greater than zero.";
var L_LargeNumOfCells_Message = "You have requested to add an unusually large number of rows or columns to the table.This will reduce the performance of your site. Are you sure?";


// ---------------------------------------------------------------------------- 
//
//	For the Insert Hyperlink dialog
//
// ---------------------------------------------------------------------------- 
var L_HlinkCustomWinName_Message = "Please enter your custom window name";
var L_HlinkWarnEmpty_Message = "You did not specify a Hyperlink Address or a Name.\r\nAs a result the selection in the placeholder will receive no anchor tag.\r\n\r\n Do you want to proceed?";
var L_HlinkWarnRelLink_Message = "You seemed to have specified a relative URL.\r\n Relative URL is currently not supported by Content Management Server.\r\n\r\n Do you want to continue?";

var L_LabelWinTargetCustomName_Text = "Custom";
// ---------------------------------------------------------------------------- 
//
//	For the InternalLinks dialog
//
// ---------------------------------------------------------------------------- 
var L_NoSelectedLink_ErrorMessage = "No Internal Link has been selected.";

// ---------------------------------------------------------------------------- 
//
//	Revision History dialog
//
// ---------------------------------------------------------------------------- 

var L_InvalidState_ErrorMessage = "Invalid state of filter";
var L_AlertLessSelected_ErrorMessage = "Two revisions must be chosen for comparison.\nChoose two revisions by selecting two check\nboxes in the lists.";

var L_AlertExceedSelected_ErrorMessage = "Only two revisions can be compared at one time.\n\nYou have already selected three revisions. The last\nselected revision will be removed from the list.";

// ---------------------------------------------------------------------------- 
//
//	Page Copy/Move dialog
//
// ---------------------------------------------------------------------------- 

// ---------------------------------------------------------------------------- 
//
//  ActiveX Toolbar UI tooltip strings
//
// ---------------------------------------------------------------------------- 
var L_ActiveXInsertImage_ToolTip = "Insert Image";
var L_ActiveXInsertVideo_ToolTip = "Insert Video";
var L_ActiveXInsertAttachment_ToolTip = "Insert Attachment";
var L_ActiveXInsertTable_ToolTip = "Insert Table";
var L_ActiveXEditHyperlink_ToolTip = "Edit Hyperlink";
var L_ActiveXEditSource_ToolTip = "Edit Source";
var L_ActiveXCut_ToolTip = "Cut";
var L_ActiveXCopy_ToolTip = "Copy";
var L_ActiveXPaste_ToolTip = "Paste";
var L_ActiveXUndo_ToolTip = "Undo";
var L_ActiveXRedo_ToolTip = "Redo";
var L_ActiveXSpellCheck_ToolTip = "Spell Check";
var L_ActiveXBold_ToolTip = "Bold";
var L_ActiveXItalic_ToolTip = "Italic";
var L_ActiveXUnderline_ToolTip = "Underline";
var L_ActiveXForeColor_ToolTip = "Foreground Color";
var L_ActiveXBackGroundColor_ToolTip = "Background Color";
var L_ActiveXAlignLeft_ToolTip = "Align Left";
var L_ActiveXAlignCenter_ToolTip = "Align Center";
var L_ActiveXAlignRight_ToolTip = "Align Right";
var L_ActiveXNumberedList_ToolTip = "Numbered List";
var L_ActiveXBulletedList_ToolTip = "Bulleted List";
var L_ActiveXDecreseIndent_ToolTip = "Decrease Indent";
var L_ActiveXIncreseIndent_ToolTip = "Increase Indent";

var L_FailedToInsertHyperLink_ErrorMessage = "Failed to insert hyperlink!";
var L_NoSelectedTextForHyperlink_ErrorMessage = "There is no selected text or object for hyperlinking.";

var L_StatusCheckingSpelling_Message = "Checking spelling...";
var L_StatusCheckCancelled_Message = "Spell check cancelled";
var L_StatusCheckDone_Message = "Spell check complete";
// ---------------------------------------------------------------------------- 
//
//	Dates.js
//
// ---------------------------------------------------------------------------- 
// Month names
var L_JSMonthJan_Text = "Jan";
var L_JSMonthFeb_Text = "Feb";
var L_JSMonthMar_Text = "Mar";
var L_JSMonthApr_Text = "Apr";
var L_JSMonthMay_Text = "May";
var L_JSMonthJun_Text = "Jun";
var L_JSMonthJul_Text = "Jul";
var L_JSMonthAug_Text = "Aug";
var L_JSMonthSep_Text = "Sep";
var L_JSMonthOct_Text = "Oct";
var L_JSMonthNov_Text = "Nov";
var L_JSMonthDec_Text = "Dec";