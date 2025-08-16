const container = document.getElementById('container');
const categoriesDiv = document.getElementById('categories');
const closeBtn = document.getElementById('closeBtn');

// Determine the resource name dynamically (fallback to resource folder name)
const resourceName = typeof GetParentResourceName === 'function' ? GetParentResourceName() : 'lspd-system-fivem';

function renderMenu(data) {
    categoriesDiv.innerHTML = '';
    // Iterate over each category
    for (const [catKey, cat] of Object.entries(data)) {
        const catDiv = document.createElement('div');
        catDiv.classList.add('category');
        const catHeader = document.createElement('h2');
        catHeader.textContent = cat.label;
        catDiv.appendChild(catHeader);

        // Iterate over organizations in the category
        for (const [orgKey, org] of Object.entries(cat.organizations)) {
            const orgDiv = document.createElement('div');
            orgDiv.classList.add('organization');
            const orgHeader = document.createElement('h3');
            orgHeader.textContent = org.label;
            orgDiv.appendChild(orgHeader);

            const ranksList = document.createElement('ul');
            ranksList.classList.add('ranks');
            // Sort ranks by descending order so highest rank appears first
            const entries = Object.entries(org.ranks).sort((a, b) => parseInt(b[0]) - parseInt(a[0]));
            for (const [rankId, rankName] of entries) {
                const li = document.createElement('li');
                li.textContent = `${rankId} - ${rankName}`;
                // When clicking a rank, notify the game to assign it (stub implementation)
                li.addEventListener('click', () => {
                    fetch(`https://${resourceName}/assignRank`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json; charset=UTF-8'
                        },
                        body: JSON.stringify({ organization: orgKey, rank: parseInt(rankId) })
                    });
                });
                ranksList.appendChild(li);
            }
            orgDiv.appendChild(ranksList);
            catDiv.appendChild(orgDiv);
        }

        categoriesDiv.appendChild(catDiv);
    }
}

// Listen for messages from the client script
window.addEventListener('message', (event) => {
    const data = event.data;
    if (!data || !data.action) return;
    switch (data.action) {
        case 'open':
            renderMenu(data.data);
            container.style.display = 'flex';
            break;
        case 'close':
            container.style.display = 'none';
            break;
    }
});

// Close button handler
closeBtn.addEventListener('click', () => {
    fetch(`https://${resourceName}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({})
    });
});
