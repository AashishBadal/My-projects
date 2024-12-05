document.addEventListener('DOMContentLoaded', () => {
    const joinButton = document.querySelector('.cta-button');
    if (joinButton) {
        joinButton.addEventListener('click', () => {
            window.location.href = 'membership.html';
        });
    }
});
