export interface Item {
  id: string;
  name: string;
  description?: string;
  price: number;
  category?: string;
  createdBy: {
    id: string;
    name: string;
    email: string;
    role: string;
  };
  createdAt: string;
  updatedAt: string;
}

export interface ItemRequest {
  name: string;
  description?: string;
  price: number;
  category?: string;
}
