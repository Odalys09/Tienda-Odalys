let cart = [];

function addToCart(product) {
    let existing = cart.find(item => item.id === product.id);
    if (existing) {
        if (existing.qty + 1 > product.cantidad) {
            alert(`¡Stock insuficiente! Solo quedan ${product.cantidad} unidades disponibles.`);
            return;
        }
        existing.qty++;
    } else {
        if (product.cantidad < 1) {
            alert('¡Producto agotado!');
            return;
        }
        cart.push({ ...product, qty: 1 });
    }
    renderCart();
}

function renderCart() {
    const container = document.getElementById('cart-items');
    const totalEl = document.getElementById('cart-total-amount');
    
    if (!container || !totalEl) return;

    if (cart.length === 0) {
        container.innerHTML = '<p style="color: var(--texto-mutado); text-align: center; margin-top: 40px;">No hay productos en la orden.</p>';
        totalEl.textContent = '$0.00';
        return;
    }

    let total = 0;
    container.innerHTML = cart.map((item) => {
        let subtotal = item.precio * item.qty;
        total += subtotal;
        return `
            <div class="cart-item">
                <div>
                    <strong style="color: #fff;">${item.producto}</strong>
                    <div style="font-size: 12px; color: var(--amarillo-oro);">$${parseFloat(item.precio).toFixed(2)} x ${item.qty}</div>
                </div>
                <div style="font-weight: 900; color: var(--amarillo-oro);">$${subtotal.toFixed(2)}</div>
            </div>
        `;
    }).join('');

    totalEl.textContent = `$${total.toFixed(2)}`;
}

async function processSale() {
    if (cart.length === 0) {
        alert('Agrega al menos un producto al carrito para completar la venta.');
        return;
    }

    const totalAmount = cart.reduce((sum, item) => sum + (item.precio * item.qty), 0);

    try {
        const response = await fetch('procesar_venta.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                items: cart,
                total: totalAmount
            })
        });

        const result = await response.json();

        if (result.success) {
            alert(`¡Venta #${result.id_venta} realizada con éxito y registrada en la base de datos!`);
            cart = [];
            renderCart();
            setTimeout(() => window.location.reload(), 500);
        } else {
            alert('Error al registrar la venta: ' + result.message);
        }
    } catch (error) {
        alert('Ocurrió un error al conectar con el servidor.');
        console.error(error);
    }
}

document.getElementById('search-box')?.addEventListener('input', (e) => {
    const term = e.target.value.toLowerCase().trim();
    document.querySelectorAll('.product-card').forEach(card => {
        const name = card.dataset.name;
        card.style.display = name.includes(term) ? 'flex' : 'none';
    });
});

document.querySelectorAll('.cat-chip').forEach(chip => {
    chip.addEventListener('click', () => {
        document.querySelectorAll('.cat-chip').forEach(c => c.classList.remove('active'));
        chip.classList.add('active');
        
        const selectedCat = chip.getAttribute('data-cat');
        document.querySelectorAll('.product-card').forEach(card => {
            const cardCat = card.getAttribute('data-category');
            if (selectedCat === 'all' || cardCat === selectedCat) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    });
});
