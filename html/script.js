const container = document.getElementById('container');
const categoriesDiv = document.getElementById('categories');
const closeBtn = document.getElementById('closeBtn');

const selectorContainer = document.getElementById('selectorContainer');
const selectorTitle = document.getElementById('selectorTitle');
const itemsDiv = document.getElementById('items');
const selectorCloseBtn = document.getElementById('selectorCloseBtn');

const resourceName = typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'lspd-system-fivem';

/**
 * Render organizations menu with categories, orgs and ranks.
 */
function renderMenu(data) {
    categoriesDiv.innerHTML = '';
    Object.entries(data).forEach(([catKey, cat]) => {
        const catDiv = document.createElement('div');
        catDiv.classList.add('category');
        const catHeader = document.createElement('h2');
        catHeader.textContent = cat.label;
        catDiv.appendChild(catHeader);
        Object.entries(cat.organizations).forEach(([orgKey, org]) => {
            const orgDiv = document.createElement('div');
            orgDiv.classList.add('organization');
            const orgHeader = document.createElement('h3');
            orgHeader.textContent = org.label;
            orgDiv.appendChild(orgHeader);
            const ranksList = document.createElement('ul');
            ranksList.classList.add('ranks');
            Object.entries(org.ranks)
                .sort((a, b) => parseInt(b[0]) - parseInt(a[0]))
                .forEach(([rankId, rankName]) => {
                    const li = document.createElement('li');
                    li.textContent = `${rankId} - ${rankName}`;
                    li.addEventListener('click', () => {
                        fetch(`https://${resourceName}/assignRank`, {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                            body: JSON.stringify({ organization: orgKey, rank: parseInt(rankId) })
                        });
                    });
                    ranksList.appendChild(li);
                });
            orgDiv.appendChild(ranksList);
            catDiv.appendChild(orgDiv);
        });
        categoriesDiv.appendChild(catDiv);
    });
}

/**
 * Render selector menu for armory, vehicles or uniforms.
 */
function renderSelector(menuType, items, rank) {
    if (menuType === 'armory') {
        selectorTitle.textContent = 'Armería';
    } else if (menuType === 'vehicles') {
        selectorTitle.textContent = 'Garaje';
    } else if (menuType === 'uniforms') {
        selectorTitle.textContent = 'Uniformes';
    } else {
        selectorTitle.textContent = '';
    }
    itemsDiv.innerHTML = '';
    if (Array.isArray(items)) {
        items.forEach(item => {
            const el = document.createElement('div');
            el.classList.add('item');
            el.textContent = item.label || item.name || item.model;
            if (item.minRank !== undefined && rank < item.minRank) {
                el.classList.add('disabled');
            } else {
                el.addEventListener('click', () => {
                    fetch(`https://${resourceName}/selectItem`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                        body: JSON.stringify({ menuType: menuType, item: item })
                    });
                });
            }
            itemsDiv.appendChild(el);
        });
    } else if (items && typeof items === 'object') {
        Object.entries(items).forEach(([key, uniform]) => {
            const el = document.createElement('div');
            el.classList.add('item');
            el.textContent = uniform.label || key;
            el.addEventListener('click', () => {
                fetch(`https://${resourceName}/selectItem`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                    body: JSON.stringify({ menuType: menuType, item: { key: key, label: uniform.label } })
                });
            });
            itemsDiv.appendChild(el);
        });
    }
    selectorContainer.style.display = 'flex';
}

/**
 * Hide menus
 */
function closeMenu() {
    container.style.display = 'none';
}

function closeSelector() {
    selectorContainer.style.display = 'none';
}

// Listen for messages from the client script
window.addEventListener('message', (event) => {
    const data = event.data;
    if (!data || !data.action) return;
    switch (data.action) {
        case 'openMenu':
        case 'open':
            renderMenu(data.data);
            container.style.display = 'flex';
            break;
        case 'close':
            closeMenu();
            break;
        case 'openSelector':
            renderSelector(data.menuType, data.items, data.rank);
            break;
        case 'closeSelector':
            closeSelector();
            break;
    }
});

// Close button handlers
closeBtn.addEventListener('click', () => {
    fetch(`https://${resourceName}/close`, { method: 'POST' });
});

selectorCloseBtn.addEventListener('click', () => {
    fetch(`https://${resourceName}/closeSelector`, { method: 'POST' });
});
