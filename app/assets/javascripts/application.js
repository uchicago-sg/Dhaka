//= require 'analytics'
//= require mediaqueries
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require cookie
//= require easing
//= require sticky
//= require timeago
//= require fancybox
//= require bxSlider
//= require autoNumeric
//= require 'dhaka'
//= require_tree .

$(function () {
    $('.navbar-toggle').click(function () {
        $('.navbar-nav').toggleClass('slide-in');
        $('.side-body').toggleClass('body-slide-in');
        $('#search').removeClass('in').addClass('collapse').slideUp(200);

        /// uncomment code for absolute positioning tweek see top comment in css
        //$('.absolute-wrapper').toggleClass('slide-in');

    });

    // Remove menu for searching
    $('#search-trigger').click(function () {
        $('.navbar-nav').removeClass('slide-in');
        $('.side-body').removeClass('body-slide-in');

        /// uncomment code for absolute positioning tweek see top comment in css
        //$('.absolute-wrapper').removeClass('slide-in');

    });
});