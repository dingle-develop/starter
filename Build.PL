#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Module::Build;

my $builder = Module::Build->new(
     module_name => 'dIngle::Project::Starter',
     dist_version => '0.01001',
     dist_author => [
	     'Mike Würfel <sknpp@cpan.org>'
     ],
     license => 'perl',
     dist_abstract => 'a module which starts a dIngle project',
     requires => {
          'perl' => '5.12.0'
     },
     build_requires => {
          'Test::ClassAPI' => ''
     }
);

$builder->create_build_script();
