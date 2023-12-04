import { randomBetween, randomSign } from '../utils/random';

export class Rover {
  windSpeed: number;
  temperature: number;

  constructor(public readonly name: string) {
    this.windSpeed = randomBetween(0, 100);
    this.temperature = randomBetween(-100, 100);
  }

  updateWind() {
    const inc = Math.random() * 5;
    const sign: number = randomSign();

    this.windSpeed = Math.max(this.windSpeed + inc * sign, 0);
  }

  updateTemperature() {
    const inc = Math.random() * 2;
    const sign: number = randomSign();

    this.temperature = this.temperature + inc * sign;
  }
}
