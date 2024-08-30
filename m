Return-Path: <linux-kernel+bounces-308260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB096597D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA961C2166B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081A16CD04;
	Fri, 30 Aug 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iAy8Hvsn"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94159165EEB;
	Fri, 30 Aug 2024 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005216; cv=none; b=igygKnQ1VDMhY3ECohrBmfMHZ18Gy9gTD3ovnuO1FoTRWRGCayxf4OermLu7w1/I2NlPlMaApAkazmC+o/W4BXjOHTPDgJBJIxgPmd29rx6vQI6KqKfBBpqJs49degX7CFXTXQp4oS9WrPfo9eK4iW8U47K4ZKix4BcaQ8WuWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005216; c=relaxed/simple;
	bh=F8vFDhSL9XbZBr7zg6BszaGOQ6Ux/WG7ilJpp/l9fZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3qi24oZlxpEg0ACF9pumMadSxT5UDYy6YkHCawyFrTbuuihq45FAIMnX8dUGZSpKrHf4OH2l9dTcOqldmh5MpHnryBRc0zdL2hMya/25tzllJOW78m6Cdxc1m7s0MLZa6BD3ViqVXZj/uBUYtmuhF5dlSYlJ6KZLcOs97PSAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iAy8Hvsn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22928E0006;
	Fri, 30 Aug 2024 08:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725005211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxF8rfNjn5nCmRFRz11/s9asoMEsUtfey24NfljSmKo=;
	b=iAy8HvsncgpQxw1p4svMZrNYvxeghJA99J6Pf0OyfrFy30QQIN+G0cjItrfmC6ooFquIR/
	dvtkTvMMl2my2XhPIMh0K3PavJfsfyEFRLBNxDbOnIEmG0vUKE1qoks3ghF0yeTCOFodHg
	BpR5tIkr5JOYoD0OSC1u6SJ9HBli+ovrP4iVn+9t2d/Dxy7I/7I4jERnvTQX6Tje2rCEDa
	TKB54r1GQyvZ3dWSzXrFtYXGUas4bgdNDzGuejlFcl8Vd2jvMt75jMK+SImChI5r/X87oQ
	8CA1dax2jqUiCNn0KlMO68kkma5sYVbir3Iro/eRl8m6q4PvC7Myae+Z+waOzQ==
Message-ID: <1b202582-0487-483c-ba80-47125551eb5d@bootlin.com>
Date: Fri, 30 Aug 2024 10:06:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
To: Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <20240711-sg2002-v4-4-d97ec2367095@bootlin.com>
 <IA1PR20MB4953612773890B94FFD0C9EABB962@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822AC58BC43FDE03802E773FE972@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <MA0P287MB2822AC58BC43FDE03802E773FE972@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sg2002.dtsi"
>>> +
>>> +/ {
>>> +    model = "LicheeRV Nano B";
>>> +    compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", 
>>> "sophgo,sg2002";
>>> +
>>> +    aliases {
>>> +        gpio0 = &gpio0;
>>> +        gpio1 = &gpio1;
>>> +        gpio2 = &gpio2;
>>> +        gpio3 = &gpio3;
>>> +        serial0 = &uart0;
>>> +        serial1 = &uart1;
>>> +        serial2 = &uart2;
>>> +        serial3 = &uart3;
>>> +        serial4 = &uart4;
>>> +    };
>>> +
>>> +    chosen {
>>> +        stdout-path = "serial0:115200n8";
>>> +    };
>>> +};
>>> +
>>> +&osc {
>>> +    clock-frequency = <25000000>;
>>> +};
>>> +
>>> +&sdhci0 {
>>> +    status = "okay";
>>> +    bus-width = <4>;
>>> +    no-1-8-v;
>>> +    no-mmc;
>>> +    no-sdio;
>>> +    disable-wp;
>>> +};
>>> +
>>> +&uart0 {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&uart1 {
>>> +    status = "okay";
>>> +};
>>> +
>>> +&i2c0 {
>>> +    status = "okay";
>>> +};
>>>
>>> -- 
>>> 2.45.2
>>>
>> Have you test you patch with a real board? Especially
>> for device "uart1" and "i2c0", I suspect your
>> configuartion does not work by default.
> 
> Hi, Thomas Bonnefille,
> 
> Can you please double check and feedback, I want to confirm this before 
> acking this change.
> 
> As you know, rc6 will come next week and I'm planning a pr next week.
> 
> Regards,
> 
> Chen
> 
Hello Chen and Inochi,

I'm really sorry, indeed, those nodes certainly don't work, it was a 
mistake on my side introduced between v1 and v2.
However, I can ensure that "uart0" and "sdhci0" are working fine.
May I suggest to remove those two nodes? I can send a new iteration if 
it's easier for you to handle?

