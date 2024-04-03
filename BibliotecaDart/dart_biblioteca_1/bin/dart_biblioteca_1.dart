import 'dart:core';

class Libro {
  String titulo;
  String autor;
  String iSBN;
  String genero;
  bool disponible;

  Libro(this.titulo, this.autor, this.iSBN, this.genero, {this.disponible = true});
}

class Usuario {
  String nombre;
  String correoElectronico;
  List<Libro> librosPrestados = [];

  Usuario(this.nombre, this.correoElectronico);
}

class Biblioteca {
  List<Libro> libros = [];
  List<Usuario> usuarios = [];

  void addLibro(Libro libro) {
    libros.add(libro);
  }

  void eliminarLibro(Libro libro) {
    libros.remove(libro);
  }

  void registrarUsuario(Usuario usuario) {
    usuarios.add(usuario);
  }

  void prestarLibro(Libro libro, Usuario usuario) {
    if (libro.disponible) {
      libro.disponible = false;
      usuario.librosPrestados.add(libro);
      print('El libro "${libro.titulo}" ha sido prestado a ${usuario.nombre}');
    } else {
      print('Lo siento, el libro "${libro.titulo}" no está disponible en este momento.');
    }
  }

  void aceptarDevolucion(Libro libro, Usuario usuario) {
    if (usuario.librosPrestados.contains(libro)) {
      libro.disponible = true;
      usuario.librosPrestados.remove(libro);
      print('El libro "${libro.titulo}" ha sido devuelto correctamente.');
    } else {
      print('El usuario ${usuario.nombre} no tiene prestado el libro "${libro.titulo}".');
    }
  }
}

void main() {
  var biblioteca = Biblioteca();

  var libro1 = Libro('El Señor de los Anillos', 'J.R.R. Tolkien', '978-84-450-7409-6', 'Fantasía');
  var libro2 = Libro('Cien años de soledad', 'Gabriel García Márquez', '978-84-9759-015-0', 'Realismo mágico');
  var libro3 = Libro('Las 48 leyes del poder', 'Robert Greene', '978-0-451-52493-5', 'Educativo');

  biblioteca.addLibro(libro1);
  biblioteca.addLibro(libro2);
  biblioteca.addLibro(libro3);

  var usuario1 = Usuario('David', 'David@gmail.com');
  var usuario2 = Usuario('Felix', 'felix@gmail.com');

  biblioteca.registrarUsuario(usuario1);
  biblioteca.registrarUsuario(usuario2);

  biblioteca.prestarLibro(libro1, usuario1);
  biblioteca.prestarLibro(libro2, usuario2);
  biblioteca.prestarLibro(libro3, usuario1); 

  biblioteca.aceptarDevolucion(libro2, usuario2);
  biblioteca.aceptarDevolucion(libro3, usuario2); 

  print('Libros disponibles en la biblioteca:');
  for (var libro in biblioteca.libros) {
    if (libro.disponible) {
      print('${libro.titulo} - ${libro.autor}');
    }
  }

  print('Libros prestados por los usuarios:');
  for (var usuario in biblioteca.usuarios) {
    print('Usuario: ${usuario.nombre}');
    for (var libro in usuario.librosPrestados) {
      print('- ${libro.titulo} (${libro.autor})');
    }
   }
  }
