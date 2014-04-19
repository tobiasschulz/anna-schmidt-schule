/* 
Infragistics Editable Tree Script 
Version 1.0.19
Copyright (c) 2001-2002 Infragistics, Inc. All Rights Reserved.
*/

   var igt_IE = (document.all) ? true : false;
   var igtree_treeState=[];

   // Initializes the tree object on the client
   function igtree_initTree(treeId) {
       var treeElement = igtree_getElementById("T_"+treeId);
	   // Create the tree object and assign it to the tree variable on the html page
	   var tree = new igtree_tree(treeElement);
	   treeElement.igtree = tree;
	   igtree_treeState[treeId]=tree;
	   return tree;
   }

   // Constructor for the tree object
   function igtree_tree(_treeElement) {
       this.treeId = _treeElement;
   	   this.treeElement = _treeElement;
   }

   // Returns the current Tree for the Node 
   function igtree_treeFromNode(nodeId) {
      var treeName = nodeId;
      var strArray = treeName.split("_");
      treeName = strArray[0];
      if(!igtree_treeState[treeName])
	 return null;
      var tree = eval("igtree_" + treeName);
      if(tree == null) {
          return null;
      }
      return tree;
   }
   
   // Returns the current Node for the Tree 
   // if one is selected.
   function igtree_currentNode(nodeId) {
      var tree = igtree_treeFromNode(nodeId);
      if(tree)
	      return tree.currentNode;
      return null;
   }
   
   // Returns the current Node for the Tree 
   // if one is selected.
   function igtree_currentNodeFromTree(treeId) {
      var tree = eval("igtree_" + treeId);
      if(tree == null) {
          return null;
      }
      return tree.currentNode;
   }

   // Sets the current Node for the Tree 
   // to the passed in Node.
   function igtree_setCurrentNode(nodeId, src) {
      var treeName = nodeId;
      var strArray = treeName.split("_");
      treeName = strArray[0];
      if(!igtree_treeState[treeName])
	 return null;
      var tree = eval("igtree_" + treeName);
      if(tree == null) {
          return;
      }
      tree.currentNode = src;
      if(src != null)
		src.focus();
   }

   function igtree_toggle(src, button) {
      var s;
      var image;
      var treeName = src;
      var strArray = treeName.split("_");
      treeName = strArray[1];

      s = igtree_getElementById(src);

      if(s.style.display == "none") {
		 image = eval(treeName + "CollapseImage");
         if(image == null)
            image = "minus.gif";    
         button.innerHTML = "<img style='margin-right:5px' src='" +  image + "'>";
         s.style.display = "";
		 igtree_updateNodeToggle(src, true);
      }
      else {
		 image = eval(treeName + "ExpandImage");
         if(image == null)
            image = "plus.gif";    
         button.innerHTML = "<img style='margin-right:5px' src='" + image + "'>";
         s.style.display = "none";
		 igtree_updateNodeToggle(src, false);
      }
   }

   function igtree_classicToggle(src, button) {
      var s;
      s = igtree_getElementById(src);

	  if(igt_IE ) {
		if(s.style.display != "none") {
			button.children[0].src = button.children[0].src.replace("fminus.gif", "fplus.gif");
			button.children[0].src = button.children[0].src.replace("mminus.gif", "mplus.gif");
			button.children[0].src = button.children[0].src.replace("lminus.gif", "lplus.gif");
			button.nextSibling.src = button.nextSibling.src.replace("folderopen.gif", "folder.gif");
			s.style.display = "none";
			igtree_updateNodeToggle(src, false);
		}
		else {
			button.children[0].src = button.children[0].src.replace("fplus.gif", "fminus.gif");
			button.children[0].src = button.children[0].src.replace("mplus.gif", "mminus.gif");
			button.children[0].src = button.children[0].src.replace("lplus.gif", "lminus.gif");
			button.nextSibling.src = button.nextSibling.src.replace("folder.gif", "folderopen.gif")
			s.style.display = "";
			igtree_updateNodeToggle(src, true);
		}
      }
      else {
		if(s.style.display != "none") {
			s.style.display = "none";
			button.childNodes[0].src = button.childNodes[0].src.replace("fminus.gif", "fplus.gif");
			button.childNodes[0].src = button.childNodes[0].src.replace("mminus.gif", "mplus.gif");
			button.childNodes[0].src = button.childNodes[0].src.replace("lminus.gif", "lplus.gif");
			button.nextSibling.src = button.nextSibling.src.replace("folderopen.gif", "folder.gif");
			igtree_updateNodeToggle(src, false);
		}
		else {
			s.style.display = "";
			button.childNodes[0].src = button.childNodes[0].src.replace("fplus.gif", "fminus.gif");
			button.childNodes[0].src = button.childNodes[0].src.replace("mplus.gif", "mminus.gif");
			button.childNodes[0].src = button.childNodes[0].src.replace("lplus.gif", "lminus.gif");
			button.nextSibling.src = button.nextSibling.src.replace("folder.gif", "folderopen.gif")
			igtree_updateNodeToggle(src, true);
		}
      }
   }

   function igtree_mouseover(src, hoverClass) {
	  var parentId;
	  if(igt_IE ) 
		 parentId = src.parentElement.id;
	  else
	     parentId = src.parentNode.id;
	     	
      if(src == igtree_currentNode(parentId))
         return;
      var className;
      if(hoverClass == null) {
         var treeName = parentId;
         var strArray = treeName.split("_");
         treeName = strArray[0];
         className = eval(treeName + "HoverClass");
      }
      else
         className = hoverClass;
      if(src.className != className) {
         src.setAttribute("igtHovClass", src.className);
         src.className = className;
      }
   }

   function igtree_mouseout(src) {
      if(igt_IE ) {
		if(src != igtree_currentNode(src.parentElement.id)) {
			if(src.style != null) {
				src.className = src.getAttribute("igtHovClass");
			}
		}
      }
      else {
		if(src != igtree_currentNode(src.parentNode.id)) {
			if(src.style != null) {
				src.className = src.getAttribute("igtHovClass");
			}
		}
      }
   }

   function igtree_getElementById(id) {
         if(igt_IE)
            return document.all[id];
         else 
            return document.getElementById(id);
   }
	

   function igtree_nodeclick(src, hiliteClass, previous) {
      if(src == igt_editControl)
         return;
      if(igt_editControl != null)
         igtree_endedit(true);
      var className;
      var oldNodeId;
      var nodeId;

      if(igt_IE)
         nodeId = src.parentElement.id;
      else
		 nodeId = src.parentNode.id;
      var strArray = nodeId.split("_");
      treeName = strArray[0];
      if(!igtree_treeState[treeName])
	 return null;

      if(hiliteClass == null) {
         className = eval(treeName + "HiliteClass");
      }
      else
         className = hiliteClass;


      var igt_currentNode = igtree_currentNode(nodeId);
      if(igt_currentNode != null && igt_currentNode != src) {
         igt_currentNode.className = igt_currentNode.getAttribute("igtInitClass");
         if(igt_IE ) {
	        if(igt_currentNode.parentElement != null)
	           oldNodeId = igt_currentNode.parentElement.id;
	     }
	     else {
	        if(igt_currentNode.parentNode != null)
	           oldNodeId = igt_currentNode.parentNode.id;
	     }
	         
      }
      else if(igt_currentNode != src) {
		igt_currentNode = igtree_getElementById(treeName + "_currentNode");
		if(igt_currentNode != null)
			igt_currentNode.className = igt_currentNode.getAttribute("igtInitClass");	 
      }

      if(src.className != className) {
		var initClass = src.getAttribute("igtHovClass");
        if(initClass != null)
			src.setAttribute("igtInitClass", initClass);
		else
            src.setAttribute("igtInitClass", src.className);
	    src.className = className;
        igtree_setCurrentNode(nodeId, src);
      }

      igtree_updatePostField(treeName, nodeId, oldNodeId);
   }

   // The following two functions work together to ensure that
   // nodeClicks get posted for single clicks but not for doubleclicks
   var igtree_treeName;
   var igtree_nodeId;
   var igtree_postCanceled = false;

   var igtree_clickCounter = 0;
   function igtree_postNodeClick(treeName, nodeId, evnt) {
      igtree_treeName = treeName;
      igtree_nodeId = nodeId;
      var src;
      if(evnt == null)
         evnt = window.event;
      src = igtree_getElementById(nodeId);
      igtree_nodeclick(evnt.srcElement);
      igtree_clickCounter++;
      if(igtree_clickCounter == 1)
         setTimeout('igtree_OnTimerPostNodeClick()', 300);
   }

   
   function igtree_OnTimerPostNodeClick() {
      igtree_updatePostField(igtree_treeName, igtree_nodeId, null); 

      if(igtree_postCanceled == false) { 

         __doPostBack(igtree_getUniqueId(igtree_treeName), igtree_nodeId);
      }
      igtree_postCanceled = false;
      igtree_clickCounter = 0;
	
   }

	function igtree_getUniqueId(treeId) {
		var str = treeId + "UniqueId";
		var uniqueId = eval(str);
		if(uniqueId != null)
			return uniqueId;
		else
			return treeId;
	}

   function igtree_onScroll(src) {
      var treeName = src;
      var formControl = igtree_getElementById(treeName);
      if(formControl == null)
         return;
      var treeState = formControl.value;
      
      var index = treeState.search("Tree:Scrl");
      if(index >= 0) {
			var reg = /Tree:Scrl=\d+<%;/;
			treeState = treeState.replace(reg, "");
      }
      var treeControl = igtree_getElementById("T_" + treeName);
      var scrollVal = treeControl.scrollTop;
      treeState += "Tree:Scrl=" + scrollVal + "<%;";
      formControl.value = treeState;
      return true;
   }
	
   // Update the PostBackData field
   function igtree_updatePostField(treeName, nodeId, oldNodeId) {
      var formControl = igtree_getElementById(treeName);
      if(formControl == null)
         return;
      var treeState = formControl.value;
      

      if((oldNodeId != null) && treeState.search(oldNodeId + ":Clck<%;") >= 0) {
		 treeState = treeState.replace(oldNodeId + ":Clck<%;", nodeId + ":Clck<%;");
      }
      else
         treeState += nodeId + ":Clck<%;";
      formControl.value = treeState;   

   }


   function igtree_dblclick(src) {
      igtree_postCanceled = true;
      igtree_beginedit(src);
   }

	function igtree_getEditControl(src)
	{
		var strArray;
		if(igt_IE)
		strArray = src.parentElement.id.split("_");
		else
		strArray = src.parentNode.id.split("_");
		var treeName = strArray[0];
		return igtree_getElementById(treeName+"_tb");
	}

   var igt_editControl = null;
   var igt_editSource = null;
   function igtree_beginedit(src) {
	    igtree_endedit(true);
		var te;
		if(igt_IE)
		   te = igtree_treeFromNode(src.parentElement.id).treeElement;
		else
		   te = igtree_treeFromNode(src.parentNode.id).treeElement;
		igt_editControl=igtree_getEditControl(src);
		if(igt_editControl)
		{
			igt_editControl.setAttribute("currentNode",src);
			igt_editSource = src;
			igt_editControl.setAttribute("oldInnerText",src.innerText);
			igt_editControl.value=src.innerHTML;
			igt_editControl.style.display="";
			igt_editControl.style.position="absolute";
			if(igt_IE) {
    			igt_editControl.style.left=igt_fnGetLeftPos(src)-igt_fnGetLeftPos(te)+te.scrollLeft-(te.style.borderWidth?parseInt(te.style.borderWidth,10):0);
	    		igt_editControl.style.top=igt_fnGetTopPos(src)-igt_fnGetTopPos(te)+te.scrollTop-(te.style.borderWidth?parseInt(te.style.borderWidth,10):0);
				igt_editControl.style.width=src.offsetWidth+25;
				igt_editControl.style.height=src.offsetHeight;
    		}
    		else {
    			igt_editControl.style.left=igt_fnGetLeftPos(src);//-igt_fnGetLeftPos(te)+te.scrollLeft;
	    		igt_editControl.style.top=igt_fnGetTopPos(src);//-igt_fnGetTopPos(te)+te.scrollTop;
				igt_editControl.style.width=src.offsetWidth+25;
				igt_editControl.style.height=src.offsetHeight + 6;
    		}
			igt_editControl.focus();
			igt_editControl.select();
		}
   }

 
function igtree_endedit(accept) {
    if(!igt_editControl || igt_editControl.style.display=="none")
		return;
	
	var src;
	if(igt_IE)	
		src = igt_editControl.getAttribute("currentNode");
	else
		src = igt_editSource;
	if(src && accept && igtree_updateNodeText(src,igt_editControl.value)){
		src.innerHTML=igt_editControl.value;
	}
	else if(src)
		src.innerText=igt_editControl.getAttribute("oldInnerText");
	igt_editControl.removeAttribute("currentNode");
	igt_editControl.removeAttribute("oldInnerText");
	igt_editControl.style.display="none";
	igt_editControl=null;
}
  
   function igt_editClickHandler() {
      event.cancelBubble = true;
   }


   function igtree_linkTo(linkUrl, linkTarget) {
		if(linkUrl.indexOf("javascript") != -1)
			eval(linkUrl);
		else
		if(linkTarget != null){
			if(igtree_getElementById(linkTarget) != null) {
				igtree_getElementById(linkTarget).src = linkUrl;
			}
			else
			if(eval("parent.frames."+linkTarget) != null) {
				eval("parent.frames."+linkTarget+".location=\""+linkUrl+"\";");
			}
			else {
				window.open(linkUrl);
			}
		}
		else
		{ 
			location.href = linkUrl;
		}
   }

   function igtree_selectStart() {
	if(window.event.srcElement.tagName == "INPUT")
		return;
        window.event.cancelBubble = true; 
	window.event.returnValue = false; 
	return false;	
   }

   function igtree_updateNodeText(src, newText) {
      var nodeId;
      if(igt_IE)
	      nodeId = src.parentElement.id;
	  else  {
	      nodeId = src.parentNode.id;
	      }
      var treeName = nodeId;
      var strArray = treeName.split("_");
      treeName = strArray[0];
      var formControl = igtree_getElementById(treeName);
      if(formControl == null)
         return;
      var treeState = formControl.value;
      treeState += nodeId + ":Edit=" + newText + "<%;";
      formControl.value = treeState;
      return true;
   }

   function igtree_updateNodeToggle(src, bExpanded) {
      var nodeId = src;

      var treeName = nodeId;
      nodeId = nodeId.replace("M_", "");
      var strArray = treeName.split("_");
      treeName = strArray[1];
      var formControl = igtree_getElementById(treeName);
      if(formControl == null)
         return;
      var treeState = formControl.value;
      
      var newValue;
      var oldValue;
      if(bExpanded) {
          oldValue = "0";
	      newValue = "1";
      }
      else {
          oldValue = "1";
          newValue = "0";
      }

      var oldString = nodeId + ":Togl=" + oldValue + "<%;";
      var newString = nodeId + ":Togl=" + newValue + "<%;";
      if(treeState.search(oldString) >= 0) {
	  treeState = treeState.replace(oldString, newString);
      }
      else {
         treeState += newString;
      }
      formControl.value = treeState; 
   }
   
   function igt_clickEndEdit() {
      if(event.sourceElement == igt_editControl)
         return;
      igtree_endedit(true);
   }

   function igtree_imageClick(tree, node, expand) {
//		if(expand)
//			//__doPostBack(tree, node, "Expand");
//		else
//			__doPostBack(tree, node, "Collapse");
   }
  
   function igt_onKeyDown(evnt, treeID) {
	  var processed=false;
   	  var igt_currentNode = igtree_currentNodeFromTree(treeID);
      if(evnt.keyCode == 113) {  // F2
         if(igt_currentNode != null) {
			processed=true;
			igtree_beginedit(igt_currentNode);
		 }
	  }
	  if(evnt.keyCode == 107 || evnt.keyCode == 109 || evnt.keyCode == 37 || evnt.keyCode == 39) { // plus/minus key
		 var parentNode;
		 if(igt_IE)
		    parentNode = igt_currentNode.parentElement;
		 else
		    parentNode = igt_currentNode.parentNode;
		 if(parentNode && parentNode.nextSibling && parentNode.nextSibling.id.substr(0,2)=="M_")
		 {
			var toggle=((evnt.keyCode == 107 || evnt.keyCode == 39) && parentNode.nextSibling.style.display=="none" || (evnt.keyCode == 109 || evnt.keyCode == 37) && parentNode.nextSibling.style.display=="");
			var tree=igtree_treeFromNode(parentNode.id);
			if(tree && tree.treeElement.ClassicTree)
			{
				if(toggle)
					igtree_classicToggle(parentNode.nextSibling.id, igt_currentNode.previousSibling.previousSibling);
			}
			else if(toggle)
				igtree_toggle(parentNode.nextSibling.id, parentNode.childNodes[1]);
			processed=true;
		 }
	  }
	  if(evnt.keyCode == 35) { // end key
	     if(igt_currentNode) {
		    var parentNode;
		    if(igt_IE)
		       parentNode = igt_currentNode.parentElement;
		    else
		       parentNode = igt_currentNode.parentNode;
		    if(parentNode) {
			   var tree=igtree_treeFromNode(parentNode.id).treeElement;
		       var last = tree.children[0].children[tree.children[0].children.length-1];
		       while(last.id.substr(0,2)=="M_")
		       {
				  if(last.style.display=="")
					last = last.children[last.children.length-1];
				  else
					last=last.previousSibling;
			   }
		       if(last) {
		          var child = last.childNodes[last.childNodes.length-1];
		          if(child) {
		             igtree_nodeclick(child);
					 igt_scrollToView(tree,child);
					 processed=true;
		          }
		       }
		    }
	     }
	  }
	  if(evnt.keyCode == 36) { // home key
	     if(igt_currentNode) {
		    var parentNode;
		    if(igt_IE)
		       parentNode = igt_currentNode.parentElement;
		    else
		       parentNode = igt_currentNode.parentNode;
		    if(parentNode) {
			   var tree=igtree_treeFromNode(parentNode.id).treeElement;
		       var first = tree.children[0].children[0];
		       if(first) {
		          var child = first.childNodes[first.childNodes.length-1];
		          if(child) {
		             igtree_nodeclick(child);
					 igt_scrollToView(tree,child);
					 processed=true;
		          }
		       }
		    }
	     }
	  }
	  if(evnt.keyCode == 38) { // up arrow
	     if(igt_currentNode) {
		    var parNode;
		    if(igt_IE){
		       parNode = igt_currentNode.parentElement;
		    }
		    else
		       parNode = igt_currentNode.parentNode;
		    if(parNode) {
		       var sibling = igt_prevSibling(parNode);
		       if(sibling) {
		          var child = sibling.childNodes[sibling.childNodes.length-1];
		          if(child) {
		             igtree_nodeclick(child);
					 igt_scrollToView(igtree_treeFromNode(parNode.id).treeElement,child);
					 processed=true;
		          }
		       }
		    }
	     }
	  }
	  if(evnt.keyCode == 40) { // down arrow
	     if(igt_currentNode) {
		    var parentNode;
		    if(igt_IE)
		       parentNode = igt_currentNode.parentElement;
		    else
		       parentNode = igt_currentNode.parentNode;
		    if(parentNode) {
		       var sibling = igt_nextSibling(parentNode);
		       if(sibling) {
		          var child = sibling.childNodes[sibling.childNodes.length-1];
		          if(child) {
		             igtree_nodeclick(child);
					 igt_scrollToView(igtree_treeFromNode(parentNode.id).treeElement,child);
					 processed=true;
		          }
		       }
		    }
	     }
	  }
	  if(processed)
	  {
		evnt.cancelBabble=true;
		evnt.returnValue=false;
		return false;
	  }
   }

function igt_nextSibling(node) {
	var sibling = node.nextSibling;
	while(sibling && sibling.style.display=="none")
		sibling=sibling.nextSibling;
	var n=node;
	var parentNode;
	if(igt_IE)
		parentNode = n.parentElement;
	else
		parentNode = n.parentNode;
	
	while(!sibling && parentNode && parentNode.id.substr(0,2)=="M_")
	{
		sibling=parentNode.nextSibling;
		n=parentNode;
		while(sibling && sibling.style.display=="none")
			sibling=sibling.nextSibling;
	}
	if(sibling && sibling.id.substr(0,2)=="M_")
		sibling=sibling.childNodes[0];
	return sibling;
}

function igt_prevSibling(node) {
	var sibling = node.previousSibling;
	while(sibling && sibling.style.display=="none")
		sibling=sibling.previousSibling;
	var parentNode;
	var n=node;
	if(igt_IE)
		parentNode = n.parentElement;
	else
		parentNode = n.parentNode;
	while(!sibling && parentNode && parentNode.id.substr(0,2)=="M_")
	{
		sibling=parentNode.previousSibling;
		n=parentNode;
		while(sibling && sibling.style.display=="none")
			sibling=sibling.previousSibling;
	}
	while(sibling && sibling.id.substr(0,2)=="M_")
	{
		sibling=sibling.childNodes[sibling.childNodes.length-1];
		while(sibling && sibling.style.display=="none")
			sibling=sibling.previousSibling;
	}
	return sibling;
}

function igt_fnGetLeftPos(e) 
{
    x = e.offsetLeft;
    tmpE = e.offsetParent;
    while (tmpE != null) 
    {
        x += tmpE.offsetLeft;
        if(tmpE.tagName=="DIV" && tmpE.style.borderLeftWidth)
	        x += parseInt(tmpE.style.borderLeftWidth);
        if(igt_IE && tmpE.tagName!="BODY") {
			x-=tmpE.scrollLeft;
	    }
        tmpE = tmpE.offsetParent;
    }
    return x;
}

// Returns top position of some element
function igt_fnGetTopPos(e) 
{
    y = e.offsetTop;
    tmpE = e.offsetParent;
    while (tmpE != null) 
    {
        y += tmpE.offsetTop;
        if(tmpE.tagName=="DIV" && tmpE.style.borderTopWidth)
	        y += parseInt(tmpE.style.borderTopWidth);
        if(igt_IE && tmpE.tagName!="BODY")
			y-=tmpE.scrollTop;
        tmpE = tmpE.offsetParent;
    }
    return y;
}

function igt_scrollToView(parent,child)
{
	if(parent.scrollWidth<=parent.offsetWidth && parent.scrollHeight<=parent.offsetHeight)
		return;
	var childLeft=igt_fnGetLeftPos(child);
	var parentLeft=igt_fnGetLeftPos(parent);
	var childTop=igt_fnGetTopPos(child);
	var parentTop=igt_fnGetTopPos(parent);
	var childRight=childLeft+child.offsetWidth;
	var parentRight=parentLeft+parent.offsetWidth;
	var childBottom=childTop+child.offsetHeight;
	var parentBottom=parentTop+parent.offsetHeight;
	var hsw=(parent.scrollWidth>parent.offsetWidth?18:0);
	var vsw=(parent.scrollWidth>parent.offsetWidth || parent.scrollHeight>parent.offsetHeight?18:0);
	if(childRight>parentRight-vsw && childLeft-(childRight-parentRight)>parentLeft)
		parent.scrollLeft+=childRight-parentRight+vsw;
	if(childBottom>parentBottom-hsw && childTop-(parentTop-childTop)>parentTop)
		parent.scrollTop+=childBottom-parentBottom+hsw;
	if(childLeft<parentLeft)
		parent.scrollLeft-=parentLeft-childLeft;
	if(childTop<parentTop)
		parent.scrollTop-=parentTop-childTop;
}

function igtree_editKeyDown(evnt, src)
{
	if(igt_IE) {
		evnt.cancelBubble=true;
		if(evnt.keyCode==13)
		{
			event.returnValue=false;
			igtree_endedit(true);
			
			return false;
		}
		else if(evnt.keyCode==27){
			igtree_endedit(false);
		}
	}
	else {
		if(evnt.keyCode==13)
		{
			evnt.cancelBubble=true;
			igtree_endedit(true);
			return false;
		}
		else if(evnt.keyCode==27){
			igtree_endedit(false);
		}
	}
}
