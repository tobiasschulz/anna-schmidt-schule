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
	my $vn = get_param('firstname');
	my $nn = get_param('lastname');
	my $un = get_param('username');
	if ($un eq '') {
		$un = ($vn . $nn);
	}
	my $department = get_param('department');

	my $serv = get_param('server');
	my $quota = get_param('quota');
	my $public = get_param('public');

	my $proj = get_param('proj');
	my @perm;
	if (defined $cgi->param('permission'))
	{
		@perm = $cgi->param('permission');
	}
	my $appl = get_param('applications');
	
	my $time = time();
	
	my @arr = (0, $time, $vn, $nn, $un, $department, $serv, ((length($quota)==0)?"":($quota . "GB")), $proj, (join ", ", @perm), $appl, $public);
	my $line = join(";", @arr);

	print "<div class=\"h\">Account requested successfully</div>";
	print "<p>Account requested successfully.</p><p>&nbsp;</p>";
	
	### Ausgabe zum Testen
	###
	### print "<p>Line:</p><blockquote><code><pre>" . $line . "</pre></code></blockquote>\n";
	
	open(FILE, ">>", $file_kennungen);
	print FILE $line . "\n";
	close FILE;
	
	# --> SMTP-Programm zum Versenden der Mail:
	$Sendmail_Prog = "/usr/sbin/sendmail";
	# --> Ziel-Mailadresse, an die gesendet werden soll:
	$mailto = 'ifernges@de.amadeus.com';
	
	# -------> E-Mail versenden:
	(open MAIL, "|$Sendmail_Prog -t") || print "$Sendmail konnte nicht gestartet werden\n";
	print MAIL "To: $mailto\n";
	print MAIL "Subject: account request from " . ($vn . " " . $nn) . "\n\n";
	print MAIL ($vn . " " . $nn) . " has requested a new account.\n";
	print MAIL "Time: " . scalar localtime($now + 0) . "\n";
	print MAIL "First Name: " . $vn . "\n";
	print MAIL "Last Name: " . $nn . "\n";
	print MAIL "User Name: " . $un . "\n";
	print MAIL "Department: " . $department . "\n";
	print MAIL "Rights: " . (join ", ", @perm) . "\n";
	print MAIL "\n";
	print MAIL "Server: " . $serv . "\n";
	print MAIL "Account type: " . $public . "\n";
	print MAIL "Quota: " . ((length($quota)==0)?"":($quota . "GB")) . "\n";
	print MAIL "\n";
	print MAIL "Project: " . $proj . "\n";
	print MAIL "Application: " . $appl . "\n";
	close(MAIL);
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
	
	print "<div class=\"h\">Accounts</div>";
	print "<table class='tabelle'>\n";
	print "<tr>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=0\">time</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=1\">first name</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=2\">last name</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=2\">user name</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=3\">department</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=4\">server</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=5\">quota</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=6\">project</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=7\">rights</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=8\">application</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=8\">public</a></th>";
	print "<th><a href=\"index.pl?show_table=1&sort_index=9\">accepted</a></th>";
	print "</tr>\n";
	
	$z = -1;
	foreach my $line (@lines) {
		$z++;
		print "<tr>\n";
		@line = split(";", $line);
		
		$ok = shift @line;
		$now = shift @line;
		my $now = scalar localtime($now + 0);
		print "<td>" . $now . "</td>";
		
		$r = -1;
		foreach (@line) {
			$r++;
			$_ = '&nbsp;' if length($_) == 0;
			s/_/_ /gm;
			s/-/- /gm;
			
			if (($r != 2 && $r != 6 && $r != 7) || $ok) {
				print "<td>" . $_ . "</td>";
			}
			else {
				# Eindeutig
				$u = join "", (split " ", (join "", @line));
				$u =~ tr/_//d;
				$u =~ tr/;//d;
				$u =~ tr/ //d;
				$u =~ tr/-//d;
				$u =~ tr/+//d;
				$u =~ tr/&//d;
				$u =~ s/nbsp;//igm;
				$u =~ s/&nbsp;//igm;
				
				print "<td style=\"background-color: white; padding: 0px; border: 2px solid #1a61a9;\"><form style=\"padding: 0px;width: 100%; height: 100%; \" id=\"edit" . $z . $r . "\" method='get'>";
				print "<input type=\"hidden\" name=\"r\" value=\"" . $u . "\">";
				print "<input type=\"hidden\" name=\"c\" value=\"" . $r . "\">";
				print "<input type=\"hidden\" name=\"exists\" value=\"1\">";
				print "<input type=\"hidden\" name=\"show_table\" value=\"1\">";
				print "<input type=\"hidden\" name=\"sort_index\" value=\"" . $sort_index . "\">";
				print "<input type=\"hidden\" name=\"sessionid\" value=\"" . $session->{"sessionid"} . "\">";
				print "<input type=\"hidden\" name=\"userid\" value=\"" . $para{"userid"} . "\">";
				
				print "<textarea style=\"overflow: hidden; width: 100%; height: 100%; border: none;\" onblur=\"document.getElementById('edit" . $z . $r . "').submit();\" name='editfield'>" . $_ . "</textarea>"; 
				print "</form></td>";
			}
		}

		$x = scalar @line;
		while ($x < 10) {
			print "<td>&nbsp;</td>";
			
			$x++;
		}
		
		print "<td>" . (($ok) ? "OK" : ("<a href='index.pl?exists=1&show_table=1&sort_index=" . $sort_index . "&accept_num=" . $z . "&sessionid=" . $session->{"sessionid"} . "&userid=" . $para{"userid"} . "'>accept</a>")) . "</td>";
		
		print "</tr>\n";
	}
	print "</table> 		<div style=\"clear: both;\">&nbsp;</div>";

}

sub add_to_file {
	$grp = shift;
	$member = shift;
	$user = shift;
	
	%groups = get_groups();
	
	my $line = '';
	foreach (sort split(" ", $groups{$grp})) {
		if (/$member/) {
			$line = $_ . "=\\";
			$line =~ tr/-//d;
			$line =~ tr/_//d;
			$line =~ tr/+//d;
			$line =~ tr/ //d;
			print "Line: " . $line . "\n";
		}
	}
	
	@lines = ();
	open FILE, "<", $file_projects;
	while (<FILE>) {
		chomp;
		tr/\n//d;
		tr/\r//d;
		push @lines, $_;
		next if /[#]/;

#		print;
#		print " eq $line\n";

		tr/-//d;
		tr/_//d;
		tr/+//d;
		tr/ //d;
		if ($line eq $_) {
			print "Found!\n";

			my %users = ();
			$users{$user . ",\\"} = 1;
			while (my $user = <FILE>) {
				chomp;
				last if $user =~ /[#]/;
				$user =~ tr/\n//d;
				$user =~ tr/\r//d;
				$user =~ s/[,\\]//igm;
				last if $user eq '';
				$users{$user . ",\\"} = 1;
			}

			print "users: " . (join ", ", keys %users) . "\n";

			push @lines, (sort { $a cmp $b } keys %users);
			push @lines, "";
		}
	}
	close FILE;

	open DATEI, ">", $file_projects;
	print DATEI (join "\n", @lines);
	close DATEI;
}

sub accept_num {
	$num = shift;

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
		$y =~ s/,/, /gm;
		next if length($y) == 0;
		push(@lines, $_);
	}
	@lines = sort { (split ";", $b)[$sort_index] cmp (split ";", $a)[$sort_index] } @lines;
	@ende = ();

	$z = -1;
	foreach my $line (@lines) {
		$z++;
		
		if ($num == $z) {
			@line = split ";", $line;
			$line[0] = 1;
			
			add_to_file($line[8], $line[9], $line[4]);
			
			$line = join ";", @line;
		}
		
		push @ende, $line;
	}
	
	open(FILE, ">", $file_kennungen);
	for (@ende) {
		print FILE $_ . "\n";
	}
	close FILE;
}

sub edit_field {
	$num = shift;
	$num =~ tr/\n//d;
	$num =~ tr/\r//d;

	$sort_index = get_param('r');
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
		$y =~ s/,/, /gm;
		next if length($y) == 0;
		push(@lines, $_);
	}
	@lines = sort { (split ";", $b)[$sort_index] cmp (split ";", $a)[$sort_index] } @lines;
	@ende = ();

	$z = -1;
	foreach my $line (@lines) {
		$z++;
		
		@line = split ";", $line;
		$x1 = shift @line;
		$x2 = shift @line;
		# Eindeutig
		$u = join "", (split " ", (join "", @line));
		$u =~ tr/;//d;
		$u =~ tr/_//d;
		$u =~ tr/\n//d;
		$u =~ tr/ //d;
		$u =~ tr/-//d;
		$u =~ tr/+//d;
		$u =~ tr/&//d;
		$u =~ s/nbsp//igm;
		
		$num =~ s/nbsp//igm;
		$num =~ tr/ //d;
		$num =~ s/ //g;

#		print "$u eq $num\n";
		if ($u eq $num) {
			if (defined get_param('c')) {
				$c = get_param('c');
				
				$line[$c] = get_param('editfield');
				$line[$c] =~ tr/\n//d;
				$line[$c] =~ tr/\r//d;
			}
		}
		
		@line = reverse @line;
		push @line, $x2;
		push @line, $x1;
		@line = reverse @line;
		$line = join ";", @line;
		
		push @ende, $line;
	}
	
	open(FILE, ">", $file_kennungen);
	for (@ende) {
		print FILE $_ . "\n";
	}
	close FILE;
}


1;
