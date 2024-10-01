Return-Path: <linux-kernel+bounces-346053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5398BEC9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF21D285603
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA41C7B9D;
	Tue,  1 Oct 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKGc7oIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1491C6F70;
	Tue,  1 Oct 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791184; cv=none; b=Fi7qTd97NwmsZDGeE7RJ/Ng2vvD2KV05ptRqd4+YAqXB21aEtJus3q8FVth3zcXyZdqNhUJou1BsGmnZ0IpfvNN4xSR1WddHfk77AerOaQFRsTpEYZbN99uohNBfrydHWfmAcHsGdMUBpSoikQ80mVzp8zgI4CYeN8APcb7drjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791184; c=relaxed/simple;
	bh=QT8/sIkqWH5UWAUvNNM3cYc5PhWtk3v9UxRxQKqjGbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkVPVDLP9sX4XWgI0itsEGSxrlqQcpmdTxRvNRkrnuB0EepB8JKnF9KGFpPv757T+Krp4ZFpWSTLRWUM8xhLgcxsoH5GRDkJ6jmf/xgjuO8jHqc/1o1mGJZ051h5P5dW6LzMpjxhFblvcHH/mYiK9vBYZ+QUQhA4UyulJi9Sj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKGc7oIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FABBC4CEC6;
	Tue,  1 Oct 2024 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727791184;
	bh=QT8/sIkqWH5UWAUvNNM3cYc5PhWtk3v9UxRxQKqjGbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nKGc7oIXWZXtSDyhVT+Qew857D7Zw8KgqHWztUOcGuMsi7pCWlxpLPhhPR94chqWt
	 qZzm3GtpL8s3yQBSttWkDuedY/jbm231sLsiRnvvOmwAcxEGiq2eM+ECDQ8QU1jhBl
	 IsbWsFCGeEqFFy1v5xFXlmkB6TkcpwOLLcGKata+KBWNp+zId/r/h913r9PuE6K1nq
	 7rVDTns+Ck4+u3mjHFEt+sGX83kkqxr+T3h6sWzwUqBmjO8JS7j+LKU1K3EvKAp5Yq
	 hREy2D/rfDM5dy3oJzbutn3/5SncBnE8PssoWJkI5eaeaZRGNp66+flpYkyIhDxqmG
	 AAiYARSdJdSQw==
Message-ID: <3d9de1b8-488b-4df5-b984-7581b1d02241@kernel.org>
Date: Tue, 1 Oct 2024 15:59:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Update tla2024 adc
 compatible
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>
 <a5890be6-914c-48cc-9abd-761961ccb7ca@kernel.org>
 <20241001130128.GA36341@francesco-nb>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241001130128.GA36341@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/10/2024 15:01, Francesco Dolcini wrote:
> Hello Krzysztof,
> 
> On Tue, Oct 01, 2024 at 01:54:56PM +0200, Krzysztof Kozlowski wrote:
>> On 01/10/2024 13:14, João Paulo Gonçalves wrote:
>>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>
>>> With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
>>> new compatible was introduced for TLA2024 ADC. Update the device
>>> tree to use the correct compatible for the Verdin-AM62 hardware.
>>>
>>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>>> index 5bef31b8577b..f201722d81b3 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>>> @@ -1220,7 +1220,7 @@ sensor@48 {
>>>  	};
>>>
>>>  	adc@49 {
>>> -		compatible = "ti,ads1015";
>>> +		compatible = "ti,tla2024";
>>
>> So it is not always TI, who breaks their users. :) (as pointed out in
>> LPC DT BoF).
> 
> So, let's adjust what I said at that time, I think is important, and I
> appreciate you giving me an excuse for doing that :-)
> 
> Lately as Toradex we are working a lot with TI, and one of the reasons is
> that they have a great software support, backed-up by a great strategy
> on the way they contribute to the various upstream projects they build
> their SDK on top (Linux, U-Boot, and more).
> 
> With that is normal that while working so closely with them we find
> issues, everybody have those, it's just that those are the one we
> care the most at the moment :-). Not to mention that we started working
> with TI a couple of years ago, so TI is still somehow "new" to us and we
> are still "learning".
> 
> On this regards I was recently working on updating our BSP to the
> latest SDK from TI, that is based on a v6.6 stable kernel and looking at
> the patches we had to apply on top, the total counts of the patches we
> do not have in mainline to support the board subject of this patch is
> just _zero_. This to me is a great achievement.
> 
> Nishant: this is also for you, and feel free to "market" this
> internally/externally :-)
> 
> 
>> If you want to break users, sure, but at least explain in commit msg why.
> 
> Now, on this specific topic, the actual device that is assembled on this
> board is a TI TLA2024, and it's like that since ever, the board never
> changed. The current compatible is not matching what is assembled on
> board. It works because the device is close enough to TI ADS1015.
> 
> With that said, I do not think this is breaking any actual compatibility
> issue.
> 
>  - The old DTB will keep working with old and new kernel.

New DTB stops working with old kernel and this is what we talked about
during LPC.

All out-of-tree users of this DTS, like other operating systems, will be
affected as well probably.

>  - The commit adding support for TI TLA2024 is in v5.19, and this board
>    is supported only from kernel v6.5, so you cannot run an older kernel
>    with this board. In addition to that I do not think that is
>    reasonable to have someone using a "new" dtb with an "old" kernel.
>  - The firmware, U-Boot, the only one that currently supports this board,
>    is not making any use of this compatible nor of this ADC.
Best regards,
Krzysztof


