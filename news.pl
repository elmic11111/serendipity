#!/usr/bin/perl -w
use lib '/kunden/homepages/17/d100079702/htdocs/underground/modules/';
use Carp;
use strict;
use DBI;
use MY::ReadParm;
print "Content-type: text/html\n\n";

# 1se4gTHV80

my $readparm = MY::ReadParm->new();
my %in = $readparm->GetIn();
my $ntype = 0;
if ($in{'ntype'}) {
	if ($in{'ntype'} == 1) {
		$ntype = 1;
		print "<h1>Norm News</h1>";		
	} elsif ($in{'ntype'} == 2) {
		$ntype = 2;
		print "<h1>Others News</h1>";		
	}

	my $dbh = DBI->connect("dbi:mysql:database=db484426291;host=db484426291.db.1and1.com:3306;user=dbo484426291;password=1se4gTHV80") 
		or die "Couldn't connect to database: $DBI::errstr\n";

	my $getnews = "SELECT news_id, news_title, news_text FROM news WHERE (active_date <= now() or force_live = 1) AND status = 1 AND ntype = $ntype ORDER BY active_date DESC";

	$getnews = $dbh->prepare($getnews)
		or die "Couldn't prepare query getnews: $DBI::errstr\n";

	$getnews->execute()
		or die "Couldn't execute query getnews: $DBI::errstr\n";
	while (my $row_ref = $getnews->fetchrow_hashref()) {
		print "
		<div id=\"news_title_$row_ref->{news_id}\" class=\"newstitle\" style=\"cursor: pointer;\" onmouseout=\"this.style.border-color='#B36643'\" onmouseover=\"this.style.border-color='#090C0E'\" onclick=\"togglenews('#news_$row_ref->{news_id}');\">
			<span style=\"text-transform:uppercase; font-weight:bold; padding-left:5px;\">$row_ref->{news_title}</span>
		</div>
		<div id=\"news_$row_ref->{news_id}\" class=\"toPopup\">
			<h1>$row_ref->{news_title}</h1>$row_ref->{news_text}
			<span><a href=\"#\" onClick=\"togglenews('#news_$row_ref->{news_id}');return false;\">Close</a></span>
		</div>";
	}
	$dbh->disconnect(); 
	
}	