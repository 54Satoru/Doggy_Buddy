import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  window.messageContainer = document.getElementById('message-container')

  if (messageContainer === null) {
    return
  }

  consumer.subscriptions.create("RoomChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      messageContainer.insertAdjacentHTML('beforeend', data['message'])
    }
  })

  const documentElement = document.documentElement
  window.messageContent = document.getElementById('message_content')
  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight)
  }

  scrollToBottom()


  const messageButton = document.getElementById('message-button')

  const button_activation = () => {
    if (messageContent.value === '') {
      messageButton.classList.add('disabled')
    } else {
      messageButton.classList.remove('disabled')
    }
  }

  messageContent.addEventListener('input', () => {
    button_activation()
  })

  messageButton.addEventListener('click', () => {
    messageButton.classList.add('disabled')
  })


  messageContent.addEventListener('input', () => {
    button_activation()
    changeLineCheck()
  })

  messageButton.addEventListener('click', () => {
    messageButton.classList.add('disabled')
    changeLineCount(1)
  })

  const maxLineCount = 10

  const getLineCount = () => {
    return (messageContent.value + '\n').match(/\r?\n/g).length;
  }

  let lineCount = getLineCount()
  let newLineCount

  const changeLineCheck = () => {
    newLineCount = Math.min(getLineCount(), maxLineCount)
    if (lineCount !== newLineCount) {
      changeLineCount(newLineCount)
    }
  }

  const messageForm = document.getElementById('message-form')
  let messageFormHeight = messageForm.scrollHeight
  let newMessageFormHeight, messageFormHeightDiff

  const changeLineCount = (newLineCount) => {
    // フォームの行数を変更
    messageContent.rows = lineCount = newLineCount
    // 新しいフッターの高さを取得し，違いを計算
    newMessageFormHeight = messageForm.scrollHeight
    messageFormHeightDiff = newMessageFormHeight - messageFormHeight
    // 新しいフッターの高さをチャット欄の padding-bottom に反映し，スクロールさせる
    // 行数が増える時と減る時で操作順を変更しないとうまくいかない
    if (messageFormHeightDiff > 0) {
      messageContainer.style.paddingBottom = newMessageFormHeight + 'px'
      window.scrollBy(0, messageFormHeightDiff)
    } else {
      window.scrollBy(0, messageFormHeightDiff)
      messageContainer.style.paddingBottom = newMessageFormHeight + 'px'
    }
    messageFormHeight = newMessageFormHeight
  }


  let oldestMessageId

  window.showAdditionally = true

  window.addEventListener('scroll', () => {
    if (documentElement.scrollTop === 0 && showAdditionally) {
      showAdditionally = false

      oldestMessageId = document.getElementsByClassName('message')[0].id.replace(/[^0-9]/g, '')

      $.ajax({
        type: 'GET',
        url: '/show_additionally',
        cache: false,
        data: {oldest_message_id: oldestMessageId, remote: true}
      })
    }
  }, {passive: true});
})
