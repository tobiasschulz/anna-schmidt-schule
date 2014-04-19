sub without_permissions {
	my $wp = shift;
	$wp =~ s/(testmanager|responsible|decisionboard|buildmanager|viewer|member|Extern|CM-Responsible|CMResponsible|Developer|Projectmanager|Quality-Inspector|QualityInspector|Read-User|ReadUser|Imperator|SB_Reviewer|Tester|Productmanager|Reviewer)//ig;
#	$wp =~ s/extern//ig;
	$wp =~ s/-_/-/;
	$wp =~ s/_-/_/;
	$wp =~ s/__/_/;
	$wp =~ s/--/-/;
	$wp =~ s/_$//;
	$wp =~ s/-$//;
	return $wp;
}

sub get_groups {
	# Reading projects from test.datei
	%groups = ();
	
	open(FILE, "<", $file_projects);
	while (<FILE>) {
		next if /([#]|IntegrityManagerGroup|SourceIntegrityGroup|RequirementsManagementGroup|CM_ADM)/;
		if (/=\\/) {
			s/=\\//;
			s/\n//;
			s/\r//;

			# Spelling
			s/tiion/tion/;
			
			tr/-//d;
			tr/+//d;
			tr/;//d;
			tr/.//d;
			tr/\\\\//d;
			
			my $key = $_;
			$key = without_permissions($key . "");
#			print $_ . "\n" . $key . "\n";
			
			$groups{$key} .= " " if defined $groups{$key};
			$groups{$key} .= $_;
		}
	}
	
	return %groups;
}

sub print_register {
	%groups = get_groups();

	print << "	END";
		<script type="text/javascript">
		<!--
	END

	print "var reload_page_when_click_on_permissions = true;";


	print << "	END";
	
			function mark_page_for_reload () {
				reload_page_when_click_on_permissions = true;
			}
			
			function reload_page () {
				fake_reload(document.getElementsByName('proj')[0].options[document.getElementsByName('proj')[0].selectedIndex].text);
				if (reload_page_when_click_on_permissions) {
					fake_reload(document.getElementsByName('proj')[0].options[document.getElementsByName('proj')[0].selectedIndex].text);
	END
#	print "self.location.href = 'index.pl?exists=1&group=' + document.getElementsByName('proj')[0].options[document.getElementsByName('proj')[0].selectedIndex].text + '&index=' + document.getElementsByName('proj')[0].selectedIndex + '&sessionid=" . $session->{"sessionid"} . "&userid=" . $para{"userid"} . "';\n";
	print << "	END";
				}
			}
			
			// Clearing the content of "show_tool"
			function clean_innerhtml () {
				document.getElementById("show_tool").innerHTML = "";
			}


			// The HTML code which should be shown when the radio button gets the focus
			var application_content =	  "<table class=\\"leftspace\\">"
							+ "<tr><th class=\\"descr\\">applications:</th><td>"
							+ "<select name=\\"applications\\" class=\\"input\\">"
							+ "<option name=\\"applications\\">MKS</option>"
							//							+ "<option name=\\"applications\\">ClearCase</option>"
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">project:</th><td>"
							+ "<select name=\\"proj\\" class=\\"input\\" onfocus=\\"reload_page();\\" onchange=\\"reload_page();\\">"
	END
	foreach $g (sort keys %groups) {
		print "+ \"<option name=\\\"proj\\\">" . $g . "</option>\"\n";
	}
	print << "	END";
							+ "</select></td></tr>";
	END
	print "function fake_reload (x) {\n";
	foreach $group (sort keys %groups) {
		$key = $group . "";
		$key =~ tr/-//d;
		$key =~ tr/+//d;
		$key =~ tr/;//d;
		$key =~ tr/.//d;
		$key =~ tr/\\\\//d;
		
		print "if (x == '" . $group . "') {\n";

		print << "		ENDE";
			
			for (var y = 0; y < document.getElementById(\"select_perm\").length; y += 1) {
				document.getElementById(\"select_perm\").options[y] = null;
			}
		
		ENDE

		$z = -1;
		foreach (sort split(" ", $groups{$group})) {
			$z++;
			tr/-//d;
			tr/+//d;
			tr/;//d;
			tr/.//d;
			tr/\\\\//d;
			@away = split /[_-]/, $group;
			for $a (@away) {
				s/$a//igm;
			} 
			tr/[_]//d;
			tr/-//d;
			
			print "NeuerEintrag = new Option('" . $_ . "', '" . $_ . "', false, true);";
			print "		document.getElementById(\"select_perm\").options[" . $z . "] = NeuerEintrag;\n";
		}

		print "}\n";
	}
	print "}\n";
	print << "	END";
			application_content +=		 "<tr><th class=\\"descr\\">rights:</th><td>"
	END

	print "+ \"<select class=\\\"input\\\" id=\\\"select_perm\\\" name=\\\"permission\\\">\""; #onfocus=\\\"reload_page();\\\" onchange=\\\"reload_page();\\\"

	print << "	END";
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">user name:</th><td><input type=\\"text\\" name=\\"username\\" class=\\"input\\" /></td></tr>"
							+ "</table>";
							
			var server_content = 	          "<table class=\\"leftspace\\">"
							+ "<tr><th class=\\"descr\\">server:</th><td>"
							+ "<select name=\\"server\\" class=\\"input\\">"
							+ "<option name=\\"server\\">fraurauscher1</option>"
							+ "<option name=\\"server\\">fraurauscher2</option>"
							+ "<option name=\\"server\\">frasde1</option>"
							+ "<option name=\\"server\\">frasde3</option>"
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">public/private:</th><td>"
							+ "<input type=\\"radio\\" name=\\"public\\" value=\\"public\\" onfocus=\\"show_username();this.blur();\\" onchange=\\"show_username();this.blur();\\">public</input>"
							+ "<br />"
							+ "<input type=\\"radio\\" name=\\"public\\" value=\\"private\\" checked=\\"checked\\" onclick=\\"hide_username();this.blur();\\">private</input>"
							+ "</td></tr></table>"
							+ "<div id=\\"req_username\\"></div>"
							+ "<table class=\\"leftspace\\"><tr><th class=\\"descr\\">quota:</th><td>"
							+ "<select name=\\"quota\\" class=\\"input\\">"
	END
	@quotas = (1, 2, 3, 4, 5);
	foreach $num (@quotas) {
		print "+ \"<option name=\\\"quota\\\" value=\\\"". $num . "\\\">" . $num . " GB</option>\"";
	}
	
	print << "	END";
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">rights:</th><td>"
							+ "<select name=\\"permission\\" class=\\"input\\" multiple=\\"multiple\\">"
							+ "<option name=\\"permission\\" value=\\"---\\">---</option>"
	END
	@rights = qw(aswa aswb aswc aswd aswe aswf aswg aswh aswi aswj aswk aswl aswm aswn
			aswo aswp aswq aswr asws aswt aswu aswv asww aswx aswy aswz
			asw1 asw2 asw3 asw4 asw5 asw6 asw7 asw8 asw9 asw10 asw11 asw12 asw13 asw14 asw15 asw16
			aswmon
			blggen
			infj infk infl infm);
			
	foreach $num (@rights) {
		print "+ \"<option name=\\\"permission\\\" value=\\\"". $num . "\\\">" . $num . "</option>\"";
	}
	
	print << "	END";
							+ "</select></td></tr>"
							+ "</table>";

			// The "server" radio button has got the focus
			function chk_server () {
				document.getElementById("show_tool").innerHTML = server_content;
				document.getElementById("show_tool").blur();
			}

			// The "application" radio button has got the focus
			function chk_appl () {
				document.getElementById("show_tool").innerHTML = application_content;
				document.getElementById("show_tool").blur();
	END
	@arr = sort keys %groups;
	foreach (sort split(" ", $groups{$arr[0]})) {
		$z++;
		tr/-//d;
		tr/+//d;
		tr/;//d;
		tr/.//d;
		tr/\\\\//d;
		@away = split /[_-]/, $arr[0];
		for $a (@away) {
			s/$a//igm;
		} 
		tr/[_]//d;
		tr/-//d;
		
		if (length($_)) {
			print "NeuerEintrag = new Option('" . $_ . "', '" . $_ . "', false, true);";
			print "		document.getElementById(\"select_perm\").options[" . ($z-1) . "] = NeuerEintrag;\n";
		}
	}
	print "document.getElementsByName('proj')[0].blur()";
	print << "	END";
			}
			var username_content = "<table class=\\"leftspace\\">"
							+ "<tr><th class=\\"descr\\">user name:</th><td>"
							+ "<input type=\\"text\\" name=\\"username\\" class=\\"input\\" />"
							+ "</td></tr>"
							+ "</table>";
			function show_username () {
				hide_username ();
				document.getElementById("req_username").innerHTML = username_content;
				document.getElementById("req_username").blur();
			}
			function hide_username () {
				document.getElementById("req_username").innerHTML = "";
				document.getElementById("req_username").blur();
			}
			//-->
		</script>
		<div class="h">Request account</div>
		<form id="register" method="get" action="index.pl">
	END
#		&sessionid=" . $session->{"sessionid"} . "&userid=" . $para{"userid"} . "
	print "<input type=\"hidden\" name=\"sessionid\" value=\"" . $session->{"sessionid"} . "\" />\n";
	print "<input type=\"hidden\" name=\"userid\" value=\"" . $para{"userid"} . "\" />\n";
	print "<input type=\"hidden\" name=\"exists\" value=\"1\" />\n";
	print << "	END";
			<div>
				<table class="leftspace">
					<tr><th class="descr">first name:</th><td><input type="text" name="firstname" class="input" /></td></tr>
					<tr><th class="descr">last name:</th><td><input type="text" name="lastname" class="input" /></td></tr>
					<tr><th class="descr">department:</th><td><input type="text" name="department" class="input" /></td></tr>
						
					<tr><th class="descr">&nbsp;</th><td>
						<input type="radio" name="X" value="server" onfocus="clean_innerhtml(); chk_server(); this.blur();" onchange="clean_innerhtml(); chk_server(); this.blur();">Server</input>
						<br />
						<input type="radio" name="X" value="application" onfocus="clean_innerhtml(); chk_appl(); this.blur();" onchange="clean_innerhtml(); chk_appl(); this.blur();">Applikation</input>
					</td></tr>				
				</table>
			</div>
			<div id="show_tool">
			</div>

			<input class="input" type="submit" value="submit" style="width: 100px !important;" name="do_save" />
		</form>

		<script type="text/javascript">
	END
#	print $arr[0] . "\n";
	print << "	END";
		</script>
	END
}






1;
