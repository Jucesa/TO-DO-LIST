// filepath: /home/jucesa/todolist/app/assets/javascripts/drag_and_drop.js
document.addEventListener('DOMContentLoaded', function() {
    var tasks = document.querySelectorAll('.task');
    var columns = document.querySelectorAll('.task-column .task-list');
  
    tasks.forEach(function(task) {
      task.addEventListener('dragstart', function(e) {
        e.dataTransfer.setData('text/plain', task.dataset.id);
        task.classList.add('dragging');
      });
  
      task.addEventListener('dragend', function() {
        task.classList.remove('dragging');
      });
    });
  
    columns.forEach(function(column) {
      column.addEventListener('dragover', function(e) {
        e.preventDefault();
        var draggingTask = document.querySelector('.task.dragging');
        column.appendChild(draggingTask);
      });
  
      column.addEventListener('drop', function(e) {
        e.preventDefault();
        var taskId = e.dataTransfer.getData('text/plain');
        var task = document.querySelector(`.task[data-id='${taskId}']`);
        column.appendChild(task);
  
        // Update task status via AJAX
        var newStatus = column.parentElement.id;
        updateTaskStatus(taskId, newStatus);
      });
    });
  
    function updateTaskStatus(taskId, newStatus) {
      fetch(`/tasks/${taskId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ task: { status: newStatus } })
      });
    }
  });