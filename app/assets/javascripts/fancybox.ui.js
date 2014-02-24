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
        var mce_FNAME = $("#mce-FNAME").val();
        var tmp_mce_FNAME = mce_FNAME.split(' ');
        if (tmp_mce_FNAME.length < 2) {
            alert('Missing FULL name');
            var sbmt_chk = 'no';
            return false;
        }


        var mce_MMERGE2 = $("#mce-MMERGE2").val();

        /* this for start of the mobile no validation   */
        if (mce_MMERGE2 == "" || isNaN(mce_MMERGE2)) {
            alert('not a number');
            return false;
        }

        /* this for start of the mobile no validation   */

        var mce_EMAIL = $("#mce-EMAIL").val();
        var x = mce_EMAIL;
        var atpos = x.indexOf("@");
        var dotpos = x.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
            alert("Not a valid e-mail address");
            var sbmt_chk = 'no';
            return false;
        }

        if (sbmt_chk != 'no') {
            var form = $(".newsletter").first();
            var valuesToSubmit = form.serialize();
            $.ajax({
                type: "POST",
                url: form.attr('action'), //sumbits it to the given url of the form
                data: valuesToSubmit,
                dataType: "script"
            }).success(function (script) {

                });
            //document.getElementById("mc-embedded-subscribe-form").submit();

        }

    });
});


var valuesToSubmit = $("mc-embedded-subscribe-form").serialize();
$.ajax({
    url: $("mc-embedded-subscribe-form").attr('action'), //sumbits it to the given url of the form
    data: valuesToSubmit,
    dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
}).success(function (json) {
        //act on result.
    });