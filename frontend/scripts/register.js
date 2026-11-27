const form = document.getElementById('registerForm')
const greska = document.getElementById('greska')
const link = BACKEND_URL

form.addEventListener('submit', async (e) => {
    e.preventDefault()
    greska.textContent = ''

    const registerUsername = document.getElementById('registerUsername').value.trim()
    const registerName = document.getElementById('registerName').value.trim()
    const registerLastName = document.getElementById('registerLastName').value.trim()
    const registerEmail = document.getElementById('registerEmail').value.trim()
    const registerPassword = document.getElementById('registerPassword').value
    const registerConfirmPassword = document.getElementById('registerConfirmPassword').value
    const uloga = document.getElementById('uloga').value

    if (registerPassword !== registerConfirmPassword) {
        greska.textContent = 'Lozinke se ne poklapaju'
        return
    }

    const korisnik = {
        ime: registerName,
        prezime: registerLastName,
        mail: registerEmail,
        korisnickoIme: registerUsername,
        lozinka: registerPassword,
        uloga: uloga
    }

    try {
        const response = await fetch(`${link}/register`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(korisnik)
        })

        const data = await response.json()

        if (response.ok) {
            window.location.href = 'login.html'
        } else {
            greska.textContent = data.detail || 'Greška pri registraciji, proverite unete podatke!'
        }
    } catch (error) {
        greska.textContent = 'Greška pri povezivanju sa serverom!'
    }
})