// Generated by CoffeeScript 1.7.1
var Marker, app;

Marker = (function() {
  function Marker(id, latitude, longitude) {
    this.id = id;
    this.latitude = latitude;
    this.longitude = longitude;
    this.start = null;
    this.end = null;
    this.icon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-66c547/shapecolor-light/shadow-1/border-white/symbolstyle-dark/symbolshadowstyle-no/gradient-no/bridge_old.png";
    this.showWindow = false;
  }

  return Marker;

})();

app = angular.module('mapApp', ['google-maps', 'services']);

app.controller('infoController', [
  '$scope', 'sharedProperties', function($scope, sharedProperties) {
    $scope.onStartClick = function() {
      return sharedProperties.setStart($scope.model.id);
    };
    return $scope.onEndClick = function() {
      return sharedProperties.setEnd($scope.model.id);
    };
  }
]);

app.controller('mapController', [
  '$scope', 'sharedProperties', function($scope, sharedProperties) {
    var latlngs, setMakerToInactive, setMarkerToEnd, setMarkerToStart;
    $scope.markers = [];
    $scope.map = {
      'center': {
        'latitude': 33.884388,
        'longitude': -117.641235
      },
      'zoom': 12
    };
    $scope.local = sharedProperties.Properties();
    $scope.logIt = function() {
      return console.log("Selected");
    };
    $scope.prevIcon = '';
    $scope.showTraffic = false;
    $scope.toggleTrafficLayer = function() {
      return $scope.showTraffic = !$scope.showTraffic;
    };
    setMarkerToStart = function(marker) {
      marker.status = "start";
      marker.icon = $scope.local.markers[$scope.local.start].icon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-262626/shapecolor-white/shadow-1/border-color/symbolstyle-color/symbolshadowstyle-no/gradient-no/bridge_old.png";
      return marker.prevIcon = $scope.local.markers[$scope.local.start].icon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-262626/shapecolor-white/shadow-1/border-color/symbolstyle-color/symbolshadowstyle-no/gradient-no/bridge_old.png";
    };
    setMakerToInactive = function(marker) {
      marker.status = "inactive";
      marker.icon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-66c547/shapecolor-light/shadow-1/border-white/symbolstyle-dark/symbolshadowstyle-no/gradient-no/bridge_old.png";
      return marker.prevIcon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-66c547/shapecolor-light/shadow-1/border-white/symbolstyle-dark/symbolshadowstyle-no/gradient-no/bridge_old.png";
    };
    setMarkerToEnd = function(marker) {
      marker.status = "end";
      marker.icon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-262626/shapecolor-color/shadow-1/border-dark/symbolstyle-white/symbolshadowstyle-dark/gradient-no/bridge_old.png";
      return marker.prevIcon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-262626/shapecolor-color/shadow-1/border-dark/symbolstyle-white/symbolshadowstyle-dark/gradient-no/bridge_old.png";
    };
    latlngs = [];
    latlngs.push({
      'latitude': 33.884780,
      'longitude': -117.639754
    });
    latlngs.push({
      'latitude': 33.884388,
      'longitude': -117.641235
    });
    latlngs.push({
      'latitude': 33.883924,
      'longitude': -117.643724
    });
    latlngs.forEach(function(element, index) {
      var marker;
      marker = new Marker(index, element.latitude, element.longitude);
      marker.close = function() {
        this.model.icon = $scope.prevIcon;
        this.model.showWindow = false;
        return $scope.$apply();
      };
      marker.onClick = function() {
        $scope.prevIcon = this.model.icon;
        this.model.icon = "http://mapicons.nicolasmollet.com/wp-content/uploads/mapicons/shape-default/color-facd1b/shapecolor-light/shadow-1/border-white/symbolstyle-dark/symbolshadowstyle-no/gradient-no/tollstation.png";
        $scope.local.markers.forEach(function(element) {
          return element.showWindow = false;
        });
        this.model.showWindow = true;
        $scope.id = this.model.id;
        return $scope.$apply();
      };
      return $scope.local.markers.push(marker);
    });
    return $scope.$watchGroup(['local.start', 'local.end'], function(newValues, oldValues) {
      var endId, markers, startId;
      startId = newValues[0].id;
      endId = newValues[1].id;
      if ((startId === -1) && (endId === -1)) {
        return;
      }
      markers = sharedProperties.Properties().markers;
      markers.forEach(function(marker) {
        if (marker.status === "start" || marker.status === "end") {
          return setMakerToInactive(marker);
        }
      });
      sharedProperties.setMarkers(markers);
      setMakerToStart(markers[startId]);
      return setMarkerToEnd(markers[endId]);
    });
  }
]);
