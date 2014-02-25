$(document).ready(function () {
    $(".fancybox-close").click(function () {
        $('.fancybox-overlay').hide();
        $("#mce-FNAME").val('');
        $("#mce-MMERGE2").val('');
        $("#mce-EMAIL").val('');
    });
    $('mc-embedded-subscribe-form').submit(function () {
        var valuesToSubmit = $(this).serialize();
        alert('hello dear');
        $.ajax({
            url: $(this).attr('/news_letters/create'), //sumbits it to the given url of the form
            data: valuesToSubmit,
            dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
        }).success(function (json) {
                //act on result.
            });
        return false; // prevents normal behaviour
    });

    $(".fancybox-overlay").click(function () {
        $('.fancybox-overlay').hide();
    });

    $(".fancybox-skin").click(function () {
        return false;
    });

    $(".validet_chk").click(function () {
        var form = $(".newsletter").first();
        var valuesToSubmit = form.serialize();
        $.ajax({
            type: "POST",
            url: form.attr('action'), //sumbits it to the given url of the form
            data: valuesToSubmit,
            dataType: "script"
        }).success(function (script) {

            });
    });
});
