define(['planet'], function (planet) {
    var _ = require('lodash');  // AMD & require hybrid
    if (_.isString(planet)) {
        return "Hello, " + planet;
    }
});