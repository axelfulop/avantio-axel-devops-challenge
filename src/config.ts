export const config = () => ({
  port: parseInt(process.env.PORT, 10) || 3000,
  updateInterval: parseInt(process.env.UPDATE_INTERVAL, 10) || 1000,
});
