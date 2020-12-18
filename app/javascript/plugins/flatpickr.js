import flatpickr from "flatpickr";

// First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.


const initFlatpickr = () => {
  // Check that the query selector id matches the one you put around your form.

  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');
  const homeStart = document.getElementById('search_starts_at');
  const homeEnd = document.getElementById('search_ends_at');
  if (startDateInput) {
    const unavailableDates = JSON.parse(document.querySelector('#profile-booking-dates').dataset.unavailable)
    if (startDateInput == "") {
      endDateInput.disabled = true
    }
  
    flatpickr(startDateInput, {
      minDate: "today",
      disable: unavailableDates,
      dateFormat: "Y-m-d",
      mode: "range",
      onClose: function(selectedDates, dateStr, instance) {
        if(selectedDates.length == 1){
            instance.setDate([selectedDates[0],selectedDates[0]], true);
        }
    }
    });
  }
  
  

  if (homeStart) {
    homeEnd.disabled = true
    console.log("here")
    flatpickr(homeStart, {
      minDate: "today",
      dateFormat: "Y-m-d",
      disableMobile: "true"
    });
  
    homeStart.addEventListener("change", (e) => {
      if (homeStart != "") {
        homeEnd.disabled = false
      }
      flatpickr(homeEnd, {
        minDate: e.target.value,
        dateFormat: "Y-m-d",
        disableMobile: "true"
        });
      });
    }
};




export { initFlatpickr };
