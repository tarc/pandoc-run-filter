{ python3Packages,
  fetchFromGitHub,
  lib
}: with python3Packages;

buildPythonPackage rec {
  pname = "pandoc-run-filter";
  version = "0.2.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-hFc3E3jE6ypEtEeFyHHI8meZRGGnJmabakDUm+LRy1o=";
  };

  nativeBuildInputs = [ setuptools pytest pyfiglet ];

  propagatedBuildInputs = [
    pandocfilters
    psutil
    pillow
  ];

  doCheck = false;

  meta = with lib; {
    description = "A simple filter for pandoc that runs commands and scripts capturing the output as images or text.";
    homepage = "https://github.com/johnlwhiteman/pandoc-run-filter";
    license = licenses.bsd3;
    mainProgram = "pandoc-run-filter";
  };
}
