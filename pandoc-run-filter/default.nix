{ buildPythonPackage,
  fetchFromGitHub,
  lib,
  pandocfilters,
  psutil,
  setuptools
}:

buildPythonPackage rec {
  pname = "pandoc-run-filter";
  version = "0.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "johnlwhiteman";
    repo = pname;
    rev = version;
    hash = "sha256-beiGvN0DS6s8wFjcDKozDuwAM2OApX3lTRaUDRUqLeU=";
  };

  nativeBuildInputs = [ setuptools ];

  pythonRelaxDeps = [ "psutil" ];

  propagatedBuildInputs = [
    pandocfilters
    psutil
  ];

  pythonImportsCheck = [ "pandocrunfilter" ];

  doCheck = false;

  meta = with lib; {
    description = "A simple filter for pandoc that runs commands and scripts capturing the output as images or text.";
    homepage = "https://github.com/johnlwhiteman/pandoc-run-filter";
    license = licenses.bsd3;
    mainProgram = "pandoc-run-filter";
  };
}
