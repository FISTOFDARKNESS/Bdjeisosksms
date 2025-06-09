// Blender 3D Models Data
const models = [
    {
        id: 1,
        name: "Inverted Spear of Heaven",
        description: "Detailed with textures and more.",
        price: 5.00,
        category: "weapons",
        images: ["assets/previews/ish.jpg"],
        thumbnail: "assets/thumbnails/ish.jpg",
        featured: true,
        polycount: "250k tris",
        files: "Rbxm",
        specs: [
            "4K PBR textures",
            "Tested in Eevee and Cycles"
        ],
        payhipLink: "https://payhip.com/b/BlTk5"
    },
    {
        id: 2,
        name: "GTR R34",
        description: "High-detail sports car model.",
        price: 25.00,
        category: "vehicles",
        images: ["assets/previews/GTR-34.jpg"],
        thumbnail: "assets/thumbnails/GTR-34.jpg",
        featured: true,
        polycount: "1.1M tris",
        files: "FBX",
        specs: [
            "5 paint material presets",
            "No texture"
        ],
        payhipLink: "https://payhip.com/b/VgGiq"
    },
        {
        id: 3,
        name: "Nissan GT-R R35 GT V2",
        description: "High-detail sports car model.",
        price: 25.00,
        category: "vehicles",
        images: ["assets/previews/GTR35.jpg"],
        thumbnail: "assets/thumbnails/GTR35.jpg",
        featured: true,
        polycount: "650.5k tris",
        files: "FBX",
        specs: [
            "Detailed interior",
            "5 paint material presets",
            "4K PBR textures"
        ],
        payhipLink: "https://payhip.com/b/dPAs6"
    },
     {
        id: 4,
        name: "AK-47",
        description: "good quality, with part of the gun are separated.",
        price: 10.00,
        category: "Weapons",
        images: ["assets/previews/ak.jpg"],
        thumbnail: "assets/thumbnails/ak.jpg",
        featured: true,
        polycount: "501k tris",
        files: "Rbxm",
        specs: [
            "Detailed",
            "4K PBR textures"
        ],
        payhipLink: "https://payhip.com/b/2lADY"
    },
         {
        id: 5,
        name: "Excalibur Dark",
        description: "good quality",
        price: 5.00,
        category: "Weapons",
        images: ["assets/previews/exd.jpg"],
        thumbnail: "assets/thumbnails/exd.jpg",
        featured: true,
        polycount: "1.1k tris",
        files: "FBX",
        specs: [
            "Detailed",
            "4K PBR textures"
        ],
        payhipLink: "https://payhip.com/b/RW7Ds"
    },
     {
        id: 6,
        name: "Excalibur",
        description: "good quality",
        price: 5.00,
        category: "Weapons",
        images: ["assets/previews/ex.jpg"],
        thumbnail: "assets/thumbnails/ex.jpg",
        featured: true,
        polycount: "1.1k tris",
        files: "Rbxm",
        specs: [
            "Detailed",
            "4K PBR textures"
        ],
        payhipLink: "https://payhip.com/b/cAGwM"
    },
];

// DOM Elements
const dom = {
    featuredContainer: document.getElementById('featured-container'),
    modelsGrid: document.getElementById('models-grid'),
    searchInput: document.getElementById('search'),
    categoryFilter: document.getElementById('category-filter'),
    sortSelect: document.getElementById('sort'),
    modal: document.getElementById('model-modal'),
    closeModal: document.querySelector('.close-modal'),
    modalContent: {
        name: document.getElementById('modal-model-name'),
        price: document.getElementById('modal-model-price'),
        desc: document.getElementById('modal-model-desc'),
        category: document.getElementById('modal-model-category'),
        polycount: document.getElementById('modal-model-polycount'),
        files: document.getElementById('modal-model-files'),
        specs: document.getElementById('modal-model-specs'),
        mainImage: document.getElementById('modal-model-image'),
        thumbnails: document.querySelector('.thumbnail-container'),
        payhipButton: document.getElementById('payhip-button-container')
    }
};

// Initialize the application
function init() {
    displayFeaturedModels();
    displayAllModels();
    setupEventListeners();
    loadPayhipScript();
}

// Display featured models
function displayFeaturedModels() {
    dom.featuredContainer.innerHTML = '';
    
    const featuredModels = models.filter(model => model.featured);
    
    if (featuredModels.length === 0) {
        dom.featuredContainer.innerHTML = '<p>No featured models available</p>';
        return;
    }
    
    featuredModels.forEach(model => {
        const modelElement = createModelCard(model, true);
        dom.featuredContainer.appendChild(modelElement);
    });
}

// Display all models
function displayAllModels(modelsToDisplay = models) {
    dom.modelsGrid.innerHTML = '';
    
    if (modelsToDisplay.length === 0) {
        dom.modelsGrid.innerHTML = '<p>No models found matching your criteria</p>';
        return;
    }
    
    modelsToDisplay.forEach(model => {
        const modelElement = createModelCard(model, false);
        dom.modelsGrid.appendChild(modelElement);
    });
}

// Create model card HTML
function createModelCard(model, isFeatured) {
    const element = document.createElement('div');
    element.className = isFeatured ? 'featured-model' : 'model-card';
    element.innerHTML = `
        ${model.badge ? `<span class="model-badge">${model.badge}</span>` : ''}
        <img src="${model.thumbnail}" alt="${model.name}" class="model-image">
        <div class="model-info">
            <h3>${model.name}</h3>
            <p class="model-price">$${model.price.toFixed(2)}</p>
            <p class="model-desc">${model.description}</p>
            <div class="model-actions">
                <button class="view-details" data-id="${model.id}">View Details</button>
                <a href="${model.payhipLink}" class="payhip-buy-button" 
                   data-theme="${isFeatured ? 'green' : 'small-green'}" 
                   data-product="${getPayhipProductCode(model.payhipLink)}">
                   Buy Now
                </a>
            </div>
        </div>
    `;
    return element;
}
function createModelCard1(model, isFeatured) {
    const element = document.createElement('div');
    element.className = isFeatured ? 'featured-model' : 'model-card';
    element.innerHTML = `
        ${model.badge ? `<span class="model-badge">${model.badge}</span>` : ''}
        <img src="${model.thumbnail}" alt="${model.name}" class="model-image">
        <div class="model-info">
            <h3>${model.name}</h3>
            <p class="model-price">$${model.price.toFixed(2)}</p>
            <p class="model-desc">${model.description}</p>
            <div class="model-actions">
                <button class="view-details" data-id="${model.id}">View Details</button>
                <a href="${model.payhipLink}" class="buy-now-btn">
                    Buy Now
                </a>
                <a href="https://discord.gg/9JueCryCQp" class="discord-btn" target="_blank">
                    Discord
                </a>
            </div>
        </div>
    `;
    return element;
}
// Show model details in modal
function showModelDetails(modelId) {
    const model = models.find(m => m.id === modelId);
    if (!model) return;
    
    // Set basic info
    dom.modalContent.name.textContent = model.name;
    dom.modalContent.price.textContent = `$${model.price.toFixed(2)}`;
    dom.modalContent.desc.textContent = model.description;
    dom.modalContent.category.textContent = model.category;
    dom.modalContent.polycount.textContent = model.polycount;
    dom.modalContent.files.textContent = model.files;
    
    // Set specifications
    dom.modalContent.specs.innerHTML = '';
    model.specs.forEach(spec => {
        const li = document.createElement('li');
        li.textContent = spec;
        dom.modalContent.specs.appendChild(li);
    });
    
    // Set images
    dom.modalContent.mainImage.src = model.images[0];
    dom.modalContent.mainImage.alt = model.name;
    
    // Set thumbnails
    dom.modalContent.thumbnails.innerHTML = '';
    model.images.forEach((image, index) => {
        const thumbnail = document.createElement('div');
        thumbnail.className = `thumbnail ${index === 0 ? 'active' : ''}`;
        thumbnail.innerHTML = `<img src="${image}" alt="${model.name} preview ${index + 1}">`;
        thumbnail.addEventListener('click', () => {
            dom.modalContent.mainImage.src = image;
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            thumbnail.classList.add('active');
        });
        dom.modalContent.thumbnails.appendChild(thumbnail);
    });
    
    dom.modalContent.payhipButton.innerHTML = '';
    
    // Show modal
    dom.modal.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
}

// Filter and sort models
function filterAndSortModels() {
    const searchTerm = dom.searchInput.value.toLowerCase();
    const categoryValue = dom.categoryFilter.value;
    const sortValue = dom.sortSelect.value;
    
    let filteredModels = models.filter(model => 
        (model.name.toLowerCase().includes(searchTerm) || 
         model.description.toLowerCase().includes(searchTerm)) &&
        (categoryValue === 'all' || model.category === categoryValue)
    );
    
    // Sort models
    switch (sortValue) {
        case 'newest': filteredModels.sort((a, b) => b.id - a.id); break;
        case 'price-asc': filteredModels.sort((a, b) => a.price - b.price); break;
        case 'price-desc': filteredModels.sort((a, b) => b.price - a.price); break;
    }
    
    displayAllModels(filteredModels);
}

// Helper functions
function getPayhipProductCode(url) {
    const parts = url.split('/');
    return parts[parts.length - 1];
}

function loadPayhipScript() {
    if (!window.Payhip) {
        const script = document.createElement('script');
        script.src = 'https://payhip.com/payhip.js';
        document.body.appendChild(script);
    }
}

// Event listeners
function setupEventListeners() {
    // Search and filter events
    dom.searchInput.addEventListener('input', filterAndSortModels);
    dom.categoryFilter.addEventListener('change', filterAndSortModels);
    dom.sortSelect.addEventListener('change', filterAndSortModels);
    
    // Modal events
    dom.closeModal.addEventListener('click', () => {
        dom.modal.classList.add('hidden');
        document.body.style.overflow = 'auto';
    });
    
    window.addEventListener('click', (e) => {
        if (e.target === dom.modal || e.target.classList.contains('modal-overlay')) {
            dom.modal.classList.add('hidden');
            document.body.style.overflow = 'auto';
        }
    });
    
    // Delegate click events for view details buttons
    document.addEventListener('click', (e) => {
        if (e.target.classList.contains('view-details')) {
            e.preventDefault();
            const modelId = parseInt(e.target.getAttribute('data-id'));
            showModelDetails(modelId);
        }
    });
}


// Initialize the app when DOM is loaded
document.addEventListener('DOMContentLoaded', init);
