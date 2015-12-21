var OAUTH2_CLIENT_ID = '1017704670056-952h768rd62ovuah8rtkelf237vcfkp1.apps.googleusercontent.com';
var OAUTH2_SCOPES = [
  'https://www.googleapis.com/auth/youtube'
];
var API_KEY = "AIzaSyBc-td4AoauNAcdL5ekogWWXIYFPBCAB6U";


// ----------------------------------------------------------------------------
//
// Google MAP API Call
//
// ----------------------------------------------------------------------------

// Draw the Google Map
function drawMap(address) {
    var geocoder = new google.maps.Geocoder();
    //住所から座標を取得する
    geocoder.geocode(
            {
                'address': address,
                'region': 'jp'
            },
            function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    google.maps.event.addDomListener(window, 'load', function () {
                        var map_tag = document.getElementById('map');
                        // 取得した座標をセット緯度経度をセット
                        var map_location = new google.maps.LatLng(results[0].geometry.location.lat(),results[0].geometry.location.lng());
                        //マップ表示のオプション
                        var map_options =
                        {
                            zoom: 15,//縮尺
                            center: map_location,//地図の中心座標
                            //ここをfalseにすると地図上に人みたいなアイコンとか表示される
                            disableDefaultUI: true,
                            mapTypeId: google.maps.MapTypeId.ROADMAP//地図の種類を指定
                        };

                        //マップを表示する
                        var map = new google.maps.Map(map_tag, map_options);

                        //地図上にマーカーを表示させる
                        var marker = new google.maps.Marker({
                            position: map_location,//マーカーを表示させる座標
                            map: map//マーカーを表示させる地図
                        });
                    });
                }
            }
    );
}

// ----------------------------------------------------------------------------
//
// Youtube API Call
//
// ----------------------------------------------------------------------------

// Search Youtube Movies
function search(q) {
  var request = gapi.client.youtube.search.list({
    q: q,
    part: 'snippet',
    maxResults : 9
  });

  request.execute(function(response) {
    var str = JSON.stringify(response.result);
    // $('#youtube_container').html('<pre>' + str + '</pre>');
    renderYoubeSeachList(JSON.parse(str));
  });
}
// Render the Youtube Search List document
function renderYoubeSeachList(rso)
{
  var videoList = parseYoutubeResultObject(rso);
  $.each(videoList,function(index,obj){
    $('#youtube_container').append(
       '<div class="col-md-4 col-sm-4">' +
         '<a href="' + obj.videoUrl + '" target="blank">' + 
           '<img src="' + obj.imageUrl + '" class="img-rounded">' +
           '<p>' + obj.title + '</p>' +
         '</a>' +
       '</div>');
  });
}
// Parse for Youtube Search Result Object
function parseYoutubeResultObject(rso)
{
  var ary = new Array();
  var items = rso.items;

  for (var i = 0; i < items.length; i++) {
    var videoId = items[i].id.videoId;
    var title = items[i].snippet.title;
    var thumbnail = items[i].snippet.thumbnails.medium.url;
    var item = {
      "videoUrl"  : "https://www.youtube.com/watch?v=" + videoId,
      "title"     : title,
      "imageUrl"  : thumbnail
    }
    ary.push(item);
  }

  return ary;
}

// ----------------------------------------------------------------------------
//
// Youtube Authentication API Call
//
// ----------------------------------------------------------------------------

// Upon loading, the Google APIs JS client automatically invokes this callback.
googleApiClientReady = function() {
  gapi.auth.init(function() {
    window.setTimeout(checkAuth, 1);
  });
}

// Attempt the immediate OAuth 2.0 client flow as soon as the page loads.
// If the currently logged-in Google Account has previously authorized
// the client specified as the OAUTH2_CLIENT_ID, then the authorization
// succeeds with no user intervention. Otherwise, it fails and the
// user interface that prompts for authorization needs to display.
function checkAuth() {
  gapi.auth.authorize({
    client_id: OAUTH2_CLIENT_ID,
    scope: OAUTH2_SCOPES,
    immediate: true
  }, handleAuthResult);
}

// Handle the result of a gapi.auth.authorize() call.
function handleAuthResult(authResult) {
//  if (authResult && !authResult.error) {
//    // Authorization was successful. Hide authorization prompts and show
//    // content that should be visible after authorization succeeds.
//    $('.pre-auth').hide();
//    $('.post-auth').show();
//    loadAPIClientInterfaces();
//  } else {
//    // Make the #login-link clickable. Attempt a non-immediate OAuth 2.0
//    // client flow. The current function is called when that flow completes.
//    $('#login-link').click(function() {
//      gapi.auth.authorize({
//        client_id: OAUTH2_CLIENT_ID,
//        scope: OAUTH2_SCOPES,
//        immediate: false
//        }, handleAuthResult);
//    });
//  }
  if (authResult) {
    loadAPIClientInterfaces();
  }
}

// Load the client interfaces for the YouTube Analytics and Data APIs, which
// are required to use the Google APIs JS client. More info is available at
// http://code.google.com/p/google-api-javascript-client/wiki/GettingStarted#Loading_the_Client
function loadAPIClientInterfaces() {
  gapi.client.setApiKey(API_KEY);
  gapi.client.load('youtube', 'v3', function() {
    handleAPILoaded();
  });
}

// ----------------------------------------------------------------------------
//
// Itunes API Call
//
// ----------------------------------------------------------------------------

/**
  iTunes APIから取得する関数
*/
var itunesSearch = function(term, limit) {

  // 検索条件のベースとなるオブジェクト
  var params = {
    lang: 'ja_jp',
    entry: 'music',
    media: 'music',
    country: 'JP',
  };

  params.term  = term;    // 検索ワード
  params.limit = limit;  // 検索数

  // iTunes APIをコールする
  $.ajax({
    url: 'https://itunes.apple.com/search',
    method: 'GET',
    data: params,
    // dataTypeをjsonpにする必要があります
    dataType: 'jsonp',

    // 処理が成功したら、jsonが返却されます
    success: function(json) {
      renderItunesSeachList(json);
    },

    error: function() {
      console.log('itunes api search error. ', arguments);
    },
  });
};
// Render the Itunes Search List document
function renderItunesSeachList(rso)
{
  var videoList = parseItunesResultObject(rso);
  $.each(videoList,function(index,obj){
    $('#instagram_container').append(
       '<div class="col-md-2 col-sm-2">' +
         '<a href="' + obj.previewUrl + '" target="blank">' + 
           '<img src="' + obj.artworkUrl + '" class="img-rounded">' +
           '<p>' + obj.trackName + '</p>' +
         '</a>' +
       '</div>');
  });
}
// Parse for Itunes Search Result Object
function parseItunesResultObject(rso)
{
  var ary = new Array();
  var items = rso.results;

  for (var i = 0; i < items.length; i++) {
    var item = {
      "previewUrl"  : items[i].previewUrl,
      "trackName"   : items[i].trackName,
      "artworkUrl"  : items[i].artworkUrl100
    }
    ary.push(item);
  }

  return ary;
}
