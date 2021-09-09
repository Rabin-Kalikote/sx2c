function renderPdf(url){
  var renderPage, thePdf;
  thePdf = null;
  renderPage = function(pageNumber, canvas) {
    thePdf.getPage(pageNumber).then(function(page) {
      var scale, viewport;
      scale = 1;
      viewport = page.getViewport({
        scale: scale
      });
      canvas.width = $('.article-pdf').width();
      scale = $('.article-pdf').width() / viewport.width;
      canvas.height = viewport.height * scale;
      viewport = page.getViewport({
        scale: scale
      });
      page.render({
        canvasContext: canvas.getContext('2d'),
        viewport: viewport
      });
    });
  };
  pdfjsLib.getDocument(url).promise.then(function(pdf) {
    var canvas, page, viewer;
    thePdf = pdf;
    viewer = $('.article-pdf');
    page = 1;
    while (page <= pdf.numPages) {
      canvas = document.createElement('canvas');
      viewer.append(canvas);
      renderPage(page, canvas);
      page++;
    }
  });
}

$( document ).on('turbolinks:load', function() {
  // toggle nav search bar
  $(".toggle-search").on( "click", function(e) {
    e.preventDefault();
    $( ".sx2c-search" ).toggleClass("d-none");
  });
  // render pdf
  renderPdf($('.article-pdf').data('url'));
});
