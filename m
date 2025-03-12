Return-Path: <linux-kernel+bounces-557536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCAA5DA82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4287A3111
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0C23E32B;
	Wed, 12 Mar 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WNMOmc6v"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90423496B;
	Wed, 12 Mar 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775675; cv=none; b=Exf5/CYAJyR52+nptW5w07+gByDKSrlq8vs1RULtXhey2j2cVPFXOiVgzz1bWoAmWy6h2FmTHyzoJvefEHLp1ptJa0hsXwoqxov89cqqsIJALxIp3mCMVpPAiqF9XBEj03kiTmucZFeK0V3Bj8fzzRj949jolRKQrJ8yGvX1igo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775675; c=relaxed/simple;
	bh=vtEgiFiNKz4mOrS9h4JjnDKiS+PYUsjqaZRsDlaZ44Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fGZVE7zyeyoFdGjYM/+atdKlONmuT5ZFGawIODGqY2ZLQmb+Ex3ldufoCxlfImDJICgJn0QHQ6e/0qSIO48x2QW9E+mW2rCN03p3792LLztkoRFE1jCnatcGNIHuUFu1tG93qZeBRlEEw+mORkzMH1sYcihZQsXwBCseN+XtGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WNMOmc6v; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741775664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCx5YAH/sAsaL16jy2DXOMRm0Fr1aAKlpBDGrdma5Zw=;
	b=WNMOmc6vboNRAgv8JLDAr228Cs7eNkjbwkz0CNj6JfukEymA5BgjrT1MlN9++KpY3Lyo4F
	PpA1H5ibX3N6R1qU0aU+JVGJesw70AXKUC2rurEwEsMedGq4zpaTxPmTsgT26JhSpP+rj2
	c8VRPMruMYnyJdPceQhktYHaYO98OP2UxTtbsnsTbAhzzFUVJgrQPW4UVxqzWwrpf/GuHU
	KQiriIKlpSJcjTFbkM5yblTCRpxPTKod5q4zUV4bHk0ujc5I4Ryrv25y9MBe4KFar+LxXH
	VW9hn4uNwUf3GHlzdLON+fT9DIwEL4DsI1GSkn/T28XeywhBQlvsokD/GDUWeQ==
Date: Wed, 12 Mar 2025 11:34:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Alexey Charkov <alchark@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas
 <didi.debian@cknow.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
In-Reply-To: <e55125ed-64fb-455e-b1e4-cebe2cf006e4@cherry.de>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
 <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
 <2914631.KiezcSG77Q@diego>
 <CABjd4YxF4N1tAgGUZk-oKkMUO+Q9rWHZsas9gMQdJ+TF4A1=NA@mail.gmail.com>
 <e55125ed-64fb-455e-b1e4-cebe2cf006e4@cherry.de>
Message-ID: <a56b59a21dc3c21192fe45197eee4865@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Quentin,

On 2025-03-12 11:15, Quentin Schulz wrote:
> On 2/16/25 1:32 PM, Alexey Charkov wrote:
>> On Sat, Feb 15, 2025 at 11:30 PM Heiko Stübner <heiko@sntech.de> 
>> wrote:
>>> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
>>>> On Tue, Feb 11, 2025 at 7:32 PM Quentin Schulz 
>>>> <quentin.schulz@cherry.de> wrote:
>>>>> On 6/17/24 8:28 PM, Alexey Charkov wrote:
> [...]
>>>>>> +     };
>>>>>> +
>>>>>> +     cluster2_opp_table: opp-table-cluster2 {
>>>>>> +             compatible = "operating-points-v2";
>>>>>> +             opp-shared;
>>>>>> +
>>>>>> +             opp-1416000000 {
>>>>>> +                     opp-hz = /bits/ 64 <1416000000>;
>>>>>> +                     opp-microvolt = <750000 750000 950000>;
>>>>>> +                     clock-latency-ns = <40000>;
>>>>>> +             };
>>>>>> +             opp-1608000000 {
>>>>>> +                     opp-hz = /bits/ 64 <1608000000>;
>>>>>> +                     opp-microvolt = <787500 787500 950000>;
>>>>>> +                     clock-latency-ns = <40000>;
>>>>>> +             };
>>>>>> +             opp-1800000000 {
>>>>>> +                     opp-hz = /bits/ 64 <1800000000>;
>>>>>> +                     opp-microvolt = <875000 875000 950000>;
>>>>>> +                     clock-latency-ns = <40000>;
>>>>>> +             };
>>>>>> +             opp-2016000000 {
>>>>>> +                     opp-hz = /bits/ 64 <2016000000>;
>>>>>> +                     opp-microvolt = <950000 950000 950000>;
>>>>>> +                     clock-latency-ns = <40000>;
>>>>>> +             };
>>>>> 
>>>>> opp-1800000000 and opp-2016000000 should be removed as well.
>>>>> 
>>>>> Did I misunderstand what Rockchip did here? Adding Kever in Cc at 
>>>>> least
>>>>> for awareness on Rockchip side :)
>>>>> 
>>>>> I guess another option could be to mark those above as
>>>>> 
>>>>> turbo-mode;
>>>>> 
>>>>> though no clue what this would entail. From a glance at cpufreq, it
>>>>> seems that for Rockchip since we use the default cpufreq-dt, it 
>>>>> would
>>>>> mark those as unusable, so essentially a no-op, so better remove 
>>>>> them
>>>>> entirely?
>>>> 
>>>> I believe the opp core just marks 'turbo-mode' opps as
>>>> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to 
>>>> the
>>>> cpufreq core. But then to actually use those boost frequencies I 
>>>> would
>>>> guess the governor needs to somehow know the power/thermal 
>>>> constraints
>>>> of the chip?.. Don't know where that is defined.
>>> 
>>> personally I don't believe in "boost" frequencies - except when they 
>>> are
>>> declared officially.
>>> 
>>> Rockchip for the longest time maintains that running the chip outside
>>> the declared power/rate envelope can reduce its overall lifetime.
>>> 
>>> So for Rockchip in mainline a "it runs stable for me" has never been 
>>> a
>>> suitable reasoning ;-) .
>> 
>> My key concern here was perhaps that we are looking at a file inside
>> the Rockchip source tree which looks relevant by the name of it, but
>> doesn't actually get included anywhere for any of the boards. This may
>> or may not constitute an endorsement by Rockchip of any OPPs listed
>> there :-D
> 
> Rockchip support stated:
> 
> """
> If you run overdrive mode, you do not need to include rk3588j.dtsi,
> and you can change it to #incldue rk3588.dtsi to ensure that the
> maximum frequency can reach 2GHz
> 
> below picture from datasheet.
> """
> 
> The picture is the table 3-2 Recommended operating conditions, page 30
> from the RK3588J datasheet, e.g.
> https://www.lcsc.com/datasheet/lcsc_datasheet_2403201054_Rockchip-RK3588J_C22364189.pdf
> 
> What is overdrive?
> 
> """
> Overdrive mode brings higher frequency, and the voltage will increase
> accordingly. Under
> the overdrive mode for a long time, the chipset may shorten the
> lifetime, especially in high temperature condition
> """
> 
> according to the same datasheet, end of the same table, page 31.
> 
> so this seems like a turbo-mode frequency to me.
> 
> Additionally, the note for the "normal mode" (the one with the lower
> freqs) states:
> 
> """
> Normal mode means the chipset works under safety voltage and frequency. 
> For the
> industrial environment, highly recommend to keep in normal mode, the 
> lifetime is
> reasonably guaranteed.
> """
> 
> I believe "industrial environment" means RK3588J used in the
> temperatures that aren't OK for the standard RK3588 variant?

Thanks a lot for obtaining these clarifications!

Yes, I'd say that in this case "industrial environment" boils down
to the extended temperature range for the RK3588J variant.

>> I haven't seen a TRM for the J variant, nor do I have a board with
>> RK3588J to run tests, so it would be great if Kever could chime in
>> with how these OPPs are different from the others (or not).
>> 
>>> So while the situation might be strange for the rk3588j, I really 
>>> only want
>>> correct frequencies here please - not any pseudo "turbo freqs".
>>> 
>>> I don't care that much what people do on their own device{s/trees}, 
>>> but
>>> the devicetrees we supply centrally (and to u-boot, etc) should only
>>> contain frequencies vetted by the manufacturer.
>> 
>> Fair enough. Let's just try and get another data point on whether
>> these frequencies are vetted or not.
> 
> So the higher freqs seems to be vetted (and used by default on
> Rockchip's BSP kernel), it just feels like you aren't really supposed
> to run those higher frequencies all the time? And especially not in
> "industrial environment"?
> 
> I would assume we want to stay on the safer side and remove those
> higher frequencies? Heiko?

I agree, we should remove the higher-frequency OPPs.  I'd like
to go through everything once again in detail and prepare a patch
that removes the unsafe OPPs, and you could review it once it's
on the ML, to make sure it's fine.

