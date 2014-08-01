{"changed":true,"filter":false,"title":"map.coffee","tooltip":"/map.coffee","value":"# Class for the markers\nclass Marker\n  constructor: (@id, @latlng) ->\n    @start = null\n    @end = null\n    @glatlng = { lat: @latlng.latitude, lng: @latlng.longitude }\n    @icon = \"/vitaliikalinincrg/map-test//states/inactive.png\"\n    @prevIcon = \"/vitaliikalinincrg/map-test//states/inactive.png\"\n    @showWindow = false\n\napp = angular.module 'mapApp', ['google-maps', 'services']\n\n# InfoWindow controller\napp.controller 'infoController', ['$scope', 'sharedProperties', ($scope, sharedProperties) ->\n  \n  $scope.onStartClick = () -> \n    props = sharedProperties.Properties()\n    id = $scope.model.id\n    sharedProperties.setEnd -1 if props.route.end is id\n    sharedProperties.setStart($scope.model.id) \n  $scope.onEndClick = () -> \n    props = sharedProperties.Properties()\n    id = $scope.model.id\n    sharedProperties.setStart -1 if props.route.start is id\n    sharedProperties.setEnd($scope.model.id) \n\n  $scope.onStreetViewClick = ->\n    properties = sharedProperties.Properties()\n    currentMarker = properties.markers[$scope.model.id]\n    panoramaOptions = {\n        position : currentMarker.glatlng\n      }\n    panorama = new google.maps.StreetViewPanorama(document.getElementById('pano'),panoramaOptions)\n    panorama.setVisible(true)\n    $('#pano').animate({'height': 0}, 100).animate({'z-index': 1}, 1).animate({'height': 500}, 800)\n    return true\n]\n\n# Map Controller\n\napp.controller 'mapController', ['$scope', 'sharedProperties', 'markerService', \n ($scope, sharedProperties, markerService) ->\n  \n  $scope.markers = []\n  \n  $scope.map = {\n    'center': {'latitude': 33.884388, 'longitude': -117.641235},\n    'zoom': 12,\n    'streetView': {},\n    'local': sharedProperties.Properties(),\n    'showTraffic': false,\n    'toggleTrafficLayer': -> $scope.map.showTraffic = !$scope.map.showTraffic,\n    'mapOptions': {\n      'panControl': false,\n      'rotateControl': false,\n      'streetViewControl': false,\n      'zoomControlOptions': {\n        'position': google.maps.ControlPosition.BOTTOM_LEFT\n      }\n    }\n    'infoWindowOptions': {\n      'pixelOffset': new google.maps.Size(0, -30)\n    }\n\n  }\n    \n  latlngs = []\n\n  latlngs.push {'latitude': 33.843801, 'longitude': -117.717234}\n  latlngs.push {'latitude': 33.826690, 'longitude': -117.716419}\n  latlngs.push {'latitude': 33.820415, 'longitude': -117.716977}\n  \n  # Creating the markers\n  latlngs.forEach (element, index) ->\n    marker = new Marker index, element\n    marker.close = ->\n      markerService.setMarkerDefault @model\n      $scope.$apply()\n\t  \n    marker.onClick = ->\n      # Saving the streetview map\n      sharedProperties.setPanorama $scope.map.streetView\n      # Set all markers to their default just in case one that was focused wasn't closed\n      $scope.map.local.markers.forEach (element) -> markerService.setMarkerDefault element\n      markerService.setMarkerStatus @model, \"focused\"\n      $scope.id = @model.id\n      $scope.$apply()\n\t  \n    $scope.map.local.markers.push marker\n  \n  $scope.$watchCollection 'map.local.route', (newValues, oldValues, scope) ->\n    startId = newValues.start\n    endId = newValues.end\n    # Check is needed just in case the current start is trying to be overwritten by end\n    if (startId is -1) and (endId is -1) or (startId is endId)\n      return sharedProperties.setStart -1 if oldValues.start is startId\n      return sharedProperties.setEnd -1 if oldValues.end is endId\n    markers = sharedProperties.Properties().markers\n    # Set other markers that were previously start or end to inactive\n    markers.forEach (marker) ->\n      if marker.status is \"start\" or marker.status is \"end\"\n        markerService.setMarkerStatus marker, \"inactive\" \n    \n    sharedProperties.setMarkers markers\n    markerService.setMarkerStatus markers[startId], 'start'; markerService.setMarkerStatus markers[endId], 'end'\n]\n","undoManager":{"mark":6,"position":28,"stack":[[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":0,"column":0},"end":{"row":1,"column":0}},"text":"\n"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":1,"column":0},"end":{"row":2,"column":0}},"text":"\n"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":0,"column":0},"end":{"row":0,"column":23}},"text":"# Class for the markers"},{"action":"insertText","range":{"start":{"row":0,"column":23},"end":{"row":1,"column":0}},"text":"\n"},{"action":"insertLines","range":{"start":{"row":1,"column":0},"end":{"row":9,"column":0}},"lines":["class Marker","  constructor: (@id, @latlng) ->","    @start = null","    @end = null","    @glatlng = { lat: @latlng.latitude, lng: @latlng.longitude }","    @icon = \"/states/inactive.png\"","    @prevIcon = \"/states/inactive.png\"","    @showWindow = false"]}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":6,"column":13},"end":{"row":6,"column":40}},"text":"vitaliikalinincrg/map-test/"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":6,"column":13},"end":{"row":6,"column":14}},"text":"/"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":7,"column":17},"end":{"row":7,"column":18}},"text":"/"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":7,"column":18},"end":{"row":7,"column":45}},"text":"vitaliikalinincrg/map-test/"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":0},"end":{"row":10,"column":1}},"text":"a"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":1},"end":{"row":10,"column":2}},"text":"n"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":2},"end":{"row":10,"column":3}},"text":"g"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":0},"end":{"row":10,"column":3}},"text":"ang"},{"action":"insertText","range":{"start":{"row":10,"column":0},"end":{"row":10,"column":7}},"text":"angular"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":7},"end":{"row":10,"column":8}},"text":"."}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":8},"end":{"row":10,"column":9}},"text":"m"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":8},"end":{"row":10,"column":9}},"text":"m"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":8},"end":{"row":10,"column":9}},"text":"s"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":9},"end":{"row":10,"column":10}},"text":"e"}]}],[{"group":"doc","deltas":[{"action":"insertText","range":{"start":{"row":10,"column":10},"end":{"row":10,"column":11}},"text":"r"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":10},"end":{"row":10,"column":11}},"text":"r"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":9},"end":{"row":10,"column":10}},"text":"e"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":8},"end":{"row":10,"column":9}},"text":"s"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":7},"end":{"row":10,"column":8}},"text":"."}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":6},"end":{"row":10,"column":7}},"text":"r"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":5},"end":{"row":10,"column":6}},"text":"a"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":4},"end":{"row":10,"column":5}},"text":"l"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":3},"end":{"row":10,"column":4}},"text":"u"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":2},"end":{"row":10,"column":3}},"text":"g"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":1},"end":{"row":10,"column":2}},"text":"n"}]}],[{"group":"doc","deltas":[{"action":"removeText","range":{"start":{"row":10,"column":0},"end":{"row":10,"column":1}},"text":"a"}]}],[{"group":"doc","deltas":[{"action":"removeLines","range":{"start":{"row":9,"column":0},"end":{"row":10,"column":0}},"nl":"\n","lines":[""]}]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":9,"column":0},"end":{"row":9,"column":0},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1406920938894}