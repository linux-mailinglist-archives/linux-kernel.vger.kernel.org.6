Return-Path: <linux-kernel+bounces-412496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F49D09B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432F6281E62
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB8148827;
	Mon, 18 Nov 2024 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TfdfMtp9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252117597;
	Mon, 18 Nov 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912135; cv=none; b=IImmHSNNYRUx7NLlWBMzGf2Wp6hw91reeBuOFWdFlsQ/985qacH6nt3JXtRGH7fMIkSYBeBOGG5fVw/VJaYPeDtWwe8W7IwXkmK5StchgvJK4x/ju5EbaNkP8wxkoCE9Ji6GljXZn+SDBTiIlW8VouWzZzzi/LAdIaM0z128YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912135; c=relaxed/simple;
	bh=hkBROPeoD5rMUjYCyIB1phZYBgfbk1CSvz/OhAqXRo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sG2aXmpE+y46j4VGudvPLpm4Oq1on3MgGoRAy7zgbHJHz9lPpYFG43YnaDw51vmUD91iw6Ay8AaaACpYhVuD7CNpBq9CSGxKenVfTXtCvniZQBMejg83425Ng3R6VXTcp+TkIqNmSNPJ2JpYw9e7PIVb8vm8FDZDRrRuRC4Ny+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TfdfMtp9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912125;
	bh=hkBROPeoD5rMUjYCyIB1phZYBgfbk1CSvz/OhAqXRo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TfdfMtp9anoHDX6J3bUXMT30uvCBfHLSu9NG3H/4PNxVWQwjI+sXiM/HoYdrzXDie
	 49zHY7tDKadHkJ301mviS1XcRxolEa4M99bH42sKqy3wHD1PMbcx2bH4jlkdH5kq60
	 9wPZ703y/xuBqhcSCVQnmIc+/kp33VnCeluqCFvpackG/sJgMpZTAZQenyyJ4aRAqa
	 WmndLisx9HiH7CGK4UeWHLWBnGP53JuAl72FldAXs1Ot8ae8wMD6snAyG0ihC3hw6+
	 tYqJSyZqs45EDB8p1XR2t/cr5/ruo99NIsi1J2fDWsalMqg0gEWR3JYhJZlL9uIh/i
	 nwExZU78o2gtQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EF43517E1221;
	Mon, 18 Nov 2024 07:42:04 +0100 (CET)
Message-ID: <fd1c76ba-e288-4cc9-abcc-522b5ea6b0b9@collabora.com>
Date: Mon, 18 Nov 2024 07:42:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: Fei Shao <fshao@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20241105093222.4055774-1-fshao@chromium.org>
 <20241105093222.4055774-3-fshao@chromium.org>
 <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com>
 <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
 <59f4bcc1-c752-4f2f-8e55-349cc2432b8a@collabora.com>
 <CAC=S1nhhfwHU5K5ZyUhZBhvz38LOZGLnGN-Rc1ZAup_VTfkpvA@mail.gmail.com>
 <CAC=S1nj5PVJ=zwZiBLoOCHzsspaRw9ddAH_dXfPayD=LyW5wNA@mail.gmail.com>
 <545b6db8-c7d7-4a28-a040-12088f9002df@collabora.com>
 <CAC=S1nhX88aaQ6dusab1qM2_noaSjTMdhJ9t5o4L_Nri9dWPVw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1nhX88aaQ6dusab1qM2_noaSjTMdhJ9t5o4L_Nri9dWPVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/11/24 06:26, Fei Shao ha scritto:
> On Thu, Nov 14, 2024 at 6:09 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 11/11/24 08:10, Fei Shao ha scritto:
>>> On Fri, Nov 8, 2024 at 12:11 PM Fei Shao <fshao@chromium.org> wrote:
>>>>
>>>> On Thu, Nov 7, 2024 at 6:37 PM AngeloGioacchino Del Regno
>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>
>>>>> Il 07/11/24 07:58, Fei Shao ha scritto:
>>>>>> On Wed, Nov 6, 2024 at 9:19 PM AngeloGioacchino Del Regno
>>>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>>>
>>>>>>> Il 05/11/24 10:30, Fei Shao ha scritto:
>>>>>>>> Introduce MT8188-based Chromebook Ciri, also known commercially as
>>>>>>>> Lenovo Chromebook Duet (11", 9).
>>>>>>>>
>>>>>>>> Ciri is a detachable device based on the Geralt design, where Geralt is
>>>>>>>> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
>>>>>>>> different combinations of second-source components, including:
>>>>>>>> - audio codecs (RT5682S and ES8326)
>>>>>>>> - speaker amps (TAS2563 and MAX98390)
>>>>>>>> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
>>>>>>>>
>>>>>>>> Signed-off-by: Fei Shao <fshao@chromium.org>
>>>>>>>> ---
>>> [...]
>>>>>>>> +&pmic {
>>>>>>>> +     interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +&scp {
>>>>>>>
>>>>>>> Is this SCP-dual or SCP?
>>>>>>> I see SCP, but I also see a SCP-Dual memory region... what's going on here?
>>>>>>>
>>>>>>> Of course, the SCP-Dual won't work if you don't override the compatible string...
>>>>>>
>>>>>> To clarify, the second SCP core is used for MIPI camera in downstream,
>>>>>> and I deliberately only describe the first SCP core here since the MTK
>>>>>> camera ISP driver isn't in upstream at the moment.
>>>>>> I had a fixup patch for removing the scp-dual reserved memory region,
>>>>>> but likely it was missing during the rebase... let me check again if
>>>>>> it can be removed, just in case there's firmware protecting the region
>>>>>> and the kernel shouldn't access it.
>>>>>>
>>>>>
>>>>> Hmm... but the second SCP core can still be brought up, even if the MIPI Camera
>>>>> driver is not upstreamed yet, right?
>>>>
>>>> Well, that's true... and it should pave the way for validating the
>>>> driver with the upstreamed DT whenever that becomes available.
>>>>
>>>>>
>>>>> That shouldn't cause lockups and/or other kinds of bad behavior, and should
>>>>> bring up a core and just never use it, without any particular issues.
>>>>>
>>>>> If we can enable the secondary core, let's just go for it.. as that will help
>>>>> specifying the exact memory layout of this board (and failing to do that may
>>>>> create some other issues, that's why I'm proposing to enable that even if it
>>>>> is not really used in this case).
>>>>>
>>>>> What do you think? :-)
>>>>>
>>>>
>>>> Sure, that sounds good to me, too.
>>>> I started only with the essential DT bits to ensure the device can
>>>> boot, which it does, so I guess it's time to bring that back. I'll
>>>> incorporate that in v3.
>>>> I plan to fix up the single SCP core node to SCP-dual directly, so
>>>> please let me know if you prefer seeing that as an individual patch on
>>>> top (either option works for me).
>>>>
>>>
>>> In fact, I noticed that it seems to require modifying mt8188.dtsi (and
>>> potentially mt8390-genio-700-evk.dts) to support the second SCP core,
>>> but I want to avoid doing so in this series if possible to keep this
>>> as a pure new .dts introduction (if that makes sense).
>>>
>>> I can think of 3 options here:
>>> 1. I resend this series *with* the single SCP core enabled in
>>> -geralt.dtsi. And then I send a follow-up series to introduce the
>>> second SCP core and update the affected .dts{,i}.
>>> 2. I resend this series *without* any SCP cores in -geralt.dtsi. And
>>> then I send a follow-up series to introduce both of the SCP cores at
>>> once, and update the affected .dts{,i}.
>>> 3. I delete the parent (mt8188) scp declaration and re-describe the
>>> dual-core SCP structure in -geralt.dtsi. This avoids touching
>>> mt8188.dtsi and mt8390-genio-700-evk but leaves the dual-core SCP
>>> stuff exclusively to geralt/ciri. I don't know if MT8390 wants to
>>> utilize the second SCP core or not.
>>>
>>> I guess (3) is less likely what we want down the line, but that's just
>>> for reference. Any preference/suggestion?
>>>
>>
>> I want to verify with MediaTek whether the Genio 700 EVK can make use of the
>> dual-core SCP first, as it is highly possible that it indeed can and, if that
>> is the case, counting that any product development would be anyway based on
>> the EVK.... we will probably never see single-core SCP in MT8188 devicetrees
>> ever again.
>>
>> Please send the Geralt/Ciri devicetrees without SCP support for now, so that
>> we can get the vast majority of the code upstream - which anyway is likely
>> 95% of what you have right now... then I will either notify you for how to
>> proceed with the SCP (especially if I come to a conclusion before you send
>> the new series), or I will just send the SCP DT series on my own.
> 
> Noted. This is currently on the back burner as I have other tasks at
> hand, but I'll get back to it ASAP (hopefully later this week).
> 

There's no rush. It's too late for 6.13 anyway, so take your time :-)


> Thanks,
> Fei
> 
>>
>> Cheers,
>> Angelo
>>




