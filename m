Return-Path: <linux-kernel+bounces-293200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E5957BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DE4B22195
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415454652;
	Tue, 20 Aug 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FOIOJsBS"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACD482FF;
	Tue, 20 Aug 2024 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125288; cv=none; b=I1Qim5hYHbgA8u1QzK+qM0lliI09z2+lKhb2TKrjmP/UimZBTZNDgQcy4wjHinwbORC61WtTx9PpZ/vSiQO9pwj7X7VeEql1qaDGTKGCPfkXvn6FE6LPpItNdBQREZQS9GlG4+DZbwZP+GtBRsANZNMuOKkeRMHKqZD/i1Azw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125288; c=relaxed/simple;
	bh=ysTDfXylE3vpqTa1ndRr310Mtp1c7IPLukmtWOY8DdQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EX9c3Y62xeyWnpI6Gq1laJyKiDn0UnHeni39isL0ukCESKGKNEWf+GejFCexDnzZmfOmlTh6elKdvxcG/Mq8VfUInMa48nlppJckxLzq7djwZE8znLNbfVjtpft8CsrlsYxeiJBE26CIRB3AVouyKdf+3EEGD0ZZwG9Zm+BHSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=FOIOJsBS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724125284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b1w2uuFQHzrmMY+1/Wm/GawkAfhtZkQAlTy3XLCyj/4=;
	b=FOIOJsBSd/fvlv4GrX2xZVjOjqJrwx6a2bCj4Z+yHmJhdhW1K3sCkLXujeEX6VaSyCAMSI
	aJYH0cRXZmnPi6tL6Nglx1A2pIDfIuOjyEzqSd+5yN0Gxx0v53u7N/PkuezAPimNI27pSJ
	APAA/6MHz7AJ1xPmX+q+pzE9Gd84QPMNBZEOpC/GbIpuRhD8xP8QJ1mcQdrrkcp3vo5rll
	hLMNbPIXzvLEABhQmygfSmr2PqG13450vxqS7xnntA4NdqwSRO72zaFUrjEXy5P9xMkYd8
	dgVQiS/g/fXKCvWbrbi7YX7XHhdiRWAyalV5MiJStT3GKMatLsnCwbq2dcJHBQ==
Date: Tue, 20 Aug 2024 05:41:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: wens@csie.org
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, wenst@chromium.org, broonie@kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add GPU thermal trips to the SoC
 dtsi for A64
In-Reply-To: <CAGb2v64aQAkqj1OR55HVyrVU=uNrH70fx+jOaT0SBMHBzCFgRQ@mail.gmail.com>
References: <a17e0df64c5b976b47f19c5a29c02759cd9e5b8c.1723427375.git.dsimic@manjaro.org>
 <24406e36f6facd93e798113303e22925b0a2dcc1.camel@icenowy.me>
 <25b65e9ef1cae59a8366532cc8db576b@manjaro.org>
 <CAGb2v64aQAkqj1OR55HVyrVU=uNrH70fx+jOaT0SBMHBzCFgRQ@mail.gmail.com>
Message-ID: <662f2332efb1d6c21e722066562a72b9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Chen-Yu,

On 2024-08-20 05:37, Chen-Yu Tsai wrote:
> On Mon, Aug 12, 2024 at 10:46 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Hello Icenowy,
>> 
>> On 2024-08-12 04:40, Icenowy Zheng wrote:
>> > 在 2024-08-12星期一的 04:00 +0200，Dragan Simic写道：
>> >> Add thermal trips for the two GPU thermal sensors found in the
>> >> Allwinner A64.
>> >> There's only one GPU OPP defined since the commit 1428f0c19f9c
>> >> ("arm64: dts:
>> >> allwinner: a64: Run GPU at 432 MHz"), so defining only the critical
>> >> thermal
>> >> trips makes sense for the A64's two GPU thermal zones.
>> >>
>> >> Having these critical thermal trips defined ensures that no hot spots
>> >> develop
>> >> inside the SoC die that exceed the maximum junction temperature.
>> >> That might
>> >> have been possible before, although quite unlikely, because the CPU
>> >> and GPU
>> >> portions of the SoC are packed closely inside the SoC, so the
>> >> overheating GPU
>> >> would inevitably result in the heat soaking into the CPU portion of
>> >> the SoC,
>> >> causing the CPU thermal sensor to return high readings and trigger
>> >> the CPU
>> >> critical thermal trips.  However, it's better not to rely on the heat
>> >> soak
>> >> and have the critical GPU thermal trips properly defined instead.
>> >>
>> >> While there, remove a few spotted comments that are rather redundant,
>> >> because
>> >> it's pretty much obvious what units are used in those places.
>> >
>> > This should be another individual patch, I think.
>> 
>> Perhaps, which I already thought about, but it might also be best
>> to simply drop the removal of those redundant comments entirely.
>> Let's also see what will other people say.
>> 
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> ---
>> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 ++++++++++++++---
>> >> --
>> >>  1 file changed, 16 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> index e868ca5ae753..bc5d3a2e6c98 100644
>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> >> @@ -212,7 +212,6 @@ timer {
>> >>
>> >>         thermal-zones {
>> >>                 cpu_thermal: cpu0-thermal {
>> >> -                       /* milliseconds */
>> >
>> > The unit of a 0 isn't not so obvious I think, so I suggest to keep
>> > this.
>> 
>> Quite frankly, I think it should be obvious to anyone tackling
>> the thermal zones and trips.
> 
> Sorry for the late reply.

No worries.

> Not everyone writing or editing the DT would be fully familiar with
> all the bindings. As Icenowy mentioned, it's not even obvious when
> the existing value is zero. I would prefer we keep them.

That's two votes for keeping the already present comments, so I'll
drop their removal in the v2.

>> >>                         polling-delay-passive = <0>;
>> >>                         polling-delay = <0>;
>> >>                         thermal-sensors = <&ths 0>;
>> >> @@ -236,40 +235,51 @@ map1 {
>> >>
>> >>                         trips {
>> >>                                 cpu_alert0: cpu-alert0 {
>> >> -                                       /* milliCelsius */
>> >>                                         temperature = <75000>;
>> >>                                         hysteresis = <2000>;
>> >>                                         type = "passive";
>> >>                                 };
>> >>
>> >>                                 cpu_alert1: cpu-alert1 {
>> >> -                                       /* milliCelsius */
>> >>                                         temperature = <90000>;
>> >>                                         hysteresis = <2000>;
>> >>                                         type = "hot";
>> >>                                 };
>> >>
>> >>                                 cpu_crit: cpu-crit {
>> >> -                                       /* milliCelsius */
>> >>                                         temperature = <110000>;
>> >>                                         hysteresis = <2000>;
>> >>                                         type = "critical";
>> >>                                 };
>> >>                         };
>> >>                 };
>> >>
>> >>                 gpu0_thermal: gpu0-thermal {
>> >> -                       /* milliseconds */
>> >>                         polling-delay-passive = <0>;
>> >>                         polling-delay = <0>;
>> >>                         thermal-sensors = <&ths 1>;
>> >> +
>> >> +                       trips {
>> >> +                               gpu0_crit: gpu0-crit {
>> >> +                                       temperature = <110000>;
>> >> +                                       hysteresis = <2000>;
>> >> +                                       type = "critical";
>> >> +                               };
>> >> +                       };
>> >>                 };
>> >>
>> >>                 gpu1_thermal: gpu1-thermal {
>> >> -                       /* milliseconds */
>> >>                         polling-delay-passive = <0>;
>> >>                         polling-delay = <0>;
>> >>                         thermal-sensors = <&ths 2>;
>> >> +
>> >> +                       trips {
>> >> +                               gpu1_crit: gpu1-crit {
>> >> +                                       temperature = <110000>;
>> >> +                                       hysteresis = <2000>;
>> >> +                                       type = "critical";
>> >> +                               };
>> >> +                       };
>> >>                 };
>> >>         };
>> >>

