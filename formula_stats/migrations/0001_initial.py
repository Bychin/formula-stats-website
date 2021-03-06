# -*- coding: utf-8 -*-
# Generated by Django 1.11.7 on 2017-12-10 16:00
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='DriverRaces',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('laps', models.IntegerField()),
                ('time', models.DurationField(blank=True, null=True)),
                ('row_id', models.IntegerField()),
            ],
            options={
                'db_table': 'formula_stats_driver_races',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='TeamDrivers',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('amount', models.IntegerField()),
                ('name', models.CharField(max_length=30)),
            ],
            options={
                'db_table': 'formula_stats_team_drivers',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Driver',
            fields=[
                ('name', models.CharField(max_length=30, unique=True)),
                ('number', models.IntegerField(primary_key=True, serialize=False)),
                ('photo', models.ImageField(upload_to='')),
            ],
        ),
        migrations.CreateModel(
            name='Event',
            fields=[
                ('name', models.CharField(max_length=50, primary_key=True, serialize=False)),
                ('event_date', models.DateField()),
                ('photo', models.ImageField(upload_to='')),
            ],
        ),
        migrations.CreateModel(
            name='Race',
            fields=[
                ('id', models.IntegerField(primary_key=True, serialize=False)),
                ('laps', models.IntegerField(default=0)),
                ('time', models.DurationField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Team',
            fields=[
                ('name', models.CharField(max_length=16, primary_key=True, serialize=False)),
                ('color_code', models.CharField(max_length=10)),
                ('photo', models.ImageField(upload_to='')),
            ],
        ),
        migrations.CreateModel(
            name='Track',
            fields=[
                ('name', models.CharField(max_length=50, primary_key=True, serialize=False)),
                ('laps_number', models.IntegerField()),
                ('lap_record', models.DurationField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='MostSuccessfulDrivers',
            fields=[
                ('driver', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='formula_stats.Driver')),
                ('name', models.CharField(max_length=30, unique=True)),
                ('podiums', models.IntegerField()),
            ],
            options={
                'db_table': 'formula_stats_drivers_podiums',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='MostSuccessfulTeams',
            fields=[
                ('team', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='formula_stats.Team')),
                ('podiums', models.IntegerField()),
                ('color_code', models.CharField(max_length=10)),
            ],
            options={
                'db_table': 'formula_stats_teams_podiums',
                'managed': False,
            },
        ),
        migrations.AddField(
            model_name='race',
            name='driver',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='formula_stats.Driver'),
        ),
        migrations.AddField(
            model_name='race',
            name='event',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='formula_stats.Event'),
        ),
        migrations.AddField(
            model_name='race',
            name='team',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='formula_stats.Team'),
        ),
        migrations.AddField(
            model_name='event',
            name='track',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='formula_stats.Track'),
        ),
        migrations.AlterUniqueTogether(
            name='race',
            unique_together=set([('event', 'driver', 'time'), ('event', 'driver')]),
        ),
    ]
