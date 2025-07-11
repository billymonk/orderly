import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["draggable", "dropzone"];

  dragstart(event) {
    event.dataTransfer.setData(
      "text/plain",
      event.target.dataset.dragAndDropTaskId
    );
    event.dataTransfer.effectAllowed = "move";
    event.target.classList.add("opacity-50");

    this.draggedTaskId = event.target.dataset.dragAndDropTaskId;
  }

  dragover(event) {
    event.preventDefault();
    this._resetDropzoneStyles();

    const timeslotPartial = event.currentTarget.querySelector(
      '[id^="timeslot_"]'
    );

    if (!timeslotPartial) return;

    const timeslotTaskIds = timeslotPartial.dataset.taskIds
      ? timeslotPartial.dataset.taskIds.split(",")
      : [];

    if (timeslotTaskIds.includes(this.draggedTaskId)) {
      event.dataTransfer.dropEffect = "none";
    } else {
      event.currentTarget.classList.add("border-indigo-500", "border-2");
      event.dataTransfer.dropEffect = "move";
    }
  }

  drop(event) {
    event.preventDefault();
    const taskId = event.dataTransfer.getData("text/plain");

    const timeslotPartial = event.currentTarget.querySelector(
      '[id^="timeslot_"]'
    );

    if (!timeslotPartial) return;

    const timeslotId = timeslotPartial.id.replace("timeslot_", "");
    const timeslotTaskIds = timeslotPartial.dataset.taskIds
      ? timeslotPartial.dataset.taskIds.split(",")
      : [];

    if (timeslotTaskIds.includes(taskId)) {
      this._resetDropzoneStyles();
      return;
    }

    fetch(`/scheduled_tasks`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "text/vnd.turbo-stream.html, text/html, application/xhtml+xml",
        "X-CSRF-Token": document.querySelector("meta[name=\"csrf-token\"]").content,
      },
      body: JSON.stringify({
        scheduled_task: { task_id: taskId, timeslot_id: timeslotId },
      }),
    })
      .then((response) => response.text())
      .then((responseText) => {
        Turbo.renderStreamMessage(responseText);
      })

    this._resetDropzoneStyles();
  }

  dragend(event) {
    event.target.classList.remove("opacity-50");
    this._resetDropzoneStyles();
    this.draggedTaskId = null;
  }

  _getTimeslotData(dropzoneElement) {
    const timeslotPartial = dropzoneElement.querySelector('[id^="timeslot_"]');
    if (!timeslotPartial)
      return { timeslotPartial: null, timeslotId: null, timeslotTaskIds: [] };

    const timeslotId = timeslotPartial.id.replace("timeslot_", "");
    const timeslotTaskIds = timeslotPartial.dataset.taskIds
      ? timeslotPartial.dataset.taskIds.split(",")
      : [];

    return { timeslotPartial, timeslotId, timeslotTaskIds };
  }

  _resetDropzoneStyles() {
    this.dropzoneTargets.forEach((dropzone) => {
      dropzone.classList.remove("border-indigo-500", "border-2");
    });
  }
}
