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

function form_int_from_color_code(symbol){
    switch(symbol){
        case 'A':
            return 10;
            break;
        case 'B':
            return 11;
            break;
        case 'C':
            return 12;
            break;
        case 'D':
            return 13;
            break;
        case 'E':
            return 14;
            break;
        case 'F':
            return 15;
            break;
        default:
            return parseInt(symbol);
            break;
    }
}

function form_color_code(color_number){
    switch(color_number){
        case 10:
            return 'A';
            break;
        case 11:
            return 'B';
            break;
        case 12:
            return 'C';
            break;
        case 13:
            return 'D';
            break;
        case 14:
            return 'E';
            break;
        case 15:
            return 'F';
            break;
        default:
            return color_number.toString();
            break;
    }
}

function form_text_color_code(color_number){
    switch(color_number){
        case 10:
            return 'A';
            break;
        case 11:
            return 'B';
            break;
        case 12:
            return 'C';
            break;
        case 13:
            return 'D';
            break;
        case 14:
            return 'E';
            break;
        case 15:
            return 'F';
            break;
        case (color_number > 4 && color_number < 7):
            return (color_number - 3).toString();
            break;
        case (color_number > 6 && color_number < 9):
            return form_color_code(color_number + 3);
            break;
        default:
            return color_number.toString();
            break;
    }
}

function generate_body_color(){
    var bg_color = '#';
    for (var i = 0; i < 6; i++){
        bg_color += form_color_code( Math.floor(Math.random() * 16) );
    }
    return bg_color;
}

function form_text_color(bg_color){
    var panel_color = '#';
    for (var i = 1; i < bg_color.length; i++) panel_color += form_text_color_code( 15 - form_int_from_color_code(bg_color[i]) )
    return panel_color;
}

function hide_flash(){
    setTimeout(function(){
        $('.alert').fadeOut(2000);
    }, 3500);
}

function preload(){
        setTimeout(function(){
            $('#preload').remove();
        }, 1500);
}

var main = function(){
    var bg_color = generate_body_color();
    var text_color = form_text_color(bg_color);
    $('body').css('background-color', bg_color);
    $('footer h3').css('color', text_color);

    var hide = hide_flash();
    preload();

    $('.alert').mouseover(function(){
        clearTimeout(hide);
        $(this).stop().animate({opacity: '100'});
    })
        .mouseout(function(){
            hide = hide_flash();
    });
};

$(document).ready(main);
$(document).on('page:load', main);