{prev, ...}: [
    (pyfinal: pyprev: {
        cffi = pyprev.cffi.overridePythonAttrs(old: {
            doCheck = old.doCheck && !prev.stdenv.isDarwin;
        });
        pandoc-run-filter = pyfinal.callPackage ./pandoc-run-filter {};
    })
]