// Generated by CoffeeScript 1.7.1
var app;

app = angular.module('services', []);

app.service('sharedProperties', function() {
  var props;
  props = {
    start: -1,
    end: -1,
    markers: []
  };
  return {
    Properties: function() {
      return props;
    },
    setStart: function(val) {
      return props.start = val;
    },
    setEnd: function(val) {
      return props.end = val;
    },
    setMarkers: function(val) {
      return props.markers = val;
    }
  };
});
