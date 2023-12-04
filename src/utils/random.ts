export const randomBetween = (min: number, max: number) => {
  return Math.random() * (max - min) + min;
};

export const randomSign = () => {
  return Math.random() > 0.5 ? 1 : -1;
};
