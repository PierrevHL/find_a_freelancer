import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

flatpickr("#search_starts_at", {
  altInput: true,
  plugins: [new rangePlugin({ input: "#search_ends_at"})]
});
