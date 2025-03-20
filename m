Return-Path: <linux-kernel+bounces-569720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04868A6A699
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F9719C413F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA217996;
	Thu, 20 Mar 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="BucDZ/t8"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53618E2A;
	Thu, 20 Mar 2025 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475400; cv=none; b=T7X9fY8UmOCHxW7YN9qg5vlJAIfs8pwcN4yAuo4tbpWabEyDZjEYL+HO99RWfVQcGiMZMw6bCOsM8EWYJgJGnFAihtzuiPyXNPsF0eOH/BlGG5BKbHC+mbfzHFdSLrzaFV9fRD3IIAL014AdGRBnQiBzYeLFrkiS16VTmUob6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475400; c=relaxed/simple;
	bh=sRUI2jzqEs2f9as7vJf0V/U+1KW/OBzGcUm1+Qwh+wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=An12sxmgaqJFfw9sEzLFLat4Inv1wo1e79yrXZynIwM1f3drJONvd4drlrSydctgcNeYMlKDFdJX4qg49Isp3RlKfbZJzZ8xb6feS2f0DLUyCeYvHB9aLIlYXJEql4Kq6SbpeUdfCJLOTM9JwSF1BoXqeuq4hoDiPHl39ChV+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=BucDZ/t8; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [192.168.2.71] (office.icewarp.com [82.113.48.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id DEB531653EA;
	Thu, 20 Mar 2025 13:56:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1742475393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t8Bsfd8niP3QwBQ/M3PzVpd4oPoKsL6VL/b4RXjMQzY=;
	b=BucDZ/t8bu21mOT0BgKhZN+SY6K4RZCG63JioKjCQSQSObZn4jMJtDdB4VIisLIlc8I+iA
	6xZLLStAwzJuKxzjTvEWV6WQv8kzUYVYHaZqjiT0p28bAcxct0VfVu/dEG7PAbO7juaXH5
	UXhgDBsK+hk8puNENUO0FvLXYYHyPRQ=
Message-ID: <a09d6d03-2c27-40c9-93d7-1462d9a28923@ixit.cz>
Date: Thu, 20 Mar 2025 13:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
 johan@kernel.org, martin.blumenstingl@googlemail.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250204135842.3703751-1-clabbe@baylibre.com>
 <20250204135842.3703751-2-clabbe@baylibre.com>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20250204135842.3703751-2-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for 8th revision!

Acked-by: David Heidelberg <david@ixit.cz>

On 04/02/2025 14:58, Corentin Labbe wrote:
> The CH348 is an USB octo port serial adapter.
> The device multiplexes all 8 ports in the same pair of Bulk endpoints.
> Since there is no public datasheet, unfortunately it remains some magic values
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   drivers/usb/serial/Kconfig  |   9 +
>   drivers/usb/serial/Makefile |   1 +
>   drivers/usb/serial/ch348.c  | 736 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 746 insertions(+)
>   create mode 100644 drivers/usb/serial/ch348.c
> 
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index ef8d1c73c754..1e1842656b54 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -112,6 +112,15 @@ config USB_SERIAL_CH341
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called ch341.
>   
> +config USB_SERIAL_CH348
> +	tristate "USB Winchiphead CH348 Octo Port Serial Driver"
> +	help
> +	  Say Y here if you want to use a Winchiphead CH348 octo port
> +	  USB to serial adapter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ch348.
> +
>   config USB_SERIAL_WHITEHEAT
>   	tristate "USB ConnectTech WhiteHEAT Serial Driver"
>   	select USB_EZUSB_FX2
> diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> index c7bb1a88173e..d16ff59fde68 100644
> --- a/drivers/usb/serial/Makefile
> +++ b/drivers/usb/serial/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_USB_SERIAL_AIRCABLE)		+= aircable.o
>   obj-$(CONFIG_USB_SERIAL_ARK3116)		+= ark3116.o
>   obj-$(CONFIG_USB_SERIAL_BELKIN)			+= belkin_sa.o
>   obj-$(CONFIG_USB_SERIAL_CH341)			+= ch341.o
> +obj-$(CONFIG_USB_SERIAL_CH348)			+= ch348.o
>   obj-$(CONFIG_USB_SERIAL_CP210X)			+= cp210x.o
>   obj-$(CONFIG_USB_SERIAL_CYBERJACK)		+= cyberjack.o
>   obj-$(CONFIG_USB_SERIAL_CYPRESS_M8)		+= cypress_m8.o
> diff --git a/drivers/usb/serial/ch348.c b/drivers/usb/serial/ch348.c
> new file mode 100644
> index 000000000000..01b61d74c4a4
> --- /dev/null
> +++ b/drivers/usb/serial/ch348.c
> @@ -0,0 +1,736 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB serial driver for USB to Octal UARTs chip ch348.
> + *
> + * Copyright (C) 2023 Corentin Labbe <clabbe@baylibre.com>
> + * With the help of Neil Armstrong <neil.armstrong@linaro.org>
> + * Copyright (C) 2024 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> + *
> + * Based on the ch9344 driver:
> + *   https://github.com/WCHSoftGroup/ch9344ser_linux/
> + *   Copyright (C) 2024 Nanjing Qinheng Microelectronics Co., Ltd.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/kfifo.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/serial.h>
> +#include <linux/serial_reg.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +#include <linux/workqueue.h>
> +
> +#define CH348_CMD_TIMEOUT   2000
> +
> +#define CH348_CTO_D	0x01
> +#define CH348_CTO_R	0x02
> +
> +#define CH348_CTI_C	0x10
> +#define CH348_CTI_DSR	0x20
> +#define CH348_CTI_R	0x40
> +#define CH348_CTI_DCD	0x80
> +
> +#define CMD_W_R		0xC0
> +#define CMD_W_BR	0x80
> +
> +#define CMD_WB_E	0x90
> +#define CMD_RB_E	0xC0
> +
> +#define M_NOR		0x00
> +#define M_HF		0x03
> +
> +#define R_MOD		0x97
> +#define R_IO_D		0x98
> +#define R_IO_O		0x99
> +#define R_IO_I		0x9b
> +#define R_TM_O		0x9c
> +#define R_INIT		0xa1
> +
> +#define CMD_VER		0x96
> +
> +/* 0x10 is normally UART_MCR_LOOP but for CH348 it's UART_MCR_RTS */
> +#define UART_MCR_RTS_CH348	0x10
> +
> +/*
> + * The CH348 multiplexes rx & tx into a pair of Bulk USB endpoints for the 8
> + * serial ports, and another pair of Bulk USB endpoints to set port settings
> + * and receive port status events.
> + *
> + * The USB serial cores ties every Bulk endpoints pairs to each ports, In our
> + * case it will set port 0 with the rx/tx endpoints and port 1 with the
> + * setup/status endpoints.
> + *
> + * For bulk writes we skip all of USB serial core's helpers and implement it on
> + * our own since for serial TX we need to not only wait for the URB to complete
> + * but also for the UART_IIR_THRI signal.
> + *
> + * For bulk reads we use USB serial core's helpers, even for the status/int
> + * handling as it simplifies our code.
> + */
> +#define CH348_MAXPORT				8
> +#define CH348_PORTNUM_SERIAL_RX_TX		0
> +#define CH348_PORTNUM_STATUS_INT_CONFIG		1
> +
> +#define CH348_RX_PORT_MAX_LENGTH	30
> +
> +struct ch348_rxbuf {
> +	u8 port;
> +	u8 length;
> +	u8 data[CH348_RX_PORT_MAX_LENGTH];
> +} __packed;
> +
> +struct ch348_txbuf {
> +	u8 port;
> +	__le16 length;
> +	u8 data[];
> +} __packed;
> +
> +#define CH348_TX_HDRSIZE offsetof(struct ch348_txbuf, data)
> +
> +struct ch348_initbuf {
> +	u8 cmd;
> +	u8 reg;
> +	u8 port;
> +	__be32 baudrate;
> +	u8 format;
> +	u8 paritytype;
> +	u8 databits;
> +	u8 rate;
> +	u8 unknown;
> +} __packed;
> +
> +#define CH348_INITBUF_FORMAT_STOPBITS		0x2
> +#define CH348_INITBUF_FORMAT_NO_STOPBITS	0x0
> +
> +/*
> + * struct ch348_port - per-port information
> + * @uartmode:		UART port current mode
> + * @baudrate:		A cached copy of current baudrate for the RX logic
> + */
> +struct ch348_port {
> +	u8 uartmode;
> +	speed_t baudrate;
> +};
> +
> +/*
> + * struct ch348 - main container for all this driver information
> + * @udev:		pointer to the CH348 USB device
> + * @ports:		List of per-port information
> + * @serial:		pointer to the serial structure
> + * @write_work:		worker for processing the write queues
> + * @txbuf_completion:	indicates that the TX buffer has been fully written out
> + * @tx_ep:		endpoint number for serial data transmit/write operation
> + * @config_ep:		endpoint number for configure operations
> + * @small_package:	indicates package size: small (CH348Q) or large (CH348L)
> + */
> +struct ch348 {
> +	struct usb_device *udev;
> +	struct ch348_port ports[CH348_MAXPORT];
> +	struct usb_serial *serial;
> +
> +	struct work_struct write_work;
> +	struct completion txbuf_completion;
> +
> +	int tx_ep;
> +	int config_ep;
> +
> +	bool small_package;
> +};
> +
> +struct ch348_serial_config {
> +	u8 action;
> +	u8 reg;
> +	u8 control;
> +} __packed;
> +
> +struct ch348_status_entry {
> +	u8 portnum;
> +	u8 reg_iir;
> +	union {
> +		u8 lsr_signal;
> +		u8 modem_signal;
> +		u8 init_data[10];
> +	};
> +} __packed;
> +
> +#define CH348_STATUS_ENTRY_PORTNUM_MASK		0xf
> +
> +static void ch348_process_status_urb(struct usb_serial *serial, struct urb *urb)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +	struct ch348_status_entry *status_entry;
> +	struct usb_serial_port *port;
> +	unsigned int i, status_len;
> +	u8 portnum;
> +
> +	if (urb->actual_length < 3) {
> +		dev_warn_ratelimited(&ch348->udev->dev,
> +				     "Received too short status buffer with %u bytes\n",
> +				     urb->actual_length);
> +		return;
> +	}
> +
> +	for (i = 0; i < urb->actual_length;) {
> +		status_entry = urb->transfer_buffer + i;
> +		portnum = status_entry->portnum & CH348_STATUS_ENTRY_PORTNUM_MASK;
> +
> +		if (portnum >= CH348_MAXPORT) {
> +			dev_warn_ratelimited(&ch348->udev->dev,
> +					     "Invalid port %d in status entry\n",
> +					     portnum);
> +			break;
> +		}
> +
> +		port = serial->port[portnum];
> +		status_len = 3;
> +
> +		if (!status_entry->reg_iir) {
> +			dev_dbg(&port->dev, "Ignoring status with zero reg_iir\n");
> +		} else if (status_entry->reg_iir == R_INIT) {
> +			status_len = 12;
> +		} else if ((status_entry->reg_iir & UART_IIR_ID) == UART_IIR_RLSI) {
> +			if (status_entry->lsr_signal & UART_LSR_OE)
> +				port->icount.overrun++;
> +			if (status_entry->lsr_signal & UART_LSR_PE)
> +				port->icount.parity++;
> +			if (status_entry->lsr_signal & UART_LSR_FE)
> +				port->icount.frame++;
> +			if (status_entry->lsr_signal & UART_LSR_BI)
> +				port->icount.brk++;
> +		} else if ((status_entry->reg_iir & UART_IIR_ID) == UART_IIR_THRI) {
> +			complete_all(&ch348->txbuf_completion);
> +		} else {
> +			dev_warn_ratelimited(&port->dev,
> +					     "Unsupported status with reg_iir 0x%02x\n",
> +					     status_entry->reg_iir);
> +		}
> +
> +		i += status_len;
> +	}
> +}
> +
> +static void ch348_process_serial_rx_urb(struct usb_serial *serial,
> +					struct urb *urb)
> +{
> +	unsigned int portnum, serial_rx_len, i;
> +	struct usb_serial_port *port;
> +	struct ch348_rxbuf *rxb;
> +
> +	if (urb->actual_length < 2) {
> +		dev_dbg(&serial->dev->dev, "Empty rx buffer\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < urb->actual_length; i += sizeof(*rxb)) {
> +		rxb = urb->transfer_buffer + i;
> +		portnum = rxb->port;
> +		if (portnum >= CH348_MAXPORT) {
> +			dev_dbg(&serial->dev->dev, "Invalid port %d\n", portnum);
> +			break;
> +		}
> +
> +		port = serial->port[portnum];
> +
> +		serial_rx_len = rxb->length;
> +		if (serial_rx_len > CH348_RX_PORT_MAX_LENGTH) {
> +			dev_dbg(&port->dev, "Invalid length %d for port %d\n",
> +				serial_rx_len, portnum);
> +			break;
> +		}
> +
> +		tty_insert_flip_string(&port->port, rxb->data, serial_rx_len);
> +		tty_flip_buffer_push(&port->port);
> +
> +		port->icount.rx += serial_rx_len;
> +	}
> +}
> +
> +static void ch348_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +
> +	if (port->port_number == CH348_PORTNUM_SERIAL_RX_TX)
> +		ch348_process_serial_rx_urb(port->serial, urb);
> +	else if (port->port_number == CH348_PORTNUM_STATUS_INT_CONFIG)
> +		ch348_process_status_urb(port->serial, urb);
> +	else
> +		dev_warn_ratelimited(&port->serial->dev->dev,
> +				     "Ignoring read URB callback for unknown port/endpoint %u\n",
> +				     port->port_number);
> +}
> +
> +static int ch348_port_config(struct usb_serial_port *port, u8 action, u8 reg,
> +			     u8 control)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	struct ch348_serial_config *buffer;
> +	int ret;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	if (port->port_number < 4)
> +		reg += 0x10 * port->port_number;
> +	else
> +		reg += 0x10 * (port->port_number - 4) + 0x08;
> +
> +	buffer->action = action;
> +	buffer->reg = reg;
> +	buffer->control = control;
> +
> +	ret = usb_bulk_msg(ch348->udev, ch348->config_ep, buffer,
> +			   sizeof(*buffer), NULL, CH348_CMD_TIMEOUT);
> +	if (ret) {
> +		dev_err(&ch348->udev->dev, "Failed to write port config: %d\n", ret);
> +		goto out;
> +	}
> +
> +out:
> +	kfree(buffer);
> +
> +	return ret;
> +}
> +
> +static int ch348_write(struct tty_struct *tty, struct usb_serial_port *port,
> +		       const unsigned char *buf, int count)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +
> +	if (!count)
> +		return 0;
> +
> +	count = kfifo_in_locked(&port->write_fifo, buf, count, &port->lock);
> +
> +	schedule_work(&ch348->write_work);
> +
> +	return count;
> +}
> +
> +static int ch348_set_uartmode(struct usb_serial_port *port, u8 mode)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	unsigned int portnum = port->port_number;
> +	int ret;
> +
> +	if (ch348->ports[portnum].uartmode == M_NOR && mode == M_HF) {
> +		ret = ch348_port_config(port, CMD_W_BR, UART_MCR,
> +					UART_MCR_DTR | UART_MCR_RTS_CH348 |
> +					UART_MCR_TCRTLR);
> +		if (ret)
> +			return ret;
> +		ch348->ports[portnum].uartmode = M_HF;
> +	}
> +
> +	if (ch348->ports[portnum].uartmode == M_HF && mode == M_NOR) {
> +		ret = ch348_port_config(port, CMD_W_BR, UART_MCR,
> +					UART_MCR_RTS_CH348 | UART_MCR_TCRTLR);
> +		if (ret)
> +			return ret;
> +		ch348->ports[portnum].uartmode = M_NOR;
> +	}
> +	return 0;
> +}
> +
> +static void ch348_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
> +			      const struct ktermios *termios_old)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	struct ktermios *termios = &tty->termios;
> +	int ret, portnum = port->port_number;
> +	struct ch348_initbuf *buffer;
> +	speed_t	baudrate;
> +
> +	if (termios_old && !tty_termios_hw_change(&tty->termios, termios_old))
> +		return;
> +
> +	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> +	if (!buffer)
> +		goto out;
> +
> +	/*
> +	 * The datasheet states that only baud rates in range of 1200..6000000
> +	 * are supported. Tests with an oscilloscope confirm that even when
> +	 * configuring a baud rate slower than 1200 the output stays at around
> +	 * 1200 baud.
> +	 */
> +	baudrate = clamp(tty_get_baud_rate(tty), 1200, 6000000);
> +	tty_termios_encode_baud_rate(&tty->termios, baudrate, baudrate);
> +	ch348->ports[port->port_number].baudrate = baudrate;
> +
> +	if (termios->c_cflag & PARENB) {
> +		if  (termios->c_cflag & CMSPAR) {
> +			if (termios->c_cflag & PARODD)
> +				buffer->paritytype = 3;
> +			else
> +				buffer->paritytype = 4;
> +		} else if (termios->c_cflag & PARODD) {
> +			buffer->paritytype = 1;
> +		} else {
> +			buffer->paritytype = 2;
> +		}
> +	} else {
> +		buffer->paritytype = 0;
> +	}
> +
> +	switch (C_CSIZE(tty)) {
> +	case CS5:
> +		buffer->databits = 5;
> +		break;
> +	case CS6:
> +		buffer->databits = 6;
> +		break;
> +	case CS7:
> +		buffer->databits = 7;
> +		break;
> +	case CS8:
> +	default:
> +		buffer->databits = 8;
> +		break;
> +	}
> +
> +	buffer->cmd = CMD_WB_E | portnum;
> +	buffer->reg = R_INIT;
> +	buffer->port = portnum;
> +	buffer->baudrate = cpu_to_be32(baudrate);
> +
> +	if (termios->c_cflag & CSTOPB)
> +		buffer->format = CH348_INITBUF_FORMAT_STOPBITS;
> +	else
> +		buffer->format = CH348_INITBUF_FORMAT_NO_STOPBITS;
> +
> +	buffer->rate = max_t(speed_t, 5, (10000 * 15 / baudrate) + 1);
> +
> +	ret = usb_bulk_msg(ch348->udev, ch348->config_ep, buffer,
> +			   sizeof(*buffer), NULL, CH348_CMD_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&ch348->udev->dev, "Failed to change line settings: err=%d\n",
> +			ret);
> +		goto out_free;
> +	}
> +
> +	ret = ch348_port_config(port, CMD_W_R, UART_IER, UART_IER_RDI |
> +				UART_IER_THRI | UART_IER_RLSI | UART_IER_MSI);
> +	if (ret < 0)
> +		goto out_free;
> +
> +	if (C_CRTSCTS(tty))
> +		ret = ch348_set_uartmode(port, M_HF);
> +	else
> +		ret = ch348_set_uartmode(port, M_NOR);
> +
> +out_free:
> +	kfree(buffer);
> +out:
> +	if (ret && termios_old)
> +		tty->termios = *termios_old;
> +}
> +
> +static int ch348_open(struct tty_struct *tty, struct usb_serial_port *port)
> +{
> +	int ret;
> +
> +	clear_bit(USB_SERIAL_THROTTLED, &port->flags);
> +
> +	if (tty)
> +		ch348_set_termios(tty, port, NULL);
> +
> +	ret = ch348_port_config(port, CMD_W_R, UART_FCR,
> +				UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
> +				UART_FCR_CLEAR_XMIT | UART_FCR_T_TRIG_00 |
> +				UART_FCR_R_TRIG_10);
> +	if (ret) {
> +		dev_err(&port->serial->dev->dev,
> +			"Failed to configure UART_FCR, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = ch348_port_config(port, CMD_W_BR, UART_MCR, UART_MCR_OUT2);
> +	if (ret) {
> +		dev_err(&port->serial->dev->dev,
> +			"Failed to configure UART_MCR, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ch348_close(struct usb_serial_port *port)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	kfifo_reset_out(&port->write_fifo);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void ch348_write_work(struct work_struct *work)
> +{
> +	struct ch348 *ch348 = container_of(work, struct ch348, write_work);
> +	struct usb_serial_port *port, *hw_tx_port;
> +	unsigned int i, max_bytes;
> +	struct ch348_txbuf *rxt;
> +	unsigned long flags;
> +	int ret, count;
> +
> +	reinit_completion(&ch348->txbuf_completion);
> +
> +	hw_tx_port = ch348->serial->port[CH348_PORTNUM_SERIAL_RX_TX];
> +	rxt = hw_tx_port->write_urbs[0]->transfer_buffer;
> +
> +	for (i = 0; i < CH348_MAXPORT; i++) {
> +		port = ch348->serial->port[i];
> +
> +		if (ch348->ports[i].baudrate < 9600)
> +			/*
> +			 * Writing larger buffers can take longer than the
> +			 * hardware allows before discarding the write buffer.
> +			 * Limit the transfer size in such cases.
> +			 * These values have been found by empirical testing.
> +			 */
> +			max_bytes = 128;
> +		else
> +			/*
> +			 * Only ingest as many bytes as we can transfer with
> +			 * one URB at a time keeping the TX header in mind.
> +			 */
> +			max_bytes = hw_tx_port->bulk_out_size - CH348_TX_HDRSIZE;
> +
> +		count = kfifo_out_locked(&port->write_fifo, rxt->data,
> +					 max_bytes, &port->lock);
> +		if (count)
> +			break;
> +	}
> +
> +	if (!count)
> +		return;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	port->tx_bytes += count;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	rxt->port = port->port_number;
> +	rxt->length = cpu_to_le16(count);
> +
> +	usb_serial_debug_data(&port->dev, __func__, count + CH348_TX_HDRSIZE,
> +			      (const unsigned char *)rxt);
> +
> +	ret = usb_bulk_msg(ch348->udev, ch348->tx_ep, rxt,
> +			   count + CH348_TX_HDRSIZE, NULL, CH348_CMD_TIMEOUT);
> +	if (ret) {
> +		dev_err_console(port,
> +				"Failed to bulk write TX buffer, err=%d\n",
> +				ret);
> +		goto write_done;
> +	}
> +
> +	if (!wait_for_completion_timeout(&ch348->txbuf_completion,
> +					 msecs_to_jiffies(CH348_CMD_TIMEOUT)))
> +		dev_err_console(port,
> +				"Failed to wait for TX buffer to be fully written out\n");
> +
> +write_done:
> +	spin_lock_irqsave(&port->lock, flags);
> +	port->tx_bytes -= count;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	port->icount.tx += count;
> +
> +	schedule_work(&ch348->write_work);
> +	usb_serial_port_softint(port);
> +}
> +
> +static int ch348_submit_urbs(struct usb_serial *serial)
> +{
> +	int ret;
> +
> +	ret = usb_serial_generic_open(NULL,
> +				      serial->port[CH348_PORTNUM_SERIAL_RX_TX]);
> +	if (ret) {
> +		dev_err(&serial->dev->dev,
> +			"Failed to open RX/TX port, err=%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = usb_serial_generic_open(NULL,
> +				      serial->port[CH348_PORTNUM_STATUS_INT_CONFIG]);
> +	if (ret) {
> +		dev_err(&serial->dev->dev,
> +			"Failed to submit STATUS/INT URB, err=%d\n", ret);
> +		usb_serial_generic_close(serial->port[CH348_PORTNUM_SERIAL_RX_TX]);
> +	}
> +
> +	return ret;
> +}
> +
> +static void ch348_kill_urbs(struct usb_serial *serial)
> +{
> +	usb_serial_generic_close(serial->port[CH348_PORTNUM_STATUS_INT_CONFIG]);
> +	usb_serial_generic_close(serial->port[CH348_PORTNUM_SERIAL_RX_TX]);
> +}
> +
> +static int ch348_detect_version(struct usb_serial *serial)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +	u8 *version_buf;
> +	int ret;
> +
> +	version_buf = kzalloc(4, GFP_KERNEL);
> +	if (!version_buf)
> +		return -ENOMEM;
> +
> +	ret = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> +			      CMD_VER,
> +			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
> +			      0, 0, version_buf, 4, CH348_CMD_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&serial->dev->dev, "Failed to read CMD_VER: %d\n", ret);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +	ch348->small_package = !!(version_buf[1] & 0x80);
> +
> +	dev_info(&serial->dev->dev, "Found WCH CH348%c\n",
> +		 ch348->small_package ? 'Q' : 'L');
> +
> +out:
> +	kfree(version_buf);
> +
> +	return ret;
> +}
> +
> +static int ch348_attach(struct usb_serial *serial)
> +{
> +	struct usb_serial_port *tx_port, *config_port;
> +	struct ch348 *ch348;
> +	int ret;
> +
> +	ch348 = kzalloc(sizeof(*ch348), GFP_KERNEL);
> +	if (!ch348)
> +		return -ENOMEM;
> +
> +	usb_set_serial_data(serial, ch348);
> +
> +	ch348->udev = serial->dev;
> +	ch348->serial = serial;
> +
> +	INIT_WORK(&ch348->write_work, ch348_write_work);
> +
> +	init_completion(&ch348->txbuf_completion);
> +
> +	tx_port = ch348->serial->port[CH348_PORTNUM_SERIAL_RX_TX];
> +	ch348->tx_ep = usb_sndbulkpipe(ch348->udev,
> +				       tx_port->bulk_out_endpointAddress);
> +
> +	config_port = ch348->serial->port[CH348_PORTNUM_STATUS_INT_CONFIG];
> +	ch348->config_ep = usb_sndbulkpipe(ch348->udev,
> +					   config_port->bulk_out_endpointAddress);
> +
> +	ret = ch348_detect_version(serial);
> +	if (ret)
> +		goto err_free_ch348;
> +
> +	ret = ch348_submit_urbs(serial);
> +	if (ret)
> +		goto err_free_ch348;
> +
> +	return 0;
> +
> +err_free_ch348:
> +	kfree(ch348);
> +	return ret;
> +}
> +
> +static void ch348_release(struct usb_serial *serial)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +
> +	cancel_work_sync(&ch348->write_work);
> +	ch348_kill_urbs(serial);
> +
> +	kfree(ch348);
> +}
> +
> +static int ch348_calc_num_ports(struct usb_serial *serial,
> +				struct usb_serial_endpoints *epds)
> +{
> +	int i;
> +
> +	epds->num_bulk_out = CH348_MAXPORT;
> +
> +	for (i = serial->type->num_bulk_out; i < CH348_MAXPORT; ++i)
> +		epds->bulk_out[i] = epds->bulk_out[0];
> +
> +	return CH348_MAXPORT;
> +}
> +
> +static int ch348_suspend(struct usb_serial *serial, pm_message_t message)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +
> +	cancel_work_sync(&ch348->write_work);
> +
> +	return 0;
> +}
> +
> +static int ch348_resume(struct usb_serial *serial)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +	int ret;
> +
> +	ret = ch348_submit_urbs(serial);
> +	if (ret)
> +		return ret;
> +
> +	schedule_work(&ch348->write_work);
> +
> +	return 0;
> +}
> +
> +static const struct usb_device_id ch348_ids[] = {
> +	{ USB_DEVICE(0x1a86, 0x55d9), },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(usb, ch348_ids);
> +
> +static struct usb_serial_driver ch348_device = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "ch348",
> +	},
> +	.id_table =		ch348_ids,
> +	.num_ports =		CH348_MAXPORT,
> +	.num_bulk_in =		2,
> +	.num_bulk_out =		2,
> +	.open =			ch348_open,
> +	.close =		ch348_close,
> +	.set_termios =		ch348_set_termios,
> +	.process_read_urb =	ch348_process_read_urb,
> +	.write =		ch348_write,
> +	.calc_num_ports =	ch348_calc_num_ports,
> +	.attach =		ch348_attach,
> +	.release =		ch348_release,
> +	.suspend =		ch348_suspend,
> +	.resume =		ch348_resume,
> +};
> +
> +static struct usb_serial_driver * const serial_drivers[] = {
> +	&ch348_device, NULL
> +};
> +
> +module_usb_serial_driver(serial_drivers, ch348_ids);
> +
> +MODULE_AUTHOR("Corentin Labbe <clabbe@baylibre.com>");
> +MODULE_DESCRIPTION("USB CH348 Octo port serial converter driver");
> +MODULE_LICENSE("GPL");

-- 
David Heidelberg


