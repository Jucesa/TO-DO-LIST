document.addEventListener('DOMContentLoaded', function() {
    var collapsibles = document.querySelectorAll('.collapsible');
    
    collapsibles.forEach(function(collapsible) {
      collapsible.addEventListener('click', function() {
        var content = this.nextElementSibling;
        content.classList.toggle('show');
      });
    });
  });
  