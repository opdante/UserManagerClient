$(document).ready(function() {
  $('#login').click(function() {
    window.location = "/login";
  });
  $('#signup').click(function() {
    window.location = "http://account.collegezen.com/signup";
  });
  $('#profile').click(function() {
    window.location = "http://account.collegezen.com/";
  });
  $('#logout').click(function() {
    window.location = "/signout";
  });
  $('.dropdown-toggle').dropdown();
});