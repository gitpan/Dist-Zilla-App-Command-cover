use 5.008;
use strict;
use warnings;

package Dist::Zilla::App::Command::cover;
BEGIN {
  $Dist::Zilla::App::Command::cover::VERSION = '1.101000';
}

# ABSTRACT: Code coverage metrics for your distribution
use Dist::Zilla::App -command;
use File::Temp;
use Path::Class;
use File::chdir;
sub abstract { "code coverage metrics for your distribution" }

sub execute {
    my $self = shift;
    local $ENV{HARNESS_PERL_SWITCHES} = '-MDevel::Cover';
    my @cover_command = @ARGV;

    # adapted from the 'test' command
    my $zilla = $self->zilla;
    my $build_root = Path::Class::dir('.build');
    $build_root->mkpath unless -d $build_root;
    my $target = Path::Class::dir(File::Temp::tempdir(DIR => $build_root));
    $self->log("building test distribution under $target");

    # Don't run author and release tests during code coverage.
    # local $ENV{AUTHOR_TESTING}  = 1;
    # local $ENV{RELEASE_TESTING} = 1;

    $zilla->ensure_built_in($target);
    $self->zilla->run_tests_in($target);

    $self->log(join ' ' => @cover_command);
    local $CWD = $target;
    system @cover_command;
    $self->log("leaving $target intact");
}
1;


__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::cover - Code coverage metrics for your distribution

=head1 VERSION

version 1.101000

=head1 SYNOPSIS

    # dzil cover -outputdir /my/dir

=head1 DESCRIPTION

This is a command plugin for L<Dist::Zilla>. It provides the C<cover> command,
which generates code coverage metrics for your distribution using
L<Devel::Cover>.

If there were any test errors, the C<cover> command won't be run. Author and
release tests are not run since they should not be counted against code
coverage. Any additional command-line arguments are passed to the C<cover>
command.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-App-Command-cover>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see
L<http://search.cpan.org/dist/Dist-Zilla-App-Command-cover/>.

=head1 AUTHOR

  Marcel Gruenauer <marcel@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

