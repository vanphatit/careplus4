document.addEventListener("DOMContentLoaded", function() {
    const currentPath = window.location.pathname;

    // Tìm tất cả các mục trong sidebar
    const menuItems = document.querySelectorAll('.app-menu__item, .app-submenu a');

    menuItems.forEach(item => {
        if (item.getAttribute('href') === currentPath) {
            item.classList.add('active');

            // Nếu là mục con, highlight cả mục cha
            const parent = item.closest('.app-menu__item');
            if (parent) {
                parent.classList.add('active');
            }
        }
    });
});
