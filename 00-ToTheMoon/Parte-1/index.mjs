const Maquina = require('./maquina.mjs');

const validate = (arg) => {
    const floatValue = parseFloat(arg);

    if ( floatValue == NaN || floatValue < 0 || floatValue > 1) {
        throw new Error (`El argument ${arg} es invalido: debe ser un numero flotante entre 0 y 1`)
    
    }

    return floatValue;
}

const main  = () => {
    
    try {

        if (process.argv.length != 4 ) {
            throw new Error('La cantidad de argumentos deber ser 2');
        }

        const dureza = validate(process.argv[2]);
        const porosidad = validate(process.argv[3]);
        
        const maquina = new Maquina();

        maquina.excavar(dureza, porosidad)
        .then( () => {
            console.log('Terminé de obtener la muestra')
        })
        .catch(error => {
            console.log(error.message)
        });
    } catch (error) {
        console.error(error.message);
    };
}

main()