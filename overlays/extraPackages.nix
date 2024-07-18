{ self, ... } :
final: prev : {
    python3Extra =  self.packages.${prev.system}.python3Extra;
}
