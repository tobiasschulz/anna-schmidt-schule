sub get_param {
	$p = shift;
	if (defined $cgi->param($p))
	{
    		return $cgi->param($p);
	}
	return '';
}

################################################################################
# 
#  Format:
#
#  Vorname;Nachname;Abteilung;Server;Quota;Projekt;Rechte;Application

sub do_save {
	my $vn = get_param('vorname');
	my $nn = get_param('nachname');
	my $abt = get_param('abteilung');

	my $serv = get_param('server');
	my $quota = get_param('quota');

	my $proj = get_param('proj');
	my $perm = get_param('permission');
	my $appl = get_param('applications');
	
	my @arr = ($vn, $nn, $abt, $serv, $quota, $proj, $perm, $appl);
	my $line = join(";", @arr);

	print "<div class=\"h\">Kennung erfolgreich eingetragen</div>";
	print "<p>Anforderung abgespeichert.</p><p>Zeile:</p>";
	print "<blockquote><pre>" . $line . "</pre></blockquote>\n";
	
	open(FILE, ">>", $file_kennungen);
	print FILE $line . "\n";
	close FILE;
}


sub show_table {
	$sort_index = get_param('sort_index');
	if ($sort_index eq '') {
		$sort_index = 0;
	}
	$sort_index += 0;
	
	
	open(FILE, "<", $file_kennungen);
	@_lines = <FILE>;
	close FILE;

	my @lines;
	foreach (@_lines) {
		chomp;
		$y = $_;
		$y =~ tr/;//d;
		next if length($y) == 0;
		push(@lines, $_);
	}
#	@lines = sort { (split " ", $a)[$sort_index] cmp (split " ", $b)[$sort_index] } @_lines;
	@lines = sort { (split ";", $b)[$sort_index] cmp (split ";", $a)[$sort_index] } @lines;
	
	print << "	EOF";
	<style type="text/css">
	* html .tabelle {
		position: relative;
/*		top: 40px;*/
		
	}
	</style>
	EOF
	
	print "<div class=\"h\">Kennungen</div>";
	print "<table class='tabelle'>\n";
	print "<tr>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=0\">Vorname</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=1\">Nachname</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=2\">Abteilung</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=3\">Server</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=4\">Quota</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=5\">Projekt</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=6\">Rechte</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=7\">Application</a></th>";
	print "</tr>\n";
	
	foreach my $line (@lines) {
		print "<tr>\n";
		@line = split(";", $line);
		foreach my $td (@line) {
			$td = '&nbsp;' if length($td) == 0;
			print "<td>" . $td . "</td>";
		}
#		print "\n" . scalar @line . "\n";
		$x = scalar @line;
		while ($x < 8) {
			print "<td>&nbsp;</td>";
			
			$x++;
		}
		print "</tr>\n";
	}
	print "</table> 		<div style=\"clear: both;\">&nbsp;</div>";

}



1;
