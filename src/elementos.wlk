import plagas.*

class Hogar {
	var nivelDeMugre
	var comfort
	
	method esBueno() = nivelDeMugre <= comfort / 2
	method recibirAtaqueDe(unaPlaga) {
		nivelDeMugre += unaPlaga.nivelDeDanio()
	}
}

class Huerta {
	var capacidadDeProduccion
	var nivelDeProduccion
	
	method esBueno() = capacidadDeProduccion > nivelDeProduccion
	method recibirAtaqueDe(unaPlaga) {
		capacidadDeProduccion = 0.max(capacidadDeProduccion - unaPlaga.nivelDeDanio() * 0.1)
		if(unaPlaga.transmiteEnfermedades()) {
			capacidadDeProduccion = 0.max(capacidadDeProduccion - 10)
		}
	}
}

class Mascota {
	var nivelDeSalud
	
	method esBueno() = nivelDeSalud >= 250
	method recibirAtaqueDe(unaPlaga) {
		if(unaPlaga.transmiteEnfermedades()) {
			nivelDeSalud = 0.max(nivelDeSalud - unaPlaga.nivelDeDanio())
		}
	}
}

class Barrio {
	const elementos = []
	
	method agregarElemento(unElemento) {elementos.add(unElemento)}
	method sacarElemento(unElemento) {elementos.remove(unElemento)}
	method cantidadDeElementos() = elementos.size()
	method elementosBuenos() = elementos.filter({e => e.esBueno()})
	method esBueno(unElemento) {
		if(!elementos.contains(unElemento)) {
			self.error("El elemento no está en la lista de elementos")
		}
		else {	
			unElemento.esBueno()
		}
	}
	
	method esCopado() = self.cantidadDeElementos() - self.elementosBuenos().size() < 0
}