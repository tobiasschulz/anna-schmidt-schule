sub umformen {
	my ($aus) = @_;
	
	$aus =~ s/\s/  /gim;
	$aus =~ s/([)(])/ $1 /gmi;
	$aus =~ s/ und /E&&E/gim;
	$aus =~ s/ oder /E||E/gmi;
	$aus =~ s/ nicht /!/gmi;
	$aus =~ s/ ist /E<=>E/gmi;
	$aus =~ s/ folgt /E=>E/gmi;
	$aus =~ s/ wahr /1/gmi;
	$aus =~ s/ richtig /1/gmi;
	$aus =~ s/ falsch /0/gmi;
	$aus =~ s/\s//gmi;
	$aus = 'E' . $aus . 'E';

	return $aus;
}

sub neutralabsorb {
	my ($aus, $pro) = @_;

	$$pro .= '- Neutralelemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E&&E1/;
	$aus =~ s/E&&E1//igm;
	$$pro .= '- Neutralelemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E\|\|E0/;
	$aus =~ s/E\|\|E0//igm;

	$$pro .= '- Absorbierende Elemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E&&E0/;
	$aus =~ s/E(.*?)E&&E0/E0/igm;
	$$pro .= '- Absorbierende Elemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E\|\|E1/;
	$aus =~ s/E(.*?)E\|\|E1/E1/igm;

	$$pro .= '- Neutralelemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E&&E1/;
	$aus =~ s/E1E&&E//igm;
	$$pro .= '- Neutralelemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E\|\|E0/;
	$aus =~ s/E0E\|\|E//igm;

	$$pro .= '- Absorbierende Elemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E&&E0/;
	$aus =~ s/E0E&&E(.*?)E/E0/igm;
	$$pro .= '- Absorbierende Elemente, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E\|\|E1/;
	$aus =~ s/E1E\|\|E(.*?)E/E1/igm;

	return $aus;
}

sub assoz {
	my ($aus, $pro) = @_;

	$$pro .= '- Assoziativitaet, vorher ' . lesbar($aus) . '\n' if $aus =~ /E\((.*?)E&&E(.*?)\)E&&E(.*?)E/;
	$aus =~ s/E\((.*?)E&&E(.*?)\)E&&E(.*?)E/E$1E&&E$2E&&E$3E/igm;
	$$pro .= '- Assoziativitaet, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E&&E\((.*?)E&&E(.*?)\)E/;
	$aus =~ s/E(.*?)E&&E\((.*?)E&&E(.*?)\)E/E$1E&&E$2E&&E$3E/igm;
	$$pro .= '- Assoziativitaet, vorher ' . lesbar($aus) . '\n' if $aus =~ /E\((.*?)E\|\|E(.*?)\)E\|\|E(.*?)E/;
	$aus =~ s/E\((.*?)E\|\|E(.*?)\)E\|\|E(.*?)E/E$1E\|\|E$2E\|\|E$3E/igm;
	$$pro .= '- Assoziativitaet, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E\|\|E\((.*?)E\|\|E(.*?)\)E/;
	$aus =~ s/E(.*?)E\|\|E\((.*?)E\|\|E(.*?)\)E/E$1E\|\|E$2E\|\|E$3E/igm;

	return $aus;
}

sub distrib1 {
	my ($aus, $pro) = @_;

	$$pro .= '- Distributivitaet 1.1, vorher ' . lesbar($aus) . '\n' if $aus =~ /E\((.*?)E&&E(.*?)\)E\|\|E(.*?)E/;
	$aus =~ s/E\((.*?)E&&E(.*?)\)E\|\|E(.*?)E/E($1E||E$3)E&&E($2E||E$3)E/igm and return $aus;
	$$pro .= '- Distributivitaet 1.2, vorher ' . lesbar($aus) . '\n' if $aus =~ /E(.*?)E&&E\((.*?)E\|\|E(.*?)\)E/;
	$aus =~ s/E(.*?)E&&E\((.*?)E\|\|E(.*?)\)E/E($1E||E$2)E&&E($1E||E$3)E/igm and return $aus;

	return $aus;
}

sub distrib2 {
	my ($aus, $pro) = @_;

	if ( $aus =~ /E\((.*?)E\|\|E(.*?)\)E&&E\((.*?)E\|\|E(.*?)\)E/ && $2 eq $4 ) {
		$$pro .= '- Distributivitaet 2.1, vorher ' . lesbar($aus) . '\n';
		$aus =~ s/E\((.*?)E\|\|E(.*?)\)E&&E\((.*?)E\|\|E(.*?)\)E/E($1E&&E$3)E||E$2E/igm;
	}
	if ( $aus =~ /E\((.*?)E&&E(.*?)\)E\|\|E\((.*?)E&&E(.*?)\)E/ && $2 eq $4 ) {
		$$pro .= '- Distributivitaet 2.2, vorher ' . lesbar($aus) . '\n';
		$aus =~ s/E\((.*?)E&&E(.*?)\)E\|\|E\((.*?)E&&E(.*?)\)E/E($1E||E$3)E&&E$2E/igm;
	}

	return $aus;
}

sub lesbar {
	my ($aus) = @_;

	$aus =~ s/E//igm;
	$aus =~ s/&&/ und /igm;
	$aus =~ s/\|\|/ oder /igm;
	$aus =~ s/<=>/ ist equivalent mit /igm;
	$aus =~ s/=>/ folgt /igm;
	$aus =~ s/1+/ wahr /igm;
	$aus =~ s/0+/ falsch /igm;

	return $aus;
}

sub vereinfache {
	my ($aus) = @_;
	my $pro = 'Protokoll: Vereinfachen von ' . $aus;
	$aus = umformen($aus);
	for $dummy (0..5) {
		$pro .= "::" . $dummy . "\n";
		$aus = assoz($aus, \$pro);
		$aus = distrib1($aus, \$pro);
		$aus = neutralabsorb($aus, \$pro);
		$aus = distrib2($aus, \$pro);
		$aus = neutralabsorb($aus, \$pro);
		$aus = distrib2($aus, \$pro);
	}
	$aus = lesbar($aus);

	$pro =~ s/\\n/\n/igm;

	return ($aus, $pro);
}


print "Content-type: text/html\n\n";
while (<>) {
	my ($aus, $pro) = vereinfache($_);
	print $pro . "\n\nErgebnis:";
	print $aus . "\n";
	exit 0;
}
