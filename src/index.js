require('dotenv').config()
const express = require('express')
const cors = require('cors')
const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()
const app = express()
 const alcoholOptions = [
    { label: 'Шампанское', value: 'champagne' },
    { label: 'Виски', value: 'whiskey' },
    { label: 'Красное вино', value: 'wineRed' },
    { label: 'Водка', value: 'vodka' },
    { label: 'Белое вино', value: 'wineWhite' },
    { label: 'Безалкогольные', value: 'alkoFree'},
  ]
app.use(cors({origin:"*"}))
app.use(express.json())


// API routes тут


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on ${PORT}`);
});
app.get('/guest/:slug', async (req, res) => {
  const { slug } = req.params
  console.log(slug)
  try {
    const invitation = await prisma.invite.findUnique({
      where: { slug },
      include: {
        guests: true // ← здесь подтягиваем всех гостей, связанных с Invite
      }
    })
    console.log(invitation)
    if (!invitation) {
      return res.status(404).json({ error: 'Not found' })
    }

    res.json(invitation)
  } catch (e) { 
    res.status(500).json({ error: 'Server error' })
  }
})
app.post('/rsvp', async (req, res) => {
  const { id, status, comment  } = req.body
  let dataPayload = {status, comment }
  alcoholOptions.map(cv => dataPayload[cv.value] = req.body[cv.value] ?? false)
  try {
    const guest = await prisma.guest.update({
      where: { id },
      data: dataPayload
    })

    res.json(guest)
  } catch (e) {
    res.status(500).json({ error: 'Update failed' })
  }
})
