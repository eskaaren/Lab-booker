package LabBooker;
use Mojo::Base 'Mojolicious';
use DBI;

# Database
has dbh => sub {
  my $self = shift;
  my $dbfile = $self->app->home->rel_file("lib/LabBooker/Model/lbooker.sqlite");

  my $data_source = "dbi:SQLite:database=$dbfile";

  my $dbh = DBI->connect($data_source, '', '');

  return $dbh;
};

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  # Query database and return all records
  $r->get('/q/all')->to('queries#all');

  # return records for user
  $r->get('/q/user/:id')->to('queries#user');
}

1;
