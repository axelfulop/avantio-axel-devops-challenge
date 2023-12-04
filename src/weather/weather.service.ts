import { Injectable } from '@nestjs/common';
import { InjectMetric } from '@willsoto/nestjs-prometheus';
import { Gauge } from 'prom-client';
import { Rover } from './rover.model';
import { ConfigService } from '@nestjs/config';

const ROVER_NAMES = ['perseverance', 'curiosity', 'spirit', 'opportunity'];

@Injectable()
export class WeatherService {
  rovers: Rover[] = ROVER_NAMES.map((name) => new Rover(name));

  constructor(
    private configService: ConfigService,
    @InjectMetric('wind_speed') private readonly windSpeed: Gauge<string>,
    @InjectMetric('temperature') private readonly temperature: Gauge<string>,
  ) {
    this.updateWeather();
    setInterval(
      () => this.updateWeather(),
      this.configService.get('updateInterval'),
    );
  }

  updateWeather() {
    this.rovers.forEach((rover) => {
      rover.updateWind();
      rover.updateTemperature();

      this.windSpeed.set({ rover_name: rover.name }, rover.windSpeed);
      this.temperature.set({ rover_name: rover.name }, rover.temperature);
    });
  }
}
