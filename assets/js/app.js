document.addEventListener('DOMContentLoaded', () => {
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.has('edit')) {
    enableEditing();
  }
});

function enableEditing() {
  document.querySelectorAll('[data-editable]').forEach(el => {
    el.setAttribute('contenteditable', 'true');
    el.setAttribute('aria-label', 'Editable content');
    el.tabIndex = 0;
  });
}
