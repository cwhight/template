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
  contentHeight: 500,
});

// price filter

$(".js-range-slider").ionRangeSlider({});

// date filter

var lang = "en-US";
var year = new Date().getFullYear();
var futureMonth = new Date().getMonth() + 1;
var currentMonth = new Date().getMonth();
var day = new Date().getDate();

var lowerYear = $(".targeter").data('startyear');
var lowerMonth = $(".targeter").data('startmonth') - 1;
var lowerDay = $(".targeter").data('startday');
var higherYear = $(".targeter").data('endyear');
var higherMonth = $(".targeter").data('endmonth')  - 1;
var higherDay = $(".targeter").data('endday');

function dateToTS (date) {
    return date.valueOf();
}

function tsToDate (ts) {
    var d = new Date(ts);

    return d.toLocaleDateString(lang, {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });
}

$(".js-range-slider2").ionRangeSlider({
  grid: false,
  min: dateToTS(new Date(year, currentMonth, day)),
  max: dateToTS(new Date(year, futureMonth, day)),
  from: dateToTS(new Date(lowerYear, lowerMonth, lowerDay)),
  to: dateToTS(new Date(higherYear, higherMonth, higherDay)),
  prettify: tsToDate
});
