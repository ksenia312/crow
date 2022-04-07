import { Controller, Get, Param, Redirect } from '@nestjs/common';

@Controller('levels')
export class LevelsController {
  @Get()
  // @Redirect('https://www.google.com/', 301)
  getAll() {
    return 'getAll';
  }

  @Get(':id')
  getLevel(@Param('id') id: string) {
    return 'getAll' + id;
  }
}
