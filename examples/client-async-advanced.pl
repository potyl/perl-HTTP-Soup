#!/usr/bin/env perl

=head1 NAME

client-async-advanced.pl - Advanced HTTP async client

=head1 SYNOPSIS

client-async-advanced.pl [OPTION]... url...

Where

    --max-connections       the maximum number of connections that the session
                            can open at once.
    --max-conns-per-host    the maximum number of connections that the session
                            can open at once to a given host.
    --help                  print this help message.

Example:

    client-async-advanced.pl http://search.cpan.org

=head1 DESCRIPTION

Sample program that fetches URLs asynchronously, multiple URLs are downloaded
simultaneously with a single process.

=cut

use strict;
use warnings;

use Pod::Usage;
use Getopt::Long qw(:config auto_help);

use HTTP::Soup;
use Glib;


# Schedule downloads while the queue $ctx->{urls} is not empty.
sub schedule_download {
    my ($ctx) = @_;
    my $urls = $ctx->{urls};
    my $url = shift @$urls or return;

    my $id = $ctx->{id};
    my $pending = $ctx->{pending};
    $pending->{$id} = $url;
    my $pending_count = keys %$pending;

    print "[$id] Downloading $url; pending $pending_count\n";
    my $message = HTTP::Soup::Message->new(GET => $url);

    # Schedule a download
    my $session = $ctx->{session};
    $session->queue_message($message, sub {
        # Called when a download is completed
        my ($session, $message) = @_;
        delete $pending->{$id};
        my $pending_count = keys %$pending;
        print "[$id] Got url $url; pending: $pending_count\n";

        if (@$urls) {
            schedule_download($ctx);
        }
        elsif ($pending_count == 0) {
            # No more urls and this was the last url to downlaod
            print "[$id] End program\n";
            my $loop = $ctx->{loop};
            $loop->quit();
        }
    });
}


sub main {
    GetOptions(
        'max-connections=i'      => \my $max_conns,
        'max-conns-per-host=i'   => \my $max_conns_per_host,
    ) or pod2usage(1);
    
    my @urls;
    if (@ARGV) {
        @urls = @ARGV;
    }
    else {
        @urls = qw(
            http://www.google.com/
            http://www.amazon.com/
            http://search.cpan.org/
            http://www.reddit.com/
            http://www.microsoft.com/
            http://www.hp.com/
            http://www.ibm.com/
        );
    }

    my $session = HTTP::Soup::SessionAsync->new();    

    #The maximum number of connections that the session can open at once
    $session->set('max-conns', $max_conns) if $max_conns;
    $max_conns = $session->get('max-conns');

    #The maximum number of connections that the session can open at once to a given host
    $session->set('max-conns-per-host', $max_conns_per_host) if $max_conns_per_host;
    $max_conns_per_host = $session->get('max-conns');


    my $loop = Glib::MainLoop->new();

    # Hash of id => url used to track how many URLs we have pending
    my %pending;

    # Start X async downloads, we fetch X urls simultaneously
    foreach my $id (1 .. $max_conns) {
        my $ctx = {
            session => $session,
            urls    => \@urls,
            pending => \%pending,
            loop    => $loop,
            id      => $id,
        };
        schedule_download($ctx);
    }

    # Run an event loop
    $loop->run();

    return 0;
}


exit main() unless caller;
