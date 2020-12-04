import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.


const initFlatpickr = () => {
  // Check that the query selector id matches the one you put around your form.

  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');
  const homeStart = document.getElementById('search_starts_at');
  const homeEnd = document.getElementById('search_ends_at');
  if (startDateInput) {
  const unavailableDates = JSON.parse(document.querySelector('#profile-booking-dates').dataset.unavailable)
  endDateInput.disabled = true

  flatpickr(startDateInput, {
    minDate: "today",
    disable: unavailableDates,
    dateFormat: "Y-m-d",
  });

  startDateInput.addEventListener("change", (e) => {
    if (startDateInput != "") {
      endDateInput.disabled = false
    }
    flatpickr(endDateInput, {
      minDate: e.target.value,
      disable: unavailableDates,
      dateFormat: "Y-m-d"
      });
    });
  }

  flatpickr(homeStart, { dateFormat: "Y-m-d" })
  flatpickr(homeEnd, { dateFormat: "Y-m-d" })
};




export { initFlatpickr }
