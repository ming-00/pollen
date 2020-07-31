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
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require rails-ujs
//= require bootstrap.min
//= require bootstrap
//= require notifications

$(document).on('turbolinks:load', function() {

    new Notifications().constructor();

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