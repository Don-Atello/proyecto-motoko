import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor {

  type Avion = {
    id: Text;
    matricula: Text;
    empresa: Text;
    modelo: Text;
    motor: Text;
    horasVueloFuselaje: Text;
    horasVueloMotores: Text;
    costo:Int;
    observaciones : Text; 
  };

let aviones = HashMap.HashMap<Text, Avion>(5, Text.equal, Text.hash);

// leer estudiante
 public query func getAvion(matricula: Text): async ?Avion{
   return aviones.get(matricula);
 };


//crear 
 public func setAvion( id:Text,empresa: Text,modelo: Text,matricula: Text, motor: Text, horasVueloFuselaje: Text, horasVueloMotores: Text, costo: Int, observaciones: Text): async (){
   let newAvion : Avion ={
     id = id;
     empresa= empresa;
    modelo= modelo;
    matricula= matricula;
    motor= motor;
    horasVueloFuselaje = horasVueloFuselaje;
    horasVueloMotores = horasVueloMotores;
    costo = costo;
    observaciones = observaciones; 
   };
   aviones.put(matricula,newAvion);
 };

    // Método para eliminar un estudiante por índice
  public func deleteAvion(index: Text): async ?Avion {
    return aviones.remove(index);
  };

  // Método para listar todos los estudiantes
  public query func listAviones(): async  [(Text, Avion)] {
    let iter : Iter.Iter<(Text, Avion)> = aviones.entries();
    Iter.toArray<(Text, Avion)>(iter);  
  };

};