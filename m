Return-Path: <linux-kernel+bounces-207775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE397901BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803741F21A52
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9E722EE5;
	Mon, 10 Jun 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l3RiJSBz"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7E63C7;
	Mon, 10 Jun 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004669; cv=none; b=S4kFhjg2rW72swaHZAG47iX3Kkw9R+DikL2M2v5zF4W2lgicQ7J4sBfq1Q08hIfIoVpoaRlaCptViagK2CxgJ+1XrC7xT05m8NCXCJhpiyjEk5Mn8behf8IHCfYuCNItHjJJTL4hX+G5Vcl8n2mp1+HOL7f4jhyUaftT2MldvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004669; c=relaxed/simple;
	bh=VY9k03Q6E8eehYSZYzaDS3vRHjPtX00/+G7XS8di9bk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OlPr3N/ZQ1y/EVeuGdy9Ow8u5AYu/XFMfS6kKfymiTEr2OumfKgwiRmjWtkZGMqfeNFmHNrmYxur3/yL5Zd1F1BPf0gWHunUYsFXdavGJ/PMuB5EQqm88D5jL6nUyhDswoU+/rK7ZRvfAFC49fNleF20dR2dyMUvqlLmyc0ORbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l3RiJSBz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60C7120008;
	Mon, 10 Jun 2024 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718004659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peXQDKPKM2SH0GrsNM/5NIgqruWO0h7j87RkGy1k6rM=;
	b=l3RiJSBznUh0cOintGPPJhaYBUBbFovJSVKd0nC42cxVTLliFUFdCdaI4NN5g+I0ohvZ4L
	MnxTZmSxCxMKNtZyQs89GeDikE5+ZMwD1AUmAGCQT01+vZbw2jp7XAvelDgthvvVsF2A6i
	U/z5G9jYFBeHhkcOaSmOP73VIn5ZoCYLlQ7WcRttpnOTAUIm1b+TlfmpukwKqB1CUP4ryP
	HxmTDXgxuMcW6XcxTruFYj/zvkKwdsdIb85gfp5vRRIg46XY0TzlUvcYGWUrC7PCpVMKuD
	1Og4xUkxg5iHkkRY6pujlE3Shqd/BYclxN/W6giBDm4NHVk3OPENXpMbRt6cgg==
Message-ID: <addbe5b3-04bc-4f02-be44-bdfe3aeba319@bootlin.com>
Date: Mon, 10 Jun 2024 09:30:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Chen Wang <unicorn_wang@outlook.com>, Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
 <IA1PR20MB49535CBF66DB31C2059C291ABBF02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <IA1PR20MB49535CBF66DB31C2059C291ABBF02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

Thank you for your answer :)

On 5/28/24 12:25 AM, Inochi Amaoto wrote:

>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
> 
> It is also better to add all already support nodes, such as gpio,
> other uart port.

I'm importing, cv18xx.dtsi through sg2002.dtsi, so GPIOs are already 
configured and activated by default.
For the other peripherals, all of them are, with the default pinctrl, 
set to function that haven't any driver yet (ADC, MIPI, PWM...).

Based on what I just said, I'm not sure to understand what you mean, can 
you be more specific about the changes you want?

