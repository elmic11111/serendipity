package MY::Common;
use Carp;
use strict;
use Symbol;
use Fcntl;
use CGI;
my $VERSION = 0.01;

BEGIN{
	use constant IS_MODPERL => $ENV{MOD_PERL};
	use subs qw(exit);
	# Select the correct exit function
	*exit = IS_MODPERL ? \&Apache::exit : sub { CORE::exit };
}

# ----------------------------------------------------------
#				initialization
# ----------------------------------------------------------

# ----------------------------------------------------------
#				Load Other Systems
# ----------------------------------------------------------



sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my $self  = {};
	bless($self, $class);
	return $self;
}

#! Use a list of bad characters to filter the data
sub FilterNegHtml {
	my $self = shift;
	 my( $parseString ) = @_;
	 if ($parseString) {
		 $parseString =~ s/[\'\\\%\;\)\(\+]//g;
		 $parseString =~ s/&/\&amp;/g;
		$parseString =~ s/</\&lt;/g;
		$parseString =~ s/>/\&gt;/g;
		$parseString =~ s/\"/\&quot;/g;
	}
	if (defined $parseString) {
		 return( $parseString );
	} else {
		return( undef );
	}
}

#! Use a list of good characters to filter the data
sub FilterAlphaNumberic {
	my $self = shift;
	my( $parseString ) = @_;
	 $parseString =~ tr/A-Za-z0-9\ //dc if ($parseString);
	if (defined $parseString) {
		 return( $parseString );
	} else {
		return( undef );
	}
}

#! Use a list of good characters to filter the data
sub FilterAlpha {
	my $self = shift;
	my( $parseString ) = @_;
	 $parseString =~ tr/A-Za-z\ //dc if ($parseString);
	if (defined $parseString) {
		 return( $parseString );
	} else {
		return( undef );
	}
}

sub FilterNumberic {
	my $self = shift;
	 my( $parseString ) = @_;
	 $parseString =~ tr/0-9//dc if (defined $parseString);
	if (defined $parseString) {
		 return( $parseString );
	} else {
		return( undef );
	}
}

#! Use a list of bad characters to filter the data
sub RedirectURL {
	my $self = shift;
	 my( $parseString ) = @_;
	 if ($parseString) {
		 $parseString =~ s/\n//g;
		 $parseString =~ s/\r//g;
		 $parseString =~ s/\f//g;
	}
	if (defined $parseString) {
		my $q = new CGI;
		print $q->redirect($parseString);
		return 1;
	}
	return 0;
}

sub ValidEmailAddr {
	my $self = shift;
	my $mail = shift;													#in form name@host
	return 0 if ( $mail !~ /^[0-9a-zA-Z\.\-\_]+\@[0-9a-zA-Z\.\-]+$/ );	#characters allowed on name: 0-9a-Z-._ on host: 0-9a-Z-. on between: @
	return 0 if ( $mail =~ /^[^0-9a-zA-Z]|[^0-9a-zA-Z]$/);				#must start or end with alpha or num
	return 0 if ( $mail !~ /([0-9a-zA-Z]{1})\@./ );						#name must end with alpha or num
	return 0 if ( $mail !~ /.\@([0-9a-zA-Z]{1})/ );						#host must start with alpha or num
	return 0 if ( $mail =~ /.\.\-.|.\-\..|.\.\..|.\-\-./g );			#pair .- or -. or -- or .. not allowed
	return 0 if ( $mail =~ /.\.\_.|.\-\_.|.\_\..|.\_\-.|.\_\_./g );		#pair ._ or -_ or _. or _- or __ not allowed
	return 0 if ( $mail !~ /\.([a-zA-Z]{2,3})$/ );						#host must end with '.' plus 2 or 3 alpha for TopLevelDomain (MUST be modified in future!)
	return 1;
}
