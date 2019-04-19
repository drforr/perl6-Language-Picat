NAME
====

Language::Picat - Learn Perl 6 Grammars in github

SYNOPSIS
========

```perl6
use Language::Picat::Grammar;

my $fh = open 'picat-sample.pi', :r;
say Language::Picat::Grammar.new.parse( $fh.slurp );
```

DESCRIPTION
===========

The important thing here isn't so much the language, but the commit log.
Go back to the very first commit, and read about the process of language
design. You'll also wamt to read
[http://www.theperlfisher.blogspot.com](The Perl Fisher) for an idea of the
technique I'm using, and have largely developed on my own.

It's not fully-featured by any means, and some of the commit logs are purposely
broken, because I want to show both the easy stuff and the times when I
make mistakes and paint myself into corners.

AUTHOR
======

Jeffrey Goff <jgoff@cpan.org>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 Jeffrey Goff

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

