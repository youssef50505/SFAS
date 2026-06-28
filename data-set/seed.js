const { Client } = require('pg');
const bcrypt = require('bcryptjs');
const { v4: uuidv4 } = require('uuid');
const { faker } = require('@faker-js/faker');

const dbConfig = {
  user: 'postgres',
  host: 'localhost',
  database: 'sfas',
  password: 'password',
  port: 5432,
};

async function seed() {
  const client = new Client(dbConfig);
  try {
    await client.connect();
    console.log('Connected to the database.');

    // Truncate tables to ensure a clean slate
    console.log('Truncating existing tables...');
    await client.query('TRUNCATE TABLE reports, request_funds, bills, items, vendors, users CASCADE');

    const users = [];
    const vendors = [];

    // Create 10 Users
    console.log('Seeding Users...');
    for (let i = 0; i < 10; i++) {
      const isFirstAdmin = i === 0;
      const isSecondFinance = i === 1;
      const role = isFirstAdmin ? 'ADMIN' : isSecondFinance ? 'FINANCE_OFFICER' : (i % 2 === 0 ? 'ADMIN' : 'FINANCE_OFFICER');
      const email = isFirstAdmin ? 'admin@school.com' : isSecondFinance ? 'finance@company.com' : faker.internet.email();
      const passwordHash = await bcrypt.hash('password123', 10);
      
      const user = {
        id: uuidv4(),
        name: isFirstAdmin ? 'Main Admin' : isSecondFinance ? 'Main Finance' : faker.person.fullName(),
        role: role,
        email: email,
        password: passwordHash
      };
      
      await client.query(
        'INSERT INTO users (id, name, role, email, password) VALUES ($1, $2, $3, $4, $5)',
        [user.id, user.name, user.role, user.email, user.password]
      );
      users.push(user);
    }

    const admins = users.filter(u => u.role === 'ADMIN');
    const financeOfficers = users.filter(u => u.role === 'FINANCE_OFFICER');

    // Create 10 Vendors
    console.log('Seeding Vendors...');
    for (let i = 0; i < 10; i++) {
      const vendor = {
        id: uuidv4(),
        name: faker.company.name(),
        contact_email: faker.internet.email(),
        phone_number: faker.phone.number(),
        tax_id: faker.string.alphanumeric(10),
        address: faker.location.streetAddress(),
        created_by_id: admins[faker.number.int({ min: 0, max: admins.length - 1 })].id
      };
      
      await client.query(
        'INSERT INTO vendors (id, name, contact_email, phone_number, tax_id, address, created_at, updated_at, created_by_id) VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW(), $7)',
        [vendor.id, vendor.name, vendor.contact_email, vendor.phone_number, vendor.tax_id, vendor.address, vendor.created_by_id]
      );
      vendors.push(vendor);
    }

    // Create 10 Items
    console.log('Seeding Items...');
    for (let i = 0; i < 10; i++) {
      await client.query(
        'INSERT INTO items (id, name, description, price, category, created_at, updated_at, created_by_id) VALUES ($1, $2, $3, $4, $5, NOW(), NOW(), $6)',
        [
          uuidv4(),
          faker.commerce.productName(),
          faker.commerce.productDescription(),
          faker.commerce.price({ min: 10, max: 1000 }),
          faker.commerce.department(),
          admins[faker.number.int({ min: 0, max: admins.length - 1 })].id
        ]
      );
    }

    // Create 10 Bills
    console.log('Seeding Bills...');
    const statuses = ['PENDING', 'APPROVED', 'REJECTED'];
    for (let i = 0; i < 10; i++) {
      const status = statuses[faker.number.int({ min: 0, max: 2 })];
      const reviewer = status !== 'PENDING' ? financeOfficers[faker.number.int({ min: 0, max: financeOfficers.length - 1 })].id : null;
      
      await client.query(
        'INSERT INTO bills (id, title, amount, date, description, status, image_path, review_comments, created_at, updated_at, created_by_id, vendor_id, reviewed_by_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, NOW(), NOW(), $9, $10, $11)',
        [
          uuidv4(),
          faker.finance.transactionDescription(),
          faker.finance.amount({ min: 100, max: 5000 }),
          faker.date.recent(),
          faker.lorem.sentence(),
          status,
          null, // image_path
          status !== 'PENDING' ? faker.lorem.sentence() : null, // review_comments
          admins[faker.number.int({ min: 0, max: admins.length - 1 })].id,
          vendors[faker.number.int({ min: 0, max: vendors.length - 1 })].id,
          reviewer
        ]
      );
    }

    // Create 10 Request Funds
    console.log('Seeding Request Funds...');
    const urgencies = ['LOW', 'MEDIUM', 'HIGH', 'CRITICAL'];
    for (let i = 0; i < 10; i++) {
      const status = statuses[faker.number.int({ min: 0, max: 2 })];
      const reviewer = status !== 'PENDING' ? financeOfficers[faker.number.int({ min: 0, max: financeOfficers.length - 1 })].id : null;

      await client.query(
        'INSERT INTO request_funds (id, title, description, amount_of_fund, urgency_level, date, image_path, status, review_comments, created_at, updated_at, created_by_id, reviewed_by_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW(), NOW(), $10, $11)',
        [
          uuidv4(),
          faker.commerce.productName() + ' Request',
          faker.lorem.paragraph(),
          faker.finance.amount({ min: 500, max: 20000 }),
          urgencies[faker.number.int({ min: 0, max: 3 })],
          faker.date.recent(),
          null,
          status,
          status !== 'PENDING' ? faker.lorem.sentence() : null,
          admins[faker.number.int({ min: 0, max: admins.length - 1 })].id,
          reviewer
        ]
      );
    }

    // Create 10 Reports
    console.log('Seeding Reports...');
    const types = ['EMAIL', 'IN_APP'];
    for (let i = 0; i < 10; i++) {
      await client.query(
        'INSERT INTO reports (id, date, title, description, type_of_report, created_at, updated_at, created_by_id) VALUES ($1, $2, $3, $4, $5, NOW(), NOW(), $6)',
        [
          uuidv4(),
          faker.date.recent(),
          faker.company.catchPhrase() + ' Report',
          faker.lorem.paragraph(),
          types[faker.number.int({ min: 0, max: 1 })],
          admins[faker.number.int({ min: 0, max: admins.length - 1 })].id
        ]
      );
    }

    console.log('Seeding completed successfully!');
  } catch (error) {
    console.error('Error during seeding:', error);
  } finally {
    await client.end();
  }
}

seed();
