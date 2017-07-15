package MY::ReadParm;
use Carp;
use strict;
use CGI();
use MY::Common;
my $VERSION = 0.01;

BEGIN{
	use constant IS_MODPERL => $ENV{MOD_PERL};
	use subs qw(exit);
	# Select the correct exit function
	*exit = IS_MODPERL ? \&Apache::exit : sub { CORE::exit };
}

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self  = {};
	bless($self, $class);
	$MY::ReadParm::Query = $self->{'readquery'} = new CGI;
	$self->{'common'} = MY::Common->new();

	# This overwrites any default values in $self with stuff passed in.
	return $self;
}

sub GetInDirty {
	my $self = shift;
	my %in;
	foreach my $temppram ($self->{'readquery'}->param) {
		$in{$temppram} = $self->{'readquery'}->param($temppram);
	}
	return %in;
}

sub GetIn {
	my $self = shift;
	my %in;
	foreach my $temppram ($self->{'readquery'}->param) {
		my $parseName = $self->{'common'}->FilterNegHtml($temppram);
		my $parseString = $self->{'common'}->FilterNegHtml($self->{'readquery'}->param($temppram));
		$in{$parseName} = $parseString if (defined $parseName && defined $parseString) ;
	}
	return %in;
}

sub GetMultiDirty {
	my $self = shift;
	my ($parmreq) = @_;
	my @allvalues = $self->{'readquery'}->param($parmreq);
	return @allvalues;
}


sub GetMulti {
	my $self = shift;
	my ($parmreq) = @_;
	my (@allvaluesclean);
	foreach my $temppram ($self->{'readquery'}->param($parmreq)) {
		my $parseString = $self->{'common'}->FilterNegHtml($temppram);
		push(@allvaluesclean,$parseString) if (defined $parseString) ;
	}
	return @allvaluesclean;
}


sub GetMultiListDirty {
	my $self = shift;
	my (@allvalues);
	foreach my $temppram ($self->{'readquery'}->param) {
		my @valscount = $self->{'readquery'}->param($temppram);
		if (scalar(@valscount) > 1) {
			push(@allvalues, $temppram);
		}
	}
	return @allvalues;
}


sub GetMultiList {
	my $self = shift;
	my (@allvaluesclean);
	foreach my $temppram ($self->{'readquery'}->param) {
		my $parseString = $self->{'common'}->FilterNegHtml($temppram);
		my @valscount = $self->{'readquery'}->param($parseString) if (defined $parseString);
		if (scalar(@valscount) > 1) {
			push(@allvaluesclean, $parseString);
		}
	}
	return @allvaluesclean;
}

1;
__END__
