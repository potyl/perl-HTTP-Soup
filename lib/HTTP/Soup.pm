package HTTP::Soup;

=head1 NAME

HTTP::Soup - HTTP client/server library for GNOME

=head1 SYNOPSIS

	use HTTP::Soup;

=head1 DESCRIPTION

Soup consists of the Perl bindings for the C library libsoup which HTTP
client/server library for GNOME.

For more information about libsoup see:
L<http://live.gnome.org/LibSoup>.

=cut

use warnings;
use strict;

use Glib::Object::Introspection;


our $VERSION = '0.01';


Glib::Object::Introspection->setup(
	basename => 'Soup',
	version  => '2.4',
	package  => __PACKAGE__,
);


1;


=head1 AUTHORS

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by Emmanuel Rodriguez.

This library is free software; you can redistribute it and/or modify
it under the same terms of:

=over 4

=item the GNU Lesser General Public License, version 2.1; or

=item the Artistic License, version 2.0.

=back

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

You should have received a copy of the GNU Library General Public
License along with this module; if not, see L<http://www.gnu.org/licenses/>.

For the terms of The Artistic License, see L<perlartistic>.

=cut
