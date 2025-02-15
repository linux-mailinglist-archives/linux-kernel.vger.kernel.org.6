Return-Path: <linux-kernel+bounces-516407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63BA370E0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7717016F43B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3B1FC7C1;
	Sat, 15 Feb 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NTRzTjyi"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D4170A1B;
	Sat, 15 Feb 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739654795; cv=none; b=mJWHqocKwk7Xr3r0m5GZgfNCx45rpOt1Nxfp8OTu7Mwvz1RRIIvKZzTfS+cN4A+AAieRKId3+c9zLCUmqQvFaKUXx/dKbKQxDGYmKjUGy77QZmQTyDTjhJrU7XjASsV0SbBoapQJhW7yZqSt1811gGCAfI5ZqVC02BVMus/3h2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739654795; c=relaxed/simple;
	bh=DUnoZSqliATF7IEK/VGihQ7C6huDqEMzETKQ+9+oPjM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KvCaCi60gSC/crTLgYC8sgEbQ1YWnxzUbPht8j9iVzZpRd4L4xkd4vnT4T8zDyKTloMX4z869vPAwr//m9eBEe8hCQprgvzgB2lUzAkfWCzqS2myMsjGnP35h2ZLMn5tSVyNI1pAIcrA+EbhmEY2+j+jaS6HNOybeEGrlZam8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NTRzTjyi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1739654783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSwBFh8ZRCZGLdsfz2d5JFpVQxBwR9usCreYMoQo9D8=;
	b=NTRzTjyiGJaQZI793KXmWFF/Oi6/6pw1GWPvMYMWp9CRMXMkqvHpf7B/2yrF7zRhjVCN5s
	CpuSao6Bo19669ofuqLiOd5PqdMaNR//ZfZH28T/gjyXGWCoIAYePLf6lv+Q9jIbJNW/gR
	eIVl62mWA2su1+EwpUQzOl0bNe47nLEn9BUSm3FJJWscFHXEzqKU/qVlIISfUqQwnTWfZl
	qVm9zhkug1iNHWdMh0OpCghmbdWFvY1GD7YL5jDolYuLjtkp33amNs0MRF5yvc/VjvAO/J
	XYII3WvdIDJEN9/GHn8s1GBQD1DpQIJyfzuO3K1J7q0LVajMuYuTeFSUgX/opg==
Date: Sat, 15 Feb 2025 22:26:23 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov
 <alchark@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas
 <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
In-Reply-To: <2914631.KiezcSG77Q@diego>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
 <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
 <2914631.KiezcSG77Q@diego>
Message-ID: <edbb0d1c538755e8388c29565fea1a48@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2025-02-15 21:30, Heiko Stübner wrote:
> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
>> On Tue, Feb 11, 2025 at 7:32 PM Quentin Schulz 
>> <quentin.schulz@cherry.de> wrote:
>> > On 6/17/24 8:28 PM, Alexey Charkov wrote:
>> > > RK3588j is the 'industrial' variant of RK3588, and it uses a different
>> > > set of OPPs both in terms of allowed frequencies and in terms of
>> > > applicable voltages at each frequency setpoint.
>> > >
>> > > Add the OPPs that apply to RK3588j (and apparently RK3588m too) to
>> > > enable dynamic CPU frequency scaling.
>> > >
>> > > OPP values are derived from Rockchip downstream sources [1] by taking
>> > > only those OPPs which have the highest frequency for a given voltage
>> > > level and dropping the rest (if they are included, the kernel complains
>> > > at boot time about them being inefficient)
>> > >
>> > > [1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> > >
>> >
>> > Funny stuff actually. Rockchip have their own downstream cpufreq driver
>> > which autodetects at runtime the SoC variant and filter out OPPs based
>> > on that info. And this patch is based on those values and filters.
>> >
>> > However, they also decided that maybe this isn't the best way to do it
>> > and they decided to have an rk3588j.dtsi where they remove some of those
>> > OPPs instead of just updating the mask/filter in their base dtsi
>> > (rk3588s.dtsi downstream). See
>> > https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> 
>> Funny stuff indeed! Judging by the comments in the file you
>> referenced, those higher OPP values constitute an 'overdrive' mode,
>> and apparently the chip shouldn't stay in those for prolonged periods
>> of time. However, I couldn't locate any dts file inside Rockchip
>> sources that would include this rk3588j.dtsi - so not sure if we
>> should follow what it says too zealously.
>> 
>> > So...
>> >
>> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> > > ---
>> > >   arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 108 ++++++++++++++++++++++++++++++
>> > >   1 file changed, 108 insertions(+)
>> > >
>> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> > > index 0bbeee399a63..b7e69553857b 100644
>> > > --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>> > > @@ -5,3 +5,111 @@
>> > >    */
>> > >
>> > >   #include "rk3588-extra.dtsi"
>> > > +
>> > > +/ {
>> > > +     cluster0_opp_table: opp-table-cluster0 {
>> > > +             compatible = "operating-points-v2";
>> > > +             opp-shared;
>> > > +
>> > > +             opp-1416000000 {
>> > > +                     opp-hz = /bits/ 64 <1416000000>;
>> > > +                     opp-microvolt = <750000 750000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +                     opp-suspend;
>> > > +             };
>> > > +             opp-1608000000 {
>> > > +                     opp-hz = /bits/ 64 <1608000000>;
>> > > +                     opp-microvolt = <887500 887500 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-1704000000 {
>> > > +                     opp-hz = /bits/ 64 <1704000000>;
>> > > +                     opp-microvolt = <937500 937500 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> >
>> > None of those are valid according to Rockchip, we should have
>> 
>> Well, valid but more taxing on the hardware apparently.
>> 
>> >                 opp-1296000000 {
>> >                         opp-hz = /bits/ 64 <1296000000>;
>> >                         opp-microvolt = <750000 750000 950000>;
>> >                         clock-latency-ns = <40000>;
>> >                         opp-suspend;
>> >                 };
>> >
>> > instead?
>> 
>> I dropped this one because it uses a lower frequency but same voltage
>> as the 1.416 GHz one, thus being 'inefficient' as the thermal
>> subsystem says in the logs. It can be added back if we decide to
>> remove opp-1416000000.
>> 
>> > and...
>> >
>> > > +     };
>> > > +
>> > > +     cluster1_opp_table: opp-table-cluster1 {
>> > > +             compatible = "operating-points-v2";
>> > > +             opp-shared;
>> > > +
>> > > +             opp-1416000000 {
>> > > +                     opp-hz = /bits/ 64 <1416000000>;
>> > > +                     opp-microvolt = <750000 750000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-1608000000 {
>> > > +                     opp-hz = /bits/ 64 <1608000000>;
>> > > +                     opp-microvolt = <787500 787500 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-1800000000 {
>> > > +                     opp-hz = /bits/ 64 <1800000000>;
>> > > +                     opp-microvolt = <875000 875000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-2016000000 {
>> > > +                     opp-hz = /bits/ 64 <2016000000>;
>> > > +                     opp-microvolt = <950000 950000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> >
>> > opp-1800000000 and opp-2016000000 should be removed.
>> >
>> > and...
>> >
>> > > +     };
>> > > +
>> > > +     cluster2_opp_table: opp-table-cluster2 {
>> > > +             compatible = "operating-points-v2";
>> > > +             opp-shared;
>> > > +
>> > > +             opp-1416000000 {
>> > > +                     opp-hz = /bits/ 64 <1416000000>;
>> > > +                     opp-microvolt = <750000 750000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-1608000000 {
>> > > +                     opp-hz = /bits/ 64 <1608000000>;
>> > > +                     opp-microvolt = <787500 787500 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-1800000000 {
>> > > +                     opp-hz = /bits/ 64 <1800000000>;
>> > > +                     opp-microvolt = <875000 875000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> > > +             opp-2016000000 {
>> > > +                     opp-hz = /bits/ 64 <2016000000>;
>> > > +                     opp-microvolt = <950000 950000 950000>;
>> > > +                     clock-latency-ns = <40000>;
>> > > +             };
>> >
>> > opp-1800000000 and opp-2016000000 should be removed as well.
>> >
>> > Did I misunderstand what Rockchip did here? Adding Kever in Cc at least
>> > for awareness on Rockchip side :)
>> >
>> > I guess another option could be to mark those above as
>> >
>> > turbo-mode;
>> >
>> > though no clue what this would entail. From a glance at cpufreq, it
>> > seems that for Rockchip since we use the default cpufreq-dt, it would
>> > mark those as unusable, so essentially a no-op, so better remove them
>> > entirely?
>> 
>> I believe the opp core just marks 'turbo-mode' opps as
>> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to the
>> cpufreq core. But then to actually use those boost frequencies I would
>> guess the governor needs to somehow know the power/thermal constraints
>> of the chip?.. Don't know where that is defined.
> 
> personally I don't believe in "boost" frequencies - except when they 
> are
> declared officially.
> 
> Rockchip for the longest time maintains that running the chip outside
> the declared power/rate envelope can reduce its overall lifetime.

FWIW, as an additional data point, some other SoC manufacturers
officially state that the expected lifetime of their chips gets
reduced when they are run at higher temperatures, which are still
within the permitted temperature ranges.

> So for Rockchip in mainline a "it runs stable for me" has never been a
> suitable reasoning ;-) .
> 
> So while the situation might be strange for the rk3588j, I really only 
> want
> correct frequencies here please - not any pseudo "turbo freqs".
> 
> I don't care that much what people do on their own device{s/trees}, but
> the devicetrees we supply centrally (and to u-boot, etc) should only
> contain frequencies vetted by the manufacturer.

Totally agreed, "works for me" is simply not applicable here.  As we
know, some samples of the same CPU or SoC may be luckier when it comes
to the silicon lottery that got the binned, meaning that only the most
conservative frequencies and voltages, as assigned by the manufacturer,
are what we can provide as the OPPs.

I'm having a more detailed look into this, and I'll come back with,
hopefully, some additional comments. :)

