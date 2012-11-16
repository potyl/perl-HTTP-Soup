#!/usr/bin/env perl

use strict;
use warnings;

use HTTP::Soup;
use Glib;

sub main {
    my @urls = qw(
        http://www.google.com/
        http://www.amazon.com/
        http://search.cpan.org/
        http://www.reddit.com/
        http://www.microsoft.com/
        http://www.hp.com/
        http://www.ibm.com/
    );

    my $session = HTTP::Soup::SessionAsync->new();
    my $loop = Glib::MainLoop->new();

    my $count = 0;
    foreach my $url (@urls) {
        my $message = HTTP::Soup::Message->new(GET => $url);
        ++$count;
        $session->queue_message($message, sub {
            my ($session, $message) = @_;
            
            my $body = $message->get('response-body');
            printf "Url $url has %s bytes\n", length($body->data);
            --$count;

            if ($count == 0) {
                print "Downloaded all URLS\n";
                $loop->quit();
            }
        });
    }

    # Run an event loop
    $loop->run();

    return 0;
}


exit main() unless caller;
