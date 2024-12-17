Return-Path: <linux-kernel+bounces-449897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901429F5788
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7277A18923D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198C1F9EA4;
	Tue, 17 Dec 2024 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lodewillems.com header.i=@lodewillems.com header.b="Sn5ZiSyN"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A31F9431;
	Tue, 17 Dec 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466701; cv=none; b=GF+D6MeTJK1eVkzYE/TS8WvjWS4mWstEbFMmSstikF4RIdyEPsHRK+dxDMsv7NWISwNIx4W2UXZalPBn2luc1nIxQqwznszOk0g3vtaNtRve6THIjMIzOr6TnfxExl1n5ZeDIRBql0CsASDbG38QNC2gWn4SkycaLpItV951GEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466701; c=relaxed/simple;
	bh=HBUUvIWBwQLqxhwKfqHNDEhxwxvTBxU5fqmMxkAoJ70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdZBV/3j7xlp55lcI/pkwszE+JnH4MxxdOq5vWjgRqPowDCzrS5PzkrtlhMsIfGAh1JQxqE19xf8gB4r0qRttBd7gYKJU69/YmSmM8FvNwmp3pjnb90AYszULdWk+4LooMUeqTMDzKSAZoq9Glnx9i+O0dXaqpltr3IcjaCJT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lodewillems.com; spf=pass smtp.mailfrom=lodewillems.com; dkim=pass (2048-bit key) header.d=lodewillems.com header.i=@lodewillems.com header.b=Sn5ZiSyN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lodewillems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lodewillems.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YCSYP1Gp8z9sWp;
	Tue, 17 Dec 2024 21:08:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lodewillems.com;
	s=MBO0001; t=1734466105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vik/uoCAr+mic177P1g8olkmGxdxWNqod5BOEEyu/8s=;
	b=Sn5ZiSyNmXySkI2niORPKMHdKHEahMX4HNzFSRzhI6/V3IPsY+dduZ68TBKJqidgGeNAyY
	S4t0a6UAAZhq9QTcYwaf31S69wCjTe9ksgWJR/CR+fk4Cl0pLn2wpsmgdlYKIUZG5uW41p
	z3kPGpNnq9t6aduhFGLwDH6gt7IqxkbyX6M74GfigJCLX8lRcDUsf/qhOTylz/lZfInyg4
	avYz3mdVihastBurB7qbOV92R1TvXNyBPtCfSEXZ57o7URKJ95Rg3z/q6tk3L5BiO754Y6
	akEAd7ZloLYwpJt/8L5FLN89+anS3TRPQi9JK4RqLVVQvYz8psCrvip343et0g==
Message-ID: <55c078d2-80de-4eaf-afc3-d470a712bd49@lodewillems.com>
Date: Tue, 17 Dec 2024 21:08:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND] USB: serial: CH341: add hardware flow control
 RTS/CTS
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241113180930.3741-1-me@lodewillems.com>
 <Z12-hZKS83WQ5bYd@hovoldconsulting.com>
Content-Language: en-US
From: Lode Willems <me@lodewillems.com>
In-Reply-To: <Z12-hZKS83WQ5bYd@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4YCSYP1Gp8z9sWp

On 14/12/2024 18:21, Johan Hovold wrote:
> On Wed, Nov 13, 2024 at 07:08:27PM +0100, Lode Willems wrote:
>> This adds support for enabling and disabling
>> RTS/CTS hardware flow control.
>> Tested using a CH340E in combination with a CP2102.
>>
>> Fixes part of the following bug report:
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197109
>>
>> Signed-off-by: Lode Willems <me@lodewillems.com>
> 
> Thanks for the patch and sorry about the late feedback on this one. I
> wanted to give it a spin with the devices I have here (ch340g and
> ch341a).

Thanks for the review. Sorry in advance if this e-mail is formatted
incorrectly, this is my first time replaying to a review.

> 
> Appears to the modem control lines are not wired up on the ch341a
> evaluation board I have, but the device accepts the request and stops
> transmitting with hardware flow control enabled.
> 

Since creating this patch I've acquired a ch341a breakout board and can
confirm that it transmits with hardware flow control enabled and CTS
asserted.

> With ch340g in loopback, I also see it refuse to transmit unless cts is
> asserted. I was not able to get the device to deassert rts when
> attempting to fill its receive buffers, however. Perhaps the hardware
> does not support this, but is this something you tried?
> 

I didn't try this before. Just trying a couple of things now I also
couldn't seem to make it deassert RTS, but this may be a failure of
how I'm testing this.

>> ---
>>  drivers/usb/serial/ch341.c | 41 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
>> index d10e4c4848a0..62237f657320 100644
>> --- a/drivers/usb/serial/ch341.c
>> +++ b/drivers/usb/serial/ch341.c
>> @@ -63,6 +63,7 @@
>>  #define CH341_REG_DIVISOR      0x13
>>  #define CH341_REG_LCR          0x18
>>  #define CH341_REG_LCR2         0x25
>> +#define CH341_REG_FLOW_CTL     0x27
>>  
>>  #define CH341_NBREAK_BITS      0x01
>>  
>> @@ -77,6 +78,9 @@
>>  #define CH341_LCR_CS6          0x01
>>  #define CH341_LCR_CS5          0x00
>>  
>> +#define CH341_FLOW_CTL_NONE    0x000
>> +#define CH341_FLOW_CTL_RTSCTS  0x101
> 
> The registers are eight bits wide, but the driver writes two at a time.
> So this should just be 0x00 and 0x01.

Ok. I'm guessing I don't have to send the same request twice and can
just leave the top eight bits of the value and index empty?
It seems to work in the quick testing I've done.

> 
>> +
>>  #define CH341_QUIRK_LIMITED_PRESCALER	BIT(0)
>>  #define CH341_QUIRK_SIMULATE_BREAK	BIT(1)
>>  
>> @@ -478,6 +482,41 @@ static int ch341_open(struct tty_struct *tty, struct usb_serial_port *port)
>>  	return r;
>>  }
>>  
>> +static void ch341_set_flow_control(struct tty_struct *tty,
>> +				   struct usb_serial_port *port,
>> +				   const struct ktermios *old_termios)
>> +{
>> +	int r;
>> +
>> +	if (old_termios &&
>> +	    C_CRTSCTS(tty) == (old_termios->c_cflag & CRTSCTS))
>> +		return;
> 
> Just drop this and set the requested setting unconditionally.

Ok

> 
>> +
>> +	if (C_CRTSCTS(tty)) {
>> +		r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
>> +				      CH341_REG_FLOW_CTL |
>> +				      ((u16)CH341_REG_FLOW_CTL << 8),
>> +				      CH341_FLOW_CTL_RTSCTS);
>> +		if (r < 0) {
>> +			dev_err(&port->dev,
>> +				"%s - failed to enable flow control: %d\n",
>> +				__func__, r);
>> +			tty->termios.c_cflag &= ~CRTSCTS;
>> +		}
>> +	} else {
>> +		r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
>> +				      CH341_REG_FLOW_CTL |
>> +				      ((u16)CH341_REG_FLOW_CTL << 8),
>> +				      CH341_FLOW_CTL_NONE);
>> +		if (r < 0) {
>> +			dev_err(&port->dev,
>> +				"%s - failed to disable flow control: %d\n",
>> +				__func__, r);
>> +			tty->termios.c_cflag |= CRTSCTS;
>> +		}
>> +	}
> 
> Please rewrite this so that you prepare the value and index parameters
> based on the termios settings and then do one control request. If it
> fails you can restore the old setting (if old_termios is non-NULL).

Ok, I haven't seen any other driver restore the old setting on request
failure, now I'm questioning if it's actually necessary?
If it is, I'll change it to the following:
	tty->termios.c_cflag = (tty->termios.c_cflag & !CRTSCTS)
		| (old_termios->c_cflag & CRTSCTS);

> 
> And please drop the redundant __func__ from the error message (even if
> the driver still uses it in some other functions still).

Ok. Looking at the code again, the error already gets logged in
ch341_control_out on failure. Maybe this log line shouldn't be added?

> 
>> +}
>> +
> 
> Johan

Lode

