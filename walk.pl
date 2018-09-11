#!/usr/bin/perl
; $walk::VERSION = '0.01'
# ***********************
; use strict; use warnings; use utf8

; use lib 'lib/'

; use dIngle::Application
; use Cwd qw/getcwd/
; use File::chdir
; use Data::Dumper
; use File::Spec ()
; use dIngle
; use Getopt::Std::Strict 'P:B:rhL'

; die <<__USAGE__
$0 [-P projectname] [-B project basedir]
  -L -- use log4perl for logging
  -r -- (re)initialize project
  -h -- this help
__USAGE__
  if $OPT{h}

; BEGIN
    { $dIngle::LOGGING    = 'Log::Log4Perl' if $OPT{'L'}
    }

; use dIngle::Project

; my $project_name = $OPT{'P'} || do { local $_ = $0; s/\..*//; $_ }
; my $base_dir = $OPT{'B'} || File::Spec->catdir(getcwd(), 'scheme',$project_name)

; my ($project)

; $project = new dIngle::Project::($project_name)
; $project->basedir($project_name =~ /^dingle/ ? getcwd() : $base_dir)

; print "new project basedir: " . $project->basedir, "\n"

; eval 
    { local $CWD = $project->basedir 
    ; $project->load_config
    ; $project->load_modules
    }
; if($@)
    {
    ; require dIngle::Starter::Plan
    ; my $plan = dIngle::Starter::Plan->new
    ; $plan->plan($project)
    ; print "Start " . $plan->project . "\n";
    ; $plan->work
    }

; print $project->name . "\n"
; print $project->configuration->instance , "\n"
; print "".$project->namespace , "\n"

; print "Modules:\n\t", join "\n\t",$project->list_modules

; print "\n"
#; print Dumper($project)

