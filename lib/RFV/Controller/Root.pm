package RFV::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller::BindLex';
use FormValidator::Simple;

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';
__PACKAGE__->config->{unsafe_bindlex_ok} = 1;

=head1 NAME

RFV::Controller::Root - Root Controller for RFV

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

Load main application template.

=cut

sub index : Private {
    my ( $self, $c ) = @_;
    my $template : Stashed = 'site/index.tpl';
}

=head2 save

"Save" form fields.

=cut

sub save : Global {
    my ( $self, $c ) = @_;

    $c->form(
        first   => [ qw/NOT_BLANK ASCII/ => [qw/LENGTH 2 20/] ],
        last    => [ qw/NOT_BLANK ASCII/ => [qw/LENGTH 2 20/] ],
        company => [ qw/NOT_BLANK ASCII/ => [qw/LENGTH 2 20/] ],
        email   => [qw/NOT_BLANK EMAIL_LOOSE/],
    );

    my $json : Stashed = {
        error   => $c->form->field_messages('save'),
    };
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;

    my $json : Stashed;
    if (    defined $c->req->header('x-requested-with')
        and $c->req->header('x-requested-with') eq 'XMLHttpRequest'
        and not $c->res->body
        and not defined $c->stash->{template} )
    {
        $json->{success} ||= 'true';
        $c->detach('View::JSON');
    }
}

=head1 AUTHOR

Johannes Plunien

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
