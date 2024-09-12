Return-Path: <linux-kernel+bounces-326131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92106976377
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A62128655C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB118E030;
	Thu, 12 Sep 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DWi3/Xmp";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="SwxBjU3G"
Received: from a7-49.smtp-out.eu-west-1.amazonses.com (a7-49.smtp-out.eu-west-1.amazonses.com [54.240.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3B36C;
	Thu, 12 Sep 2024 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127556; cv=none; b=o4Q0zB3NnUdMj/XJlTqIQclgLo2/3RPXlGAsxwKIzl/zzvvraUEBgSR247eMbd+gpHgijZUN9VrGtRC3U4KmtMPp0pZAxyiPrjpOB4u5955wQblAea9Y3DaEWQ95dKuIdx6hNzcVMDTKr/OY7rBrfM90vUI5fQtCPOOcEybeDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127556; c=relaxed/simple;
	bh=K3pm6X6uxgABerMke/w7Hi/s9E6MlhMLw0RxpeXXuic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLqa4pOms63Xn2B4gGmI+jcG+hYGlc+HTM9P7vMQqi/UaqgP6INhsAQXTIUsJxth740fKK8rQo2qyOQABOviExRU96ocolhMqbG9ssK16o426BultkV31JBsK2pkQhbz7Y/S+lY0hmph5iyIDcne9gvdzBuGtMyexHZDC4aQF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DWi3/Xmp; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=SwxBjU3G; arc=none smtp.client-ip=54.240.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726127552;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K3pm6X6uxgABerMke/w7Hi/s9E6MlhMLw0RxpeXXuic=;
	b=DWi3/XmpM4dXcSRy3WBYeEz09HFUYETrYfN+9K+6AUsDhtV7qg7Q9s/cT+IIG6Xs
	Xq9gdTBnDXUGedB3w4BemQNyZwGMtqk0PwIKu9ooE9m1yhriwwaqRDVYu2Dh4Ph2T+0
	SEBmSKAl4DU2yj05P/CtjdLPe477qK5b1j3H4aeXyBQhbiQoVvOaD5ndkDidxNCK9l7
	UrRuxDgtfLH2u67qNJZL0qblDMhtuWD708LUYjk2oXZ1V7gLK36qitqqTYudd4Z4xb8
	Z1ir5etzgpW8f2di9Y4oFdMBbF6egCNiNfkmCq+YpokKrksWABGBka7JX0LQXTmjrrH
	wOTu+vmRCg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726127552;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=K3pm6X6uxgABerMke/w7Hi/s9E6MlhMLw0RxpeXXuic=;
	b=SwxBjU3Go+S1KILudUPzbepP9EQyOQNFAnh/cV1AWFJqOeJbwG0Hrkmh9HUdeBmz
	TFb6ClOlhBj+5uLPurfx5LCPJf/5bqyI6mNBG1qmRDmzgpCRVexmBhSt7lpcjcpTbvL
	WBuVEvh/J1RN8E9i8WGhbu39Cnr46CiQqe6EFymo=
Message-ID: <01020191e5383829-7eb375ea-ee17-419e-b173-30df46f61863-000000@eu-west-1.amazonses.com>
Date: Thu, 12 Sep 2024 07:52:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240910143245.5282-1-pablo.sun@mediatek.com>
 <01020191e04d4237-204596e1-6cc1-491c-a60f-de3917af7d42-000000@eu-west-1.amazonses.com>
 <2fd45240-a341-806b-f336-78d0595a8031@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2fd45240-a341-806b-f336-78d0595a8031@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.12-54.240.7.49

Il 11/09/24 12:35, Pablo Sun ha scritto:
> Hi Angelo,
> 
> Thanks for the review,
> 
> On 9/11/24 16:57, AngeloGioacchino Del Regno wrote:
> 
> [snip]
> 
>>> +/* for GPU SRAM */
>>> +&mt6359_vsram_others_ldo_reg {
>>> +    regulator-always-on;
>>
>> No, that's not good. Like that, the GPU VSRAM will be subject to current leakage.
>>
>> Remove the regulator-always-on property.
>> The right way of doing that is to add the vgpu to the mfg0's domain supply and
>> vsram to mfg1; that way all of the GPU regulators will be off at PM suspend time.
> 
> Thanks for pointing this out, I'll send v2 to fix this.
> 
>>>   &mt6359codec {
>>>       mediatek,mic-type-0 = <1>; /* ACC */
>>>       mediatek,mic-type-1 = <3>; /* DCC */
>>> @@ -839,8 +851,8 @@ regulators {
>>>               mt6315_7_vbuck1: vbuck1 {
>>>                   regulator-compatible = "vbuck1";
>>>                   regulator-name = "Vgpu";
>>> -                regulator-min-microvolt = <300000>;
>>> -                regulator-max-microvolt = <1193750>;
>>> +                regulator-min-microvolt = <546000>;
>>
>> I'm okay with this constraint but are you sure that MTK-SVS won't go any lower 
>> than 0.546V?
> 
> I'll see if I could confirm the maximum voltage drop that may be lowered by mtk-svs 
> for MT8395. There are 3 constraints that I am aware of:
> 
> - capability of Vgpu buck: 0.3V-1.193V
> - sign-off voltage of the EVK board: 0.6V to 1.2V
> - recommended operating voltage of MT8395 DVDD_GPU: 0.546V to 0.787V
> 
> For the device tree of the board, would you recommend set the regulator voltage 
> constraints in narrower range (because it's safer to keep in recommended operating 
> conditions), or in a wider range (leaving the check to driver software for 
> potential power saving?)
> 

The range should match the target device's Vin constraints; in this case, it
should be no lower than the minimum working voltage of the Vgpu-in of the Mali IP.

The drivers will be responsible of setting the lowest possible voltage for
enhanced efficiency (power saving), taking into account the fused chip quality bits
(in this case, the MediaTek SVS driver!).

You should, at this point, check the constraints of SVS, as in, given a reference
voltage (in this case, located in the GPU OPP table, the voltage associated with
the lowest frequency of the GPU), what is the maximum voltage *subtraction* that
SVS will do on the VGPU?

After the subtraction, may this voltage be lower than 0.546V? :-)

Cheers,
Angelo

> Thanks
> 
> 




