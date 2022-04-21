import { Injectable } from '@nestjs/common';
import { CreateSmtDto } from './dto/create-smt.dto';

@Injectable() //логика
export class TestService {
  private test = [];

  getAll() {
    return this.test;
  }

  getByID(id: string) {
    return this.test.find((t) => t.id === id);
  }

  create(testDTO: CreateSmtDto) {
    return this.test.push({
      ...testDTO,
      id: Date.now().toString(),
    });
  }
}
