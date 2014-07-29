// Generated by CoffeeScript 1.7.1
describe("directives.api.Window", function() {
  beforeEach(function() {
    window.google;
    module("google-maps");
    module("google-maps.mocks");
    inject((function(_this) {
      return function(GoogleApiMock) {
        _this.gmap = new GoogleApiMock();
        _this.gmap.mockAPI();
        _this.gmap.mockLatLng();
        _this.gmap.mockMarker();
        _this.gmap.mockInfoWindow();
        return _this.gmap.mockEvent();
      };
    })(this));

    /* Possible Attributes
            coords: '=coords',
    				show: '=show',
    				templateUrl: '=templateurl',
    				templateParameter: '=templateparameter',
    				isIconVisibleOnClick: '=isiconvisibleonclick',
    				closeClick: '&closeclick',           #scope glue to gmap InfoWindow closeclick
    				options: '=options'
     */
    this.mocks = {
      scope: {
        coords: {
          latitude: 90.0,
          longitude: 89.0
        },
        show: true,
        $watch: function() {},
        $on: function() {}
      },
      element: {
        html: function() {
          return "<p>test html</p>";
        }
      },
      attrs: {
        isiconvisibleonclick: true
      },
      ctrls: [
        {
          getMap: function() {
            return {};
          }
        }
      ]
    };
    this.timeOutNoW = (function(_this) {
      return function(fnc, time) {
        return fnc();
      };
    })(this);
    this.gMarker = new google.maps.Marker(this.commonOpts);
    return inject((function(_this) {
      return function(_$rootScope_, $q, $compile, $http, $templateCache, $injector, Window) {
        var d;
        _this.$rootScope = _$rootScope_;
        d = $q.defer();
        d.resolve(_this.gmap);
        _this.$rootScope.deferred = d;
        _this.mocks.ctrls[0].getScope = function() {
          return _this.$rootScope;
        };
        _this.windowScope = _.extend(_this.$rootScope.$new(), _this.mocks.scope);
        _this.subject = new Window(_this.timeOutNoW, $compile, $http, $templateCache);
        _this.subject.onChildCreation = function(child) {
          return _this.childWindow = child;
        };
        _this.prom = d.promise;
      };
    })(this));
  });
  it("should test receive the fulfilled promise!!", function() {
    var result;
    result = void 0;
    this.prom.then(function(returnFromPromise) {
      return result = returnFromPromise;
    });
    this.$rootScope.$apply();
    return expect(result).toBe(this.gmap);
  });
  it('can be created', function() {
    expect(this.subject).toBeDefined();
    return expect(this.subject.index).toEqual(this.index);
  });
  return it('link creates window options and a childWindow', function() {
    var crap;
    this.subject.link(this.windowScope, this.mocks.element, this.mocks.attrs, this.mocks.ctrls);
    crap = null;
    this.prom.then(function() {
      return crap = "set";
    });
    this.$rootScope.$apply();
    expect(crap).toBe('set');
    expect(this.childWindow).toBeDefined();
    return expect(this.childWindow.opts).toBeDefined();
  });
});
