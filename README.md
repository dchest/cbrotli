cbrotli without libbrotli
=========================

This package re-packages the official C-Brotli CGO bindings
<https://github.com/google/brotli/tree/master/go/cbrotli>
into a package that needs no separate libbrotli{common|enc|dec}.

It's produced by the script make-cbrotli.sh.
