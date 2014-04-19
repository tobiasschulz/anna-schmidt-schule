#!/usr/bin/perl -w

use strict;						
use warnings;						
use CGI;						
use CGI::Carp qw(fatalsToBrowser);	
use Date::Calc qw( Week_of_Year );		 
use DBI;


###
### Definition der benötigten Variablen (meist mit Deklaration)
###

our $cgi = new CGI;
our $dbh;

# Zählvariable
my $i;

# Variablen zur Statusausgabe am Bildschirm
my $error = "";

# Übergabeparameter Kurzschreibweisen
my $p_a;
my $p_w;
my $p_l;
my $p_p;
my $p_t;
my $p_s;
my $p_n;
my $g_s;

if (defined $cgi->param('action'))
{
    $p_a = $cgi->param('action');
}
else
{
    $p_a  = "";
}
if (defined $cgi->param('week'))
{
    $p_w = sprintf("%02u", $cgi->param('week'));
}
else
{
    $p_w  = "";
}
if (defined $cgi->param('location'))
{
    $p_l = $cgi->param('location');
}
else
{
    $p_l  = "";
}
if (defined $cgi->param('project'))
{
    $p_p = $cgi->param('project');
}
else
{
    $p_p  = "";
}
if (defined $cgi->param('technical'))
{
    $p_t = $cgi->param('technical');
}
else
{
    $p_t  = "";
}
if (defined $cgi->param('severity'))
{
    $p_s = $cgi->param('severity');
}
else
{
    $p_s  = "";
}
if (defined $cgi->param('number'))
{
    $p_n = $cgi->param('number');
}
else
{
    $p_n  = "";
}
if (defined $cgi->url_param('sort'))
{
    $g_s = $cgi->url_param('sort');
}
else
{
    $g_s  = "project ASC";
}

# Die aufgeführten Arrays enthalten die Werte für die Select-Felder
($Date::Calc::week, $Date::Calc::year) = Week_of_Year(&Date::Calc::Today(time)); # berechnet KW
my $this_year	= sprintf("/%02u", $Date::Calc::year - 2000);
my $this_week 	= sprintf("%02u", $Date::Calc::week);
my %location 	= ("BHO"=>"black", "ANR"=>"green", "MIA"=>"red", "NCE"=>"brown", "MUC"=>"blue");
my @project 	= sort("AGM (MBO)", "AMOS (MBO)", "ARNO (LLP)", "ASW (LLP)", "BS2000 (LLP)", "CDP (SEP)", "LEGO (LLP)", "SEL (SEP)", "SEN Services (all)", "other (LLP)", "other (MBO)", "other (SEP)");
my @technical	= sort("Build-environment: BS2000", "Dev-environment: BS2000", "Build-environment:UNIX", "Dev-environment: Unix", "Build-environment:Windows", "Dev-envitonment Windows", "Documentation: Intranet", "Training / Lecture", "Documentation: other", "IDE: BS2000", "IDE: Eclipse", "IDE: Visual Studio", "UML: Rational Rose", "Repository: CVS", "Repository: MKS Source Integrity", "Process: MKS Integrity Manager", "Repository: ClaerCase", "Process: CMMI", "Process: QA Intranet", "other");
my %severity   = ("P1"=>"System down", "P2"=>"Error on running system", "P3"=>"Advice on usage");
my @severity	= sort(keys(%severity));
my @location	= sort(keys(%location));

# Variablen für Zugriff auf die Datenbank und Fehler- oder Statusausgabe
my $query;
my $lines_selected = 0;
my $lines_inserted = 0;
my $lines_updated = 0;


###
### Herstellen einer Verbindung zu Datenbank
###

# Verbindung zur Datenbank herstellen
open (INFILE, '</usr/local/html/support/connection.txt') or $error = "<b>No database to connect: </b>".$!;
my @dbdata = <INFILE>; 
close (INFILE);
chomp(@dbdata);

$dbh = DBI->connect($dbdata[0], $dbdata[1], $dbdata[2]) or $error = "<b>Problems to prepare database:<b/> ".$!;


###
### Dieser Teil wird nur aufgerufen, wenn das Formular über 'Update' abgeschickt wird.
###

if(($p_a eq 'update') && ($error eq ""))
{
       # Prüfung auf gültige Eingaben in den Freitaxtfeldern 'week' und 'number'.
	if(!(($p_w =~ m/^(([0]?[1-9])|([1-4]?[0-9])|(5[012]))$/) && ($p_w <= $this_week)))
	{
		$error = "Please insert a calendar week between 1 and ".$this_week.".\n";	
	}
	if(!($p_n =~ m/^[\-0-9]?[1-9]$/))
	{
		$error.= "Please insert a number between 1 and 99. ";	
	}
	
	# Wenn die Eingaben in Ordnung sind, werden SQL Statement abgesetzt
	if($error eq "")
	{
		$query = $dbh->prepare("SELECT week_of_year, location, project, technical FROM support_strichliste WHERE week_of_year='".$p_w.$this_year."' AND location='".$p_l."' AND project='".$p_p."' AND technical='".$p_t."';");
		$lines_selected = $query->execute() or $error = "<b>Problems while reading from database:</b> ".$!;
		if(($lines_selected eq "0E0") && ($error eq ""))
		{
		    
			$query = $dbh->prepare("INSERT INTO support_strichliste(week_of_year, location, project, technical, requests_P1, requests_P2, requests_P3) VALUES ('".$p_w.$this_year."', '".$p_l."', '".$p_p."', '".$p_t."', 0, 0, 0);");
			$lines_inserted = $query->execute() or $error = "<b>Problems while inserting into database:</b> ".$!;
			
		}
		if($error eq "")
		{
			$query = $dbh->prepare("UPDATE support_strichliste SET requests_".$p_s." = requests_".$p_s." + ".$p_n." WHERE week_of_year='".$p_w.$this_year."' AND location='".$p_l."' AND project='".$p_p."' AND technical='".$p_t."';");
			$lines_updated = $query->execute() or $error = "<b>Problems while updating database:</b> ".$!;
			$query = $dbh->prepare("DELETE FROM support_strichliste WHERE requests_P1 = 0 AND requests_P2 = 0 AND requests_P3 = 0");
			$query->execute() or $error = "Problems while deleting from database: ".$!;
		}
	}
}

###
### Ausgabe des HTML-Quelltextes bis zur ersten horizontalen Line
###

print $cgi->header();			
print $cgi->start_html(-title=>'SEN Support Activities',-style=>{-src=>'styles.css'});		
print $cgi->start_form({action=>'index.pl', method=>'POST'});	
print $cgi->start_table({class=>'table'});
	
# Ausgabe der HTML Formularfelder
print "<tr><td colspan='7'><h1>SEN Support Activities</h1></td></tr>";
print "<tr><td colspan='7'><hr /></td></tr>";
print "<tr>\n<td>\nWeek:<br />\n";
print "<input name='week' type='text' maxlength='2' size='2' value='".$this_week."' />\n";
print "</td>\n<td>\nLocation:<br />\n<select name='location'>\n";
foreach $i (@location)
{
	if($i eq "BHO")
	{
		print "<option selected='selected'>".$i."</option>\n";
	} else {
		print "<option>".$i."</option>\n";
	}
}
print "</select>\n</td>\n<td>\nProject:<br />\n<select name='project'>\n";
foreach $i (@project)
{
	print "<option>".$i."</option>\n";
}
print "</select>\n</td>\n<td>\nTechnical:<br />\n<select name='technical'>\n";
foreach $i (@technical)
{
	print "<option>".$i."</option>\n";
}
print "</select>\n</td>\n<td>\nSeverity:<br />\n<select name='severity'>\n";
foreach $i (@severity)
{
	if($i eq "P3")
	{
		print "<option selected='selected'>".$i."</option>\n";
	} else {
		print "<option>".$i."</option>\n";
	}
}
print "</select>\n</td>\n<td>\nNumber:<br />\n";
print "<input name='number' type='text' maxlength='2' size='2' value='01' />\n";
print "</td>\n<td>\nSend query:<br />\n";
print "<input type='submit' name='action' value='update' />\n";
print "</td>\n</tr>\n";
print "\n<tr>\n<td colspan='7'class='legend'>\n";
foreach $i (@severity)
{
    print " ".$i.": ".$severity{$i};
}
print "</td></tr><tr>\n<td colspan='7'>\n<hr />\n</td>\n</tr><tr><td colspan='7'>";

###
### Ausgabe des HTML-Textes bis zur zweiten horizontalen Line (Statusleiste)
###

if(($error eq "") && ($lines_inserted))
{
	print "Data successfully inserted and updated.";
}
elsif(($error eq "") && ($lines_updated))
{
	print "Data successfully updated.";
}
elsif($error eq "")
{
	print "SEN Support Activities: Waiting for user input.";	
}
else
{
	print "<font color=red>".$error."</font>";	
}
print "</td>\n</tr>\n<tr>\n<td colspan='7'>\n<hr />\n</td>\n</tr>\n";


###
### Vorbereitung und Ausgabe der Übersicht inklusive der erforderlichen Datenbankzugriffe
###

print "<tr><td colspan='7'>";
for($i=0; $this_week > $i; $i++)
{		
	$query = $dbh->prepare("SELECT location, project, technical, requests_P1, requests_P2, requests_P3, (requests_P1+requests_P2+requests_P3) AS requests_ges FROM support_strichliste WHERE week_of_year='".sprintf("%02u", $this_week - $i).$this_year."' ORDER BY ".$g_s.";");

    
	
#location, project, technical, requests_P1, requests_P2, requests_P3, (requests_P1+requests_P2+requests_P3) AS requests_ges
    $lines_selected = $query->execute() or die "<b>Problems while reading from database: </b>".$!;
	
	
	# Erste Zeile der Ausgabetabelle mit Wochennummer und den Farbkürzeln
	print "<center><table width='550'  cellpadding='3' cellspacing='0' class='output'>";
	print "<tr><td><b>Week ".($this_week - $i)."</b></td>";
	print "<td class='legend' colspan='5'><a href='index.pl?sort=location'><b>Location:</b></a> ";
	foreach (sort(@location))
	{
		print "<font color='".$location{$_}."'>".$_." </font>";	
	}
	print "</td></tr>";
	
	# Zweite Zeile der Tabelle mit den anklickbaren Spaltenüberschriften.
	print "<tr><th width='100'><a href='index.pl?sort=project ASC'>Project</a></th>";
	print "<th width='300'><a href='index.pl?sort=technical ASC'>Technical</a></th>";
	print "<th width='50'><a href='index.pl?sort=requests_P1 DESC'>P1</a></th>";
	print "<th width='50'><a href='index.pl?sort=requests_P2 DESC'>P2</a></th>";
	print "<th width='50'><a href='index.pl?sort=requests_P3 DESC'>P3</a></th>";
	print "<th width='50'><a href='index.pl?sort=requests_ges DESC'>ges</a></th></tr>";
	
	my @daten;
	my $sum1 = 0; 
	my $sum2 = 0;
	my $sum3 = 0;
	my $sumges = 0;
	while (@daten = $query->fetchrow_array())
	{
		$sum1 += $daten[3];
		$sum2 += $daten[4];
		$sum3 += $daten[5];
		$sumges += $daten[6];

		# Die folgenden Tabellenzeilen, welche die einzelnen Werte enthalten.
		print "<tr><td><font color='".$location{$daten[0]}."'>".$daten[1]."</font></td>";
		print "<td><font color='".$location{$daten[0]}."'>".$daten[2]."</font></td>";
		print "<td><font color='".$location{$daten[0]}."'>".$daten[3]."</font></td>";
		print "<td><font color='".$location{$daten[0]}."'>".$daten[4]."</font></td>";
		print "<td><font color='".$location{$daten[0]}."'>".$daten[5]."</font></td>";
		print "<td class='hsum'><font color='".$location{$daten[0]}."'>".$daten[6]."</font></td></tr>";
	}
	
	# Die letzte Zeile der Tabelle. Enthält die jeweiligen Gesamtsummen für diese Woche. 
	print "<tr><td colspan='2' class='vsum'>Gesamt</td><td class='vsum'>".$sum1."</td><td class='vsum'>".$sum2."</td><td class='vsum'>".$sum3."</td><td class='vsum'>".$sumges."</td></tr>";
	print "</table></center><br />";
}
print "</td></tr><tr><td colspan='7'><hr /></td></tr>";

### 
### Ausgabe der abschließenden HTML-Tags
###

print $cgi->end_table();
print $cgi->end_form();
print $cgi->end_html();
