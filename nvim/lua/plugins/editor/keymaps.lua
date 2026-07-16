-- Borrar sin afectar el portapapeles (Normal y Visual mode)
-- 'd' ahora borra sin copiar
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "v" }, "D", '"_D', { desc = "Delete line without yanking" })

-- 'c' (change) suele ser molesto porque también copia, lo mandamos al registro negro
vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Change without yanking" })
vim.keymap.set({ "n", "v" }, "C", '"_C', { desc = "Change line without yanking" })

-- Para que 'x' (borrar carácter) se comporte como un "Cortar" real (que sí copie):
-- No mapeamos 'x' al registro negro, o lo mapeamos explícitamente al registro +
vim.keymap.set({ "n", "v" }, "x", '"*x', { desc = "Cut character to system clipboard" })

-- Para ir hasta la proxima coincidencia y centrar la vista
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
return {}
