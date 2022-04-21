import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { CreateSmtDto } from './dto/create-smt.dto';
import { UpdateSmtDto } from './dto/update-smt.dto';
import { TestService } from './test.service';

@Controller('test') // запросы перенаправления параметры
export class TestController {
  constructor(private readonly TestService: TestService) {}

  @Get()
  getAll() {
    return this.TestService.getAll();
  }

  @Get(':id')
  getOne(@Param('id') id: string) {
    return this.TestService.getByID(id);
  }

  @Post()
  @HttpCode(HttpStatus.CREATED)
  create(@Body() CreateSmtDto: CreateSmtDto) {
    return this.TestService.create(CreateSmtDto);
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
