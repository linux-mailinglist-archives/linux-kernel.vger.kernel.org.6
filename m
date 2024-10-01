Return-Path: <linux-kernel+bounces-346212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B098C12E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8790F1F20FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0B1CC89D;
	Tue,  1 Oct 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VuFzu3fp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42851CB520;
	Tue,  1 Oct 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795142; cv=none; b=P/ZXKyubOBMxGkhUxyuyi9lB7vHFKiRFg5GKjMXpeBBWqvCGgCgi53YuqFlGMv7AtQ75R4HI55/fdispb4rmgYBh+CuHjMay6ZEBbOsy5LvgnrOJS5KaskaP1MTj8/jqbLMPJtTQ87WaRQhWa39BaV7Rs4pQhS4YrnZc1S7aBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795142; c=relaxed/simple;
	bh=05ZkBcNV3IGaiYx+K36m2aM5Z0h5kUIxoKfTz/gD41Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pJlRC8e/9Rmy1aoIvYFwKJ25DWREzk5Aftnl58MkW07jVKZkDVmmAzUZzkWM8zLueAocTMKOjsBFmc3rIjWJ9yLbBVY4iXKwylWPtAB1YLnQ3QozizwGlDMVhA4PV9pDzkdRVMQtnw63UlHOoQKrUhczSVduXwqECI0OxtZMAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VuFzu3fp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727795138; x=1759331138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=05ZkBcNV3IGaiYx+K36m2aM5Z0h5kUIxoKfTz/gD41Q=;
  b=VuFzu3fplVNHVFPtz+DJlVVlVkrupeFS6ws+l3Cykwua3RGR9vvgxdvn
   Oud3bJshkYJaCtGydnfHM9PV0MrWu6gp0OLcASQzEQCGxSbhaEQRxEEtS
   YRds0Z/QIucdmxrQ5wHheQCpSlKE8OgptI4scd3wOX9CyfKWKVy4W3evQ
   aFZ3uajQOx94+Vo64xdysTo+7Mrhdwe7QWPtEkHj0UTBYSiurlJEQaKyp
   e8tx6ci3avtKwQN5ONKTOfCkKVvGm+JCr82zKLNFh36KG2ox8DAnruaCg
   N7lXw2uY37GIOtW2ycvoTx6cbBJBEXfPxm5ER87FnemuNrR8MA5+fPE9X
   g==;
X-CSE-ConnectionGUID: cApD+rLAQ76WWTV+KoOt/A==
X-CSE-MsgGUID: CXR+2IDVRZiHrkjeZDhecw==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="32308562"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 08:05:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 08:04:56 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 1 Oct 2024 08:04:56 -0700
Message-ID: <d226d9e4-667a-4b4f-bc3f-9910f7c0d3e0@microchip.com>
Date: Tue, 1 Oct 2024 08:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc
 through DT
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <ada@thorsis.com>
CC: Conor Dooley <conor+dt@kernel.org>, "moderated list:ARM/Microchip (AT91)
 SoC support" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:COMMON CLK
 FRAMEWORK" <linux-clk@vger.kernel.org>, Rob Herring <robh@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Christian Melki <christian.melki@t2data.com>, "Michael
 Turquette" <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-10-ada@thorsis.com>
 <20240919-outsider-extending-e0a926bd23fa@thorsis.com>
 <464f599a-7f0b-4e4e-901a-8f88a25428d6@microchip.com>
 <e6c10efa-0ed6-4040-8fe2-e83d3903547a@tuxon.dev>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <e6c10efa-0ed6-4040-8fe2-e83d3903547a@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 9/26/24 00:42, claudiu beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hi, Ryan, Alexander,
> 
> Sorry for returning late, I took some time to think about it...
> 
> On 24.09.2024 18:52, Ryan Wanner wrote:
>> Hello Alex,
>>
>> I think a possible solution is to put the DT binding ID for main rc oc
>> after PMC_MCK and then add 1 to all the other IDs that are not dependent
>> on PMC_MAIN, the IDs that are before the branch for the sama7g54.
> 
> If I understand correctly, wouldn't this shift also the rest of the IDs
> and break the DT ABI?
> 
>>
>> One issue I see with this solution is with SoCs that do not want the
>> main rc os exported to the DT the driver array might be allocating too
>> much memory, this can be solved by removing the +1 that is in the clock
>> drivers next to the device tree binding macro, since this macro is now
>> increased by 1 with this change.
>>
>> Doing a quick test on the sam9x60 and sama7g54 I did not see any glaring
>> issues with this potential solution.
>>
>> Best,
>>
>> Ryan
>>
>>
>> On 9/19/24 05:39, Alexander Dahl wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Hello Claudiu,
>>>
>>> after being busy with other things, I'm back looking at this series.
>>> As Nicolas pointed out [1], we need three clocks for the OTPC to work,
>>> quote:
>>>
>>>   "for all the products, the main RC oscillator, the OTPC peripheral
>>>   clock and the MCKx clocks associated to OTP must be enabled."
>>>
>>> I have a problem with making the main_rc_osc accessible for both
>>> SAM9X60 and SAMA7G5 here, see below.
>>>
>>> Am Wed, Aug 21, 2024 at 12:59:40PM +0200 schrieb Alexander Dahl:
>>>> SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
>>>> says:
>>>>
>>>>     "The OTPC is clocked through the Power Management Controller (PMC).
>>>>     The user must power on the main RC oscillator and enable the
>>>>     peripheral clock of the OTPC prior to reading or writing the OTP
>>>>     memory."
>>>>
>>>> The code for enabling/disabling that clock is already present, it was
>>>> just not possible to hook into DT anymore, after at91 clk devicetree
>>>> binding rework back in 2018 for kernel v4.19.
>>>>
>>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>>> ---
>>>>  drivers/clk/at91/sam9x60.c       | 3 ++-
>>>>  include/dt-bindings/clock/at91.h | 1 +
>>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
>>>> index e309cbf3cb9a..4d5ee20b8fc4 100644
>>>> --- a/drivers/clk/at91/sam9x60.c
>>>> +++ b/drivers/clk/at91/sam9x60.c
>>>> @@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>>>       if (IS_ERR(regmap))
>>>>               return;
>>>>
>>>> -     sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
>>>> +     sam9x60_pmc = pmc_data_allocate(PMC_MAIN_RC + 1,
>>>>                                       nck(sam9x60_systemck),
>>>>                                       nck(sam9x60_periphck),
>>>>                                       nck(sam9x60_gck), 8);
>>>> @@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>>>                                          50000000);
>>>>       if (IS_ERR(hw))
>>>>               goto err_free;
>>>> +     sam9x60_pmc->chws[PMC_MAIN_RC] = hw;
>>>>
>>>>       hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
>>>>       if (IS_ERR(hw))
>>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
>>>> index 3e3972a814c1..f957625cb3ac 100644
>>>> --- a/include/dt-bindings/clock/at91.h
>>>> +++ b/include/dt-bindings/clock/at91.h
>>>> @@ -25,6 +25,7 @@
>>>>  #define PMC_PLLBCK           8
>>>>  #define PMC_AUDIOPLLCK               9
>>>>  #define PMC_AUDIOPINCK               10
>>>> +#define PMC_MAIN_RC          11
>>>>
>>>>  /* SAMA7G5 */
>>>>  #define PMC_CPUPLL           (PMC_MAIN + 1)
>>>
>>> There are IDs defined in the devicetree bindings here, which are used
>>> both in dts and in driver code as array indexes.  In v1 of the patch
>>> series I just added a new last element in the end of the generic list
>>> and used that for SAM9X60.
>>>
>>> For SAMA7G5 those IDs are branched of from PMC_MAIN in between, making
>>> SAMA7G5 using a different last element, and different values after
>>> PMC_MAIN.
> 
> Looking at it now, I think it was a bad decision to do this branch.
> Thinking at it maybe it would be better to have per SoC specific bindings
> to avoid this kind of issue in future. The PMC IP b/w different SAM SoCs is
> anyway different and, as it happens now, we may reach to a point where, due
> to issues in datasheet, or whatever human errors, we may reach this problem
> again.
> 
> So, what do you think about having separate binding files for each SoC?

I think the simplest way to do this is having a separate file for the
SAMA7 SoC clock bindings. To me it looks like the split is for the SAMA7
SoCs only, so having a separate file will be the best solution as it
will mean less duplicate code and still keeping the O(1) look up time.

Best,
Ryan
> 
> Another option would be to xlate the clocks not by directly indexing in
> struct pmc_data::chws but by matching the driver clock ID and DT provided
> id. This will increase the lookup time, from O(1) to O(N), N being 13 for
> SAMA7G5, 15 for SAM9X7 and SAMA7D55. And will need adjustment at least for
> SAM9X{60, 7} and SAMA7{G5, D55}. With this the of_clk_hw_pmc_get() will be
> something like:
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 5aa9c1f1c886..22191d1ca78b 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -52,8 +52,10 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args
> *clkspec, void *data)
> 
>         switch (type) {
>         case PMC_TYPE_CORE:
> -               if (idx < pmc_data->ncore)
> -                       return pmc_data->chws[idx];
> +               for (int i = 0; i < pmc_data->ncore; i++) {
> +                       if (pmc_data->chws.idx[i] == i)
> +                               return pmc_data->chws.hws[i];
> +               }
>                 break;
> 
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 4fb29ca111f7..f7e88f9872dc 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -19,7 +19,10 @@ extern spinlock_t pmc_pcr_lock;
> 
>  struct pmc_data {
>         unsigned int ncore;
> -       struct clk_hw **chws;
> +       struct {
> +               struct clk_hw **hws;
> +               int *idx;
> +       } chws;
> 
> Thank you,
> Claudiu Beznea
> 
>>>
>>> Now we need a new ID for main rc osc, but not only for SAM9X60, but
>>> also for SAMA7G5.  I'm not sure what the implications would be, if the
>>> new ID would be added in between before PMC_MAIN, so all values would
>>> change?  Adding it to the end of the lists would probably be safe, but
>>> then you would need a diffently named variant for SAMA7G5's different
>>> IDs.  I find the current status somewhat unfortunate for future
>>> extensions.  How should this new ID be added here?  What would be the
>>> way forward?
>>>
>>> Greets
>>> Alex
>>>
>>> [1] https://lore.kernel.org/linux-clk/ec34efc2-2051-4b8a-b5d8-6e2fd5e08c28@microchip.com/T/#u
>>>
>>>> --
>>>> 2.39.2
>>>>
>>>>
>>>
>>


