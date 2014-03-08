#= require s3_direct_upload
jQuery ->
  $("#myS3Uploader").S3Uploader
    remove_completed_progress_bar: false
    progress_bar_target: $('.js-progress-bars')
    click_submit_target: $('.submit-target')

    $('#myS3Uploader').bind 's3_uploads_start', (e) ->
      alert("Uploads have started")

      $('#myS3Uploader').bind "s3_upload_failed", (e, content) ->
  alert("#{content.filename} failed to upload : #{content.error_thrown}")

$(document).bind 's3_uploads_complete', ->
  alert("All Uploads completed")
