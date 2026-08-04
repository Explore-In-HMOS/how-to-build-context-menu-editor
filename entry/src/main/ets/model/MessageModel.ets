export interface MessageTemplate {
  id: string;
  text: string;
  category: string;
}

export interface EmojiOption {
  id: string;
  label: string;
  symbol: string;
}

export const MOCK_TEMPLATES: MessageTemplate[] = [
  { id: '1', text: 'On my way! 🏃', category: 'Status' },
  { id: '2', text: 'Can not talk right now. 🤫', category: 'Status' },
  { id: '3', text: 'Yes, sounds great! 👍', category: 'Response' },
  { id: '4', text: 'Please call me later.📞', category: 'Response' },
  { id: '5', text: 'Running a bit late. ⏰', category: 'Status' },
  { id: '6', text: 'Thanks a lot! 🙏', category: 'Response' }
];

export const EMOJI_OPTIONS: EmojiOption[] = [
  { id: 'e1', label: 'Fire', symbol: '🔥' },
  { id: 'e2', label: 'Thumbs Up', symbol: '👍' },
  { id: 'e3', label: 'Heart', symbol: '❤️' },
  { id: 'e4', label: 'Laugh', symbol: '😂' },
  { id: 'e5', label: 'Rocket', symbol: '🚀' },
  { id: 'e6', label: 'Party', symbol: '🎉' },
  { id: 'e7', label: 'Check', symbol: '✅' }
];