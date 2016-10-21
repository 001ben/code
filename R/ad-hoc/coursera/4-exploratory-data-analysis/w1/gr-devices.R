cat('\ncurrent graphics device:\n')
print(dev.cur())

with(faithful, plot(eruptions, waiting))
cat('\nnew graphics device:\n')
print(dev.cur())

cat('\ndevice closing:\n')
dev.off()

png(filename = './geyser-data.png')
print(dev.cur())
with(faithful, plot(eruptions, waiting))
dev.off()

with(faithful, plot(eruptions, waiting))
cat('screen device:\n')
dev.cur()
dev.copy(pdf, file='geyserplot.pdf')
dev.off()
dev.off()
