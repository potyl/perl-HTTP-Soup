use strict;
use warnings;

use ExtUtils::MakeMaker;

use Cwd;
use File::Spec;
use Data::Dumper;


sub main {
	# Create the Makefile
	my @args = (
		AUTHOR        => 'Emmanuel Rodriguez <potyl@cpan.org>',
		NAME          => 'HTTP::Soup',
		VERSION_FROM  => File::Spec->catfile('lib', 'HTTP', 'Soup.pm'),
		ABSTRACT_FROM => File::Spec->catfile('lib', 'HTTP', 'Soup.pm'),
		LICENSE       => 'perl, lgpl',

		PREREQ_PM     => {
			'Glib::Object::Introspection' => 0,
		},
		PREREQ_FATAL  => 1,
	);
	WriteMakefile(@args);


	return 0;
}


exit main() unless caller;

