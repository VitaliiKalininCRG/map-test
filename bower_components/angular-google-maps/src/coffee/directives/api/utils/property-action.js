// Generated by CoffeeScript 1.7.1
angular.module("google-maps.directives.api.utils").factory("nggmap-PropertyAction", [
  "Logger", function(Logger) {
    var PropertyAction;
    PropertyAction = function(setterFn, isFirstSet) {
      this.setIfChange = function(newVal, oldVal) {
        if (!_.isEqual(oldVal, newVal || isFirstSet)) {
          return setterFn(newVal);
        }
      };
      this.sic = (function(_this) {
        return function(oldVal, newVal) {
          return _this.setIfChange(oldVal, newVal);
        };
      })(this);
      return this;
    };
    return PropertyAction;
  }
]);
