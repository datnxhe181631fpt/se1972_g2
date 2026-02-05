
function toggleDetail(code) {
    var detailRow = document.getElementById('detail-' + code);
    if (detailRow.style.display === 'none') {
        detailRow.style.display = 'table-row';
    } else {
        detailRow.style.display = 'none';
    }
}


function showToast(message, type) {
    let container = document.getElementById('toast-container');

    if (!container) {
        container = document.createElement('div');
        container.id = 'toast-container';
        document.body.appendChild(container);
    }

    const toast = document.createElement('div');

    toast.className = 'toast-message ' + (type === 'fail' ? 'error' : 'success');

    const iconClass = (type === 'fail') ? 'fa-exclamation-circle' : 'fa-check-circle';

    toast.innerHTML =
            '<div class="toast-content">' +
            '<i class="fas ' + iconClass + ' fa-lg"></i>' +
            '<span>' + message + '</span>' +
            '</div>' +
            '<i class="fas fa-times" style="cursor: pointer; opacity: 0.6;" onclick="this.parentElement.remove()"></i>'
            ;

    container.appendChild(toast);

    setTimeout(function () {
        toast.style.opacity = '0';
        setTimeout(function () {
            toast.remove();
        }, 500);
    }, 3000);
}


function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('main-content');
    const sidebarText = document.querySelectorAll('.sidebar-text');
    const toggleIcon = document.getElementById('toggle-icon');

    sidebar.classList.toggle('collapsed');
    
    const isCollapsed = sidebar.classList.contains('collapsed');
    localStorage.setItem('sidebarState', isCollapsed ? 'collapsed' : 'expanded');
}

document.addEventListener("DOMContentLoaded", function () {
    const sidebar = document.getElementById('sidebar');
    const savedState = localStorage.getItem('sidebarState');

    if (savedState === 'collapsed') {
        sidebar.classList.add('collapsed');
    }
});