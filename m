Return-Path: <linux-kernel+bounces-202260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5139A8FCA63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49511F22DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF59192B94;
	Wed,  5 Jun 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fHqPZ+f9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF358F6A;
	Wed,  5 Jun 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586736; cv=none; b=DGXs8ULPCv1/JRq152lSxAqxmwZccsrZmfGPTbH0D0JkV9xojFuSioAvZQ0qqWYTQm/USGHQCGodQnbroWiJPETgd9/Cbd5mjhv83H0IPzkHjGsvsJDCrBqd8TYnhU4g8LouFeZTSrEE1E5c6IaxTpT5hjZrf2yEEMVH+v5XCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586736; c=relaxed/simple;
	bh=7SIN4Dh8iWcVPhTl6XQdG+T06wZg5VrgK1Kuc/BrCRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtoszHpTpvpyVgjp8cMSOmgWrekJ4Wz2pjO9q+ftEOUO8h6DL76I016zvS2yUro6GMY/sSIj2Y6KtdaeKJGfStdz/IBWFSbL7CF5yTrCmZg/d52IWKCEUJKVkvQCs+7VZGaDsrv7q4sWHLjGk+MjbiSg2VV7/JpqclriqZTtMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fHqPZ+f9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717586733;
	bh=7SIN4Dh8iWcVPhTl6XQdG+T06wZg5VrgK1Kuc/BrCRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHqPZ+f929TcIW07N83k9cmzcGHyGqXjJXzqbRkm31WabNru7K32nQxkpmAtpYpRl
	 3DV8huTacAXKoHT3Prhx45lx0rnsOOriqVi+NIJIT8HyLUu9TRTfay4HqlWFKMljVO
	 O9IDgbRz4vd0m6txJnKQ+K5lOxc0msPngVnLZtrbwPvL7ccKORG01DuoN+WNg+Ip9k
	 2OUqS9mvf/tXMhvDMitt3od5KZiHx/jMft+wAuJgQU70GSaC72/FaHzCHl305al8xW
	 gsaEek6mucH75sS0AlsJihhUYcPKroXvzvL4tNvrSQpII891M0adsUnf0YIMypqba2
	 9Kr22dFmP5Vyw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7A8343781139;
	Wed,  5 Jun 2024 11:25:32 +0000 (UTC)
Message-ID: <08256a88-7165-41ca-b484-4acf1c8e316b@collabora.com>
Date: Wed, 5 Jun 2024 13:25:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power
 domain clock
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-6-wenst@chromium.org>
 <4f20f130-c9ab-43ea-a758-e29d7be10db0@collabora.com>
 <CAGXv+5GuGz-KahcbKtuyUA1-59sMWSL0QucOdp8FPoQWrc9YUQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5GuGz-KahcbKtuyUA1-59sMWSL0QucOdp8FPoQWrc9YUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/06/24 10:25, Chen-Yu Tsai ha scritto:
> On Thu, May 30, 2024 at 6:03 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
>>> The MFG_ASYNC domain, which is likely associated to the whole MFG block,
>>> currently specifies clk26m as its domain clock. This is bogus, since the
>>> clock is an external crystal with no controls. Also, the MFG block has
>>> a independent CLK_TOP_AXI_MFG_IN_SEL clock, which according to the block
>>> diagram, gates access to the hardware registers. Having this one as the
>>> domain clock makes much more sense. This also fixes access to the MFGTOP
>>> registers.
>>>
>>> Change the MFG_ASYNC domain clock to CLK_TOP_AXI_MFG_IN_SEL.
>>>
>>> Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> Just one question... what happens if there's no GPU support at all and this
>> power domain gets powered off?
>>
>> I expect the answer to be "nothing", so I'm preventively giving you my
> 
> Well it's powered off by default. Just double checked, and without the final
> patch:
> 
> # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          children
>              performance
>      /device                                             runtime status
> ----------------------------------------------------------------------------------------------
> mfg                             off-0
>              0
> mfg_2d                          off-0
>              0
>                                                  mfg
> mfg_async                       off-0
>              0
>                                                  mfg_2d
> 
> And with the last patch but with the powervr removed:
> 
> # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> domain                          status          children
>              performance
>      /device                                             runtime status
> ----------------------------------------------------------------------------------------------
> mfg_apm                         off-0
>              0
> mfg                             off-0
>              0
>                                                  mfg_apm
>      /devices/platform/soc/13fff000.clock-controller     suspended
>              0
> mfg_2d                          off-0
>              0
>                                                  mfg
> mfg_async                       off-0
>              0
>                                                  mfg_2d
> 
> Things seem to work OK. I can SSH in, and the framebuffer console on the screen
> works fine.
> 
> 
> Note that accessing the regmap through debugfs doesn't do much good. regmap
> doesn't handle runtime PM. And the syscon regmap isn't even tied to a
> struct device. Dumping the regmap through debugfs while the power domain
> is off gives all zeroes, likely due to bus isolation.
> 

The last part where you say "gives all zeroes" is actually the best outcome that
I could have ever expected.

So, well, many thanks for this very nice analysis and test.

>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I confirm my green light. It's beautiful when this kind of patches come upstream
especially with your replies actually removing any kind of possible doubt.

> 
> Thanks!

Thank *you* for caring about this old platform!

Cheers,
Angelo

> 
> ChenYu
> 
>> ....but if I'm wrong and the answer isn't exactly "nothing", then I still agree
>> with this commit, but only after removing the Fixes tag.
>>
>> Cheers,
>> Angelo
>>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index 3458be7f7f61..136b28f80cc2 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -497,7 +497,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
>>>                                };
>>>                                mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
>>>                                        reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
>>> -                                     clocks = <&clk26m>;
>>> +                                     clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>;
>>>                                        clock-names = "mfg";
>>>                                        #address-cells = <1>;
>>>                                        #size-cells = <0>;
>>
>>


