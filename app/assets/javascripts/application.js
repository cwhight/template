//= require rails-ujs
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all
//= require_tree .

var upcoming = $("#calendar").data('upcoming');
var past = $("#calendar").data('past');
var pending = $("#calendar").data('pending');

$('#calendar').fullCalendar({
  eventSources: [
    upcoming,
    past,
    pending
  ],
  dayRender: function(calEvent, cell, date) {
      cell.css('background-color', '#f4f4f4');
  }
});


 $(".js-range-slider").ionRangeSlider({});
