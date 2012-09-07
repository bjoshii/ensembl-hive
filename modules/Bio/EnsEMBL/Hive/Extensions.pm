#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=pod 

=head1 NAME

  Bio::EnsEMBL::Hive::Extensions

=head1 SYNOPSIS

  Performs method injection into (mainly) ensembl-core classes

=head1 DESCRIPTION

=head1 CONTACT

  Please contact ehive-users@ebi.ac.uk mailing list with questions/suggestions.

=head1 APPENDIX

  The rest of the documentation details each of the object methods. 
  Internal methods are usually preceded with a _

=cut


use strict;

#use Bio::EnsEMBL::Utils::Exception;
#use Bio::EnsEMBL::Analysis;
use Bio::EnsEMBL::DBSQL::DBConnection;
#use Bio::EnsEMBL::Hive::URLFactory;


=head2 Bio::EnsEMBL::DBSQL::DBConnection::url

  Arg [1]    : none
  Example    : $url = $dbc->url;
  Description: Constructs a URL string for this database connection. Follows
               the format defined for FTP urls and adopted by
               
  Returntype : string of format  mysql://<user>:<pass>@<host>:<port>/<dbname>
  Exceptions : none
  Caller     : general

=cut

sub Bio::EnsEMBL::DBSQL::DBConnection::url {
  my $self = shift;

  return undef unless($self->driver and $self->dbname);

  my $url = $self->driver . '://';

  if($self->username) {
    $url .= $self->username;
    $url .= ":".$self->password if($self->password);
    $url .= "@";
  }
  if($self->host) {
    $url .= $self->host;
    if($self->port) {
        $url .= ':'.$self->port;
    }
  }
  $url .= '/' . $self->dbname;

  return $url;
}


#######################################
# extensions to
# Bio::EnsEMBL::Pipeline::RunnableDB
#######################################

sub Bio::EnsEMBL::Pipeline::RunnableDB::debug {
  my $self = shift;
  $self->{'_debug'} = shift if(@_);
  $self->{'_debug'}=0 unless(defined($self->{'_debug'}));  
  return $self->{'_debug'};
}

#######################################
# extensions to
# Bio::EnsEMBL::Analysis::RunnableDB
#######################################

sub Bio::EnsEMBL::Analysis::RunnableDB::debug {
  my $self = shift;
  $self->{'_debug'} = shift if(@_);
  $self->{'_debug'}=0 unless(defined($self->{'_debug'}));  
  return $self->{'_debug'};
}

 
1;

