-- =========================================================
-- 1. Registros y Portapapeles
-- =========================================================
-- Borrar sin afectar el portapapeles ("_ registro negro)
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "D", '"_D', { desc = "Delete to end of line without yanking" })

-- Change sin copiar
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without yanking" })
vim.keymap.set({ "n", "v" }, "C", '"_C', { desc = "Change to end of line without yanking" })

-- 'x' como Cortar al portapapeles del sistema (+)
vim.keymap.set({ "n", "v" }, "x", '"+x', { desc = "Cut to system clipboard" })
vim.keymap.set("n", "X", '"+D', { desc = "Cut to end of line to system clipboard" })

-- Pegar en modo visual sin perder lo copiado previamente
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without yanking selected text" })

-- =========================================================
-- 2. Búsqueda y Navegación
-- =========================================================
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search match (centered)" })

-- =========================================================
-- 3. Mover Líneas (Default de LazyVim, explícito)
-- =========================================================
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("x", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("x", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- =========================================================
-- 4. Duplicar Líneas (con Alt + Shift + j/k)
-- =========================================================
vim.keymap.set("n", "<A-J>", "<cmd>t.<cr>", { desc = "Duplicate line down" })
vim.keymap.set("n", "<A-K>", "<cmd>t -1<cr>", { desc = "Duplicate line up" })
vim.keymap.set("x", "<A-J>", ":t '> <CR>gv=gv", { desc = "Duplicate selection down" })
vim.keymap.set("x", "<A-K>", ":t '<-1<CR>gv=gv", { desc = "Duplicate selection up" })

-- =========================================================
-- 5. Dejar espacios arriba y abajo sin salir de modo normal
-- =========================================================

vim.keymap.set("n", "<leader>o", "m`o<Esc>0D``", { desc = "Blank line below" })
vim.keymap.set("n", "<leader>O", "m`O<Esc>0D``", { desc = "Blank line above" })

-- =========================================================
-- 6. Salir del modo terminal mas facil
-- =========================================================

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Salir del modo terminal" })
