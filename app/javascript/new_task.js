document.addEventListener('DOMContentLoaded', function() {
  var newTaskBtn = document.getElementById('new-task-btn');
  var taskBoard = document.querySelector('.task-board');
  var isDragging = false;
  var newTaskElement;

  newTaskBtn.addEventListener('mousedown', function(e) {
    isDragging = true;
    newTaskElement = document.createElement('div');
    newTaskElement.classList.add('task');
    newTaskElement.setAttribute('draggable', 'true');
    newTaskElement.innerHTML = '<p>New Task</p><p>Priority</p>';
    newTaskElement.style.position = 'absolute';
    newTaskElement.style.left = e.pageX + 'px';
    newTaskElement.style.top = e.pageY + 'px';
    newTaskElement.style.zIndex = 1000;
    document.body.appendChild(newTaskElement);
  });

  document.addEventListener('mousemove', function(e) {
    if (isDragging) {
      newTaskElement.style.left = e.pageX + 'px';
      newTaskElement.style.top = e.pageY + 'px';
    }
  });

  document.addEventListener('mouseup', function(e) {
    if (isDragging) {
      isDragging = false;
      document.body.removeChild(newTaskElement);

      var targetColumn = document.elementFromPoint(e.clientX, e.clientY).closest('.task-column .task-list');
      if (targetColumn) {
        var newTask = document.createElement('div');
        newTask.classList.add('task');
        newTask.setAttribute('draggable', 'true');
        newTask.innerHTML = '<p>New Task</p><p>Priority</p>';
        targetColumn.appendChild(newTask);

        // Optionally, you can send an AJAX request to create the new task in the backend
        // updateTaskStatus(newTaskId, targetColumn.parentElement.id);
      }
    }
  });

  function updateTaskStatus(taskId, newStatus) {
    fetch(`/tasks/${taskId}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ task: { status: newStatus } })
    });
  }
});