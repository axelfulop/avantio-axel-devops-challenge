import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import {
  PrometheusModule,
  makeGaugeProvider,
} from '@willsoto/nestjs-prometheus';
import { WeatherService } from './weather/weather.service';
import { ConfigModule } from '@nestjs/config';
import { config } from './config';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [config],
    }),
    PrometheusModule.register(),
  ],
  controllers: [AppController],
  providers: [
    AppService,
    WeatherService,
    makeGaugeProvider({
      name: 'wind_speed',
      help: 'Wind speed in kph',
      labelNames: ['rover_name'],
    }),
    makeGaugeProvider({
      name: 'temperature',
      help: 'Temperature in celsius',
      labelNames: ['rover_name'],
    }),
  ],
})
export class AppModule {}
