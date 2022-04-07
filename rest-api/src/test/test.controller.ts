import {
  Body,
  Controller,
  Delete,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { CreateSmtDto } from './dto/create-smt.dto';
import { UpdateSmtDto } from './dto/update-smt.dto';

@Controller('test')
export class TestController {
  @Post()
  @HttpCode(HttpStatus.CREATED)
  //@Header('Cache-Control', None)
  create(@Body() CreateSmtDto: CreateSmtDto) {
    return `title = ${CreateSmtDto.title} d = ${CreateSmtDto.description}`;
  }

  @Delete(':id')
  delete(@Param('id') id: string) {
    return `remove ${id}`;
  }

  @Put(':id')
  update(@Body() UpdateSmtDto: UpdateSmtDto, @Param('id') id: string) {
    return `update ${id}`;
  }
}
