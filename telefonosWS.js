const config = require("./src/config");
const sql = require("mssql");

async function getTelefonos() {
  try {
    let pool = await sql.connect(conexion);
    let salida = await pool.request().query("select * from telefono");
    return salida.recordsets;
  } catch (err) {
    console.log(err);
  }
}

async function getTelefono(idTelefono) {
    try {
      let pool = await sql.connect(conexion);
      let salida = await pool.request()
      .input('idTelefono',sql.Int,idTelefono)
      .query("select * from telefono where idtelefono= @idTelefono");
      return salida.recordsets;
    } catch (err) {
      console.log(err);
    }
  }

async function newTelefono(telefono) {
  try {
    let pool = await sql.connect(conexion);
    let newTelefono = await pool
      .request()
      .input("nombre", sql.VarChar, telefono.nombre)
      .input("bateria", sql.Int, telefono.bateria)
      .execute("newTelefono");
    return newTelefono.recordsets;
  } catch (err) {
    throw new Error("Se presento un error al insertar telefono");
  }
}

async function upTelefono(telefono) {
  try {
    let pool = await sql.connect(conexion);
    let newTelefono = await pool
      .request()
      .input("nombre", sql.VarChar, telefono.nombre)
      .input("bateria", sql.Int, telefono.bateria)
      .input("idTelefono", sql.Int, telefono.idTelefono)
      .execute("updateTelefono");
    return newTelefono.recordsets;
  } catch (err) {
    throw new Error("Se presento un error al actualizar telefono");
  }
}

async function delTelefono(telefono) {
    try {
      let pool = await sql.connect(conexion);
      let newTelefono = await pool
        .request()
        .input("idTelefono", sql.Int, telefono.idTelefono)
        .execute("deleteTelefono");
      return newTelefono.recordsets;
    } catch (err) {
      throw new Error("Se presento un error al eliminar telefono");
    }
  }

module.exports = {
  getTelefonos: getTelefonos,
  getTelefono: getTelefono,
  newTelefono: newTelefono,
  upTelefono: upTelefono,
  delTelefono: delTelefono
};
