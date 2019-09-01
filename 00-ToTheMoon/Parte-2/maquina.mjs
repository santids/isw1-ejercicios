
const DUREZA_THRESHOLD_LOW = 0.33;
const POROSIDAD_THRESHOLD_LOW = 0.33;
const DUREZA_THRESHOLD_HIGH = 0.66;
const POROSIDAD_THRESHOLD_HIGH = 0.66;

const TIPOS_DE_SUELO = {
    DuroYCompacto: 'DuroYCompacto',
    BlandoYPoroso: 'BlandoYPoroso',
    ValoresIntermedios: 'ValoresIntermedios'
}

const SENTIDOS = {
    Horario: 'horario',
    AntiHorario: 'anti-horario'
}

const DICCIONARIO_CONFIGURACION = {
    [TIPOS_DE_SUELO.DuroYCompacto]: {
        sentido: SENTIDOS.Horario,
        velocidad: {
            valor: 150,
            unidad: 'rpm'
        },
        tiempo: {
            valor: 10,
            unidad: 'minutos'
        }
    },
    [TIPOS_DE_SUELO.BlandoYPoroso]: {
        sentido: SENTIDOS.AntiHorario,
        velocidad: {
            valor: 100,
            unidad: 'rpm'
        },
        tiempo: {
            valor: 5,
            unidad: 'minutos'
        }
    },
    [TIPOS_DE_SUELO.ValoresIntermedios]: {
        sentido: SENTIDOS.Horario, 
        velocidad: {
            valor: 150,
            unidad: 'rpm'
        },
        velocidad_vuelta: {
            valor: 100,
            unidad: 'rpm' 
        },
        tiempo: {
            valor: 5,
            unidad: 'minutos'
        },
        tiempo_vuelta: {
            valor: 10,
            unidad: 'minutos'
        }
    }
}

const delay = delay => new Promise ( resolve => setTimeout(resolve, delay));


const toMilliSeconds = tiempo => tiempo.valor * 60 * 10;
 
const sentidoInverso = configuracion => ({
    tiempo: configuracion.tiempo_vuelta || configuracion.tiempo,
    velocidad: configuracion.velocidad_vuelta || configuracion.velocidad,
    sentido: configuracion.sentido == SENTIDOS.Horario ? SENTIDOS.AntiHorario : SENTIDOS.Horario
})


 class Maquina {

    configurar (dureza, porosidad)  {
        if ( dureza < DUREZA_THRESHOLD_LOW && porosidad >= POROSIDAD_THRESHOLD_HIGH ) {
            console.log(TIPOS_DE_SUELO.BlandoYPoroso)
            return DICCIONARIO_CONFIGURACION[TIPOS_DE_SUELO.BlandoYPoroso]
        } else if ( dureza >= DUREZA_THRESHOLD_HIGH && porosidad < POROSIDAD_THRESHOLD_LOW ) {
            console.log(TIPOS_DE_SUELO.DuroYCompacto);
            return DICCIONARIO_CONFIGURACION[TIPOS_DE_SUELO.DuroYCompacto]
        }
        else if ( DUREZA_THRESHOLD_LOW <= dureza && dureza < DUREZA_THRESHOLD_HIGH 
              && POROSIDAD_THRESHOLD_LOW <= porosidad && porosidad < DUREZA_THRESHOLD_HIGH) {
            console.log(TIPOS_DE_SUELO.ValoresIntermedios);
            return DICCIONARIO_CONFIGURACION[TIPOS_DE_SUELO.ValoresIntermedios]

        } else {
            throw new Error('Tipo de suelo desconocido');
        }

    }

    async accionarBrazo ({ tiempo, velocidad, sentido }) {
        // Este metodo debería accionar el brazo real utilizando el tiempo, la velocidad y sentidos indicados
        console.log(`Accionar brazo en el sentido ${sentido} a una velocidad de ${velocidad.valor} ${velocidad.unidad} durante ${tiempo.valor} ${tiempo.unidad} `)
        await delay(toMilliSeconds(tiempo));
    }

    async cierreDePinzas() {
        // Este metodo deberia accionar el cierre de pinzas.
        console.log('Cierre de pinzas')

    }


    async excavar(dureza, porosidad) {

        const configuracion = this.configurar(dureza, porosidad);

        await this.accionarBrazo(configuracion);

        await this.cierreDePinzas();

        await this.accionarBrazo(sentidoInverso(configuracion));
    }
}

module.exports = Maquina;