{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./pandoc-run-filter {}
