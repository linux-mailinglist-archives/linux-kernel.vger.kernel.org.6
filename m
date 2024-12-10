Return-Path: <linux-kernel+bounces-439083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7A9EAA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BE6166E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3D230990;
	Tue, 10 Dec 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IG0T+9Xf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB1230982;
	Tue, 10 Dec 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819228; cv=none; b=IH/D9HJWZDNgmQ6//TDS7dwmouiCF1y+5oOnSbnI0fkgqbNhIIxd86yw2jibTv3HA+2E74vqvTUK7fQKaiC16ct54QamRmzVaS6bQoiuVsqgtfIDfq14ah/pOEGq1e+Ynh0lm/oZ/rYmnkaJhYz1K4XilVAkorH41uFUdHCM2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819228; c=relaxed/simple;
	bh=diwroXgDfFNnxf4klVn8zrbSRkjG62ZAQpvqL6XtdtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzD5S6N7zLyMgk1GlpescHnxHmmraURCqs73F52/lmqh6D6CMny936aer6GjXeDuU+SBdlJG3CYARBnHzO1UuLh5OWTXvSVAt4LE1D1e7NLQrreRw71gT67pWuqsAgGHNy3jv63m4Y2Zqe9RxEMc3YZH2m41ELUGQBlRtTKVKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IG0T+9Xf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733819224;
	bh=diwroXgDfFNnxf4klVn8zrbSRkjG62ZAQpvqL6XtdtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IG0T+9XfaeyS+RmWBZiQT/og+j3HPF9nFz6CK4NPsOHhgFpI8wvAvqhLY2+AfcFnI
	 XX3ruDPm/UTsUq9lRFNIrr0laPOLcOAGjFrrjPs3FUH6V1E9hqct5pmHaqcFYb8dkd
	 6qV4wYMsn0UGuIaSffJVdGrrS7RkAD05iZfEZeAuycO7fFudr600psv6F8GSBFjKjk
	 4oev1p2SP6tFhqSYtMW818wP6QFxPSdt73LQ7pXlzqyOAiimNfZVX+YUbX++aANZxg
	 Yz1u6Upz3+nsCf0PG3yhvzHNL40Ij5bWmtoG4nsHgMl7lsvtgkIEk3T0bn5rTHkwsQ
	 0T6RsQFSn/uHw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C026417E1323;
	Tue, 10 Dec 2024 09:27:03 +0100 (CET)
Message-ID: <35392d9d-56a3-4db8-b500-6272d0bd275c@collabora.com>
Date: Tue, 10 Dec 2024 09:27:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop
 pp3300_panel voltage settings
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241030070224.1006331-1-wenst@chromium.org>
 <20241030070224.1006331-2-wenst@chromium.org>
 <CAGXv+5HVy41qee6kwVUeLV_DfA0=wk2X77kv81rBKAZDGE6mww@mail.gmail.com>
 <bbaa0c8f-9702-4252-a674-e46fb51f0a2a@collabora.com>
 <CAGXv+5GHP1M1rKwR8j+bN8GmpxWtpkfLTnvBdkg5wOvWanc-kw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5GHP1M1rKwR8j+bN8GmpxWtpkfLTnvBdkg5wOvWanc-kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/11/24 14:47, Chen-Yu Tsai ha scritto:
> On Mon, Nov 4, 2024 at 9:19 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 04/11/24 14:00, Chen-Yu Tsai ha scritto:
>>> On Wed, Oct 30, 2024 at 3:02 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>>>
>>>> The pp3300_panel fixed regulator is just a load switch. It does not have
>>>> any regulating capabilities. Thus having voltage constraints on it is
>>>> wrong.
>>>>
>>>> Remove the voltage constraints.
>>>>
>>>> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board")
>>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>>
>>> I see that the other three patches were merged and included in the pull
>>> request, but not this one. Were there any concerns?
>>>
>>
>> Sorry I forgot to actually provide an explanation for that - yes, I do have some
>> comment about this one.
>>
>> Despite this being a load switch, it's still switching power from regulator A to
>> target device X, so this is technically still providing 3.3V to device X.
>>
>> Think about how a "regular" full-fledged regulator works: you can (sometimes) set
>> a voltage, and then you can ENABLE the VOUT for said regulator (/rail): this kind
>> of "load switch" does exactly the same as the ENABLE switch for a full-fledged
>> regulator.
> 
> But it does not provide regulation. One cannot "set" the voltage on a load
> switch; one can only set it on its upstream supply, if that supply provides
> regulation.
> 
> IIRC Mark said some years ago that if a regulator doesn't regulate the
> voltage, then the voltage constraints should not be given. The constraints
> are then derived from its upstream supply.
> 
> That's the guideline I've followed for all the regulator related changes
> I've done over the years. Does that work for you?
> 

Ok, let's go with that then.

There's only one problem - patches 2 to 4 don't apply for whatever reason, is there
any dependency?

Cheers,
Angelo

>> So, this is switching on and off a power rail that is derived from a source rail,
>> practically creating... well, a "new" rail, with...
>>
>>    VIN=somewhere-3.3v,
>>    VOUT=somewhere-still-3.3v
>>
>> Any objections/doubts/etc? :-)
> 
> I agree with most of it, except the part that I laid out above about the
> load switch not providing regulation.
> 
>> P.S.: I'm writing fast, sorry if anything appears unclear, feel free to shoot more
>>         questions in case :-)
> 
> No, it's pretty clear, and I believe one of the common interpretations
> I see. Thank you for the quick response.
> 
> 
> Thanks
> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>>
>>> ChenYu
>>>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
>>>> index 783c333107bc..7bbafe926558 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
>>>> @@ -35,8 +35,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
>>>>           pp3300_panel: pp3300-panel {
>>>>                   compatible = "regulator-fixed";
>>>>                   regulator-name = "pp3300_panel";
>>>> -               regulator-min-microvolt = <3300000>;
>>>> -               regulator-max-microvolt = <3300000>;
>>>>                   pinctrl-names = "default";
>>>>                   pinctrl-0 = <&pp3300_panel_pins>;
>>>>
>>>> --
>>>> 2.47.0.163.g1226f6d8fa-goog
>>>>
>>



