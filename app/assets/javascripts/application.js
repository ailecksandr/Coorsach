// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

function generate_body_color(){
    var bg_color = '#';
    for (var i = 0; i < 6; i++) bg_color += (Math.floor(Math.random() * 10)).toString();
    return bg_color;
}

function form_text_color(bg_color){
    var panel_color = '#'
    for (var i = 1; i < bg_color.length; i++) panel_color += (9 - parseInt(bg_color[i])).toString();
    return panel_color;
}

var main = function(){
    var bg_color = generate_body_color();
    var text_color = form_text_color(bg_color);
    $('body').css('background-color', bg_color);
    $('footer h3').css('color', text_color);

    $('')
};


$(document).ready(main);
