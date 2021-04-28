// Importación de librerías
import processing.serial.*; // Librería para la comunicación serie
import java.awt.event.KeyEvent; // Librería para la lectura datos del puerto serie
import java.io.IOException; 
  
// Definimos un objeto serial
Serial ser;

// Variables
String datos;
int indice;
int angulo;
int distancia;
float pixDistancia;

void setup(){
  
 size(500,500); // Tamaño de la ventana
 smooth(); // Suavizado de formas
 ser = new Serial(this,Serial.list()[0], 9600); // Inicializamos el objeto Serial, iniciando así la comunicación serie
 ser.bufferUntil('.');  // Leemos los datos del puerto serie hasta el '.'. De esta manera nuestra lectura será: angulo,distancia.
}

void draw(){
  
  noStroke(); // El contorno NO se dibujará
  fill(27,78,113, 4); // Hace el efecto de desvanecimiento
  rect(0, 0, width, height); // Dibujo un Cuadrado que hara de fondo

  // Llama a la funciones que dibujan el radar
  dibujaRadar();
  dibujaBarrido();
  dibujaTexto();
  dibujaObjeto();
}

void dibujaRadar(){
  pushMatrix();
  
  translate(width/2,height-height*0.04); // Mueve el punto de coordenadas de inicio a una nueva posición
  noFill(); // El relleno NO se dibujará
  strokeWeight(2); // Definimos el grosor de la línea de contorno
  stroke(100,255,236); // Definimos el color de la línea de contorno
  
  // Dibujamos los arcos
  arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
  arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
  arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
  arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
  
  // Dibuja las líneas de los ángulos
  line(-width/2,0,width/2,0); // Línea horizontal
  line(0,0,(-width/2)*cos(radians(45)),(-width/2)*sin(radians(45))); // Línea 45º
  line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90))); // Línea 90º
  line(0,0,(-width/2)*cos(radians(135)),(-width/2)*sin(radians(135))); // Línea 135º
  
  popMatrix();
}

void dibujaBarrido(){
  
  pushMatrix();
  
  // Esta línea será mas gruesa, y de un color ligeramente distinto para no confundirla con el contorno del radar
  strokeWeight(8);
  stroke(0,255,240);
  translate(width/2,height-height*0.04); // Mueve el punto de coordenadas de inicio a una nueva posición
  line(0,0,(height-height*0.5)*cos(radians(angulo)),-(height-height*0.5)*sin(radians(angulo))); // Dibuja la línea conforme al ángulo del sensor
  
  popMatrix();
}

void serialEvent (Serial ser){
 // Almacenamos en datos la lectura los datos del puerto serie hasta el '.' 
 datos = ser.readStringUntil('.');
 datos = datos.substring(0,datos.length()-1); // De esta manera borramos el punto final del string

 indice = datos.indexOf(","); // Guardamos el indice donde se encuentra la ',' que separa el ángulo y la distancia

 // Como leemos un string, debemos castear a int
 angulo = int(datos.substring(0, indice)); // Leemos de datos desde la posición 0, hasta la ',', de esta manera obtenemos el ángulo
 distancia = int(datos.substring(indice+1, datos.length())); // Leemos de datos desde delante de la ',' hasta el final, de esta manera obtenemos la distancia
}

void dibujaTexto(){
  pushMatrix();
  
  fill(100,255,236);
  
  // Distancia en cm
  textSize(15);
  text("10cm",width-width*0.3854,height-height*0.043);
  text("20cm",width-width*0.281,height-height*0.043);
  text("30cm",width-width*0.177,height-height*0.043);
  text("40cm",width-width*0.0729,height-height*0.043);
  
  // Titulo
  textSize(25);
  text("Radar de ultrasonido", width/3.95, height-height*0.95);
  
  // Fondo texto ángulo y distancia
  fill(30,90,170);
  noStroke();
  rect(0, height-height*0.9, width, height-height*0.8);
  
  // Valores de angulo y distancia
  fill(100,255,236);
  textSize(20);  
  text("Angulo: " + angulo +" °", width/6, height-height*0.8);
  if(distancia < 41) text("Distancia: "+ distancia + " cm", width/1.75, height-height*0.8); 
  else   text("Distancia:  ", width/1.75, height-height*0.8); 
     
  // Ángulos
  // 45º
  translate((width-width*0.507)+width/2*cos(radians(45)),(height-height*0.068)-width/2*sin(radians(45)));
  rotate(radians(45));
  text("45°",0,0);
  resetMatrix();
  
  // 90º
  translate((width-width*0.525)+width/2*cos(radians(90)),(height-height*0.06)-width/2*sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  
  // 135º
  translate((width-width*0.55)+width/2*cos(radians(135)),(height-height*0.02)-width/2*sin(radians(135)));
  rotate(radians(-45));
  text("135°",0,0);
  resetMatrix();
  
  popMatrix();
}

void dibujaObjeto(){
  pushMatrix();
  
  translate(width/2,height-height*0.04); // Mueve el punto de coordenadas de inicio a una nueva posición
  strokeWeight(8);
  stroke(255,0,0); // Color rojo
  pixDistancia = distancia*((height-height*0.3666)*0.025);
  if(distancia<41){

   line(pixDistancia*cos(radians(angulo)),-pixDistancia*sin(radians(angulo)),(width-width*0.5)*cos(radians(angulo)),-(width-width*0.5)*sin(radians(angulo)));
  } 
 
  popMatrix();
}
