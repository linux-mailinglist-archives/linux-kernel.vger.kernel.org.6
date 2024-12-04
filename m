Return-Path: <linux-kernel+bounces-430833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B66F9E3631
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C912826DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76A19AA5A;
	Wed,  4 Dec 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fZ6TNfcg"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81C19068E;
	Wed,  4 Dec 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733303332; cv=none; b=llBmjLrKxnz7Q3fuNZeQlvP8K3DeE6mKucbnZ3TDxF0wFXQzfJXJmsNoE++r1nlgJqUZ4iWJb9zbSMxHWf7yYS/mkbo58yDxcv5civFDCQWaOIEUMexMdg7hQt7ycCVD1ptbT8CosAa6YPglBKufkqmcvThcNvEyo7pY4nUPSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733303332; c=relaxed/simple;
	bh=KzEazuozwzNQCKTS1PLyozmJsnY2CM2aKlSSLs5lkhM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W0GMFPFm2GXgvQLraNL7zsiHNTby6GMslK+rDUfgoh9fNSH9puBDZmfe0QYhMSRm1XlhgwllP4aRHRwj6UjDuKRrCOB2dE4IMirNaGS2ld97Tg7l9kxnJ9qS5uGIH0QINvke1TCTsfbrHGrJljfCt7NYKYRP5AC9IF8eKJm0hHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fZ6TNfcg; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86EF320002;
	Wed,  4 Dec 2024 09:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733303327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBoNT22bjOCCH26k5KlABL0rZ5aFoWyBOOtQ5GiVdgE=;
	b=fZ6TNfcgsKAfXWizpuvYO/VCeUpqVxLoLZU0h80AsSTwqITeBbhUdPjLlXQoRTMhTD83WZ
	BMDO62sEiMIn92tgFQAaZOkJxlNlDDpGzkk6+e+BPQ7J6eWpGcmwWASDrdwBNmoZV0+0nu
	SA3mA9Y1v0+JhDqxImGDJbJeSLQ5no9AOHm88gX9w7kWEAuF3Wg5oX/Y8Rs+tiY8n2LKiZ
	NvDWh4ejpPUPPGSulUjafKPYkRXWNvDtX4JyheQYSYRuvkgiIE0Xh3Is60T+sPjTRV8P/o
	46IVd9CX6nsK+ETjvRUGXahr6FZf6Pmti9v3gWkaaN1FH/UMEgnTV96oaKUdxQ==
Message-ID: <6e47e420-84c4-4539-ba54-5e1e939a37a5@bootlin.com>
Date: Wed, 4 Dec 2024 10:08:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: use ti,j7200-padconf
 compatible
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-kumar1@ti.com
Cc: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com,
 richard.genoud@bootlin.com
References: <20241113-j784s4-s2r-pinctrl-v1-1-19aeb62739bc@bootlin.com>
 <20241119190106.GA70080@francesco-nb>
Content-Language: en-US
In-Reply-To: <20241119190106.GA70080@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 11/19/24 20:01, Francesco Dolcini wrote:
> Hello Thomas and TI folks,
> 
> On Wed, Nov 13, 2024 at 11:43:05AM +0100, Thomas Richard wrote:
>> Like on j7200, pinctrl contexts shall be saved and restored during
>> suspend-to-ram.
>>
>> So use ti,j7200-padconf compatible.
>>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
>> Use ti,j7200-padconf compatible to save and restore pinctrl contexts during
>> suspend-to-ram.
>> ---
>>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  6 +++---
>>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++------
> 
> Do j784s4 supports any kind of low power mode and/or suspend to ram? My
> understanding was that this was not supported, but maybe there is some
> details that was lost when I was told this information.

Hello Francesco,

We are working on suspend-to-ram support for j7200 and j784s4.
During suspend-to-ram the SoC is fully powered-off (thanks to the PMIC
which powers off all the power rails except the DDR which is in
self-refresh), like on j7200.
Please let me know if you want more details.

Regards,

Thomas

