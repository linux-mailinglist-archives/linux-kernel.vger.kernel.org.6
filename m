Return-Path: <linux-kernel+bounces-405871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560D9C58D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5FC5B2B9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490721339B1;
	Tue, 12 Nov 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RvW3BPEO"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6185D477
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416043; cv=none; b=cm7fK9kwHdcSAzdzYiR15wImwx7O1HufajolgCMTE8zyElulCNbRI4P+JL7vUB2OgUy5ydExa3/6vYKliKoKalFx8TnA0COK2zfP2dhtLvPHKBSGSz2grru9ZxjDNW2Vs8nP3ABYzBJqAQEZbxupOfXKH23CeuKfDCf0+nQSrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416043; c=relaxed/simple;
	bh=CdODxszmj4kFB7EbRtTUE3Dn6FguM8hDpGw7Vbm10eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjC5JcsEtBPr20pHuQqdIKv53I+7GwSdF/mPrKHBSTHrzNSm1RPExbJZ5qFN0kDGCquSd4T/kg8p21eboTAI1o4WcErXsGhfYBXY16BHaf8gNsfGbrz5gvp2ACS96lPrvaWVp8GOJjQcK8PwPQo2IQBga69N9zToQEqzMevIEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RvW3BPEO; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0E85C0006;
	Tue, 12 Nov 2024 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731416032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTI6VnJwvocYVOrPV2lIisRwAEkVjTdKQ0DqSXDZyBI=;
	b=RvW3BPEOlv00PTtS5IbOzPpRewnQbXggbRuWUPjrzrFWxTSZ+I6hJZFM8CBiVho0gaNCdl
	wvHyWep0o3Lo0m/vW4IQYJNQm7oVq6XDY0WXZ3QJAkDC8zFhsd5OKaRW/i3TUDnVvT87el
	7/AcHDK/2xxmcGb8NJADfOjumwfYIMFGcLxAsNDd5oGIeLwqPLuxK2+kszDQ9EGppiA33I
	8xX3WljB75pyJRrC7wp404sdlBfrPPxmSMMjG/NPTL6AoueJiklrt/cL5Hc5CGAYgLJrtP
	c53EGtOC+Bs72+t/4XwGIearFz2fJuVVlfHwwiw0vK2ssa6SuZQ9bEUw6InqfQ==
Message-ID: <d06ebb55-590a-4e30-a7ab-62d00e1dc19e@bootlin.com>
Date: Tue, 12 Nov 2024 13:53:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mtd: rawnand: davinci: Implement setup_interface()
 operation
To: Miquel Raynal <miquel.raynal@bootlin.com>, bastien.curutchet@bootlin.com
Cc: Santosh Shilimkar <ssantosh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
References: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
 <20241106085507.76425-7-bastien.curutchet@bootlin.com>
 <87frnxr2h2.fsf@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <87frnxr2h2.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Miquèl,

On 11/11/24 8:32 PM, Miquel Raynal wrote:
> Hi Bastien,
> 
> On 06/11/2024 at 09:55:07 +01, Bastien Curutchet <bastien.curutchet@bootlin.com> wrote:
> 
>> The setup_interface() operation isn't implemented. It forces the driver
>> to use the ONFI mode 0, though it could use more optimal modes.
>>
>> Implement the setup_interface() operation. It uses the
>> aemif_set_cs_timings() function from the AEMIF driver to update the
>> chip select timings. The calculation of the register's contents is
>> directly extracted from §20.3.2.3 of the DaVinci TRM [1]
>>
>> These timings are previously set by the AEMIF driver itself from
>> device-tree properties. Therefore, IMHO, failing to update them in the
>> setup_interface() isn't critical, which is why 0 is returned even when
>> timings aren't updated.
> 
> Did you experience failures? Because I'd be more conservative and error
> out loudly when something is wrong. In general it is a safest approach
> on the long term. Here maybe you have good reasons to do differently, in
> this case I am all ears.
> 

The DaVinci's configuration isn't very wide so if its reference clock 
rate is too high, mode 0 timings can be too slow to fit while higher 
modes will fit. So returning -EINVAL here will cause the probe to fail 
with 'Failed to configure data interface to SDR timing mode 0' while 
higher modes would have worked.

>> MAX_TH_PS and MAX_TSU_PS are the worst case timings based on the
>> Keystone2 and DaVinci datasheets.
>>
>> [1] : https://www.ti.com/lit/ug/spruh77c/spruh77c.pdf
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/davinci_nand.c | 78 +++++++++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
>> index 563045c7ce08..2d0c564c8d17 100644
>> --- a/drivers/mtd/nand/raw/davinci_nand.c
>> +++ b/drivers/mtd/nand/raw/davinci_nand.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/err.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>> +#include <linux/memory/ti-aemif.h>
>>   #include <linux/module.h>
>>   #include <linux/mtd/rawnand.h>
>>   #include <linux/mtd/partitions.h>
>> @@ -44,6 +45,9 @@
>>   #define	MASK_ALE		0x08
>>   #define	MASK_CLE		0x10
>>   
>> +#define MAX_TSU_PS		3000	/* Input setup time in ps */
>> +#define MAX_TH_PS		1600	/* Input hold time in ps */
>> +
>>   struct davinci_nand_pdata {
>>   	uint32_t		mask_ale;
>>   	uint32_t		mask_cle;
>> @@ -120,6 +124,7 @@ struct davinci_nand_info {
>>   	uint32_t		core_chipsel;
>>   
>>   	struct clk		*clk;
>> +	struct aemif_device	*aemif;
>>   };
>>   
>>   static DEFINE_SPINLOCK(davinci_nand_lock);
>> @@ -767,9 +772,81 @@ static int davinci_nand_exec_op(struct nand_chip *chip,
>>   	return 0;
>>   }
>>   
>> +#define TO_CYCLES(ps, period_ns) (DIV_ROUND_UP((ps) / 1000, (period_ns)))
>> +
>> +static int davinci_nand_setup_interface(struct nand_chip *chip, int chipnr,
>> +					const struct nand_interface_config *conf)
>> +{
>> +	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(chip));
>> +	const struct nand_sdr_timings *sdr;
>> +	struct aemif_cs_timings timings;
>> +	s32 cfg, min, cyc_ns;
>> +
>> +	cyc_ns = 1000000000 / clk_get_rate(info->clk);
>> +
>> +	sdr = nand_get_sdr_timings(conf);
>> +	if (IS_ERR(sdr))
>> +		return PTR_ERR(sdr);
>> +
>> +	cfg = TO_CYCLES(sdr->tCLR_min, cyc_ns) - 1;
>> +	timings.rsetup = cfg > 0 ? cfg : 0;
>> +
>> +	cfg = max_t(s32, TO_CYCLES(sdr->tREA_max + MAX_TSU_PS, cyc_ns),
>> +		    TO_CYCLES(sdr->tRP_min, cyc_ns)) - 1;
>> +	timings.rstrobe = cfg > 0 ? cfg : 0;
>> +
>> +	min = TO_CYCLES(sdr->tCEA_max + MAX_TSU_PS, cyc_ns) - 2;
>> +	while ((s32)(timings.rsetup + timings.rstrobe) < min)
>> +		timings.rstrobe++;
> 
> I see a lot of while loops which just stop if you reach a min/max, I
> believe a slightly more robust approach should be attempted, and
> returning errors when these limits are crossed would be probably
> beneficial on the long term?
> 

This comes from the DaVinci NAND controller's documentation (cf p908 of 
https://www.ti.com/lit/ug/spruh77c/spruh77c.pdf). A first formula, gives 
the RSETUP timing, a second one the RSTROBE timing and then a third 
formula gives a constraint that has to be met by the sum of RSETUP and 
RSTROBE.
Then the validity of the timings themselves is checked by the 
aemif_set_cs_timings() function.

It works the same way for WSETUP, WSTROBE and WHOLD with the other 
while() loops.

>> +
>> +	cfg = TO_CYCLES((s32)(MAX_TH_PS - sdr->tCHZ_max), cyc_ns) - 1;
>> +	timings.rhold = cfg > 0 ? cfg : 0;
>> +
>> +	min = TO_CYCLES(sdr->tRC_min, cyc_ns) - 3;
>> +	while ((s32)(timings.rsetup + timings.rstrobe + timings.rhold) < min)
>> +		timings.rhold++;
>> +
>> +	cfg = TO_CYCLES((s32)(sdr->tRHZ_max - (timings.rhold + 1) * cyc_ns * 1000), cyc_ns);
>> +	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tCHZ_max, cyc_ns)) - 1;
>> +	timings.ta = cfg > 0 ? cfg : 0;
>> +
>> +	cfg = TO_CYCLES(sdr->tWP_min, cyc_ns) - 1;
>> +	timings.wstrobe = cfg > 0 ? cfg : 0;
>> +
>> +	cfg = max_t(s32, TO_CYCLES(sdr->tCLS_min, cyc_ns), TO_CYCLES(sdr->tALS_min, cyc_ns));
>> +	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tCS_min, cyc_ns)) - 1;
>> +	timings.wsetup = cfg > 0 ? cfg : 0;
>> +
>> +	min = TO_CYCLES(sdr->tDS_min, cyc_ns) - 2;
>> +	while ((s32)(timings.wsetup + timings.wstrobe) < min)
>> +		timings.wstrobe++;
>> +
>> +	cfg = max_t(s32, TO_CYCLES(sdr->tCLH_min, cyc_ns), TO_CYCLES(sdr->tALH_min, cyc_ns));
>> +	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tCH_min, cyc_ns));
>> +	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tDH_min, cyc_ns)) - 1;
>> +	timings.whold = cfg > 0 ? cfg : 0;
>> +
>> +	min = TO_CYCLES(sdr->tWC_min, cyc_ns) - 2;
>> +	while ((s32)(timings.wsetup + timings.wstrobe + timings.whold) < min)
>> +		timings.whold++;
>> +
>> +	dev_dbg(&info->pdev->dev, "RSETUP %x RSTROBE %x RHOLD %x\n",
>> +		timings.rsetup, timings.rstrobe, timings.rhold);
>> +	dev_dbg(&info->pdev->dev, "TA %x\n", timings.ta);
>> +	dev_dbg(&info->pdev->dev, "WSETUP %x WSTROBE %x WHOLD %x\n",
>> +		timings.wsetup, timings.wstrobe, timings.whold);
>> +
> 
> Here you probably want to exit in the NAND_DATA_IFACE_CHECK_ONLY case.
> 

I had missed this NAND_DATA_IFACE_CHECK_ONLY feature. In fact, 
additionnal checks are done in the aemif_set_cs_timings() below. I'll 
add an 'aemif_check_cs_timings()' function in AEMIF's driver in next 
iteration.

>> +	if (aemif_set_cs_timings(info->aemif, info->core_chipsel, &timings) < 0)
>> +		dev_info(&info->pdev->dev,
>> +			 "Failed to dynamically update the CS timings, keep them unchanged");
>> +
>> +	return 0;
>> +}
>> +
> 
> Thanks,
> Miquèl


