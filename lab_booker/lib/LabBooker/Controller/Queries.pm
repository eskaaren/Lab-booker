package LabBooker::Controller::Queries;
use Mojo::Base 'Mojolicious::Controller';
use DBI;

# Returns all records from database
sub all {
  my $self = shift;
  my $sth = $self->app->dbh->prepare("select * from environments");
  $sth->execute();
  my $result = get_result($sth);
  $self->render(json => {%$result});
}

# Returns all rows related to specific user
sub user {
  my $self = shift;
  my $user = $self->stash->{id};
  my $sth = $self->app->dbh->prepare("select * from environments where lower(booked_by) = ?");
  $sth->execute($user);
  my $result = get_result($sth);
  $self->render(json => {%$result}); 
}

sub get_result {
  my $sth = shift;
  my $rows =  $sth->fetchall_arrayref;
  my $result = {};
  my $i = 0;
  for my $cols (@$rows) {
      $result->{$i} = $cols;
      $i++;
  }
  return $result;
}

1;
