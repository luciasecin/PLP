console.log("Hello World!");

// ---------------------------- Ejercicio 1 -------------------------------------------------------------

console.log("----- Ejercicio 1 -----");

let c1i = {r:1, i:1};

console.log("a) c1i = ", c1i);

c1i.sumar = function (sum) {
    this.r += sum.r;
    this.i += sum.i;
}

c1i.sumar(c1i);
console.log("b) Luego de c1i.sumar(c1i), c1i = ", c1i);

c1i.sumar = function (sum) {
    return { r: this.r + sum.r,
             i: this.i + sum.i 
    }
}

console.log("c) c1i.sumar(c1i) = ", c1i.sumar(c1i));
console.log("   c1i = ", c1i);

console.log("d) c1i.sumar(c1i).sumar(c1i) da error");

c1i.sumar = function (sum) {
    return { r: this.r + sum.r,
             i: this.i + sum.i,
             sumar: this.sumar
    }
}

console.log("   Luego de redefinir sumar, c1i.sumar(c1i).sumar(c1i) = ", c1i.sumar(c1i).sumar(c1i));
console.log("   c1i = ", c1i);

let c = c1i.sumar(c1i);
c.restar = function (rest) {
    return {
        r: this.r - rest.r,
        i: this.i - rest.i,
        sumar: this.sumar,
        restar: this.restar
    }
}

console.log("e) c1i.restar(c) no lo entiende porque c1i no tiene restar, c la tiene");

c1i.mostrar = function () {
    return this.r + " + " + this.i + "i";
}

console.log("f) c1i = " + c1i.mostrar());
console.log("   c.mostrar() no funciona porque c est definido como c1i.sumar y eso no devuelve un mostrar\n");

// ---------------------------- Ejercicio 2 -------------------------------------------------------------

console.log("----- Ejercicio 2 -----");

let t = { ite: function (a,b) {return a}, mostrar: function () {return "Verdadero"}};
let f = { ite: function (a, b) { return b }, mostrar: function () {return "Falso"}};

console.log("a) t.ite(2,3) = ", t.ite(2,3));
console.log("   f.ite(2,3) = ", f.ite(2, 3));
console.log("b) t.mostrar() = " + t.mostrar());
console.log("   f.mostrar() = " + f.mostrar());

t.not = function () {return f};
f.not = function () {return t};

t.and = function (b) {return t.ite(b,this)};
f.and = function (b) {return this};

console.log("c) t.not = " + t.not().mostrar());
console.log("   f.not = " + f.not().mostrar());
console.log("   t.and(t) = " + t.and(t).mostrar());
console.log("   t.and(f) = " + t.and(f).mostrar());
console.log("   f.and(t) = " + f.and(t).mostrar());
console.log("   f.and(f) = " + f.and(f).mostrar() + "\n");

// ---------------------------- Ejercicio 3 -------------------------------------------------------------

console.log("----- Ejercicio 3 -----");

let Cero = {esCero: function (){return true},
    succ: function () {
        res = Object.create(this);
        res.esCero = function () {return false};
        res.pred = function () {return Object.getPrototypeOf(this)};
        res.for = function (f) {
            this.pred().for(f);
            f.eval(this);
        }
        return res;
    },
    for: function (f) {}    
}

console.log("a) Cero = ", Cero);
console.log("   Cero.succ() = ", Cero.succ());

Cero.toNumber = function () {
    if (this.esCero()) 
        return 0; 
    else 
        return this.pred().toNumber() + 1;
}

console.log("b) Cero.toNumber() = ", Cero.toNumber());
console.log("   Cero.succ().esCero() = ", Cero.succ().esCero());
console.log("   Cero.succ().pred().esCero() = ", Cero.succ().pred().esCero());
console.log("   Cero.succ().toNumber() = ", Cero.succ().toNumber());
console.log("   Cero.succ().succ().toNumber() = ", Cero.succ().succ().toNumber());

let func = {eval: function (i) {console.log("   Iteracion " + i.toNumber())}};

console.log("c) func.eval(Cero.succ().succ()) = ");
func.eval(Cero.succ().succ());
console.log("   Cero.succ().succ().succ().for(f) = ");
Cero.succ().succ().succ().for(func);
console.log("\n");

// ---------------------------- Ejercicio 4 -------------------------------------------------------------

console.log("----- Ejercicio 4 -----");

let Punto = { new: function (x,y) {
        res = Object.create(this);
        res.mostrar = function () { return Punto.mostrar(x,y) };
        return res;
    }, 
    mostrar : function (x,y) { return "Punto(" + x + "," + y + ")"}
}

let p = Punto.new(1, 2);
console.log("a) " + p.mostrar());
Punto.mostrar = function() { return "unPunto" };
console.log("   " + p.mostrar());

Punto.mostrar = function(x, y) {return "Punto(" + x + "," + y + ")"}

let PuntoColoreado = { new: function (x, y) {
        res = Punto.new(x,y);
        res.color = "rojo"
        res.mostrar = function () {return PuntoColoreado.mostrar(x,y)}
        return res;
    },
    mostrar: function(x, y) {return Punto.mostrar(x,y)}
}

let pp = PuntoColoreado.new(1,2);

console.log("b) " + pp.mostrar());
Punto.mostrar = function () { return "unPunto" };
console.log("   " + pp.mostrar());
PuntoColoreado.mostrar = function () { return "UnPuntoColoreado"};
console.log("   " + pp.mostrar());

PuntoColoreado.constructor = function (x,y,c){
    res = this.new(x,y);
    res.color = c;
    return res;
}

console.log("c) PuntoColoreado.constructor(1,6,rosa).mostrar() = " + PuntoColoreado.constructor(1, 6, "rosa").mostrar());
console.log("   PuntoColoreado.constructor(1,6,rosa).color = " + PuntoColoreado.constructor(1, 6, "rosa").color);

let p1 = Punto.new(1,2);
let pc1 = PuntoColoreado.new(1,2);
Punto.moverX = function (u) {return "moverX " + u};
let p2 = Punto.new(1, 2);
let pc2 = PuntoColoreado.new(1, 2);

console.log("d) p1.moverX(3) = " + p1.moverX(3));
console.log("   pc1.moverX(3) = " + pc1.moverX(3));
console.log("   p2.moverX(3) = " + p2.moverX(3));
console.log("   pc2.moverX(3) = " + pc2.moverX(3) + "\n");

// ---------------------------- Ejercicio 5 -------------------------------------------------------------

console.log("----- Ejercicio 5 -----");

function Punto2(x,y) {
    this.x = x;
    this.y = y;
}

Punto2.prototype.mostrar = function () { return "Punto(" + this.x + "," + this.y + ")" };
Punto2.prototype.moverX = function (u) { this.x += u }

function PuntoColoreado2(x,y,c){
    this.x = x;
    this.y = y;
    this.color = c;
}

PuntoColoreado2.prototype.__proto__= Punto2.prototype;

puntito = new Punto2(3, 4);
puntitoColorido = new PuntoColoreado2(5,6,"rosa");

console.log("puntito = ", puntito);
console.log("puntito.mostrar()", puntito.mostrar());
console.log("puntitoColorido = ", puntitoColorido);
console.log("puntitoColorido.mostrar() = ", puntitoColorido.mostrar());
console.log("puntitoColorido.color() = ", puntitoColorido.color);

puntito.moverX(4);
puntitoColorido.moverX(5);

console.log("puntito movido 4 = ", puntito);
console.log("puntitoColorido movido 2 = ", puntitoColorido);