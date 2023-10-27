{ pkgs ? import <nixpkgs> { }
, specialArgs ? { } }:

(pkgs.callPackage ./. specialArgs).overrideAttrs (attrs: { })
