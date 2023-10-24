let vacia = {
    esVacia: function () { return true },
    cons: function (o) {
        let res = Object.create(this);
        res.esVacia = function () { return false };
        res.head = function () { return o };
        res.tail = function () { return Object.getPrototypeOf(this) };
        return res;
    }
}

vacia.longitud = function () { return (this.esVacia() ? 0 : 1 + this.tail().longitud()); }
vacia.toString = function () { return (this.esVacia() ? "[]" : this.head() + ":" + this.tail().toString()); }

const lista12 = vacia.cons(2).cons(1);

String.prototype.head = function () { return this[0]; };
String.prototype.tail = function () { return this.substring(1); };

function Trie(esFinal, hijos) {
    this.esFinal = esFinal;
    this.hijos = hijos;
}

Trie.prototype.contienePalabra = function (palabra) {
    if (palabra == "") {
        return this.esFinal;
    }
    const hijo = this.hijos[palabra.head()];
    return (hijo !== undefined) && hijo.contienePalabra(palabra.tail());
}

Trie.prototype.agregarHijo = function (etiqueta, hijo) {
    let hijos = Object.assign({}, this.hijos);
    hijos[etiqueta] = hijo;
    this.hijos = hijos;
}
/*
Version alternativa:
Trie.prototype.agregarHijo = function(etiqueta, hijo) {
    this.hijos = {...this.hijos};
    this.hijos[etiqueta] = hijo;
}
*/

function InfiniteSequence() {
    this.val = 1;
}

InfiniteSequence.prototype.next = function () {
    let res = Object.create(this);
    res.val += 1;
    return res;
}
/*
Version alternativa:
InfiniteSequence.prototype.next = function() {
    let res = new InfiniteSequence();
    res.val = this.val+1;
    return res;
}
*/

function OneTwoFunction(f) {
    this.f = f;
}

OneTwoFunction.prototype.apply = function (x, y) {
    if (y !== undefined) {
        return this.f(x, y);
    }
    else {
        return c => this.f(x, c); //Ojo que el this anda porque es una lambda.
    }
}

function calcularResultado() {

    let o1 = { m1: function () { return 0; }, m2: function () { return 1; } }
    let o2 = Object.create(o1);
    o2.m1 = function () { return 2; };
    o2.m2 = function () { return Object.getPrototypeOf(this).m1(); };
    let o3 = Object.create(o2);


    let res = "";
    res += o3.m2();

    res += "<br>La longitud de la lista vacÃ­a es " + vacia.longitud();
    res += "<br>La longitud de la lista " + lista12.tail().toString() + " es " + lista12.tail().longitud();
    res += "<br>La longitud de la lista " + lista12.toString() + " es " + lista12.longitud();

    let trieFinal = new Trie(true, {});
    let trieASalSolAla = new Trie(false, {
        a: new Trie(true, { l: new Trie(false, { a: trieFinal }) }),
        s: new Trie(false, { a: new Trie(false, { l: trieFinal }), o: new Trie(false, { l: trieFinal }) })
    });
    res += "<br>" + trieASalSolAla.contienePalabra("a");
    res += "<br>" + trieASalSolAla.contienePalabra("sal");
    res += "<br>" + trieASalSolAla.contienePalabra("sol");
    res += "<br>" + trieASalSolAla.contienePalabra("ala");
    res += "<br>" + !trieASalSolAla.contienePalabra("al");
    res += "<br>" + !trieASalSolAla.contienePalabra("sa");
    res += "<br>" + !trieASalSolAla.contienePalabra("");
    res += "<br>" + trieFinal.contienePalabra("");

    let trieAYSalSolAlAla = Object.create(trieASalSolAla);
    trieAYSalSolAlAla.agregarHijo("y", trieFinal);
    trieAYSalSolAlAla.agregarHijo("a", new Trie(true, { l: new Trie(true, { a: trieFinal }) }));
    res += "<br>" + !trieASalSolAla.contienePalabra("al");
    res += "<br>" + !trieASalSolAla.contienePalabra("y");
    res += "<br>" + trieAYSalSolAlAla.contienePalabra("a");
    res += "<br>" + trieAYSalSolAlAla.contienePalabra("y");
    res += "<br>" + trieAYSalSolAlAla.contienePalabra("sal");
    res += "<br>" + trieAYSalSolAlAla.contienePalabra("sol");
    res += "<br>" + trieAYSalSolAlAla.contienePalabra("ala");
    res += "<br>" + trieAYSalSolAlAla.contienePalabra("al");

    let is = new InfiniteSequence();
    res += "<br>" + is.val;
    res += "<br>" + is.next().val;
    res += "<br>" + is.next().next().val;
    res += "<br>" + is.next().next().next().val;
    res += "<br>" + is.next().next().next().next().val;
    let f = new OneTwoFunction((x, y) => x + y);
    res += "<br>1 + 1 = " + f.apply(1, 1);
    res += "<br>2 + 3 = " + f.apply(2)(3);
    return res;
}