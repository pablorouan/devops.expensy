'use client';

import apiClient from './apiclient';

// Fetch all expenses
export const fetchExpensesAPI = async (): Promise<
  { name: string; amount: number; category: string }[]
> => {
  try {
    const response = await apiClient.get('/api/expenses');
    // Ensure we always return an array
    return Array.isArray(response.data) ? response.data : [];
  } catch (error) {
    console.error('[fetchExpensesAPI] Error fetching expenses:', error);
    return []; // Return empty array instead of throwing
  }
};

// Add a new expense
export const addExpensesAPI = async (
  name: string,
  amount: number,
  category: string
) => {
  try {
    const response = await apiClient.post('/api/expenses', {
      name,
      amount,
      category,
    });
    return response.data;
  } catch (error) {
    console.error('[addExpensesAPI] Error adding expense:', error);
    throw error;
  }
};
