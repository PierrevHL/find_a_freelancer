import "jquery-bar-rating";
import $ from 'jquery';

const initStarRating = () => {
  $('.barrating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
