import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { LevelsController } from './levels/levels.controller';
import { TestController } from './test/test.controller';

@Module({
  imports: [],
  controllers: [AppController, LevelsController, TestController],
  providers: [AppService],
})
export class AppModule {}
