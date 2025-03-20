Return-Path: <linux-kernel+bounces-570021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0CEA6AAED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9004F7A7368
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFFF1EF394;
	Thu, 20 Mar 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puN9NyjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816071E3DD3;
	Thu, 20 Mar 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487639; cv=none; b=VdngUInG0jJXzV8ug0Ftd7T0sEVO8aq6Aw4ct5Dxts5x7PjPqtvJM3m53DA+3nhG35ac8vyxp3g2Tgj7e5IdKx1Uk0txvFT4DkTCFTYjk29KZTbevpYyi4ZHfk4l8/Rr4II/Ehr8hnGVv+1v0ZkmIW3moU2zrEuJgl0wJG/uDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487639; c=relaxed/simple;
	bh=09ZvEo9Lo8wDXBHYBhzRezudTriTulM3WHI6hCa51Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYvQtcnERqziMYpjFzd+GAvEKz1UY9xqrlZ35HKdcj+NEtjqMI0Wngg5e8aZBDsndh72wfjFI8RUcZpKFj9a/c0eBth3nkakl+JUAacePSC153iZac2NUVwFZw0tudKv0F229L9VvYSYJjtwesUqiLtlnL3q2+mgt7swjlju2os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puN9NyjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ED1C4CEDD;
	Thu, 20 Mar 2025 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742487639;
	bh=09ZvEo9Lo8wDXBHYBhzRezudTriTulM3WHI6hCa51Nk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=puN9NyjLrRNlhGHgDejODSbzff/92krPiS3mKFZxi7T3OFQfMvTeFQdk6sERmu42Z
	 NxTOJtZDglCsMi60wIoF+UTQvG+pEtM7j5F6noCDnlq3BD59nye912C4pdV7OWh/x1
	 qDQsX59VD247e3kXWne8Gy1zP5Q4BJoVSdABpWv7u6wvYTbYxTy4cr1BHly75RrZIr
	 RNR8B6G9csJjcJnpZBlpTk6m7wFLVG8/hlNIzDKD59Y82lBUivyVxgfD7+nqdSMt8v
	 duDkpXpFaQ/lpzmqD8qd1Kuza0VbabVRo5QaNj7TMRZ/BW35xPYazQrSZSxjL9YEMz
	 TWVRrgv9zHD1Q==
Message-ID: <7ed2af14-7677-4188-b77b-7f3c325d40a4@kernel.org>
Date: Thu, 20 Mar 2025 17:20:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add CIX SoC maintainer entry
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
 <20250305053823.2048217-7-peter.chen@cixtech.com>
 <7419360a-abc0-44cf-8d55-8f5fad8e9079@kernel.org>
 <Z9vyy7f5NOPyzUES@nchen-desktop>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z9vyy7f5NOPyzUES@nchen-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2025 11:49, Peter Chen wrote:
> On 25-03-20 10:25:53, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL
>>
>> On 05/03/2025 06:38, Peter Chen wrote:
>>> Using this entry as the maintainers information for CIX SKY series SoCs.
>>>
>>> Acked-by: Fugang Duan <fugang.duan@cixtech.com>
>>> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
>>> ---
>>> Changes for v4
>>> - Add two dts files as maintained files
>>>
>>>  MAINTAINERS | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index efee40ea589f..edf26cf11ee2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2354,6 +2354,16 @@ F:     arch/arm/boot/compressed/misc-ep93xx.h
>>>  F:   arch/arm/mach-ep93xx/
>>>  F:   drivers/iio/adc/ep93xx_adc.c
>>>
>>> +ARM/CIX SKY ARM ARCHITECTURE
>>> +M:   Peter Chen <peter.chen@cixtech.com>
>>> +M:   Fugang Duan <fugang.duan@cixtech.com>
>>> +R:   CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>
>>> +L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>> +S:   Maintained
>>> +F:   Documentation/devicetree/bindings/arm/cix.yaml
>>> +F:   arch/arm64/boot/dts/cix/sky1-orion-o6.dts
>>> +F:   arch/arm64/boot/dts/cix/sky1.dtsi
>>
>> Instead:
>> arch/arm64/boot/dts/cix/
>>
>> or if you think there will be more different architectures coming from
>> cix, which you will not maintain, then useful would be a "sky" subdirectory.
>>
> Hi Krzysztof,
> 
> Thanks for your comment, CIX is Arm SoC based silicon design
> company, we may have different SoC style for middle end in future.
> So, for that SoC series, it may not name sky.

Your Kconfig says ARCH_CIX :/

Anyway, listing individual files is pointless, so if you are not going
to maintain entire arch, then create subdir. Otherwise why creating so
many entries? The biggest upstreamed SoC vendor (by number of SoCs and
boards has one entry.


Best regards,
Krzysztof

