
use strict;
use warnings;

 BEGIN { require 5.008; } 

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::App::Command::cover',
                       'DISTNAME' => 'Dist-Zilla-App-Command-cover',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Marcel Gruenauer <marcel@cpan.org>',
                       'BUILD_REQUIRES' => {
                                             'Test::More' => '0.94',
                                             'Scalar::Util' => '0',
                                             'English' => '0',
                                             'File::Find' => '0',
                                             'Carp' => '0'
                                           },
                       'ABSTRACT' => 'Code coverage metrics for your distribution',
                       'EXE_FILES' => [],
                       'VERSION' => '1.101000',
                       'PREREQ_PM' => {
                                        'Dist::Zilla::App' => '0',
                                        'File::Temp' => '0',
                                        'Path::Class' => '0',
                                        'File::chdir' => '0',
                                        'Devel::Cover' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{BUILD_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.56) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



