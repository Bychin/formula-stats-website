from django.db import models


class Driver(models.Model):
    name = models.CharField(max_length=30, unique=True)
    # team = models.ForeignKey('Team', on_delete=models.CASCADE)  # remove?
    number = models.IntegerField(primary_key=True)
    photo = models.ImageField()

    def __str__(self):
        return self.name


class Team(models.Model):
    name = models.CharField(max_length=16, primary_key=True)
    color_code = models.CharField(max_length=10)
    photo = models.ImageField()

    def __str__(self):
        return self.name


class Track(models.Model):
    name = models.CharField(max_length=50, primary_key=True)
    laps_number = models.IntegerField()
    lap_record = models.DurationField(null=True, blank=True)

    def __str__(self):
        return self.name


class Event(models.Model):
    name = models.CharField(max_length=50, primary_key=True)
    event_date = models.DateField()
    track = models.ForeignKey(Track, on_delete=models.CASCADE)
    photo = models.ImageField()

    def __str__(self):
        return self.name


class Race(models.Model):
    id = models.IntegerField(primary_key=True)  # ????
    event = models.ForeignKey(Event, on_delete=models.CASCADE)
    driver = models.ForeignKey(Driver, on_delete=models.CASCADE)
    team = models.ForeignKey(Team, on_delete=models.CASCADE)
    laps = models.IntegerField(default=0)
    time = models.DurationField(null=True, blank=True)

    class Meta:
        unique_together = (("event", "driver"), ("event", "driver", "time"),)

    def __str__(self):
        return "Race: " + self.event.name + ' - ' + self.driver.number.__str__()


# AllPodiums view
class Podium(models.Model):
    track = models.ForeignKey(Track, on_delete=models.DO_NOTHING)
    driver = models.ForeignKey(Driver, on_delete=models.DO_NOTHING)
    time = models.DurationField(null=True, blank=True)
    place = models.IntegerField()

    class Meta:
        db_table = 'formula_stats_allpodiums'
        managed = False

    def __str__(self):
        return "Podiums view: " + self.track.name + ' ' + self.place.__str__()


# Create view "MostSuccessfulDrivers" DONE
# Create view "MostSuccessfulTeams" DONE

# Create view "DriverPoints"
# Create view "TeamPoints"
# Create function & trigger "TeamAndDriverPointsUpdater"
