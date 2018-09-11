  package dIngle::Project::Starter
# ********************************
; our $VERSION = '0.02'
# *********************

; use dIngle::Project ()
; use Package::Subroutine ()

; use Carp ()
; use File::Path ()

; use subs qw/init start/

; use parent 'dIngle::Plan'

; sub init
    { my ($self) = @_
    ; $self->project(dIngle::Project->new('dingle-starter'))
    ; dIngle::Waypoint::Init->project($self->project)
    ; $self
    }

; sub import
    { my $self = shift
    ; $self->setup(@_)
    }

; sub setup
    { dIngle::Project->can('start') or do {
          Package::Subroutine->export_to('dIngle::Project')
            ->('_' => qw/start/)
      }
    }

; sub start
    { my ($project,$builder) = @_
    ; my $basedir = $project->basedir or do
      { Carp::croak("Project '$project' has no basedir specified.")
      }
      ; -d $basedir or File::Path::mkpath($basedir) or do
        { Carp::croak("Can't create directory '$basedir'.")
      }

    ; unless(defined $builder)
        { $builder = new dIngle::Project::Starter::
        }
      elsif(!ref $builder)
        { $builder = $builder->new
        }
    ; $builder->plan($project)
    ; $builder->work

    ; $project
    }

; sub work
    { my ($self) = @_
    ; $self->project->modules->sort_modules($self->module_sorter)
    # register starter public
    ; dIngle->project($self->project,my $starter)
    ; foreach my $mod ($self->project->list_modules)
        {
        ; print "Modul $mod\n"
        ; my $gen = dIngle::Generator->new(module => $mod)
        ; $gen->build_module()
        ; $color = $gen->has_errors() ? "red" : "green"
        ; write_status($gen->module,$color)
        }
    }

; sub module_sorter
    { return sub
        { my @modules = @{shift()}
        }
    }


; sub _root_dirs
    { qw/bin config lib t/
    }

; sub write_status
    { my ($module,$color) = @_
    ; warn "$module $color\n"
    }

; 1

__END__

=head1 NAME

dIngle::Project::Starter

=head1 SYNOPSIS

  use dIngle::Project::Starter;
  $project->start;

=head1 DESCRPTION

The purpose of this modue is to initialize a fresh project. It exports the
C<start> method into the dIngle::Project namespace. This method creates
a new project with the given name in the given directory. On success it
returns the project object and croaks if it fails.

=head1 BUGS

Hopefully avoided.

=head1 AUTHOR

Sebastian Knapp <rock@ccls-online.de>

=head1 LICENSE

This Software is licensed under the same terms as perl itself.

=cut
