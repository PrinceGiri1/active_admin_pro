document.addEventListener('DOMContentLoaded', () => {
	debugger
  const countrySelect = document.getElementById('admin_user_country');
  const stateSelect = document.getElementById('admin_user_state');
  const citySelect = document.getElementById('admin_user_city');

  if (countrySelect) {
    countrySelect.addEventListener('change', () => {
      const country_code = countrySelect.value;
      stateSelect.innerHTML = '';
      citySelect.innerHTML = '';

      fetch(`/locations/states?country_code=${country_code}`)
        .then(response => response.json())
        .then(states => {
          states.forEach(state => {
            const option = document.createElement('option');
            option.value = state.code;
            option.textContent = state.name;
            stateSelect.appendChild(option);
          });
        });
    });
  }

  if (stateSelect) {
    stateSelect.addEventListener('change', () => {
      const state_code = stateSelect.value;
      const country_code = countrySelect.value;
      citySelect.innerHTML = '';

      fetch(`/locations/cities?country_code=${country_code}&state_code=${state_code}`)
        .then(response => response.json())
        .then(cities => {
          cities.forEach(city => {
            const option = document.createElement('option');
            option.value = city;
            option.textContent = city;
            citySelect.appendChild(option);
          });
        });
    });
  }
});
