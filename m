Return-Path: <linux-kernel+bounces-570636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D45A6B2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D99887598
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839401DF25C;
	Fri, 21 Mar 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="C/WRMxwJ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274521A7264
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523576; cv=none; b=bO9bVOS3RdgPrhVcGBHTscQiRVTezLvuBezlp99lSVcdYzW7UmSWsu6+l3q6VDfCC8ng4CO5QtQiG9BrB7zbGTpW57Yw1UI5d1WvEZXNv7bJ1zCHJeBevtoMt3fvFyQu9V2jluB63aJx715zuIX4e6dlRR5DMkwwKozY5uXlwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523576; c=relaxed/simple;
	bh=U38ru4dqR5hQ4gzJyuvQTyJf5yulhnnCi8NT5TSJXIc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=C5xyqNiAXyXCTTccK8E1QOuqyyhIidJ4RnLmdtdWkef1hVHcUMEE/1hBXwmddYSsRkXIOKeoWXk/oW7rfMUfn3HPaoFRE/5k0niDtGZFU1YbDiBAWcAcxa7zcGWBpMU5bdVxmOgm11GFKcIfoA/ai1UTVzGQYSZxco5/KJ5Qdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=C/WRMxwJ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1742523570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ63EbsH7vgI4jedsTSMWBQF77GuUGSswmmue0ryXcM=;
	b=C/WRMxwJjPXsbmhSBUnFOPBeZ8PR30k6LyphZ584eFPiYvplv4IoRJbBy/hcfZjf4CHOjY
	6Xxzm6ypTFO1FrCY94FEJ4NZROkJC33DKAF8CB4s469qH2c3b2lsFZJ0owdgVZEuuwdeAM
	pqDuA6AYIBhquSRROOidRX2CUFAAb05wXwnlY2XrooeX3f3dM+i81U6hmLJTCZKlPDk3PU
	v7zXLe6QwVGAH6OL2URiG0Veri5jGg/3tBFJg0R1PhkQe+YMD59sSRgK8T1E0ZKz8p5y5q
	9yoB0JWtyJyXkdqaCwDaXqdkY82/PqBKH2Z765tzcAA1OxYQSZE1QCd0/UDECw==
Date: Fri, 21 Mar 2025 03:19:30 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>, Sven Rademakers
 <sven.rademakers@gmail.com>, Joshua Riek <jjriek@verizon.net>
Subject: Re: [PATCH] arm64: dts: rockchip: Allow Turing RK1 cooling fan to
 spin down
In-Reply-To: <CAH5Ym4hqkMMBsT7XEz_f+TCng+0X2m0nV_Kdr-LAPBqgENgr5A@mail.gmail.com>
References: <20250315204852.1247992-1-CFSworks@gmail.com>
 <e1cdc3a39b9201cb115b12b559899aee@manjaro.org>
 <CAH5Ym4hqkMMBsT7XEz_f+TCng+0X2m0nV_Kdr-LAPBqgENgr5A@mail.gmail.com>
Message-ID: <57bb477925efc74a0ea11b20321fa661@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sam,

On 2025-03-21 02:20, Sam Edwards wrote:
> On Thu, Mar 20, 2025 at 5:38 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2025-03-15 21:48, Sam Edwards wrote:
>> > The RK3588 thermal sensor driver only receives interrupts when a
>> > higher-temperature threshold is crossed; it cannot notify when the
>> > sensor cools back off. As a result, the driver must poll for
>> > temperature
>> > changes to detect when the conditions for a thermal trip are no longer
>> > met. However, it only does so if the DT enables polling.
>> >
>> > Before this patch, the RK1 DT did not enable polling, causing the fan
>> > to
>> > continue running at the speed corresponding to the highest temperature
>> > reached.
>> >
>> > Follow suit with similar RK3588 boards by setting a polling-delay of
>> > 1000ms, enabling the driver to detect when the sensor cools back off,
>> > allowing the fan speed to decrease as appropriate.
>> >
>> > Fixes: 7c8ec5e6b9d6 ("arm64: dts: rockchip: Enable automatic fan
>> > control on Turing RK1")
>> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>> > ---
>> >  arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>> > b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>> > index 6bc46734cc14..0270bffce195 100644
>> > --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
>> > @@ -214,6 +214,8 @@ rgmii_phy: ethernet-phy@1 {
>> >  };
>> >
>> >  &package_thermal {
>> > +     polling-delay = <1000>;
>> > +
>> >       trips {
>> >               package_active1: trip-active1 {
>> >                       temperature = <45000>;
>> 
>> Thanks for the patch, it's looking good to me, with some related
>> thoughts below.  Please, feel free to include:
>> 
>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>> 
>> After a quick look at the RK3588 TRM Part 1, it seems possible
>> to actually generate additional interrupts when the TSADC channel
>> temperature readouts reach predefined low thresholds.  Moreover,
> 
> It seems to be as simple as adding a `.set_cooloff_temp = ...` that
> writes the lower thresholds to TSADC_COMP#_LOW_INT and sets the
> necessary bits in TSADC_LT_EN+TSADC_LT_INT_EN. Since the driver
> already rescans all temperatures on any interrupt and acknowledges all
> interrupt status bits indiscriminately, I don't anticipate any other
> necessary changes.

Hmm, I'm afraid it isn't that simple...  See, the entire thermal
framework is rather complex and there may be hidden issues, because
such handling of the cooldown events probably isn't the most common
variant on all boards supported upstream.

Even if everything is fine there, with the dynamic reassigning of
the cooldown thresholds and everything else, which hopefully is, :)
generating and handling the LT_INT interrupts, at the first glance,
requires rather major changes to the driver because it introduces
a different class of interrupts, for which the amount of required
changes isn't exactly small.

> I can easily take care of that this weekend or next if that plan
> sounds good to you. However, since *this* patch is a Fixes:, I'd
> rather land it as-is first and handle the above separately. :)

I totally agree that this patch needs to get merged first, perhaps
even as a v2 that would include "Cc: stable" as well.

Regarding adding support for LT_INT interrupts, frankly, I'd much
rather leave that do be done as part of my upcoming major rework
of the OPPs by introducing the SoC binning.  As part of that, I'll
do a whole lot of testing on different boards with different SoCs
and their different variants, which should ensure that everything
works as expected, including the LT_INT stuff.

>> avoiding the polling would actually help the SoC cool down a tiny
>> bit faster, which makes it worth detailed investigation in my book,
>> despite not being used by the downstream kernel code.
> 
> Do you mean "spin down the fan a tiny bit faster" (since it would
> detect the cool-off without needing to poll for it), or are you
> emphasizing saving CPU cycles that would otherwise be spent polling?

Technically both, :) but of course, the primary goal would be to make
the CPU not do what it doesn't really have to, and spinning down the
fan faster would be just an additional benefit.  It isn't going to
make some huge difference in the CPU load (or better said, in the
"background noise"), but again, every tiny bit counts.

When it comes to the HT_INT interrupts, they're obviously much more
important, because there must not be any delays when (over)heating
happens.  That isn't so critical with the LT_INT interrupts, which
is probably the reason why the downstream kernel code uses HT_INT
interrupts only.

