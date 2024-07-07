import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

// Importar los actores existentes
import Piloto "canister:piloto_backend";

import Avion "canister:avion_backend";

actor Operaciones {

  type Piloto = {
    id: Text;
    firstName: Text;
    lastName: Text;
    licencia: Text;
    examenMedico: Bool;
    vigenciaExamen: Text;
  };

  type Avion = {
    id: Text;
    matricula: Text;
    empresa: Text;
    modelo: Text;
    motor: Text;
    horasVueloFuselaje: Text;
    horasVueloMotores: Text;
    costo: Int;
    observaciones: Text;
  };

  type Operacion = {
    id: Text;
    fecha: Text;
    piloto : ?Piloto;
    avion : ?Avion;
    
  };

  // HashMap para almacenar las operaciones
  let operaciones = HashMap.HashMap<Text, Operacion>(5, Text.equal, Text.hash);

  // Método para obtener una operación por su id
  public query func getOperacion(id: Text): async ?Operacion {
    return operaciones.get(id);
  };

// Metodo para ingresar registro
 public func setOperacion( id:Text,fecha: Text, idPiloto: Text, matriculaAvion:Text): async (){
    let obtPiloto = await getPiloto(idPiloto);
    let obtAvion = await getAvion(matriculaAvion);
   let newOperacion : Operacion ={
     id = id;
    fecha = fecha;
    piloto = obtPiloto;
    avion = obtAvion;
   
   };
   operaciones.put(id,newOperacion);
 };
  // Método para eliminar una operación por su id
  public func deleteOperacion(id: Text): async ?Operacion {
    return operaciones.remove(id);
  };

  // Método para listar todas las operaciones
  public query func listOperaciones(): async [(Text, Operacion)] {
    let iter: Iter.Iter<(Text, Operacion)> = operaciones.entries();
    return Iter.toArray<(Text, Operacion)>(iter);
  };

     // Método para obtener un piloto por su id
  public func getPiloto(id: Text): async ?Piloto {
    return await Piloto.getPiloto(id);
  };

  // Método para obtener un avión por su matrícula
  public func getAvion(matricula: Text): async ?Avion {
    return await Avion.getAvion(matricula);
  };
};