import { EmojiOption, EMOJI_OPTIONS, MessageTemplate, MOCK_TEMPLATES } from '../model/MessageModel';
import { MessageEditorViewModel } from '../viewmodel/MessageEditorViewModel';

@Entry
@Component
struct Index {
  @State viewModel: MessageEditorViewModel = new MessageEditorViewModel();

  @Builder
  EmojiSubMenu() {
    Menu() {
      ForEach(EMOJI_OPTIONS, (emoji: EmojiOption) => {
        MenuItem({ content: `${emoji.symbol} ${emoji.label}` })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.addEmoji(emoji.symbol);
          })
      }, (emoji: EmojiOption) => emoji.id)
    }
  }

  @Builder
  TextSelectionBar() {
    Menu() {
      MenuItemGroup({ header: $r('app.string.menu_text_utilities') }) {
        MenuItem({ content: $r('app.string.action_cut_text') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.cutText();
          })

        MenuItem({ content: $r('app.string.action_copy_text') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.copyText();
          })

        MenuItem({ content: $r('app.string.action_paste_text') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.pasteText();
          })
      }

      MenuItemGroup({ header: $r('app.string.menu_quick_actions') }) {
        MenuItem({ content: $r('app.string.action_uppercase_all') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.uppercaseAll();
          })

        MenuItem({ content: $r('app.string.action_lowercase_all') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.lowercaseAll();
          })
      }
    }
  }

  @Builder
  QuickReplyMenuSystem() {
    Menu() {
      MenuItemGroup({ header: $r('app.string.menu_quick_formatting') }) {
        MenuItem({ content: $r('app.string.action_clear_editor') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.clearTextContent();
          })

        MenuItem({
          content: $r('app.string.action_add_emoji'),
          builder: (): void => this.EmojiSubMenu()
        })
          .height(16)
          .contentFont({ size: 12 })
      }

      MenuItemGroup({ header: $r('app.string.menu_advanced_options') }) {
        MenuItem({
          content: $r('app.string.action_selection_menu'),
          builder: (): void => this.TextSelectionBar()
        })
          .height(16)
          .contentFont({ size: 12 })

        MenuItem({ content: $r('app.string.action_reset_analytics') })
          .height(16)
          .contentFont({ size: 12 })
          .onClick(() => {
            this.viewModel.resetAnalytics();
          })
      }
    }.height('70%')
  }

  @Builder
  HeaderSection() {
    Column() {
      Text($r('app.string.header_title'))
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_gray'))
        .margin({ top: 20, bottom: 2 })

      Text($r('app.string.header_subtitle'))
        .fontSize(10)
        .fontColor($r('app.color.text_light_gray'))
        .margin({ bottom: 12 })
    }
  }

  @Builder
  EditorDisplaySection() {
    Column() {
      Column() {
        Text(this.viewModel.currentText)
          .fontSize(14)
          .fontColor($r('app.color.text_black'))
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding(8)
      }
      .width('85%')
      .height(100)
      .backgroundColor($r('app.color.editor_background'))
      .borderRadius(8)
      .onClick(() => {
        this.viewModel.clearPlaceholderOnly();
      })
      .bindMenu(this.QuickReplyMenuSystem)

      Text($r('app.string.editor_tip'))
        .fontSize(10)
        .width('85%')
        .fontColor($r('app.color.text_orange'))
        .margin({ top: 4, bottom: 12 })
    }
  }

  @Builder
  TemplateListSection() {
    Column() {
      Text($r('app.string.smart_replies_header'))
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.text_white'))
        .width('80%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 6 })

      ForEach(MOCK_TEMPLATES, (item: MessageTemplate) => {
        Button(item.text)
          .width('80%')
          .height(32)
          .margin({ bottom: 6 })
          .fontSize(13)
          .backgroundColor($r('app.color.button_background'))
          .onClick(() => {
            this.viewModel.applyTemplate(item.text);
          })
      }, (item: MessageTemplate) => item.id)
    }
    .margin({ bottom: 10 })
  }

  @Builder
  AnalyticsDashboardSection() {
    Column() {
      Text($r('app.string.analytics_header'))
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_gray'))
        .margin({ bottom: 4 })

      Row() {
        Text(`Chars: ${this.viewModel.characterCount}`)
          .fontSize(10)
          .fontColor($r('app.color.text_white'))
        Text(`Pastes: ${this.viewModel.pasteCount}`)
          .fontSize(10)
          .fontColor($r('app.color.text_white'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      Row() {
        Text(`Clears: ${this.viewModel.clearCount}`)
          .fontSize(10)
          .fontColor($r('app.color.text_white'))
        Text(`Emojis: ${this.viewModel.emojiCount}`)
          .fontSize(10)
          .fontColor($r('app.color.text_white'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ top: 2 })

      Text(`Last Event: ${this.viewModel.lastAction}`)
        .fontSize(10)
        .fontColor($r('app.color.text_yellow'))
        .margin({ top: 6 })
    }
    .width('75%')
    .padding(8)
    .margin({ top: 5, bottom: 20 })
    .backgroundColor($r('app.color.analytics_background'))
    .borderRadius(6)
  }

  build() {
    Scroll() {
      Column() {
        this.HeaderSection()
        this.EditorDisplaySection()
        this.TemplateListSection()
        this.AnalyticsDashboardSection()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}