Return-Path: <linux-kernel+bounces-417123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8FA9D4F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC902B2A615
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770E1ABEB4;
	Thu, 21 Nov 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ArWbtJLV"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302E1D90D4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200990; cv=none; b=c3BnQVJUOT/Dp6Ak/KsT0qklcJDIzdgActGscef+6++4xsmMnfDO8ERMelBjya5nLGARSZSVVD/NE865wPLfeDO9I0WekyJhGOlwH7N9xfmo7pHlj2Bsyur8Xg+josEd4MBQd11fdS55Ldi7a150DUwZCOIaYdZ+zp68Uio5U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200990; c=relaxed/simple;
	bh=I5o6PoDiRHq1RuiCKKs5cUTbHT5egymWxAALEg0qTMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lcd5USvinEHifNNOIuGy+iAvHHCAotznBaqXIBz2cREWrc1C5PJq64/nU8tScTMMq7dYMbRYLF1lXU70GaeB/mEaLwtQ7XTOV0eIn8pdG2kk3eBQR/orUeahH48JRIe1gEnEZnNHNnVDjPMR5jYbhVZf4Ih6uZ+V0chsdYEBSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ArWbtJLV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2279840005;
	Thu, 21 Nov 2024 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLDouZPklZzpGMTdyZtvlWDtrmgpTgU58+RznhI2QS4=;
	b=ArWbtJLVVW6rfFcHFOeFRswAtedzNXlMo41TC47senVzpgr3xMwGfNzCF1GFA4nYAbyGhR
	urpbEhaHh1oL2xUnbLsUaw3GybYbJxAz5ZIy8TM3iGlF2EPAzh2woT6GEEOiQz29krRTLM
	MPdzi3V1h1OL9Kva/DrrvDR9JCVh64pjG44OnDE86xfR/gqJakQEI1TpRLs9byDVrG9+cN
	t8iNdc9R6k23Zk0+aslqpr9ItwWLxNknmgd8beZOzSJ6r9ncutKDD8uQFkmP30PSnIRcQM
	CIzukUgyYVF51bIoBmGc80dTgiFXszT9OzpOCSO6ba+1KI6Dh2ZVOCDYolBjDg==
Message-ID: <e6381bb3-70ae-4aa5-83a0-1e226a5efdfd@bootlin.com>
Date: Thu, 21 Nov 2024 15:56:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] memory: ti-aemif: Create
 aemif_check_cs_timings()
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
 <20241115132631.264609-5-bastien.curutchet@bootlin.com>
 <e3b8366d-b365-43a3-8f40-c2374ff9e8bf@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <e3b8366d-b365-43a3-8f40-c2374ff9e8bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Krzysztof,

On 11/21/24 11:28 AM, Krzysztof Kozlowski wrote:
> On 15/11/2024 14:26, Bastien Curutchet wrote:
>> aemif_calc_rate() check the validity of a new computed timing against a
>> 'max' value given as input. This isn't convenient if we want to check
>> the CS timing configuration somewhere else in the code.
>>
>> Wrap the verification of all the chip select's timing configuration into a
>> single function to ease its exportation in upcoming patches.
>> Remove the 'max' input from aemif_calc_rate() as it's no longer used.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/memory/ti-aemif.c | 107 +++++++++++++++++---------------------
>>   1 file changed, 49 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
>> index aec6d6464efa..5c1c6f95185f 100644
>> --- a/drivers/memory/ti-aemif.c
>> +++ b/drivers/memory/ti-aemif.c
>> @@ -132,18 +132,48 @@ struct aemif_device {
>>   	struct aemif_cs_data cs_data[NUM_CS];
>>   };
>>   
>> +/**
>> + * aemif_check_cs_timings - Check the validity of a CS timing configuration.
>> + * @timings: timings configuration
>> + *
>> + * @return: 0 if the timing configuration is valid, negative error number otherwise.
>> + */
>> +static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
>> +{
>> +	if (timings->ta > TA_MAX)
>> +		return -EINVAL;
>> +
>> +	if (timings->rhold > RHOLD_MAX)
>> +		return -EINVAL;
>> +
>> +	if (timings->rstrobe > RSTROBE_MAX)
>> +		return -EINVAL;
>> +
>> +	if (timings->rsetup > RSETUP_MAX)
>> +		return -EINVAL;
>> +
>> +	if (timings->whold > WHOLD_MAX)
>> +		return -EINVAL;
>> +
>> +	if (timings->wstrobe > WSTROBE_MAX)
>> +		return -EINVAL;
>> +
>> +	if (timings->wsetup > WSETUP_MAX)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * aemif_calc_rate - calculate timing data.
>>    * @pdev: platform device to calculate for
>>    * @wanted: The cycle time needed in nanoseconds.
>>    * @clk: The input clock rate in kHz.
>> - * @max: The maximum divider value that can be programmed.
>>    *
>>    * On success, returns the calculated timing value minus 1 for easy
>>    * programming into AEMIF timing registers, else negative errno.
>>    */
>> -static int aemif_calc_rate(struct platform_device *pdev, int wanted,
>> -			   unsigned long clk, int max)
>> +static int aemif_calc_rate(struct platform_device *pdev, int wanted, unsigned long clk)
>>   {
>>   	int result;
>>   
>> @@ -156,10 +186,6 @@ static int aemif_calc_rate(struct platform_device *pdev, int wanted,
>>   	if (result < 0)
>>   		result = 0;
>>   
>> -	/* ... But configuring tighter timings is not an option. */
>> -	else if (result > max)
>> -		result = -EINVAL;
>> -
>>   	return result;
>>   }
>>   
>> @@ -249,7 +275,6 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
>>   	struct aemif_device *aemif = platform_get_drvdata(pdev);
>>   	unsigned long clk_rate = aemif->clk_rate;
>>   	struct aemif_cs_data *data;
>> -	int ret;
>>   	u32 cs;
>>   	u32 val;
>>   
>> @@ -275,68 +300,34 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
>>   	aemif_get_hw_params(pdev, aemif->num_cs++);
>>   
>>   	/* override the values from device node */
>> -	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val)) {
>> -		ret = aemif_calc_rate(pdev, val, clk_rate, TA_MAX);
>> -		if (ret < 0)
>> -			return ret;
>> -
>> -		data->timings.ta = ret;
>> -	}
>> +	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val))
>> +		data->timings.ta = aemif_calc_rate(pdev, val, clk_rate);
>>   
> 
> You just changed these lines in patch #1. Basically this is partial
> revert of #1.
> 

IMHO this isn't a partial revert of patch #1. Patch #1 moved the call of 
aemif_calc_rate() from aemif_config_abus() to here. Then, this patch 
removes the check of the aemif_calc_rate() as it no longer returns 
negative values. Maybe I should change the aemif_calc_rate() return type 
to u32 by the way.


Best regards,
Bastien


