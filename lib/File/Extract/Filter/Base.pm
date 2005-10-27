# $Id: Base.pm 5 2005-10-26 16:51:24Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

package File::Extract::Filter::Base;
use strict;

sub filter { Carp::croak(__PACKAGE__ . '::filter() is not defined') }

1;
