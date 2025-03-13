Return-Path: <linux-kernel+bounces-560278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F9A60178
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7E34217F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB21F3B98;
	Thu, 13 Mar 2025 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dE/+DN+Z"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDC5464E;
	Thu, 13 Mar 2025 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895026; cv=none; b=Xa/V1IDJ3VDxSYLF59T1tAtfZMnAxAVbtfid+faDmWex8YTFVEXGUxA/fjKTNuNrnPh3BBnMPKXJbBNK2KcBgFcxGyJLZNCZgSQEVRjKge1tx7tguj+o034SRK9qHrL7FR3RqZ+I+thum206aIW/Jhi74pJOcYEP6qpLO/gNakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895026; c=relaxed/simple;
	bh=TAyJgC0+VZW7fmpUhYlcq9DyILO8ChhSK8tB2x5yuO8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FZf72Qd9WzUdVRDsBBDDExy+tRqNMWT/WzBLIRBU0jypdPx9a1MkPfPfScrWNBX3Nzjl15WZaWgjqgObxh0ezL74Wjd9i6tl1WbW9RwWID1vmtZU/tHsGFVbZ0KA34/IIbVIoMZPTAEFIYf5ON9UcDzUlC341hsGFDKO3d46Bt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dE/+DN+Z; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741895022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8TnEmqSHNmEFF2Gnw1R5cVX6hnoXPw8fB05bPnBUqE=;
	b=dE/+DN+ZBOTdTSE44pKduxHrktT3P0T3mJE54QcXa1CssIfbI2E7pJGRixf6iMC6TNqG2P
	7Gg8u/bn/pBFrOxEOKdYdE8PBHJySRi8q9yw9LdnoAfU5DgiGWh1xWBDl8Ey25o3ar+1na
	uIN8hdE7ZZmKg8Kdb+8Vuhr7bktDRJ50DW8aHlf7xi6W3Cr6MC1NQ0svgXRWROLzH+a+7y
	Ojc+eZnD38JL4yAF76nC+YBvUW+dx1uKSG4VPd0mnO4stoJmO1dpMZEo6f8bJBIKL7iT3O
	Va61HSg+Wv+xpatv0k0JfhdJeDdiHmsnN9G1tLUJLkVUac9+YtVWMfcqrRyQOA==
Date: Thu, 13 Mar 2025 20:43:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
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
In-Reply-To: <3271211.5fSG56mABF@phil>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <a56b59a21dc3c21192fe45197eee4865@manjaro.org>
 <2cf3889741f84584d8f23a4407fed08e@manjaro.org> <3271211.5fSG56mABF@phil>
Message-ID: <80c7d9fcdd270df2c61fbd61eec44d70@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2025-03-13 20:00, Heiko Stuebner wrote:
> Am Donnerstag, 13. März 2025, 11:42:17 MEZ schrieb Dragan Simic:
>> On 2025-03-12 11:34, Dragan Simic wrote:
>> > On 2025-03-12 11:15, Quentin Schulz wrote:
>> >> On 2/16/25 1:32 PM, Alexey Charkov wrote:
>> >>> On Sat, Feb 15, 2025 at 11:30 PM Heiko Stübner <heiko@sntech.de>
>> >>> wrote:
>> >>>> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
>> >>>>> On Tue, Feb 11, 2025 at 7:32 PM Quentin Schulz
>> >>>>> <quentin.schulz@cherry.de> wrote:
>> >>>>>> On 6/17/24 8:28 PM, Alexey Charkov wrote:
>> >> [...]
>> >>>>>>> +     };
>> >>>>>>> +
>> >>>>>>> +     cluster2_opp_table: opp-table-cluster2 {
>> >>>>>>> +             compatible = "operating-points-v2";
>> >>>>>>> +             opp-shared;
>> >>>>>>> +
>> >>>>>>> +             opp-1416000000 {
>> >>>>>>> +                     opp-hz = /bits/ 64 <1416000000>;
>> >>>>>>> +                     opp-microvolt = <750000 750000 950000>;
>> >>>>>>> +                     clock-latency-ns = <40000>;
>> >>>>>>> +             };
>> >>>>>>> +             opp-1608000000 {
>> >>>>>>> +                     opp-hz = /bits/ 64 <1608000000>;
>> >>>>>>> +                     opp-microvolt = <787500 787500 950000>;
>> >>>>>>> +                     clock-latency-ns = <40000>;
>> >>>>>>> +             };
>> >>>>>>> +             opp-1800000000 {
>> >>>>>>> +                     opp-hz = /bits/ 64 <1800000000>;
>> >>>>>>> +                     opp-microvolt = <875000 875000 950000>;
>> >>>>>>> +                     clock-latency-ns = <40000>;
>> >>>>>>> +             };
>> >>>>>>> +             opp-2016000000 {
>> >>>>>>> +                     opp-hz = /bits/ 64 <2016000000>;
>> >>>>>>> +                     opp-microvolt = <950000 950000 950000>;
>> >>>>>>> +                     clock-latency-ns = <40000>;
>> >>>>>>> +             };
>> >>>>>>
>> >>>>>> opp-1800000000 and opp-2016000000 should be removed as well.
>> >>>>>>
>> >>>>>> Did I misunderstand what Rockchip did here? Adding Kever in Cc at
>> >>>>>> least
>> >>>>>> for awareness on Rockchip side :)
>> >>>>>>
>> >>>>>> I guess another option could be to mark those above as
>> >>>>>>
>> >>>>>> turbo-mode;
>> >>>>>>
>> >>>>>> though no clue what this would entail. From a glance at cpufreq,
>> >>>>>> it
>> >>>>>> seems that for Rockchip since we use the default cpufreq-dt, it
>> >>>>>> would
>> >>>>>> mark those as unusable, so essentially a no-op, so better remove
>> >>>>>> them
>> >>>>>> entirely?
>> >>>>>
>> >>>>> I believe the opp core just marks 'turbo-mode' opps as
>> >>>>> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to
>> >>>>> the
>> >>>>> cpufreq core. But then to actually use those boost frequencies I
>> >>>>> would
>> >>>>> guess the governor needs to somehow know the power/thermal
>> >>>>> constraints
>> >>>>> of the chip?.. Don't know where that is defined.
>> >>>>
>> >>>> personally I don't believe in "boost" frequencies - except when they
>> >>>> are
>> >>>> declared officially.
>> >>>>
>> >>>> Rockchip for the longest time maintains that running the chip
>> >>>> outside
>> >>>> the declared power/rate envelope can reduce its overall lifetime.
>> >>>>
>> >>>> So for Rockchip in mainline a "it runs stable for me" has never been
>> >>>> a
>> >>>> suitable reasoning ;-) .
>> >>>
>> >>> My key concern here was perhaps that we are looking at a file inside
>> >>> the Rockchip source tree which looks relevant by the name of it, but
>> >>> doesn't actually get included anywhere for any of the boards. This
>> >>> may
>> >>> or may not constitute an endorsement by Rockchip of any OPPs listed
>> >>> there :-D
>> >>
>> >> Rockchip support stated:
>> >>
>> >> """
>> >> If you run overdrive mode, you do not need to include rk3588j.dtsi,
>> >> and you can change it to #incldue rk3588.dtsi to ensure that the
>> >> maximum frequency can reach 2GHz
>> >>
>> >> below picture from datasheet.
>> >> """
>> >>
>> >> The picture is the table 3-2 Recommended operating conditions, page 30
>> >> from the RK3588J datasheet, e.g.
>> >> https://www.lcsc.com/datasheet/lcsc_datasheet_2403201054_Rockchip-RK3588J_C22364189.pdf
>> >>
>> >> What is overdrive?
>> >>
>> >> """
>> >> Overdrive mode brings higher frequency, and the voltage will increase
>> >> accordingly. Under
>> >> the overdrive mode for a long time, the chipset may shorten the
>> >> lifetime, especially in high temperature condition
>> >> """
>> >>
>> >> according to the same datasheet, end of the same table, page 31.
>> >>
>> >> so this seems like a turbo-mode frequency to me.
>> >>
>> >> Additionally, the note for the "normal mode" (the one with the lower
>> >> freqs) states:
>> >>
>> >> """
>> >> Normal mode means the chipset works under safety voltage and
>> >> frequency. For the
>> >> industrial environment, highly recommend to keep in normal mode, the
>> >> lifetime is
>> >> reasonably guaranteed.
>> >> """
>> >>
>> >> I believe "industrial environment" means RK3588J used in the
>> >> temperatures that aren't OK for the standard RK3588 variant?
>> >
>> > Thanks a lot for obtaining these clarifications!
>> >
>> > Yes, I'd say that in this case "industrial environment" boils down
>> > to the extended temperature range for the RK3588J variant.
>> >
>> >>> I haven't seen a TRM for the J variant, nor do I have a board with
>> >>> RK3588J to run tests, so it would be great if Kever could chime in
>> >>> with how these OPPs are different from the others (or not).
>> >>>
>> >>>> So while the situation might be strange for the rk3588j, I really
>> >>>> only want
>> >>>> correct frequencies here please - not any pseudo "turbo freqs".
>> >>>>
>> >>>> I don't care that much what people do on their own device{s/trees},
>> >>>> but
>> >>>> the devicetrees we supply centrally (and to u-boot, etc) should only
>> >>>> contain frequencies vetted by the manufacturer.
>> >>>
>> >>> Fair enough. Let's just try and get another data point on whether
>> >>> these frequencies are vetted or not.
>> >>
>> >> So the higher freqs seems to be vetted (and used by default on
>> >> Rockchip's BSP kernel), it just feels like you aren't really supposed
>> >> to run those higher frequencies all the time? And especially not in
>> >> "industrial environment"?
>> >>
>> >> I would assume we want to stay on the safer side and remove those
>> >> higher frequencies? Heiko?
>> >
>> > I agree, we should remove the higher-frequency OPPs.  I'd like
>> > to go through everything once again in detail and prepare a patch
>> > that removes the unsafe OPPs, and you could review it once it's
>> > on the ML, to make sure it's fine.
>> 
>> Just as a note, everything above (and even a bit more) is confirmed
>> and clearly described in the publicly available RK3588J datasheet,
>> which I'll provide as a reference in my upcoming patch.
> 
> so just to reiterate my stance, in mainline I really only want 
> frequencies
> that are not possibly influencing the lifetime of the chip.
> 
> It doesn't even matter about the variant we're talking about being
> industrial :-) . When someone is using mainline I want them to be
> reasonable assured that we don't have stuff in here that may affect
> the lifetime of their board.
> 
> All gambling on performance for possible lifetime reduction people
> can do on their own ... for example with a dt-overlay ;-) .
> 
> So TL;DR, I agree to both Quentin and Dragan

Thanks!  Indeed, we must provide only the OPPs that are declared
by the manufacturer to be always safe for the particular SoC
variant.  The RK3588J is actually a good example, because it, in
theory, can run safely at higher OPPs as well, but only when not
enjoying the extended temperature range that the RK3588J, as an
SoC variant targeted at industrial applications, is specifically
made (or binned) for.

Thus, we must support only the RK3588J OPPs that are declared to
be safe throughout the entire extended temperature range, while
anyone who actually can assure that their RK3588J-based board is
never going to run within the extended temperature range, probably
may safely apply an overlay that adds the higher OPPs.  As we
obviously can't know what will be the temperature conditions, we
may provide only the lower OPPs that are always safe.

I'll finish the patch and send it over tomorrow or so...  I still
need to go through the changes once again, to make 100% sure I've
missed nothing, and that I haven't included anything extraneous. :)

