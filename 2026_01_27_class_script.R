# JEL 2026-01-27
# class script

# read in data

ant_ice_loss = read.table(file = "data/antarctica_mass_200204_202505.txt",
                          skip = 31,
                          header = FALSE,
                          col.names = c("decimal_date", "mass_Gt", "sigma_Gt")) #can use relative paths from the folder you are already working in
ant_ice_loss

grn_ice_loss = read.table(file = "data/greenland_mass_200204_202505.txt",
                          skip = 31,
                          header = FALSE,
                          col.names = c("decimal_date", "mass_Gt", "sigma_Gt")) # skip gets rid of HDR rows, header is F bc manually removed hdr
head(grn_ice_loss) # prints out the first 6 rows of data set
dim(grn_ice_loss) # checks the dimensions of data set
summary(grn_ice_loss)

# plot this, first set plots ant. second set add grn to same plot
# ylim expands window of plot to include whole range
# type = "l" makes it a line rather than scatter
#there was a break period in GRACE around 2018,

range(grn_ice_loss$mass_Gt)

plot(x = ant_ice_loss$decimal_date, y = ant_ice_loss$mass_Gt,
      ylim = range(grn_ice_loss$mass_Gt),
      type ="l",
      xlab = "",
      ylab = "Ice mass loss (Gt)")

lines(mass_Gt ~ decimal_date,
      data = grn_ice_loss,
      type = "l",
      xlab = "",
      col = "red")

# add a break between GRACE missions ~2017-2018
# insert an n/a between lines 163 and 164 which is where there is a one year gap in data

data_break = data.frame(decimal_date = 2018,
                        mass_Gt = NA,
                        sigma_Gt = NA)

# rbind adds data sets together by rows, column names must be the same, c bind can do columns
ant_ice_loss_NA = rbind(ant_ice_loss, data_break)
head(ant_ice_loss_NA)
tail(ant_ice_loss_NA) # rbind stuck the data_break to the end of ant_ice_loss so need to sort to get it in the right spot

order(ant_ice_loss_NA$decimal_date)
ant_ice_loss_NA = ant_ice_loss_NA[order(ant_ice_loss_NA$decimal_date), ]
tail(ant_ice_loss_NA)

plot(mass_Gt ~ decimal_date,
      data = ant_ice_loss_NA,
      ylim = range(grn_ice_loss$mass_Gt),
      type ="l",
      xlab = "",
      ylab = "Ice mass loss (Gt)")

lines(mass_Gt ~ decimal_date,
      data = grn_ice_loss_NA,
      type = "l",
      xlab = "",
      col = "red")

grn_ice_loss_NA = rbind(grn_ice_loss, data_break)
grn_ice_loss_NA = grn_ice_loss_NA[order(grn_ice_loss_NA$decimal_date), ]


# how much mass has been lost in a bar plot

min(ant_ice_loss$mass_Gt)
min(grn_ice_loss$mass_Gt)

# open up plotting devide
pdf("figures/ice_mass_trends.pdf", width = 7, height = 5)

# create the figure
barplot(height = c(min(ant_ice_loss$mass_Gt),min(grn_ice_loss$mass_Gt))*(-1),
        names.arg = c("Antarctica", "Greenland"))

# close plotting device
dev.off()
