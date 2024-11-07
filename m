Return-Path: <linux-kernel+bounces-399666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A79C0280
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B611F232A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C01EE015;
	Thu,  7 Nov 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dh7LiPnQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D01E906B;
	Thu,  7 Nov 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975859; cv=none; b=q5qk4dC3Hbpuf+fTkgWHAAfpa7XsIVwyPD4oY5L4TclWgGNjgV5sD/Dwb2u2x4ANfKfG/PoxVBIiWZspkRuf88beOzHfXEwgPzQaQkH6jQZx/cbxsLRK+NAR1fBO9v2jolJniT2LCWToU1l5JGuiyMXmxlhXGQPThXDwE3TePDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975859; c=relaxed/simple;
	bh=jRvsshBvtU/WBgIHhfAeu/Lb0e0oxCz8G6yAfOku9p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKLq/z3apix/0kNVqnx9JaYPHLAk9CCFqrzrIgQWlbd3nsPef4X0KkJ/O1ieEZGVR5O2DoiKh7PVuqfDwqlC2igu/UlqkBxS3g/ojA5id5KhTISRlqgvaxUFOieQsRjZkqL1fBs3yxMN5tX+iH7PHkzuY9UxKA5028JMqlnRxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dh7LiPnQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730975855;
	bh=jRvsshBvtU/WBgIHhfAeu/Lb0e0oxCz8G6yAfOku9p0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dh7LiPnQl8luK4lXoov3CcdVUIXDM0d4+LzuIqO0dFGeYrmNwA2HtxutzHJ6Yoa9m
	 VoFOSZIHtd9yzP3ssnHOBGW+p4DPeBQds+FUXwJC1EPurG6JCbmTTvbptIRVn6Eu1s
	 EIz5obxv8S5gMR+NYZZYdMMkWcsQD0l6tUHPqJOxNCsOhKwjjgk3TDE2K4sPiKs12A
	 LiV62UIWXOc0yRHa307dOKLCsZdCqJblBYz/KrjEn6hyTip8Hw2fbKFu4ota9klOwj
	 slQiT/OqZQDXVKopjaUodcWkuZZW8HVn+6u8yZkeL8Vi4Tgd2/UDJYh4TUjUNYu0tA
	 nBvmKjihEomvw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0700917E35CB;
	Thu,  7 Nov 2024 11:37:34 +0100 (CET)
Message-ID: <59f4bcc1-c752-4f2f-8e55-349cc2432b8a@collabora.com>
Date: Thu, 7 Nov 2024 11:37:34 +0100
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 07/11/24 07:58, Fei Shao ha scritto:
> On Wed, Nov 6, 2024 at 9:19 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 05/11/24 10:30, Fei Shao ha scritto:
>>> Introduce MT8188-based Chromebook Ciri, also known commercially as
>>> Lenovo Chromebook Duet (11", 9).
>>>
>>> Ciri is a detachable device based on the Geralt design, where Geralt is
>>> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
>>> different combinations of second-source components, including:
>>> - audio codecs (RT5682S and ES8326)
>>> - speaker amps (TAS2563 and MAX98390)
>>> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
>>>
>>> Signed-off-by: Fei Shao <fshao@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - remove invalid or undocumented properties
>>>       e.g. mediatek,dai-link, maxim,dsm_param_name etc.
>>> - remove touchscreen as the driver is not yet accepted in upstream
>>> - update sound DAI link node name to match the binding
>>> - add missing pinctrls in audio codec nodes
>>>
>>>    arch/arm64/boot/dts/mediatek/Makefile         |    8 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   60 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   56 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   15 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   73 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   69 +
>>>    .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   47 +
>>>    .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  397 +++++
>>>    .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1492 +++++++++++++++++
>>>    11 files changed, 2271 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
>>>
> [...]
> 

[...]

>>> +&pmic {
>>> +     interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>>> +};
>>> +
>>> +&scp {
>>
>> Is this SCP-dual or SCP?
>> I see SCP, but I also see a SCP-Dual memory region... what's going on here?
>>
>> Of course, the SCP-Dual won't work if you don't override the compatible string...
> 
> To clarify, the second SCP core is used for MIPI camera in downstream,
> and I deliberately only describe the first SCP core here since the MTK
> camera ISP driver isn't in upstream at the moment.
> I had a fixup patch for removing the scp-dual reserved memory region,
> but likely it was missing during the rebase... let me check again if
> it can be removed, just in case there's firmware protecting the region
> and the kernel shouldn't access it.
> 

Hmm... but the second SCP core can still be brought up, even if the MIPI Camera
driver is not upstreamed yet, right?

That shouldn't cause lockups and/or other kinds of bad behavior, and should
bring up a core and just never use it, without any particular issues.

If we can enable the secondary core, let's just go for it.. as that will help
specifying the exact memory layout of this board (and failing to do that may
create some other issues, that's why I'm proposing to enable that even if it
is not really used in this case).

What do you think? :-)

>>
>>> +     firmware-name = "mediatek/mt8188/scp.img";
>>> +     memory-region = <&scp_mem>;
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&scp_pins>;
>>> +     status = "okay";
>>> +
>>> +     cros-ec-rpmsg {
>>> +             compatible = "google,cros-ec-rpmsg";
>>> +             mediatek,rpmsg-name = "cros-ec-rpmsg";
>>> +     };
>>> +};
>>> +
>>> +&sound {
>>> +     compatible = "mediatek,mt8188-nau8825";
>>> +     model = "mt8188_m98390_8825";
>>> +     pinctrl-names = "aud_etdm_hp_on",
>>> +                     "aud_etdm_hp_off",
>>> +                     "aud_etdm_spk_on",
>>> +                     "aud_etdm_spk_off",
>>> +                     "aud_mtkaif_on",
>>> +                     "aud_mtkaif_off";
>>
>>          pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
>>                          "aud_etdm_spk_on", "aud_etdm_spk_off",
>>                          "aud_mtkaif_on", "aud_mtkaif_off";
> 
> Acked.
> 
>>
>>> +     pinctrl-0 = <&aud_etdm_hp_on>;
>>> +     pinctrl-1 = <&aud_etdm_hp_off>;
>>> +     pinctrl-2 = <&aud_etdm_spk_on>;
>>> +     pinctrl-3 = <&aud_etdm_spk_off>;
>>> +     pinctrl-4 = <&aud_mtkaif_on>;
>>> +     pinctrl-5 = <&aud_mtkaif_off>;
>>
>> Add a comment:
>>
>>          /* The audio-routing is defined in each board dts */
>>
>>> +     audio-routing = "ETDM1_OUT", "ETDM_SPK_PIN",
>>> +                     "ETDM2_OUT", "ETDM_HP_PIN",
>>> +                     "ETDM1_IN", "ETDM_SPK_PIN",
>>> +                     "ETDM2_IN", "ETDM_HP_PIN",
>>> +                     "ADDA Capture", "MTKAIF_PIN",
>>> +                     "Headphone Jack", "HPOL",
>>> +                     "Headphone Jack", "HPOR",
>>> +                     "MIC", "Headset Mic",
>>> +                     "Left Spk", "Front Left BE_OUT",
>>> +                     "Right Spk", "Front Right BE_OUT",
>>> +                     "Rear Left Spk", "Rear Left BE_OUT",
>>> +                     "Rear Right Spk", "Rear Right BE_OUT";
>>> +
>>
>> ...and remove the audio-routing from this dtsi; it's anyway being
>> overridden by the -ciri.dtsi devicetree...
> 
> Acknowledged, and thanks for all the feedback here.
> 

You're welcome :-)

Cheers,
Angelo


