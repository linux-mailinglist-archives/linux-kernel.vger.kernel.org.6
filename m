Return-Path: <linux-kernel+bounces-337341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8309848DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327651F23ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6E1AB53B;
	Tue, 24 Sep 2024 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zCVMOEXL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD201B85D5;
	Tue, 24 Sep 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193162; cv=none; b=pIK0mnfOpRqmZ+eIz+f3V7vIQ7X8NXaE4G293p62Jc91mV1qdats4y7lf0JZz7WD/vAsNXGRhcgwhAE0dtexOs1ou0kSNlXVSh3BuLnvZySojeo3Q+X5tHdR2A0jhDl+hTjT7J8u5Rkd2c8v0jjxpzSmOE6K7VQSgWW4Pdv59Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193162; c=relaxed/simple;
	bh=7E+7UEkwjUbxfbsRFm3hKw2YmniUAtebWb+XuKT1dtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=UQ2rzd/4fZCbJBmWAWEAnuuw/gCAOamOlidQuNzAFln6YJZEnb0UGfzIprdY2iGNdnWYXdlqeXLv7BX3eFZEvfMaoG5MHgDfAtCvQ9kfeh7Bb7J6LaSXrtCoVbvxyXQcWzlLXJgPLalOEEjWcXZCUx47EDEbtc2VoFBZENaKk8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zCVMOEXL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727193160; x=1758729160;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=7E+7UEkwjUbxfbsRFm3hKw2YmniUAtebWb+XuKT1dtw=;
  b=zCVMOEXLHikO+32DwLVsFKwvGnbFZc9c/hUb/HDFRYfHJAKNsOQtYAHf
   p0ORMq9QAPc4Yu3W8+RMOeGi5GdXZ9FU+uOuO77DpUOsgbU/Suj90qJ/C
   qyxPqJ39vepuqgUJ25F2K/WTcH1Tr7ReW9xeA8nN6JShge/4VGl8al6he
   AYEOtf3s+wlujZyDH/yJ2ykMV7pATDrBinuSCX+J/BKxl0foBhNjz+iyD
   80li0R65a29EA7aKq66l0Uz5rmKKVAVaCvB4fW7t3odhJzrT97XKTJ9dR
   c0bg3HZek+/cA8nByQUTHo4aa8QlzeatMEVlKFRAxxD9AmTW1QnK5RDMW
   A==;
X-CSE-ConnectionGUID: 1OMnI0PRS827S4FmdZcQZQ==
X-CSE-MsgGUID: XGDFMa1pQuuOEYOAZgyD7A==
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="32795531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2024 08:52:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 24 Sep 2024 08:52:22 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 24 Sep 2024 08:52:22 -0700
Message-ID: <464f599a-7f0b-4e4e-901a-8f88a25428d6@microchip.com>
Date: Tue, 24 Sep 2024 08:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc
 through DT
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, <ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-10-ada@thorsis.com>
 <20240919-outsider-extending-e0a926bd23fa@thorsis.com>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
CC: Conor Dooley <conor+dt@kernel.org>, "moderated list:ARM/Microchip (AT91)
 SoC support" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:COMMON CLK
 FRAMEWORK" <linux-clk@vger.kernel.org>, Rob Herring <robh@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Christian Melki <christian.melki@t2data.com>, "Michael
 Turquette" <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>
In-Reply-To: <20240919-outsider-extending-e0a926bd23fa@thorsis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello Alex,

I think a possible solution is to put the DT binding ID for main rc oc
after PMC_MCK and then add 1 to all the other IDs that are not dependent
on PMC_MAIN, the IDs that are before the branch for the sama7g54.

One issue I see with this solution is with SoCs that do not want the
main rc os exported to the DT the driver array might be allocating too
much memory, this can be solved by removing the +1 that is in the clock
drivers next to the device tree binding macro, since this macro is now
increased by 1 with this change.

Doing a quick test on the sam9x60 and sama7g54 I did not see any glaring
issues with this potential solution.

Best,

Ryan


On 9/19/24 05:39, Alexander Dahl wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello Claudiu,
> 
> after being busy with other things, I'm back looking at this series.
> As Nicolas pointed out [1], we need three clocks for the OTPC to work,
> quote:
> 
>   "for all the products, the main RC oscillator, the OTPC peripheral
>   clock and the MCKx clocks associated to OTP must be enabled."
> 
> I have a problem with making the main_rc_osc accessible for both
> SAM9X60 and SAMA7G5 here, see below.
> 
> Am Wed, Aug 21, 2024 at 12:59:40PM +0200 schrieb Alexander Dahl:
>> SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
>> says:
>>
>>     "The OTPC is clocked through the Power Management Controller (PMC).
>>     The user must power on the main RC oscillator and enable the
>>     peripheral clock of the OTPC prior to reading or writing the OTP
>>     memory."
>>
>> The code for enabling/disabling that clock is already present, it was
>> just not possible to hook into DT anymore, after at91 clk devicetree
>> binding rework back in 2018 for kernel v4.19.
>>
>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>> ---
>>  drivers/clk/at91/sam9x60.c       | 3 ++-
>>  include/dt-bindings/clock/at91.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
>> index e309cbf3cb9a..4d5ee20b8fc4 100644
>> --- a/drivers/clk/at91/sam9x60.c
>> +++ b/drivers/clk/at91/sam9x60.c
>> @@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>       if (IS_ERR(regmap))
>>               return;
>>
>> -     sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
>> +     sam9x60_pmc = pmc_data_allocate(PMC_MAIN_RC + 1,
>>                                       nck(sam9x60_systemck),
>>                                       nck(sam9x60_periphck),
>>                                       nck(sam9x60_gck), 8);
>> @@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>                                          50000000);
>>       if (IS_ERR(hw))
>>               goto err_free;
>> +     sam9x60_pmc->chws[PMC_MAIN_RC] = hw;
>>
>>       hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
>>       if (IS_ERR(hw))
>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
>> index 3e3972a814c1..f957625cb3ac 100644
>> --- a/include/dt-bindings/clock/at91.h
>> +++ b/include/dt-bindings/clock/at91.h
>> @@ -25,6 +25,7 @@
>>  #define PMC_PLLBCK           8
>>  #define PMC_AUDIOPLLCK               9
>>  #define PMC_AUDIOPINCK               10
>> +#define PMC_MAIN_RC          11
>>
>>  /* SAMA7G5 */
>>  #define PMC_CPUPLL           (PMC_MAIN + 1)
> 
> There are IDs defined in the devicetree bindings here, which are used
> both in dts and in driver code as array indexes.  In v1 of the patch
> series I just added a new last element in the end of the generic list
> and used that for SAM9X60.
> 
> For SAMA7G5 those IDs are branched of from PMC_MAIN in between, making
> SAMA7G5 using a different last element, and different values after
> PMC_MAIN.
> 
> Now we need a new ID for main rc osc, but not only for SAM9X60, but
> also for SAMA7G5.  I'm not sure what the implications would be, if the
> new ID would be added in between before PMC_MAIN, so all values would
> change?  Adding it to the end of the lists would probably be safe, but
> then you would need a diffently named variant for SAMA7G5's different
> IDs.  I find the current status somewhat unfortunate for future
> extensions.  How should this new ID be added here?  What would be the
> way forward?
> 
> Greets
> Alex
> 
> [1] https://lore.kernel.org/linux-clk/ec34efc2-2051-4b8a-b5d8-6e2fd5e08c28@microchip.com/T/#u
> 
>> --
>> 2.39.2
>>
>>
> 


