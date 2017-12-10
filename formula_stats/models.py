from django.db import models


class Driver(models.Model):
    name = models.CharField(max_length=30, unique=True)
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
    id = models.IntegerField(primary_key=True)  # due to only one primary key in Django ORM restriction
    event = models.ForeignKey(Event, on_delete=models.CASCADE)
    driver = models.ForeignKey(Driver, on_delete=models.CASCADE)
    team = models.ForeignKey(Team, on_delete=models.CASCADE)
    laps = models.IntegerField(default=0)
    time = models.DurationField(null=True, blank=True)

    class Meta:
        unique_together = (("event", "driver"), ("event", "driver", "time"),)

    def __str__(self):
        return "Race: " + self.event.name + ' - ' + self.driver.number.__str__()


class MostSuccessfulDrivers(models.Model):
    driver = models.ForeignKey(Driver, on_delete=models.DO_NOTHING, primary_key=True)
    name = models.CharField(max_length=30, unique=True)
    podiums = models.IntegerField()

    class Meta:
        db_table = 'formula_stats_drivers_podiums'
        managed = False

    def __str__(self):
        return "MostSuccessfulDrivers view: " + self.driver.name + ' ' + self.podiums.__str__()


class MostSuccessfulTeams(models.Model):
    team = models.ForeignKey(Team, on_delete=models.DO_NOTHING, primary_key=True)
    podiums = models.IntegerField()
    color_code = models.CharField(max_length=10)

    class Meta:
        db_table = 'formula_stats_teams_podiums'
        managed = False

    def __str__(self):
        return "MostSuccessfulTeams view: " + self.team.name + ' ' + self.podiums.__str__()


# doesn't it a copy of Race table with positions?
class DriverRaces(models.Model):
    id = models.IntegerField(primary_key=True)  # due to only one primary key in Django ORM restriction
    event = models.ForeignKey(Event, on_delete=models.DO_NOTHING)
    laps = models.IntegerField()
    time = models.DurationField(null=True, blank=True)
    row_id = models.IntegerField()  # position in race
    team = models.ForeignKey(Team, on_delete=models.DO_NOTHING)
    driver = models.ForeignKey(Driver, on_delete=models.DO_NOTHING)

    class Meta:
        db_table = 'formula_stats_driver_races'
        managed = False

    def __str__(self):
        return "DriverRaces view: " + self.id.__str__()


class TeamDrivers(models.Model):
    id = models.IntegerField(primary_key=True)  # due to only one primary key in Django ORM restriction
    amount = models.IntegerField()  # amount of races from this driver for this team
    team = models.ForeignKey(Team, on_delete=models.DO_NOTHING)
    name = models.CharField(max_length=30)

    class Meta:
        db_table = 'formula_stats_team_drivers'
        managed = False

    def __str__(self):
        return "TeamDrivers view: " + self.id.__str__()


# Create view "DriverPoints"
# Create view "TeamPoints"
# Create function & trigger "TeamAndDriverPointsUpdater"
