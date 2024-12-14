Return-Path: <linux-kernel+bounces-446115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD49F200E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3D1887EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA5198836;
	Sat, 14 Dec 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofncVW8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BB2033A;
	Sat, 14 Dec 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734196864; cv=none; b=sK1Py9CRVZLaCxzsQP5jrATEjI4PNJ8Wuu9OGyAUa8y3amwLZ9uaU9ht66+VeubFee7NC9RxAc5pIiqm6BLMqSbKirCumQvNPc2jOv6ajyinzu4Oi8S3v3vmHJgd4G2cRoDUF6SHXo/F7GvE5NfimN/5saxyT7T4Qlti8TviBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734196864; c=relaxed/simple;
	bh=ezvO/MjsOFV8uZE5WolYahI6SlHzY/UYkTp7ZCJjJzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpfg6xD9tGtiCYsw3+kKuLJKPXrtePSsV30KilLAs0A0RRaVDT0a3ouyLWVE2zvC7+9x6Hfw9STwGedQEYlEiVp6umer2U1tXTmQrZ0S1ZTD/qVAH0r3lE36NY0+3BNrD62yn9Kg/uPr5OfHsmR2x9ibZKnY6AjaJDSjRBcbzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofncVW8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D4CC4CED1;
	Sat, 14 Dec 2024 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734196864;
	bh=ezvO/MjsOFV8uZE5WolYahI6SlHzY/UYkTp7ZCJjJzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofncVW8ml90hf9qQ6TxI8LLCua/Q1FQgWwW2KW+OuE5Fk2MLnwJrhtPvl4sXcjJ3f
	 QpPzmNhf+oQyBh9xhPgWXWF2Xp0eZ3BxinP2XXdRRuLtNHK2FQozeppu9B4fjq1OwS
	 mzUlGUB5dMRZwP2Ab1VfLEAE7G1C1ZnNI72qMF8U3WKPUH517T+et/whWiSoi3SUGS
	 o4S7eO8eEBT4hUdzQ+F98FvIwFxfBRmHwFGISbB+74Q0p4+2BxFgln3n2Hr4OrOE4n
	 hE9oiEkXb+ySzad9ifO9iTcWSEAPGaH3ioM69vcfP6kIgs0oFBmO9Jd9OawBpYoXX6
	 MBo0kme65XI8w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tMVpF-000000002lV-08Zw;
	Sat, 14 Dec 2024 18:21:09 +0100
Date: Sat, 14 Dec 2024 18:21:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Lode Willems <me@lodewillems.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] USB: serial: CH341: add hardware flow control
 RTS/CTS
Message-ID: <Z12-hZKS83WQ5bYd@hovoldconsulting.com>
References: <20241113180930.3741-1-me@lodewillems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113180930.3741-1-me@lodewillems.com>

On Wed, Nov 13, 2024 at 07:08:27PM +0100, Lode Willems wrote:
> This adds support for enabling and disabling
> RTS/CTS hardware flow control.
> Tested using a CH340E in combination with a CP2102.
> 
> Fixes part of the following bug report:
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197109
> 
> Signed-off-by: Lode Willems <me@lodewillems.com>

Thanks for the patch and sorry about the late feedback on this one. I
wanted to give it a spin with the devices I have here (ch340g and
ch341a).

Appears to the modem control lines are not wired up on the ch341a
evaluation board I have, but the device accepts the request and stops
transmitting with hardware flow control enabled.

With ch340g in loopback, I also see it refuse to transmit unless cts is
asserted. I was not able to get the device to deassert rts when
attempting to fill its receive buffers, however. Perhaps the hardware
does not support this, but is this something you tried?

> ---
>  drivers/usb/serial/ch341.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
> index d10e4c4848a0..62237f657320 100644
> --- a/drivers/usb/serial/ch341.c
> +++ b/drivers/usb/serial/ch341.c
> @@ -63,6 +63,7 @@
>  #define CH341_REG_DIVISOR      0x13
>  #define CH341_REG_LCR          0x18
>  #define CH341_REG_LCR2         0x25
> +#define CH341_REG_FLOW_CTL     0x27
>  
>  #define CH341_NBREAK_BITS      0x01
>  
> @@ -77,6 +78,9 @@
>  #define CH341_LCR_CS6          0x01
>  #define CH341_LCR_CS5          0x00
>  
> +#define CH341_FLOW_CTL_NONE    0x000
> +#define CH341_FLOW_CTL_RTSCTS  0x101

The registers are eight bits wide, but the driver writes two at a time.
So this should just be 0x00 and 0x01.

> +
>  #define CH341_QUIRK_LIMITED_PRESCALER	BIT(0)
>  #define CH341_QUIRK_SIMULATE_BREAK	BIT(1)
>  
> @@ -478,6 +482,41 @@ static int ch341_open(struct tty_struct *tty, struct usb_serial_port *port)
>  	return r;
>  }
>  
> +static void ch341_set_flow_control(struct tty_struct *tty,
> +				   struct usb_serial_port *port,
> +				   const struct ktermios *old_termios)
> +{
> +	int r;
> +
> +	if (old_termios &&
> +	    C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
> +		return;

Just drop this and set the requested setting unconditionally.

> +
> +	if (C_CRTSCTS(tty)) {
> +		r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
> +				      CH341_REG_FLOW_CTL |
> +				      ((u16)CH341_REG_FLOW_CTL << 8),
> +				      CH341_FLOW_CTL_RTSCTS);
> +		if (r < 0) {
> +			dev_err(&port->dev,
> +				"%s - failed to enable flow control: %d\n",
> +				__func__, r);
> +			tty->termios.c_cflag &= ~CRTSCTS;
> +		}
> +	} else {
> +		r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
> +				      CH341_REG_FLOW_CTL |
> +				      ((u16)CH341_REG_FLOW_CTL << 8),
> +				      CH341_FLOW_CTL_NONE);
> +		if (r < 0) {
> +			dev_err(&port->dev,
> +				"%s - failed to disable flow control: %d\n",
> +				__func__, r);
> +			tty->termios.c_cflag |= CRTSCTS;
> +		}
> +	}

Please rewrite this so that you prepare the value and index parameters
based on the termios settings and then do one control request. If it
fails you can restore the old setting (if old_termios is non-NULL).

And please drop the redundant __func__ from the error message (even if
the driver still uses it in some other functions still).

> +}
> +

Johan

