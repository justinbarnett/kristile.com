((factory) ->
  "use strict"
  if typeof define is "function" and define.amd
    
    # Register as an anonymous AMD module:
    define ["jquery.cloudinary"], factory
  else
    
    # Browser globals:
    factory()
) ->
  "use strict"
  
  ###
  HTML:
  
  <img cl-image class="..." id="..."  height="..." data-crop="fit" public-id="cloudinaryPublicId"/>
  ###
  
  # The linking function will add behavior to the template
  
  ###
  HTML:
  
  <div id="photo-upload-btn" class="photo-upload-btn" cl-upload data="cloudinaryData"/>
  
  JavaScript:
  
  cloudinaryData = {
  url: 'https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME/auto/upload',
  formData : {
  timestamp : 1375363550;
  tags : sampleTag,
  api_key : YOUR_API_KEY,
  callback : URL TO cloudinary_cors.html,
  signature : '53ebfe998d4018c3329aba08237d23f7458851a5'
  }
  start : function() { ... },
  progress : function() { ... },
  done : function() { ... }
  }
  
  The start, progress, and done functions are optional callbacks. Other jquery.fileupload callbacks
  should be supported, but are untested.
  
  Functions are automatically wrapped in scope.$apply() so it is safe to change variable values
  in your callbacks.
  ###
  
  # The linking function will add behavior to the template
  
  # This wraps each function in data with an angular $apply()
  # so that changes to scoped variables will be recognized.
  angular.module("cloudinary", []).directive("clImage", ->
    restrict: "EA"
    replace: true
    transclude: false
    scope:
      publicId: "="

    link: (scope, element, attrs) ->
      scope.$watch "publicId", (value) ->
        return  unless value
        element.webpify src: value + ".jpg"

  ).directive("clUpload", ($compile) ->
    restrict: "EA"
    replace: true
    template: "<input name=\"file\" type=\"file\" class=\"cloudinary-fileupload\" data-cloudinary-field=\"image_id\" />"
    scope:
      data: "="

    link: (scope, element, attrs) ->
      scope.$watch "data", (data) ->
        if data
          defaultData = headers:
            "X-Requested-With": "XMLHttpRequest"

          wrapWithApply = (callback) ->
            (e, cbdata) ->
              phase = scope.$root.$$phase
              if phase is "$apply"
                callback e, cbdata
              else
                scope.$apply ->
                  callback e, cbdata


          for propt of data
            data[propt] = wrapWithApply(data[propt])  if typeof (data[propt]) is "function"
          completeData = angular.extend(defaultData, data)
          element.cloudinary_fileupload completeData

  ).config ->
    $.cloudinary.config CLOUDINARY_CONFIG

