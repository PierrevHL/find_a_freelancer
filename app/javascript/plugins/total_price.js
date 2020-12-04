const iniTotalPrice = () => {
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');
  const rateNode = document.getElementById("profile-booking-dates");
  const priceNode = document.getElementById("live-price")
  if (startDateInput) {
    endDateInput.addEventListener("change", e => {
      const startDateValue = startDateInput.value.split("-")
      const endDateValue = e.target.value.split("-")
      const startDateInteger = new Date(startDateValue[0], startDateValue[1], startDateValue[2]);
      const endDateInteger = new Date(endDateValue[0], endDateValue[1], endDateValue[2]);
      const price = ((endDateInteger - startDateInteger) / (1000 * 60 * 60 * 24)) * parseInt(rateNode.dataset.rate, 10)
      priceNode.innerText = `Total price: ${price}$`
    })
  }
}

export { iniTotalPrice }
