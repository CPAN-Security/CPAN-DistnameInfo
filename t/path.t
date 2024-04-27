# vim: noet

use Test::More tests => 30;
use Data::Dumper;

use CPAN::DistnameInfo;

local $/ ="";

while(<DATA>) {
  chomp;
  my($file,%exp) = split(/[\t\n]+/, $_);
  my($testname) = $file =~ m|([^/]+)$|;
  $exp{pathname} = $file;
  my($subtest_conditional, $message);
  foreach my $conditional (qw(TODO SKIP NOTE)) {
    next unless exists $exp{$conditional};
    $subtest_conditional = $conditional;
    $message = delete $exp{$conditional};

    # Allow NOTE in addtion to SKIP or TODO
    last unless $conditional eq "NOTE";
  }
  my $d = CPAN::DistnameInfo->new($file);
  my %got = $d->properties;

  subtest $testname => sub {
    my($self, $got, $expected) = @_;

    SKIP: {
        goto TODO unless ($subtest_conditional eq "SKIP");
        plan skip_all => $message;

        # skip_all does not execute any tests
        do_subtests(self => $self, got => $got, expected => $expected);
    }

    TODO: {
        goto PASS unless ($subtest_conditional eq "TODO");
        local $TODO = $message;

        do_subtests(self => $self, got => $got, expected => $expected);
    }

    # By default, expecting tests to succeed
    PASS: {
        note "NOTE: $message" if $subtest_conditional eq "NOTE";
        do_subtests(self => $self, got => $got, expected => $expected)
            unless $subtest_conditional =~ m/^(?:TODO|SKIP)$/;
        next;
    }

  }, $d, \%got, \%exp;
}

sub do_subtests {
    my (%args) = @_;
    my $self = $args{self};
    my $got = $args{got};
    my $expected = $args{expected};

    plan tests => 11;

    while (my($k, $v) = each %$got) {
      is($self->$k(), $v, "$k");
    }
    is_deeply($got, $expected, "hash matches")
      or note "\nExpected: ", explain $expected;
}


__DATA__
CPAN/authors/id/J/JA/JAMCC/ngb-101.zip
	filename	ngb-101.zip
	dist		ngb
	maturity	released
	distvname	ngb-101
	version		101
	fullversion	101
	cpanid		JAMCC
	extension	zip
	pkgurl		pkg:cpan/JAMCC/ngb@101?ext=zip

CPAN/authors/id/J/JS/JSHY/DateTime-Fiscal-Year-0.01.tar.gz
	filename	DateTime-Fiscal-Year-0.01.tar.gz
	dist		DateTime-Fiscal-Year
	maturity	released
	distvname	DateTime-Fiscal-Year-0.01
	version		0.01
	fullversion	0.01
	cpanid		JSHY
	extension	tar.gz
	pkgurl		pkg:cpan/JSHY/DateTime-Fiscal-Year@0.01

CPAN/authors/id/G/GA/GARY/Math-PRSG-1.0.tgz
	filename	Math-PRSG-1.0.tgz
	dist		Math-PRSG
	maturity	released
	distvname	Math-PRSG-1.0
	version		1.0
	fullversion	1.0
	cpanid		GARY
	extension	tgz
	pkgurl		pkg:cpan/GARY/Math-PRSG@1.0?ext=tgz

CPAN/authors/id/G/GA/GARY/Math-BigInteger-1.0.tar.gz
	filename	Math-BigInteger-1.0.tar.gz
	dist		Math-BigInteger
	maturity	released
	distvname	Math-BigInteger-1.0
	version		1.0
	fullversion	1.0
	cpanid		GARY
	extension	tar.gz
	pkgurl		pkg:cpan/GARY/Math-BigInteger@1.0

CPAN/authors/id/T/TE/TERRY/VoiceXML-Server-1.6.tar.gz
	filename	VoiceXML-Server-1.6.tar.gz
	dist		VoiceXML-Server
	maturity	released
	distvname	VoiceXML-Server-1.6
	version		1.6
	fullversion	1.6
	cpanid		TERRY
	extension	tar.gz
	pkgurl		pkg:cpan/TERRY/VoiceXML-Server@1.6

CPAN/authors/id/J/JA/JAMCC/ngb-100.tar.gz
	filename	ngb-100.tar.gz
	dist		ngb
	maturity	released
	distvname	ngb-100
	version		100
	fullversion	100
	cpanid		JAMCC
	extension	tar.gz
	pkgurl		pkg:cpan/JAMCC/ngb@100

CPAN/authors/id/J/JS/JSHY/DateTime-Fiscal-Year-0.02.tar.gz
	filename	DateTime-Fiscal-Year-0.02.tar.gz
	dist		DateTime-Fiscal-Year
	maturity	released
	distvname	DateTime-Fiscal-Year-0.02
	version		0.02
	fullversion	0.02
	cpanid		JSHY
	extension	tar.gz
	pkgurl		pkg:cpan/JSHY/DateTime-Fiscal-Year@0.02

CPAN/authors/id/G/GA/GARY/Crypt-DES-1.0.tar.gz
	filename	Crypt-DES-1.0.tar.gz
	dist		Crypt-DES
	maturity	released
	distvname	Crypt-DES-1.0
	version		1.0
	fullversion	1.0
	cpanid		GARY
	extension	tar.gz
	pkgurl		pkg:cpan/GARY/Crypt-DES@1.0

CPAN/authors/id/G/GA/GARY/Stream-1.00.tar.gz
	filename	Stream-1.00.tar.gz
	dist		Stream
	maturity	released
	distvname	Stream-1.00
	version		1.00
	fullversion	1.00
	cpanid		GARY
	extension	tar.gz
	pkgurl		pkg:cpan/GARY/Stream@1.00

CPAN/authors/id/G/GS/GSPIVEY/Text-EP3-Verilog-1.00.tar.gz
	filename	Text-EP3-Verilog-1.00.tar.gz
	dist		Text-EP3-Verilog
	maturity	released
	distvname	Text-EP3-Verilog-1.00
	version		1.00
	fullversion	1.00
	cpanid		GSPIVEY
	extension	tar.gz
	pkgurl		pkg:cpan/GSPIVEY/Text-EP3-Verilog@1.00

CPAN/authors/id/T/TM/TMAEK/DBIx-Cursor-0.14.tar.gz
	filename	DBIx-Cursor-0.14.tar.gz
	dist		DBIx-Cursor
	maturity	released
	distvname	DBIx-Cursor-0.14
	version		0.14
	fullversion	0.14
	cpanid		TMAEK
	extension	tar.gz
	pkgurl		pkg:cpan/TMAEK/DBIx-Cursor@0.14

CPAN/authors/id/G/GA/GARY/Crypt-IDEA-1.0.tar.gz
	filename	Crypt-IDEA-1.0.tar.gz
	dist		Crypt-IDEA
	maturity	released
	distvname	Crypt-IDEA-1.0
	version		1.0
	fullversion	1.0
	cpanid		GARY
	extension	tar.gz
	pkgurl		pkg:cpan/GARY/Crypt-IDEA@1.0

CPAN/authors/id/G/GA/GARY/Math-TrulyRandom-1.0.tar.gz
	filename	Math-TrulyRandom-1.0.tar.gz
	dist		Math-TrulyRandom
	maturity	released
	distvname	Math-TrulyRandom-1.0
	version		1.0
	fullversion	1.0
	cpanid		GARY
	extension	tar.gz
	pkgurl		pkg:cpan/GARY/Math-TrulyRandom@1.0

CPAN/authors/id/T/TE/TERRY/VoiceXML-Server-1.13.tar.gz
	filename	VoiceXML-Server-1.13.tar.gz
	dist		VoiceXML-Server
	maturity	released
	distvname	VoiceXML-Server-1.13
	version		1.13
	fullversion	1.13
	cpanid		TERRY
	extension	tar.gz
	pkgurl		pkg:cpan/TERRY/VoiceXML-Server@1.13

JWILLIAMS/MasonX-Lexer-MSP-0.02.tar.gz
	filename	MasonX-Lexer-MSP-0.02.tar.gz
	dist		MasonX-Lexer-MSP
	maturity	released
	distvname	MasonX-Lexer-MSP-0.02
	version		0.02
	fullversion	0.02
	cpanid		JWILLIAMS
	extension	tar.gz
	pkgurl		pkg:cpan/JWILLIAMS/MasonX-Lexer-MSP@0.02

CPAN/authors/id/J/JA/JAMCC/Tie-CacheHash-0.50.tar.gz
	filename	Tie-CacheHash-0.50.tar.gz
	dist		Tie-CacheHash
	maturity	released
	distvname	Tie-CacheHash-0.50
	version		0.50
	fullversion	0.50
	cpanid		JAMCC
	extension	tar.gz
	pkgurl		pkg:cpan/JAMCC/Tie-CacheHash@0.50

CPAN/authors/id/T/TM/TMAEK/DBIx-Cursor-0.13.tar.gz
	filename	DBIx-Cursor-0.13.tar.gz
	dist		DBIx-Cursor
	maturity	released
	distvname	DBIx-Cursor-0.13
	version		0.13
	fullversion	0.13
	cpanid		TMAEK
	extension	tar.gz
	pkgurl		pkg:cpan/TMAEK/DBIx-Cursor@0.13

CPAN/authors/id/G/GS/GSPIVEY/Text-EP3-1.00.tar.gz
	filename	Text-EP3-1.00.tar.gz
	dist		Text-EP3
	maturity	released
	distvname	Text-EP3-1.00
	version		1.00
	fullversion	1.00
	cpanid		GSPIVEY
	extension	tar.gz
	pkgurl		pkg:cpan/GSPIVEY/Text-EP3@1.00

CPAN/authors/id/J/JD/JDUTTON/Parse-RandGen-0.100.tar.gz
	filename	Parse-RandGen-0.100.tar.gz
	dist		Parse-RandGen
	maturity	released
	distvname	Parse-RandGen-0.100
	version		0.100
	fullversion	0.100
	cpanid		JDUTTON
	extension	tar.gz
	pkgurl		pkg:cpan/JDUTTON/Parse-RandGen@0.100

id/N/NI/NI-S/Tk400.202.tar.gz
	filename	Tk400.202.tar.gz
	dist		Tk
	maturity	released
	distvname	Tk400.202
	version		400.202
	fullversion	400.202
	cpanid		NI-S
	extension	tar.gz
	pkgurl		pkg:cpan/NI-S/Tk@400.202

authors/id/G/GB/GBARR/perl5.005_03.tar.gz
	filename	perl5.005_03.tar.gz
	dist		perl
	maturity	released
	distvname	perl5.005_03
	version		5.005_03
	fullversion	5.005_03
	cpanid		GBARR
	extension	tar.gz
	pkgurl		pkg:cpan/GBARR/perl@5.005_03

M/MS/MSCHWERN/Test-Simple-0.48_01.tar.gz
	filename	Test-Simple-0.48_01.tar.gz
	dist		Test-Simple
	maturity	developer
	distvname	Test-Simple-0.48_01
	version		0.48_01
	fullversion	0.48_01
	cpanid		MSCHWERN
	extension	tar.gz
	pkgurl		pkg:cpan/MSCHWERN/Test-Simple@0.48_01

id/J/JV/JV/PostScript-Font-1.09.tar.gz
	filename	PostScript-Font-1.09.tar.gz
	dist		PostScript-Font
	maturity	released
	distvname	PostScript-Font-1.09
	version		1.09
	fullversion	1.09
	cpanid		JV
	extension	tar.gz
	pkgurl		pkg:cpan/JV/PostScript-Font@1.09

id/I/IB/IBMTORDB2/DBD-DB2-0.77.tar.gz
	filename	DBD-DB2-0.77.tar.gz
	dist		DBD-DB2
	maturity	released
	distvname	DBD-DB2-0.77
	version		0.77
	fullversion	0.77
	cpanid		IBMTORDB2
	extension	tar.gz
	pkgurl		pkg:cpan/IBMTORDB2/DBD-DB2@0.77

id/I/IB/IBMTORDB2/DBD-DB2-0.99.tar.bz2
	filename	DBD-DB2-0.99.tar.bz2
	dist		DBD-DB2
	maturity	released
	distvname	DBD-DB2-0.99
	version		0.99
	fullversion	0.99
	cpanid		IBMTORDB2
	extension	tar.bz2
	pkgurl		pkg:cpan/IBMTORDB2/DBD-DB2@0.99?ext=tar.bz2

CPAN/authors/id/L/LD/LDS/CGI.pm-2.34.tar.gz
	filename	CGI.pm-2.34.tar.gz
	dist		CGI
	maturity	released
	distvname	CGI.pm-2.34
	version		2.34
	fullversion	2.34
	cpanid		LDS
	extension	tar.gz
	pkgurl		pkg:cpan/LDS/CGI.pm@2.34
	SKIP		Dist name with .pm found only on BackPAN

CPAN/authors/id/J/JE/JESSE/perl-5.12.0-RC0.tar.gz
	filename	perl-5.12.0-RC0.tar.gz
	dist		perl
	maturity	developer
	distvname	perl-5.12.0-RC0
	version		5.12.0-RC0
	fullversion	5.12.0-RC0
	cpanid		JESSE
	extension	tar.gz
	pkgurl		pkg:cpan/JESSE/perl@5.12.0-RC0
	NOTE		perl distribution version may include RC\d* suffix

CPAN/authors/id/G/GS/GSAR/perl-5.6.1-TRIAL3.tar.gz
	filename	perl-5.6.1-TRIAL3.tar.gz
	dist		perl
	maturity	developer
	distvname	perl-5.6.1-TRIAL3
	version		5.6.1-TRIAL3
	fullversion	5.6.1-TRIAL3
	cpanid		GSAR
	extension	tar.gz
	pkgurl		pkg:cpan/GSAR/perl@5.6.1-TRIAL3
	NOTE		perl distribution version may include TRIAL\d* suffix

CPAN/authors/id/R/RJ/RJBS/Dist-Zilla-2.100860-TRIAL.tar.gz
	filename	Dist-Zilla-2.100860-TRIAL.tar.gz
	dist		Dist-Zilla
	maturity	developer
	distvname	Dist-Zilla-2.100860-TRIAL
	version		2.100860
	fullversion	2.100860-TRIAL
	cpanid		RJBS
	extension	tar.gz
	pkgurl		pkg:cpan/RJBS/Dist-Zilla@2.100860-TRIAL

CPAN/authors/id/M/MI/MINGYILIU/Bio-ASN1-EntrezGene-1.10-withoutworldwriteables.tar.gz
	filename	Bio-ASN1-EntrezGene-1.10-withoutworldwriteables.tar.gz
	dist		Bio-ASN1-EntrezGene
	maturity	released
	distvname	Bio-ASN1-EntrezGene-1.10-withoutworldwriteables
	version		1.10
	fullversion	1.10-withoutworldwritables
	cpanid		MINGYILIU
	extension	tar.gz
	pkgurl		pkg:cpan/MINGYILIU/Bio-ASN1-EntrezGene@1.10-withoutworldwriteables
	SKIP		Custom version number found only on BackPAN


CPAN/authors/id/I/IL/ILYAZ/modules/Term-Gnuplot-0.90380906.zip
	cpanid		ILYAZ
	dist		Term-Gnuplot
	distvname	Term-Gnuplot-0.90380906
	extension	zip
	filename	modules/Term-Gnuplot-0.90380906.zip
	fullversion	0.90380906
	maturity	released
	pkgurl		pkg:cpan/ILYAZ/Term-Gnuplot@0.90380906?ext=zip
	version		0.90380906

CPAN/authors/id/S/SA/SANDEEPV/GuiBuilder_v0_3.zip
	filename	GuiBuilder_v0_3.zip
	dist		GuiBuilder
	maturity	released
	distvname	GuiBuilder_v0_3
	version		0.03
	fullversion	v0_3
	cpanid		SANDEEPV
	extension	zip
	pkgurl		pkg:cpan/SANDEEPV/GuiBuilder@0.03?ext=zip

CPAN/authors/id/S/SA/SANDEEPV/GuiBuilder_v0_3.zip
	filename	GuiBuilder_v0_3.zip
	dist		GuiBuilder
	maturity	released
	distvname	GuiBuilder_v0_3
	version		0.03
	cpanid		SANDEEPV
	extension	zip
	pkgurl		pkg:cpan/SANDEEPV/GuiBuilder@0.03?ext=zip

CPAN/authors/id/I/IL/ILYAZ/modules/Term-Gnuplot-0.90380906.zip
	filename	modules/Term-Gnuplot-0.90380906.zip
	dist		Term-Gnuplot
	maturity	released
	distvname	Term-Gnuplot-0.90380906
	version		0.90380906
	cpanid		ILYAZ
	extension	zip
	pkgurl		pkg:cpan/ILYAZ/Term-Gnuplot@0.90380906?ext=zip

CPAN/authors/id/S/SA/SANDEEPV/GuiBuilder_v0_3.zip
	filename	GuiBuilder_v0_3.zip
	dist		GuiBuilder
	maturity	released
	distvname	GuiBuilder_v0_3
	version		0.03
	cpanid		SANDEEPV
	extension	zip
	pkgurl		pkg:cpan/SANDEEPV/GuiBuilder@0.03?ext=zip

CPAN/authors/id/J/JH/JHALLOCK/Gtk2-Ex-TimeEntry-0.05.rar
	filename	Gtk2-Ex-TimeEntry-0.05.rar
	dist		Gtk2-Ex-TimeEntry
	maturity	released
	distvname	Gtk2-Ex-TimeEntry-0.05
	version		0.05
	fullversion	0.05
	cpanid		JHALLOCK
	extension	rar
	pkgurl		pkg:cpan/JHALLOCK/Gtk2-Ex-TimeEntry@0.05?ext=rar

BDFOY/authors/id/B/BD/BDFOY/Mojolicious-Plugin-DirectoryServer-1.003.tar
	filename	Mojolicious-Plugin-DirectoryServer-1.003.tar
	dist		Mojolicious-Plugin-DirectoryServer
	maturity	released
	distvname	Mojolicious-Plugin-DirectoryServer-1.003
	version		1.003
	fullversion	1.003
	cpanid		BDFOY
	extension	tar
	pkgurl		pkg:cpan/BDFOY/Mojolicious-Plugin-DirectoryServer@1.003?ext=tar

KMACLEOD/Frontier-RPC-0.07b4.tar.gz
	filename	Frontier-RPC-0.07b4.tar.gz
	dist		Frontier-RPC
	maturity	released
	distvname	Frontier-RPC-0.07b4
	version		0.07
	fullversion	0.07b4
	cpanid		KMACLEOD
	extension	tar.gz
	pkgurl		pkg:cpan/KMACLEOD/Frontier-RPC@0.07b4

RTFIREFLY/Frontier-RPC-0.07b4p1.tar.gz
	filename	Frontier-RPC-0.07b4p1.tar.gz
	dist		Frontier-RPC
	maturity	released
	distvname	Frontier-RPC-0.07b4p1
	version		0.07
	fullversion	0.07b4p1
	cpanid		RTFIREFLY
	extension	tar.gz
	pkgurl		pkg:cpan/RTFIREFLY/Frontier-RPC@0.07b4p1

AJPEACOCK/HTML-Table-2.08a.tar.gz
	filename	HTML-Table-2.08a.tar.gz
	dist		HTML-Table
	maturity	released
	distvname	HTML-Table-2.08a
	version		2.08
	fullversion	2.08a
	cpanid		AJPEACOCK
	extension	tar.gz
	pkgurl		pkg:cpan/AJPEACOCK/HTML-Table@2.08a

DANPEDER/MIME-Base32-1.02a.tar.gz
	filename	MIME-Base32-1.02a.tar.gz
	dist		MIME-Base32
	maturity	released
	distvname	MIME-Base32-1.02a
	version		1.02
	fullversion	1.02a
	cpanid		DANPEDER
	extension	tar.gz
	pkgurl		pkg:cpan/DANPEDER/MIME-Base32@1.02a

HAGGAI/Acme-Base64-v0.0.2.tar.gz
	filename	Acme-Base64-v0.0.2.tar.gz
	dist		Acme-Base64
	maturity	released
	distvname	Acme-Base64-v0.0.2
	version		0.0002
	fullversion	v0.0.2
	cpanid		HAGGAI
	extension	tar.gz
	pkgurl		pkg:cpan/HAGGAI/Acme-Base64@v0.0.2
