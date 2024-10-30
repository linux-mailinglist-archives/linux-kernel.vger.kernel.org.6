Return-Path: <linux-kernel+bounces-388679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B279B62FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748D01F2180B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CACB1F130F;
	Wed, 30 Oct 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cyg++nh2"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87571EF953
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290842; cv=none; b=XjLoRD5jtMCfV428qqwD6jTYkJ8aS7cltQdTghgJ5TwVTrwBnPI/p3sBRhwOdNDVDs92UrnMvtuydYOB0S+85iLLG0MIqP8OszpQSkghh28+CwVk1kyDXZr4gXDFCC47xMEvJFSAl4GYqg2X1mKJ29lk5akFblmK0b/oK31yjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290842; c=relaxed/simple;
	bh=KA503Jlkem9XW2vCY/4RoJFW6TgFAYqjhx/aZYuVCQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqGq27biZSqVvGmsKxCjY9wRoQw9PvvsKR5S/xevvRIU8UPyZgf3in34wreECtT4ehZ1x6ljncgau6AYm62ZsF+xIBYOrJAb/JCp4tk740eJjqNJ6s3b1Yxnlk6jkbCyfEsRUYjqpSKiYeAjzm4N+MmL/n3D0FAYMGstERbxwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cyg++nh2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5836EFF806;
	Wed, 30 Oct 2024 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730290838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRUeD1doCo6p8A+A2Bqu6AeqcwQMQ7NrDrHpImOiBc0=;
	b=cyg++nh2R662+x6rQcsukVOxP265jpPaGbIVQib6OKkjHPoAmvalngoxzxYbtmeiXs0iWs
	BRSARrukO5+aYeJeODKno0orGPDCCERI4AJ0JWjyqhYAfLP9ztxCuEWoH/gYa35brNzgA/
	A10aAXXsOImO0GSW/lQQVaaIlblIT1SINTQVnIvI4njNQUhQEwN8PUzVmXJv8pzdY0ALPC
	r51I4P1lG52f8qFcCswY5lRErQ2IwjXTP+4jC20Mz6LQxdpSgan2gH2bWg5s8NULjZSRfQ
	RxIWtEro/OWwkyDlOOIABjYmOsufHdCqKmAX9vx+B/CFn+mAk8xi4d45ngf7HA==
Message-ID: <58a1b909-7ed7-40a4-8845-b8327a1d740c@bootlin.com>
Date: Wed, 30 Oct 2024 13:20:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mtd: rawnand: davinci: Add clock resource
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
 <20241030104717.88688-5-bastien.curutchet@bootlin.com>
 <3035aa2e-dbab-4224-a5db-d18e37003d5e@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <3035aa2e-dbab-4224-a5db-d18e37003d5e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Krzysztof,

On 10/30/24 12:17 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 11:47, Bastien Curutchet wrote:
>> NAND controller has a reference clock but the driver doesn't use it.
>>
>> Add a struct clock in the struct davinci_nand_info so it can be used
>> to compute timings.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/davinci_nand.c | 9 +++++++++
> 
> Where are the bindings?
> 

The NAND controller bindings are in 
Documentation/devicetree/bindings/mtd/davinci-nand.txt but this clock is 
defined in the AEMIF bindings in 
Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt

>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
>> index 3c0efbdd789e..11dc30c29957 100644
>> --- a/drivers/mtd/nand/raw/davinci_nand.c
>> +++ b/drivers/mtd/nand/raw/davinci_nand.c
>> @@ -10,6 +10,7 @@
>>    *   Dirk Behme <Dirk.Behme@gmail.com>
>>    */
>>   
>> +#include <linux/clk.h>
>>   #include <linux/err.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>> @@ -117,6 +118,8 @@ struct davinci_nand_info {
>>   	uint32_t		mask_cle;
>>   
>>   	uint32_t		core_chipsel;
>> +
>> +	struct clk		*clk;
>>   };
>>   
>>   static DEFINE_SPINLOCK(davinci_nand_lock);
>> @@ -822,6 +825,12 @@ static int nand_davinci_probe(struct platform_device *pdev)
>>   		return -EADDRNOTAVAIL;
>>   	}
>>   
>> +	info->clk = devm_clk_get(&pdev->dev, "aemif");
>> +	if (IS_ERR(info->clk)) {
>> +		dev_err(&pdev->dev, "failed to get clock %ld", PTR_ERR(info->clk));
> 
> Syntax is return dev_err_probe.
> 

Ok, I'll correct this in V2


Best regards,
Bastien

