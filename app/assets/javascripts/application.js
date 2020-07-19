// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require tinymce
//= require_tree .
//= require jquery
//= require rails-ujs
//= require bootstrap
//= require bootstrap-sprockets

$(document).ready(function() {

    // Put your offset checking in a function
    function checkOffset() {
        $(".navbar-fixed-top").toggleClass("top-nav-collapse", $(".navbar").offset().top > 10);
    }

    // Run it when the page loads
    checkOffset();


    // Run function when scrolling
    $(window).scroll(function() {
        checkOffset();
    });
});

$(document).on('turbolinks:load', function() {
    
    $("#journal-button").click(function(){
        $("#journal-form").toggle();
    });
    $("#correction-button").click(function(){
        $("#load-correction").toggle();
        $("#no-correction").hide();
    });
    $("#perfection-button").click(function(){
        $("#no-correction").toggle();
        $("#load-correction").hide();
    });
    $('[data-toggle="tooltip"]').tooltip(); 
});