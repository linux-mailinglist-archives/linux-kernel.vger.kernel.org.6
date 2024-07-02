Return-Path: <linux-kernel+bounces-238125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E29243DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037ACB26F65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C11C68BE;
	Tue,  2 Jul 2024 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="bcQC1gNg"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71461C0DD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938697; cv=none; b=ugBoYCcTfDTuPYtRleYI/+5JNM4tIEmnQ1IXrS1aKID3iTaOWvh82A0A3dpPzTxw4XrVAoJjnRkOfqeA0P28Z2mbGfvfNBnbiT5EJU6ywdx4NvshB82OAMjtlx3VEYO42Hhl1OwSJ56zMIoMSIH9ODJb02/lF7Xr03uRSJZjuic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938697; c=relaxed/simple;
	bh=sAtodnEEl8mReT3BIkXwqo9FkryU2zquaGIJub47SpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzAS1e3v19p2LapWq1I/O8Gqwl5LmawYZxQSpNx9DBM/PovnGzuGp2hRYmzEh1dk9oRIolAmuPsYSOB9iJr1/Qcxf7+1f3xmKT+w9Gri4poiU9yhOlziVV3dMa2ykmMiwlqOwyOTsWXzcBLDyJzARwayd+ynGHbzv97tIOLUvZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=bcQC1gNg; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77CBF240003;
	Tue,  2 Jul 2024 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1719938693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unb3QJ1ZSaRryP9Bs3P1fLuG39JlH4isF5oYd+2RhRQ=;
	b=bcQC1gNgP3gDQfpW0v23OOjOxdP0I2luTbTTLxfUXVTUL7/jRRjMhpCL5kQzqcUNwyvVs6
	ly8+SPm0Uxlb5CXCg9Tj26hBJYHZhQWry2GCUecSInf3AhHWtNdUwZ+28quErq/hMvxqm4
	1aLtj3rOF2it97inFG6FKmcpFCAE0i+4Ywh+SkeIZjXPKpNVYbXa1FUtU1Q0XyqA77qbjp
	QwYSKTtOq/6epwUFyBd2lSGHUxxP679j3RRiKNx5E5EV5zr152wukzLyqVhyTM4HzJ7KCB
	WwEKEaq/EW9ToVvQxMcUTMdYGLs2LvHc755NQHutKnM01u8AJgp7gPZOWN0F4A==
Message-ID: <b974df45-daf5-4156-8532-cf9e2be8bdfa@yoseli.org>
Date: Tue, 2 Jul 2024 18:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arch: m68k: Add definitions for flash NFC support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Stefan Agner <stefan@agner.ch>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
 <20240627-upstream-nfc-mcf5441x-v2-1-312929d09ee5@yoseli.org>
 <20240628094511.75cc9c78@xps-13>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20240628094511.75cc9c78@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Miquel,

On 28/06/2024 09:45, Miquel Raynal wrote:
> Hi Jean-Michel & Geert,
> 
> jeanmichel.hautbois@yoseli.org wrote on Thu, 27 Jun 2024 18:05:28 +0200:
> 
>> Add a few definitions, as the base address for the NFC for the M5441x.
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> ---
>>   arch/m68k/include/asm/m5441xsim.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
>> index f48cf63bd782..d4ee1eab7c4a 100644
>> --- a/arch/m68k/include/asm/m5441xsim.h
>> +++ b/arch/m68k/include/asm/m5441xsim.h
>> @@ -99,6 +99,7 @@
>>   #define MCFINT2_PIT1		14
>>   #define MCFINT2_PIT2		15
>>   #define MCFINT2_PIT3		16
>> +#define MCFINT2_NFC		25
>>   #define MCFINT2_RTC		26
>>   
>>   /*
>> @@ -333,4 +334,10 @@
>>   #define MCF_IRQ_BOFF1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
>>   #define MCF_IRQ_ERR1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
>>   
>> +/*
>> + * Flash module
>> + */
>> +#define MCF_NFC_BASE		0xfc0fc000
>> +#define MCF_NFC_SIZE		(0xfc0fff3b - 0xfc0fc000)
>> +#define MCF_NFC_ISR		(MCFINT2_VECBASE + MCFINT2_NFC)
> 
> I'm sorry but this feels really backwards. Platform data as C
> structures are already legacy, but defining these information in
> some arch headers and using them directly from drivers really seems
> even "wronger" to me. What's the mid/long term plan for this? If the
> platforms are still in use today and need to be maintained, why not
> finally enabling device tree support? I know it's harder to do than to
> say, but I'd like some really good explanation on why we should accept
> to do this in 2024 because it feels rather inadequate.

Thanks for your review !

I agree with you it is legacy. I use a lot of ARM platforms and 
device-tree is indeed great. Though, switching the m68k architecture to 
use this sounds really tough.

I will obviously let Geert and maybe others answer, but my feeling is it 
is not really worth it to implement the dts on those platforms are they 
are not that used (compared, again, to ARM for instance).

AFAIK the platform data is not officialy considered deprecated ? As it 
concerns a few platforms out there...

Thanks,
JM

