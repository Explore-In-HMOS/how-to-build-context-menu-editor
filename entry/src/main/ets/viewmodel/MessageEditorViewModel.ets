@Observed
export class MessageEditorViewModel {
  public currentText: string = 'Select a quick reply or type here...';
  public characterCount: number = 0;
  public pasteCount: number = 0;
  public clearCount: number = 0;
  public emojiCount: number = 0;
  public lastAction: string = 'Initialized';
  public isEditorActive: boolean = true;

  public updateAnalytics(actionType: string, textLength: number): void {
    this.lastAction = actionType;
    this.characterCount = textLength;

    if (actionType === 'Paste') {
      this.pasteCount++;
    } else if (actionType === 'Clear') {
      this.clearCount++;
    } else if (actionType === 'Format Emoji') {
      this.emojiCount++;
    }
  }

  public appendText(newContent: string): void {
    if (!this.isEditorActive) {
      return;
    }
    this.currentText += newContent;
    this.updateAnalytics('Text Appended', this.currentText.length);
  }

  public clearPlaceholderOnly(): void {
    if (this.currentText === 'Select a quick reply or type here...') {
      this.currentText = '';
      this.updateAnalytics('Clear Placeholder', 0);
    }
  }

  public clearTextContent(): void {
    this.currentText = '';
    this.updateAnalytics('Clear', 0);
  }

  public applyTemplate(templateText: string): void {
    if (this.currentText === 'Select a quick reply or type here...') {
      this.currentText = templateText;
    } else {
      this.currentText += ` ${templateText}`;
    }
    this.updateAnalytics('Template Select', this.currentText.length);
  }

  public addEmoji(symbol: string): void {
    this.currentText += ` ${symbol}`;
    this.updateAnalytics('Format Emoji', this.currentText.length);
  }

  public cutText(): void {
    this.updateAnalytics('Cut', 0);
    this.currentText = '';
  }

  public copyText(): void {
    this.updateAnalytics('Copy', this.currentText.length);
  }

  public pasteText(): void {
    this.currentText += ' [Pasted]';
    this.updateAnalytics('Paste', this.currentText.length);
  }

  public uppercaseAll(): void {
    this.currentText = this.currentText.toUpperCase();
    this.updateAnalytics('Uppercase', this.currentText.length);
  }

  public lowercaseAll(): void {
    this.currentText = this.currentText.toLowerCase();
    this.updateAnalytics('Lowercase', this.currentText.length);
  }

  public resetAnalytics(): void {
    this.pasteCount = 0;
    this.clearCount = 0;
    this.emojiCount = 0;
    this.updateAnalytics('Reset Stats', this.currentText.length);
  }
}