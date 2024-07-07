import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor {

  type Piloto = {
    id: Text;
    firstName: Text;
    lastName: Text;
    licencia: Text;
    examenMedico: Bool;
    vigenciaExamen: Text;
  };

  let pilotos = HashMap.HashMap<Text, Piloto>(5, Text.equal, Text.hash);

// leer 
 public query func getPiloto(firstName: Text): async ?Piloto{
   return pilotos.get(firstName);
 };


//crear 
 public func setPiloto( id:Text,firstName: Text,lastName: Text,licencia: Text,examenMedico: Bool, vigenciaExamen: Text): async (){
   let newPiloto : Piloto ={
     id = id;
     firstName= firstName;
    lastName= lastName;
    licencia= licencia;
    examenMedico= examenMedico;
    vigenciaExamen= vigenciaExamen;
   };
   pilotos.put(id,newPiloto);
 };

    // Método para eliminar un piloto por índice
  public func deletePiloto(index: Text): async ?Piloto {
    return pilotos.remove(index);
  };

  // Método para listar todos los pilotos
  public query func listPilotos(): async  [(Text, Piloto)] {
    let iter : Iter.Iter<(Text, Piloto)> = pilotos.entries();
    Iter.toArray<(Text, Piloto)>(iter);  
  };

};