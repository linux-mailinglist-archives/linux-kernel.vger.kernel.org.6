Return-Path: <linux-kernel+bounces-263396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF893D54C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389C31F21006
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91991CF9B;
	Fri, 26 Jul 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="g1rXBa1g"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D12012B6C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005117; cv=none; b=nNCfnXPUYpB9d7U/16cwozD9QyCowz7Gc2ZBWZNw0PehbN2dDefK68MQU5lZFhGaaJGMgK+NABtfWfDhVlqdiz5vr2mXWWV3LHxwIuE1wq4MakvEhtlsnJ14UyGk+uJWmQ2lB9nVpWk8+nZEg+uTmVVmn4EBa5gjRjhgarey1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005117; c=relaxed/simple;
	bh=7Fsws2h7FovJEDsPGFtn5VcRmNnIo9FjV892i+QXBFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reAr3lSwf3lBG0uTAo9hW+GYQJOD76ZaJAdXCAfvXgprRIPArRHCa/GwCrfSyFTA3MULD8L5qSb9lew3hL5n/Ha3iwj7BkZF1O1Fo+9+/Lajhhk2E3PGs9OyBa0diZ1JJZjERNivuS56LbPJfphZMJEpJ4fdQax2FQBpO3a/ufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=g1rXBa1g; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id XMAmsKy7fxIArXMAmstFKM; Fri, 26 Jul 2024 16:43:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722005037;
	bh=FbsNU1IQfs3Sd0GZK3nAdn1qZLd7YlOQHACP57rmR3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=g1rXBa1giPwgoskNXx7Y9JXSOeV4FfSYi7phhtUi9VTS6kN6ln4gaiJJzb+eFUS2i
	 GxPWogLdniatsPcJ1RXj63QmfMelCsn1QRl3DEssxXNpAi21s/6TqzSo2e+K5tqqhi
	 tBZkCME2XPSOjBuw0Vpn97z1a6ai6lJzMxTH+ixEAYyDCridYiwEGguJv/bdgJm0+8
	 SAAZKrs2iXLVp5Sz3Y25fvXrxZ+TGmpBFkDFlkEQUf42qBzym6wK5chLwMag8YpAch
	 1A8vu7q2yAAdHfvcQi+G1j+2kCZx3uYwUjZ/KWIToeKknRmIlDftETM0Gh/ELd0XzB
	 PaJNApaZAXaVw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 26 Jul 2024 16:43:57 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c6eb2082-1100-42a4-99dd-8b29cf2042b1@wanadoo.fr>
Date: Fri, 26 Jul 2024 16:43:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - fix LED state at suspend/resume
To: Qiang Ma <maqianga@uniontech.com>, dmitry.torokhov@gmail.com,
 hdegoede@redhat.com
Cc: inux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240726102730.24836-1-maqianga@uniontech.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240726102730.24836-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/07/2024 à 12:27, Qiang Ma a écrit :
> After we turn on the keyboard CAPSL LED and let the system suspend,
> the keyboard LED is not off, and the kernel log is as follows:
> 
> [  185.987574] i8042: [44060] ed -> i8042 (kbd-data)
> [  185.988057] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
> [  185.988067] i8042: [44061] 04 -> i8042 (kbd-data)
> [  185.988248] i8042: [44061] ** <- i8042 (interrupt, 0, 1)
> 
> The log shows that after the command 0xed is sent, the data
> sent is 0x04 instead of 0x00.
> 
> Solution:
> Add a bitmap variable ledon in the atkbd structure, and then set ledon
> according to code-value in the event, in the atkbd_set_leds function,

Hi,

s/atkbd_set_leds function/atkbd_set_leds()/

> first look at the value of lenon, if it is 0, there is no need to

s/lenon/ledon/

> look at the value of dev->led, otherwise, Need to look at dev->led

s/Need/need/

> to determine the keyboard LED on/off.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   drivers/input/keyboard/atkbd.c | 35 +++++++++++++++++++++++++---------
>   1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 7f67f9f2946b..27d8f375929e 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -237,6 +237,8 @@ struct atkbd {
>   	struct mutex mutex;
>   
>   	struct vivaldi_data vdata;
> +
> +	unsigned long ledon[BITS_TO_LONGS(LED_CNT)];

DECLARE_BITMAP()?

>   };
>   
>   /*
> @@ -604,24 +606,34 @@ static int atkbd_set_repeat_rate(struct atkbd *atkbd)
>   	return ps2_command(&atkbd->ps2dev, &param, ATKBD_CMD_SETREP);
>   }
>   
> +#define ATKBD_DO_LED_TOGGLE(dev, atkbd, type, v, bits, on)		\
> +({									\
> +	unsigned char __tmp = 0;					\
> +	if (test_bit(LED_##type, atkbd->on))				\
> +		__tmp = test_bit(LED_##type, dev->bits) ? v : 0;	\
> +	else								\
> +		__tmp = 0;						\

Is it needed? __tmp is already initialized as 0.

> +	__tmp;								\
> +})
> +
>   static int atkbd_set_leds(struct atkbd *atkbd)
>   {
>   	struct input_dev *dev = atkbd->dev;
> -	unsigned char param[2];
> +	unsigned char param[2] = {0};

This extra initialization does not seem necessary. IIUC, the length to 
sent is already encoded in ATKBD_CMD_SETLEDS and ATKBD_CMD_EX_SETLEDS.

>   
> -	param[0] = (test_bit(LED_SCROLLL, dev->led) ? 1 : 0)
> -		 | (test_bit(LED_NUML,    dev->led) ? 2 : 0)
> -		 | (test_bit(LED_CAPSL,   dev->led) ? 4 : 0);
> +	param[0] = ATKBD_DO_LED_TOGGLE(dev, atkbd, SCROLLL, 1, led, ledon)
> +		 | ATKBD_DO_LED_TOGGLE(dev, atkbd, NUML,    2, led, ledon)
> +		 | ATKBD_DO_LED_TOGGLE(dev, atkbd, CAPSL,   4, led, ledon);
>   	if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS))
>   		return -1;
>   
>   	if (atkbd->extra) {
>   		param[0] = 0;
> -		param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
> -			 | (test_bit(LED_SLEEP,   dev->led) ? 0x02 : 0)
> -			 | (test_bit(LED_SUSPEND, dev->led) ? 0x04 : 0)
> -			 | (test_bit(LED_MISC,    dev->led) ? 0x10 : 0)
> -			 | (test_bit(LED_MUTE,    dev->led) ? 0x20 : 0);
> +		param[1] = ATKBD_DO_LED_TOGGLE(dev, atkbd, COMPOSE, 0x01, led, ledon)
> +			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, SLEEP,   0x02, led, ledon)
> +			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, SUSPEND, 0x04, led, ledon)
> +			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, MISC,    0x10, led, ledon)
> +			 | ATKBD_DO_LED_TOGGLE(dev, atkbd, MUTE,    0x20, led, ledon);
>   		if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_EX_SETLEDS))
>   			return -1;
>   	}
> @@ -695,6 +707,11 @@ static int atkbd_event(struct input_dev *dev,
>   	switch (type) {
>   
>   	case EV_LED:
> +		if (value)
> +			__set_bit(code, atkbd->ledon);
> +		else
> +			__clear_bit(code, atkbd->ledon);
> +
>   		atkbd_schedule_event_work(atkbd, ATKBD_LED_EVENT_BIT);
>   		return 0;
>   


