Return-Path: <linux-kernel+bounces-190129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30338CF9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D8280A50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1C1AAA5;
	Mon, 27 May 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkBW3kwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265217C60
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794399; cv=none; b=YyRravEuHW6Z70Pp0RpavALQ/EBvl3NJlGSiNlZZE0frrsvhlMxQFmB6mL1gnmg7PJJBcU2kO9C0aM9L8R8KZmDDRqibpwlra40DEM9zSRfdtApcgOIDQ6TP0I9pOmKoi5xyHeCaEyMhYqTSOiTVd5GX1SJwiC6dDIcw2+e14F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794399; c=relaxed/simple;
	bh=q9n8gPWsKQklgj2OKUpvVXNvMah5NFymAiXyPf3yL6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqSlmHfbwQwDEehPM0AEH4cBMoCzigUOq8ziIBl96GV0pRMg9R98n61Z/391vIIUotwShjXZWi5KuuieD116260tFZE2AUPjE9QEf2H3jwYcAR9OoFcN71hBKdek0qxE1w7GJYUZ38WGjl+JCdJwgn0ETz4+ePWJxT8lj5baT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkBW3kwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CF9C2BBFC;
	Mon, 27 May 2024 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716794399;
	bh=q9n8gPWsKQklgj2OKUpvVXNvMah5NFymAiXyPf3yL6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lkBW3kwq30wT7IMRV2WeerIHDwVTSAvast4OKto1e1aHXLi7ZAK5kKPDNWOd8fyh+
	 vWRJdlA0pCaIXXUO84J09+Oe6hpQuXGHOtByOxZ3YPoyzfHWr7UY835zJRkoIq6PAb
	 t6UazWZfp5HUNXMZdKnn/SNnHLs7ab3OHtDUoLQQZGpKZbS4UODa+f5CZomKGSjJjm
	 DdbKPzwrP5C0PmWpXpjU/wI8OF4DHrz0w+3XebB2IA6dke2DrSQO0teplK+kJZyMiJ
	 eQ4Hh+/rJPn1AbqgLtRXpmDQdohnZheGa9jXoKvqugjy18FdxgWnlvCJpxLwqNVK06
	 KAcfzmBzvLQsA==
Message-ID: <c045f1a4-9ddf-4c53-a69b-22ceb68a1ce8@kernel.org>
Date: Mon, 27 May 2024 09:19:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
To: Esben Haabendal <esben@geanix.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
 <979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org> <87cypc38gu.fsf@geanix.com>
 <9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org> <87le3zoatn.fsf@geanix.com>
 <6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org> <87ttijaglp.fsf@geanix.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <87ttijaglp.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/05/2024 08:55, Esben Haabendal wrote:
> Krzysztof Kozlowski <krzk@kernel.org> writes:
> 
>> On 24/05/2024 10:47, Esben Haabendal wrote:
>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>
>>>> On 23/05/2024 16:32, Esben Haabendal wrote:
>>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>>
>>>>>> On 23/05/2024 15:58, Esben Haabendal wrote:
>>>>>>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>>>>>>> driver selects FSL_IFC automatically, we need the option to be selectable
>>>>>>> for platforms using fsl_ifc with NOR flash.
>>>>>>
>>>>>> Which driver is that?
>>>>>
>>>>> This is drivers/memory/fsl_ifc.o driver. It is for Integrated Flash
>>>>> Controller (IFC) from NXP. It is used in various Layerscape socs.
>>>>
>>>> ? I know that, I mean the NOR flash working here.
>>>
>>> Ah, sorry. The NOR flash I am using here is a Spansion S29AL016J.
>>>
>>>>>> Which DTS?
>>>>>
>>>>> It is for "fsl,ifc" compatible devices.
>>>>
>>>> That's not a NOR flash.
>>>
>>> Nope.  The binding used for the NOR flash is "cfi-flash".
>>
>> And now let's get back to my original question. I asked for driver, not
>> device, and for DTS not compatible.
> 
> You got me really confused now. I am not sure what you are asking me
> for, and why.
> 
> I am sending a patch which changes to Kconfig for a memory controller
> driver. The change is AFAICS quite similar to commit be34f45f0d4a
> ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable").
> 
> As for the NOR flash that in this situation is attached to the IFC
> controller, it is (as mentioned) Spansion S29AL016J. It is handled by
> the drivers/mtd/maps/physmap.o driver (CONFIG_MTD_PHYSMAP +
> CONFIG_MTD_PHYSMAP_OF)

Thanks.

> 
> The DTS used to specify the NOR flash is

Upstream DTS. I don't care about downstream.

> 
> &ifc {
>         status = "okay";
>         #address-cells = <2>;
>         #size-cells = <1>;
>         ranges = <0x0 0x0 0x0 0x60000000 0x00200000>;
> 
>         nor_flash: nor@0,0 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 compatible = "cfi-flash";
>                 reg = <0x0 0x0 0x200000>;
>                 bank-width = <2>;
> 
>                 partition@0 {
>                         reg = <0x000000 0x0f0000>;
>                         label = "boot0";
>                 };
>         };
> };
> 
> So as mentioned, it is a quite standard "cfi-flash" compatible device
> declaration.
> 
> Do you think there is a way that ti enable CONFIG_FSL_IFC for my
> situation without the config being visible? Something like automatically
> selecting CONFIG_FSL_IFC when CONFIG_MTD_PHYSMAP and
> CONFIG_MTD_PHYSMAP_OF is enabled? Will that not include a risk of
> pulling in CONFIG_FSL_IFC in some cases where it is not desired?
> 
> Something like
> 
> config MTD_PHYSMAP
> 	tristate "Flash device in physical memory map"
> 	depends on MTD_CFI || MTD_JEDECPROBE || MTD_ROM || MTD_RAM || MTD_LPDDR
>         select FSL_IFC if SOC_LS1021A
> 
> But that looks like a road somewhere not so nice. The generic
> MTD_PHYSMAP being littered with architecture specific selects.
> 
> Or is there something completely obvious (not for me then) that I am
> missing?

If there is no user for such option, why changing it? To clarify:
whatever is out of tree, does not really exist...

Best regards,
Krzysztof


