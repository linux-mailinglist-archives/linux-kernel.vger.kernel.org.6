Return-Path: <linux-kernel+bounces-417162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9D9D4FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947F7B25122
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959781494B3;
	Thu, 21 Nov 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h4Q+kSb+"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3870817
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203212; cv=none; b=k0RcUKEKYjDO5dZ+oUHMY/4jTcyKKYfG0L1Ftg2hRT+mGnAVYKxQm5EtknpvcQ2PbyL8g0uijr0PXlGvKdB+Ep0rXPmY1jrU9vmWBH1ze7NduAx673mh1lDcLtG5z1Ndb+9Jq8pyvZ38GSvH9neqX2fpi3wQupuRzZ0uUCACiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203212; c=relaxed/simple;
	bh=Cl42ZGA9jxRylCEsqsabOKq4ALsk/YoVrlH5grFIW24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXtXwFjAHq0K1/l6IeZIjbO7e8o6hXpbteBVbnyxLkwOLbcYERhqymUQ4g3ccLGI7eayCgr2SD8vvmNVkQIZGw/vb0veW4Ll0FRki/sqcdTE2LBrI5jEtwSZV0XjXrpalz+TgMBDGJWVdvsgy5kmwlPexQmde0F1gWS2Hs6X08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h4Q+kSb+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 164F5C000C;
	Thu, 21 Nov 2024 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732203205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeqMavKGwgye1TgBIsi5L0jmrwRdZqWwsFG5j64fJeI=;
	b=h4Q+kSb+rO4qRXec+md7kBJiZpRjvkVkmoqmznGVIQ1WlpthHPEW0PMWUckVBov9OiXCQe
	NHSDjyzs2bYuM07OY5ustSGxIOeSOmNMkf/IxbvniNI0oZZ2HQM3gZc+9hg4E1jDCXMv9B
	CU1TSgkR10DuU5JT+JGA/Rt8frbzZH4UCUP/dHFDFTDQCw0vTkpkYKp6I0r0SCtAnqmjXm
	mKrmLhbvyoMZHtMJV7gSJvZbe7In9L4G/1OkcQ2eHBDtX1cWvHTpfBq3TWsCww/1jrBm/2
	JE+WRv5fU+bK2NmIt7b6Vp0DBEWAI29OJauCrq6pvs9GELDgt12X1J4wdsGUOg==
Message-ID: <972898b2-e59b-4d6d-b1a0-47f1c5a3153f@bootlin.com>
Date: Thu, 21 Nov 2024 16:33:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] memory: ti-aemif: Export aemif_*_cs_timings()
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
 <20241115132631.264609-7-bastien.curutchet@bootlin.com>
 <3a74b938-072e-443c-bf48-d97aff969a17@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <3a74b938-072e-443c-bf48-d97aff969a17@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Krzysztof,

On 11/21/24 11:33 AM, Krzysztof Kozlowski wrote:
> On 15/11/2024 14:26, Bastien Curutchet wrote:
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(aemif_check_cs_timings);
>>   
>>   /**
>>    * aemif_set_cs_timings - Set the timing configuration of a given chip select.
>> @@ -173,7 +158,7 @@ static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
>>    *
>>    * @return: 0 on success, else negative errno.
>>    */
>> -static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
>> +int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
>>   {
>>   	unsigned int offset;
>>   	u32 val, set;
>> @@ -195,13 +180,16 @@ static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_
>>   
>>   	offset = A1CR_OFFSET + cs * 4;
>>   
>> +	mutex_lock(&aemif->config_cs_lock);
>>   	val = readl(aemif->base + offset);
>>   	val &= ~TIMINGS_MASK;
>>   	val |= set;
>>   	writel(val, aemif->base + offset);
>> +	mutex_unlock(&aemif->config_cs_lock);
>>   
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(aemif_set_cs_timings);
> 
> 
> EXPORT_SYMBOL_GPL everywhere, these are quite specific to driver's
> internals, so internal implementation.

Ok, I'll use EXPORT_SYMBOL_GPL in next iteration.

> 
> Also, all of exported functions need to have correct kerneldoc but I
> think they don't. At least missing(), so maybe rest also did not conform
> to kernel doc style.
> 

Do you know a tool that could help me checking the kernel doc style ? I 
have no warning when running ```make W=1n drivers/memory/ti-aemif.o```. 
The warnings I get when running ```make W=2 drivers/memory/ti-aemif.o``` 
aren't linked to these comments. And the output I get with 
```./scripts/kernel-doc -export  drivers/memory/ti-aemif.c``` seems fine 
to me.

>>   
>>   /**
>>    * aemif_calc_rate - calculate timing data.
>> @@ -257,10 +245,12 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
>>   	if (data->enable_ss)
>>   		set |= ACR_SSTROBE_MASK;
>>   
>> +	mutex_lock(&aemif->config_cs_lock);
>>   	val = readl(aemif->base + offset);
>>   	val &= ~CONFIG_MASK;
>>   	val |= set;
>>   	writel(val, aemif->base + offset);
>> +	mutex_unlock(&aemif->config_cs_lock);
>>   
>>   	return aemif_set_cs_timings(aemif, data->cs - aemif->cs_offset, &data->timings);
>>   }
>> @@ -399,6 +389,7 @@ static int aemif_probe(struct platform_device *pdev)
>>   	if (IS_ERR(aemif->base))
>>   		return PTR_ERR(aemif->base);
>>   
>> +	mutex_init(&aemif->config_cs_lock);
>>   	if (np) {
>>   		/*
>>   		 * For every controller device node, there is a cs device node
>> diff --git a/include/linux/memory/ti-aemif.h b/include/linux/memory/ti-aemif.h
>> new file mode 100644
>> index 000000000000..0640d30f6321
>> --- /dev/null
>> +++ b/include/linux/memory/ti-aemif.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __TI_AEMIF_H
>> +#define __TI_AEMIF_H
> 
> 
> Use some longer header guard, e.g. __MEMORY_TI_AEMIF_H
> 

Ok, I'll do it in next iteration.


Best regards,
Bastien

