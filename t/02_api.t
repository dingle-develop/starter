################################################################################
# test dIngle::Project::Starter
################################################################################
; use lib 't/lib'
; use strict; use warnings
; use Test::dIngle::Light
; use Test::ClassAPI

; use dIngle::Project
; use dIngle::Project::Starter

# Execute the tests
; Test::ClassAPI->execute('complete');

__DATA__

HO::class                = interface
dIngle::Plan             = abstract
dIngle::Project::Starter = class

[HO::class]
new = method

[dIngle::Plan]
HO::class     = implements
init          = method
project       = method
plan          = method 
work          = method
load_plan     = method

[dIngle::Project::Starter]
dIngle::Plan = isa
import         = method
module_sorter  = method
setup          = method
start          = method
write_status   = method
