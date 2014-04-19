sub without_permissions {
	my $wp = shift;
	$wp =~ s/(CM-Responsible|Developer|Projectmanager|Quality-Inspector|Read-User|Imperator|SB_Reviewer|Tester|Productmanager|Reviewer)//i;
#	$wp =~ s/extern//i;
	$wp =~ s/-_/-/;
	$wp =~ s/_-/_/;
	$wp =~ s/__/_/;
	$wp =~ s/--/-/;
	$wp =~ s/_$//;
	$wp =~ s/-$//;
	return $wp;
}

sub print_register {
	print << "	END";
		<script type="text/javascript">
	END

	print "var reload_page_when_click_on_permissions = false;";
	if (!(defined $cgi->param('group'))) {
		print "reload_page_when_click_on_permissions = true;";
	}

	print << "	END";
	
			function mark_page_for_reload () {
				reload_page_when_click_on_permissions = true;
			}
			
			function reload_page () {
				if (reload_page_when_click_on_permissions) {
					self.location.href = 'index.pl?group=' + document.getElementsByName('proj')[0].options[document.getElementsByName('proj')[0].selectedIndex].text + '&index=' + document.getElementsByName('proj')[0].selectedIndex
				}
			}
			
			// The HTML code which should be shown when the radio button gets the focus
			var application_content =	  "<table class=\\"leftspace\\">"
							+ "<tr><th class=\\"descr\\">Projekt:</th><td>"
							+ "<select name=\\"proj\\" class=\\"input\\" onfocus=\\"mark_page_for_reload();\\" onchange=\\"mark_page_for_reload();\\">"
	END
	
	# Reading projects from test.datei
	%groups = ();
	
	open(FILE, "<", $file_projects);
	while (<FILE>) {
		next if /([#]|IntegrityManagerGroup|SourceIntegrityGroup|RequirementsManagementGroup)/;
		if (/=\\/) {
			s/=\\//;
			s/\n//;
			s/\r//;

			# Spelling
			s/tiion/tion/;
			
			my $key = $_;
			$key = without_permissions($key . "");
#			print $_ . "\n" . $key . "\n";
			
			$groups{$key} .= " " if defined $groups{$key};
			$groups{$key} .= $_;
		}
	}
	foreach $k (sort keys %groups) {
		print "+ \"<option name=\\\"proj\\\">" . $k . "</option>\"\n";
#		print $k . ":" . $groups{$k} . "\n"
	}
	print << "	END";
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">Applications:</th><td>"
							+ "<select name=\\"applications\\" class=\\"input\\">"
							+ "<option name=\\"applications\\">MKS</option>"
							+ "<option name=\\"applications\\">ClearCase</option>"
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">Rechte:</th><td>"
	END

	print "+ \"<select class=\\\"input\\\" name=\\\"permission\\\" onfocus=\\\"reload_page();\\\" onchange=\\\"reload_page();\\\">\"";

	foreach $k (sort split(" ", $groups{$cgi->param('group')})) {
		$k =~ s/$cgi->param('group')//;
		print "+ \"<option name=\\\"permission\\\">" . $k . "</option>\"\n";
	}
	print << "	END";
							+ "</select></td></tr>"
							+ "</table>";
			var server_content = 	          "<table class=\\"leftspace\\">"
							+ "<tr><th class=\\"descr\\">Server:</th><td>"
							+ "<select name=\\"server\\" class=\\"input\\">"
							+ "<option name=\\"server\\">fraurauscher1</option>"
							+ "<option name=\\"server\\">fraurauscher2</option>"
							+ "<option name=\\"server\\">frasde1</option>"
							+ "<option name=\\"server\\">frasde3</option>"
							+ "</select></td></tr>"
							+ "<tr><th class=\\"descr\\">Quota:</th><td>"
							+ "<select name=\\"quota\\" class=\\"input\\">"
	END
	@quotas = (1, 2, 3, 4, 5);
	foreach $num (@quotas) {
		print "+ \"<option name=\\\"quota\\\" value=\\\"". $num . "\\\">" . $num . " GB</option>\"";
	}
	
	print << "	END";
							+ "</select></td></tr>"
							+ "</table>";

			// Clearing the content of "show_application" and "show_server"
			function clean_innerhtml () {
				document.getElementById("show_server").innerHTML = "";
				document.getElementById("show_application").innerHTML = "";
			}

			// The "server" radio button has got the focus
			function chk_server () {
				document.getElementById("show_server").innerHTML = server_content;
				document.getElementById("show_server").blur();
			}

			// The "application" radio button has got the focus
			function chk_appl () {
				document.getElementById("show_application").innerHTML = application_content;
				document.getElementById("show_application").blur();
			}
		</script>
		<div class="h">Kennung anfordern</div>
		<form id="register" method="get" action="index.pl">
			<div>
				<table class="leftspace">
					<tr><th class="descr">Vorname:</th><td><input type="text" name="vorname" class="input" /></td></tr>
					<tr><th class="descr">Nachname:</th><td><input type="text" name="nachname" class="input" /></td></tr>
					<tr><th class="descr">Abteilung:</th><td><input type="text" name="abteilung" class="input" /></td></tr>
						
					<tr><th class="descr">&nbsp;</th><td>
						<input type="radio" name="X" value="server" onfocus="clean_innerhtml(); chk_server(); this.blur();" onchange="clean_innerhtml(); chk_server(); this.blur();">Server</input>
						<br />
						<input type="radio" name="X" value="application" onfocus="clean_innerhtml(); chk_appl(); this.blur();" onchange="clean_innerhtml(); chk_appl(); this.blur();">Applikation</input>
					</td></tr>				
				</table>
			</div>
			<div id="show_application">
			</div>
			<div id="show_server">
			</div>

			<input class="input" type="submit" value="Anfordern" style="width: 100px !important;" name="do_save" />
		</form>

		<script type="text/javascript">
	END
	if (defined $cgi->param('group')) {
		print "clean_innerhtml(); chk_appl();";
		print "document.getElementsByName('proj')[0].selectedIndex = '" . $cgi->param('index') . "';";
	}
	print << "	END";
		</script>
	END
}






1;
