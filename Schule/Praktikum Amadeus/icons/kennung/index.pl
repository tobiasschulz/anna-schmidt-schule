#!/usr/bin/perl -w

use strict;						
use warnings;						
use CGI;						
use CGI::Carp qw(fatalsToBrowser);
push @INC, ("/usr/local/html/kennung", "/usr/local/html/kennung/Time");

###
### Dateien
###

our $file_kennungen = "kennungen.csv";
our $file_projects = "test.datei.test";
our $session_tmp = "tmp/session.db";

###
### Global variables
###
our $session;     # Hashreferenz mit Werten der aktuellen Sitzung
our $sessions;    # # Hashreferenz aller Sitzungen

our $cgi = new CGI;
our $q = CGI->new();
our %para = $q->Vars();
our $dbh;

our $p_a = "";

if (defined $cgi->param('action'))
{
    $p_a = $cgi->param('action');
}

if ($para{"userid"} eq '') {
	undef $para{"userid"};
}

########################################################################
# Anmeldevorgang
########################################################################
sub anmelden {
    load_sessions();
    if ( defined $para{"log_out"} ) {
    	return 0 if (!(defined $para{"sessionid"})) or length($para{"sessionid"}) == 0;
    	print "<p>Logging out</p>";
        my $y = session($para{"sessionid"}, $para{"userid"});
	$sessions->{$para{"userid"}} = undef;
        save_sessions();
        return $y;
	}
    if ( $para{"new"} ) {
    	return 0 if (!(defined $para{"userid"})) or length($para{"userid"}) == 0;
        my $y = login($para{"userid"}, $para{"password"});
        save_sessions();
        return $y;
    }
    elsif ( $para{"exists"} ) {
    	return 0 if (!(defined $para{"sessionid"})) or length($para{"sessionid"}) == 0;
        my $y = session($para{"sessionid"}, $para{"userid"});
        save_sessions();
        return $y;
    }
    return 0;
}

########################################################################
# login ueberprueft Passwort
########################################################################
sub login {
    my $userid = shift;
    my $password = shift;
    unless ( $userid ) { return 0; }
    
    open FILE, "<", "kennung.passwd";
    my @pairs = <FILE>;
    close FILE;
    my %hash_pairs = ();
    foreach (@pairs) {
    	chomp;
    	@_ = split ";", $_;
    	$hash_pairs{$_[0]} = $_[1];
#   	print "\$hash_pairs{" . $_[0] . "} = " . $_[1] . ";\n";
	}
# print $userid . ";" . $password;
    
    if ( $password ne $hash_pairs{$userid} ) { print "<p>Error!</p>"; return 0; }
    $session = { "sessionid" => int(rand()*time()),
                 "userid" => $userid,
                 "client_ip" => $ENV{"REMOTE_ADDR"},
                 "counter" => 1 };
    $sessions->{$userid} = $session;
    return 1;
}

########################################################################
# ueberprueft sessionid und IP-Adresse
########################################################################
sub session {
    my $sessionid = shift;
    my $userid = shift;
    unless ( $userid ) { return 0; }
    $session = $sessions->{$userid};
    unless ( $session ) { return 0; }
    if ( $sessionid != $session->{"sessionid"} ) { return 0; }
    if ( $ENV{"REMOTE_ADDR"} ne $session->{"client_ip"} ) { return 0; }
    $session->{"counter"}++;
    return 1;
}

########################################################################
# liest Sitzungen aus File ein
########################################################################
sub load_sessions {
    $sessions = {};
    open FH, "< $session_tmp" or return;
    while ( my $line = <FH> ) {
        chomp $line;
        my ($userid, $sessionid, $client_ip, $counter) = split /:/, $line;
        my $session = { "sessionid" => $sessionid,
                        "client_ip" => $client_ip,
                        "userid" => $userid,
                        "counter" => $counter };
        $sessions->{$userid} = $session;
    }
    close FH;
}

########################################################################
# speichert Sitzungen in File
########################################################################
sub save_sessions {
    open FH, "> $session_tmp" or die "$session_tmp: $!";
    foreach my $userid ( keys %$sessions ) {
        my $session = $sessions->{$userid};
        print FH "$userid:", "$session->{sessionid}:",
            "$session->{client_ip}:", "$session->{counter}";
    }
    close FH;
}
###
### Content Type
###

print "Content-type: text/html\n\n";

###
### HTML Header
###

print << "ENDE";
<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
<head>
	<title>
		Request account
	</title>
	<link rel="stylesheet" type="text/css" href="kennung.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>
	<div id="logo">&nbsp;</div>
	<div class="all">
		<div class="login">
ENDE

if (anmelden()) 
{
	print << "	ENDE";
			<div class="h" style="margin-right: 20px;">Logout</div>
	ENDE
	print "<p>Welcome " . $session->{'userid'} . ". You are logged in.</p>";

	print $q->start_form({"method" => "post"});
    print $q->start_table();
    print "<tr><td>".
          $q->submit({"name" => "log_out", "value" => "Logout", "class" => "input", style => "width: 100px !important;"}) .
          "</td></tr>";
    print $q->end_table();
    print $q->end_form();
}
else
{
	print << "	ENDE";
		
			<div class="h" style="margin-right: 20px;">Login</div>
	ENDE
	
	print $q->start_form({"method" => "post"});
    print $q->start_table();
    print $q->Tr($q->td({"align" => "right"}, "User:"),
                 $q->td($q->textfield({"name" => "userid", "class" => "input", style => "width: 120px !important;"})));
    print $q->Tr($q->td({"align" => "right"}, "Password:"),
                 $q->td($q->password_field({"name" => "password", "class" => "input", style => "width: 120px !important;"})));
    print "<tr><td>&nbsp;</td><td>".
          $q->submit({"name" => "new", "value" => "Login", "class" => "input", style => "width: 50px !important;"}) .
          "</td></tr>";
    print $q->end_table();
    print $q->end_form();
}
print << "ENDE";
		</div>
		<div class="menu">
			<div class="h" style="margin-right: 20px;">Navigation</div>
			<ul>
ENDE
print "<li><a href=\"index.pl?exists=1&sessionid=" . $session->{"sessionid"} . "&userid=" . $para{"userid"} . "\">request account</a></li>";
if (length($session->{"sessionid"})) {
	print "<li><a href=\"index.pl?exists=1&show_table=1&sort_index=4&sessionid=" . $session->{"sessionid"} . "&userid=" . $para{"userid"} . "\">show accounts</a></li>";
}
print "<li><a href=\"index.pl?help=1&exists=1&sessionid=" . $session->{"sessionid"} . "&userid=" . $para{"userid"} . "\">help</a></li>";
print << "ENDE";
			</ul>
		</div>
		<div class="content">

ENDE

###
### Including files
###

require 'register.pl';
require 'save.pl';
require 'help.pl';

if (defined $cgi->param('help')) {
	###
	### Help 
	###
	show_help();
}
elsif (defined $cgi->param('accept_num')) {
	###
	### Accept Entry no. X in the table
	###
	accept_num($cgi->param('accept_num'));
	###
	### Show $file_kennungen (HTML Table)
	###
	show_table();
}
elsif (defined $cgi->param('do_save'))
{
	###
	### Save to $file_kennungen
	###
	do_save();
}
elsif (defined $cgi->param('show_table'))
{
	if (defined $cgi->param('editfield')) {
		edit_field($cgi->param('r'));
	}
	###
	### Show $file_kennungen (HTML Table)
	###
	show_table();
}
else
{
	###
	### Print HTML FORM
	###
	print_register();
}






###
### HTML End
###

print << "ENDE";
		<div style="clear: both;">&nbsp;</div>
		</div>
	</div>
</body>
</html>
ENDE












