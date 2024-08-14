Return-Path: <linux-kernel+bounces-286548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672C951C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87ACA1F23925
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC761B1433;
	Wed, 14 Aug 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdpD4SMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CF1AD9D6;
	Wed, 14 Aug 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643855; cv=none; b=F7Q/dyGxq4HIafl/QBUe78PIjyEEhyoARtU4aZSuOdSWMDHYT5n6v/moMfdSO4d5kabOQnaLM50RUKZBIYFJSSB2w40mHzVHD17xq8MKE5vAIFUkpiAv+yv7ZffZoUxKXuwPInysHF13g0Le5ectH9sHFD1q7a1sIuAkkayPC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643855; c=relaxed/simple;
	bh=bt+FMZ6bMUxAT+9f/nCY9eavG+uAs/lYP2LEpFVbwyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKM15MUhQAHJpcOeH73vUgKqRf6Eb8fk/1wsLV+EChtuZIPUMo+xYatKK+J7Ml0PSspLzqWyF4sMy8LscfQ8rMVKNS8aP6k0vApwgvQONM2e1HhnE7HbxxzRL6NaSOSKsh1+Q9GlDbBVV2NAQMHWAGAKDgNoebT1CvLjZRZBuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdpD4SMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0814C116B1;
	Wed, 14 Aug 2024 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643854;
	bh=bt+FMZ6bMUxAT+9f/nCY9eavG+uAs/lYP2LEpFVbwyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bdpD4SMSavxVc6t3m+D7wHFLwVuUXAnCBAyHucl2BIweiKs3idgomHnSw+Y2TI0MD
	 BqBnPcwlnr2Ql0IjjLvuuzmmYtDx7Hmja6gLPXi3jvgcHgEKZx9gTdDuK8X2K5HY1g
	 Mf3fQGMNG0DfctcTtFYYFbhe7U01JFmMekm3mOiXO4vxmy0oXUJgjQ//NVS9TR5dPW
	 loeb4Lz6YdHKah5FdDsPu/2xszhGrjhL/6w6QK/tMTzjYLE1LQ+ka6iDVx8jWWONPR
	 p7FHdh+a5PkUrs2lWSGM6vXpwC8f30xTQVdoTGIN940Jf2WZmMdn2ANTiy/eVfbNUP
	 z6rkQtq7MQufA==
Message-ID: <a71f5d8e-57bd-4e8e-b0fa-8b9468ec96eb@kernel.org>
Date: Wed, 14 Aug 2024 15:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ARM: dts: microchip: Clean up spacing and indentation
To: Andrei.Simion@microchip.com, claudiu.beznea@tuxon.dev,
 Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, peda@axentia.se
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Cristian.Birsan@microchip.com
References: <20240814122633.198562-1-andrei.simion@microchip.com>
 <20240814122633.198562-2-andrei.simion@microchip.com>
 <3294e2d3-5142-4d7f-89d3-35528f26066e@kernel.org>
 <5e37e263-ee00-41bd-a650-1c1374e24d66@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <5e37e263-ee00-41bd-a650-1c1374e24d66@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2024 15:32, Andrei.Simion@microchip.com wrote:
> On 14.08.2024 16:20, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 14/08/2024 14:26, Andrei Simion wrote:
>>> Checkpatch.pl reports some ERRORS related
>>> to coding style (spacing and indentation).
>>> So clean up : checkpatch.pl --fix-inplace
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>
> 
> checkpatch.pl has no lower limit for the number of characters.
> If you want 75 cols. OK for me.

That
has
nothing
to
do
with
checkpatch
but
with
readability. Please
read
submitting patches document.

> 
> 
>> Please be specific what are you changing.
>>
> 
> It was a bigger/bloated patch and I split it into smaller 
> ones based on what ARM/Microchip (AT91) Maintainer said.

I meant, what the commit is doing.

> 
>>
>>>
>>> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
>>> ---
>>> Split the bloated patch into small patches on topics
>>> based on comments:
>>> https://lore.kernel.org/linux-arm-kernel/89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev/
>>> ---
>>>  arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts  | 2 +-
>>>  arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 8 ++++----
>>>  arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts      | 8 ++++----
>>>  arch/arm/boot/dts/microchip/at91sam9263ek.dts         | 2 +-
>>>  4 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
>>> index 04cb7bee937d..1279dfb38300 100644
>>> --- a/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
>>> +++ b/arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts
>>> @@ -7,7 +7,7 @@
>>>   *                   HCE Engineering
>>>   *
>>>   * Derived from at91sam9g35ek.dts by:
>>> - *   Copyright (C) 2012 Atmel,
>>> + *   Copyright (C) 2012 Atmel,
>>
>> Not sure what you are fixing here, but unnecessary tab was here before
>> and still exists...
>>
> 
> WARNING: please, no space before tabs
> #10: FILE: arch/arm/boot/dts/microchip/at91-cosino_mega2560.dts:10:
> + * ^ICopyright (C) 2012 Atmel,$
> 
> after this patch : this warning disappears.

Yeah, but code is not correct, is it?

Do not run checkpatch --inplace and commit the changes. Who gave you
such idea?

Instead fix the actual issue in a correct way.



Best regards,
Krzysztof


