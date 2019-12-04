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

  },
  contentHeight: 500,
});

$(".js-range-slider").ionRangeSlider({});

var lang = "en-US";
var year = new Date().getFullYear();
var futureMonth = new Date().getMonth() + 1;
var currentMonth = new Date().getMonth();
var day = new Date().getDate();

function dateToTS (date) {
    return date.valueOf();
}

function tsToDate (ts) {
    var d = new Date(ts);

    return d.toLocaleDateString(lang, {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}

$(".js-range-slider2").ionRangeSlider({
  grid: true,
  min: dateToTS(new Date(year, currentMonth, day)),
  max: dateToTS(new Date(year, futureMonth, day)),
  from: dateToTS(new Date(year, currentMonth, day)),
  to: dateToTS(new Date(year, futureMonth, day)),
  prettify: tsToDate
});
