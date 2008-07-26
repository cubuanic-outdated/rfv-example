# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'RFV';
all_from 'lib/RFV.pm';

requires 'Catalyst::Runtime' => '5.7014';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::FormValidator::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'YAML';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
