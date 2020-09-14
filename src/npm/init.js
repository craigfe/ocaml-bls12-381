const _rustc_bls12_381 = require('rustc-bls12-381');
const _exports = require('./Fr.js');
function init() {
    return new Promise((resolve) => {
        _rustc_bls12_381().then(function(m) {
            global._RUSTC_BLS_12_381 = m;
            // Loads the caml runtime and initialise exports
            _exports.camlInit(global);
            resolve(_exports.Fr);
        })
    })
};

module.exports.init = init ;
