Return-Path: <linux-kernel+bounces-362612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04499B6E9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ACC1F2200A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB8188905;
	Sat, 12 Oct 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qUzbdLHn"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004A57CAC;
	Sat, 12 Oct 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728764456; cv=none; b=qBHbEfdZ+HoAAHNcVTMXJKBh1b6gNlVtJXj93CGmQ7qSURH3j/suoesPrVDGa/WRrlgeKBxPjQ3PtWqDMZUk1twhPiRLrpsk/D86x8RbOOpeINg2zedmPfzVbB6/jW2Sw1yrWrDVC9NjozypHpvnpA7HvbBtjxTPUaQCm2Yns6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728764456; c=relaxed/simple;
	bh=+uGp7x6Z33R9yq6AzM9JDurFi1vot7zaI9OYhle9pD4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rWCx2XrcGK2Bazx0l0twwhbDrmPMreDM8+XPeNYeAHSqaE+ESmBGBn98b99W4XL6FhvqAaZqj78XZLFg680Ji29Y5aNx1FRK68rmlUVuu3T1TcDZL0IVRT0sHzIM51EgCG9fNR4Vht+8+vUYu+lRPtqDwxYea1Lphkh9xqAlAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qUzbdLHn; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728764452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueGfS9O2UFxaYTzR7snUif34QAcEL+PBvOxPQLQLi8c=;
	b=qUzbdLHninY4NAX9Sm3zOx4Pg4vHpUnsr7mbkYjXEUW3AnmI5p3T7+Zuza+rjcMN/vtCG2
	dSKsMGI/ETLaWQ+Shvc6Stbc2K2F9alEXCZSjoZ+ASap/8WPgcXxEZf9o79TdfJdY29eyQ
	qnBbhxe38X/SxiFpVE+WYFiGctBXudXMSIFVIZ8oPvPuwIvBLkZk6SxQB6Xrc+fbpMpMmM
	jwbe5xlxmWe8WBTuVJmkGJ4ePmt29CuXrFMwe8CHMBqbFJFSl1WiYxFHyYjd614aFiYcSi
	pOLIOwUwYItnRg5+UfycSL6uS/HkZdiSq7mKn5cOQEgOAiYrrdRhFFrniewnXw==
Date: Sat, 12 Oct 2024 22:20:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Update CPU OPP voltages in
 RK356x SoC dtsi
In-Reply-To: <D4U3GKLN5U06.6VOVFCPFN6G7@cknow.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <2e1e100284b1edb470d6e7fde021a0f1779336c8.1728752527.git.dsimic@manjaro.org>
 <D4U2PO4VF4ST.9SBVKYF6095M@cknow.org>
 <0a1f13d06ec3668c136997e72d0aea44@manjaro.org>
 <D4U3GKLN5U06.6VOVFCPFN6G7@cknow.org>
Message-ID: <76b5a5548b4cb8b6d8ae92ec92b57bc1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-12 22:02, Diederik de Haas wrote:
> On Sat Oct 12, 2024 at 9:45 PM CEST, Dragan Simic wrote:
>> On 2024-10-12 21:27, Diederik de Haas wrote:
>> > On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
>> >> Update the lower/upper voltage limits and the exact voltages for the
>> >> Rockchip
>> >> RK356x CPU OPPs, using the most conservative values (i.e. the highest
>> >> per-OPP
>> >> voltages) found in the vendor kernel source. [1]
>> >>
>> >> Using the most conservative per-OPP voltages ensures reliable CPU
>> >> operation
>> >> regardless of the actual CPU binning, with the downside of possibly
>> >> using
>> >> a bit more power for the CPU cores than absolutely needed.
>> >>
>> >> Additionally, fill in the missing "clock-latency-ns" CPU OPP
>> >> properties, using
>> >> the values found in the vendor kernel source. [1]
>> >>
>> >> [1]
>> >> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> >>
>> >> Related-to: eb665b1c06bc ("arm64: dts: rockchip: Update GPU OPP
>> >> voltages in RK356x SoC dtsi")
>> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> ---
>> >>  arch/arm64/boot/dts/rockchip/rk3568.dtsi |  1 +
>> >>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 18 ++++++++++++------
>> >>  2 files changed, 13 insertions(+), 6 deletions(-)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> >> b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> >> index 0946310e8c12..5c54898f6ed1 100644
>> >> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> >> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> >> @@ -273,6 +273,7 @@ &cpu0_opp_table {
>> >>  	opp-1992000000 {
>> >>  		opp-hz = /bits/ 64 <1992000000>;
>> >>  		opp-microvolt = <1150000 1150000 1150000>;
>> >> +		clock-latency-ns = <40000>;
>> >>  	};
>> >>  };
>> >>
>> >> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> >> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> >> index 0ee0ada6f0ab..534593f2ed0b 100644
>> >> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> >> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> >> @@ -134,39 +134,45 @@ cpu0_opp_table: opp-table-0 {
>> >>
>> >>  		opp-408000000 {
>> >>  			opp-hz = /bits/ 64 <408000000>;
>> >> -			opp-microvolt = <900000 900000 1150000>;
>> >> +			opp-microvolt = <850000 850000 1150000>;
>> >>  			clock-latency-ns = <40000>;
>> >>  		};
>> >>
>> >>  		opp-600000000 {
>> >>  			opp-hz = /bits/ 64 <600000000>;
>> >> -			opp-microvolt = <900000 900000 1150000>;
>> >> +			opp-microvolt = <850000 850000 1150000>;
>> >> +			clock-latency-ns = <40000>;
>> >>  		};
>> >>
>> >>  		opp-816000000 {
>> >>  			opp-hz = /bits/ 64 <816000000>;
>> >> -			opp-microvolt = <900000 900000 1150000>;
>> >> +			opp-microvolt = <850000 850000 1150000>;
>> >> +			clock-latency-ns = <40000>;
>> >>  			opp-suspend;
>> >>  		};
>> >
>> > While it felt a bit much to send a patch just to remove the blank lines
>> > between the opp nodes, this sounds like an excellent opportunity to
>> > make it consistent with the opp list in other DT files?
>> 
>> Actually, my plan is to work on the SoC binning, which will involve
>> touching nearly every OPP in the Rockchip DTs, and will add much more
>> data to each OPP node.  Thus, having empty lines as the separators
>> between the OPP nodes is something we should actually want, because
> 
> As indicated in the "arm64: dts: rockchip: Add dtsi file for RK3399S 
> SoC
> variant" patch series, I do prefer the separator lines ...

Oh, I also prefer them.  I just opted for introducing fewer changes
in the RK3399S patch series, to keep the size of the series smaller,
and to end up with easier diffing of the SoC variant dtsi files.

>> not having them will actually reduce the readability after the size
>> of the individual OPP nodes is increased.
>> 
>> That's the reason why I opted for having the separator lines in this
>> patch series, i.e. because having them everywhere should be the final
>> outcome, and because in this case they were already present where the
>> OPPs were moved or copied from.
> 
> ... but you actually removed those lines in the other patch set.

Well, I didn't remove them in place, but en route to another, much
larger file, :) which originally didn't have them.  As described
above, that was my choice to keep the things a bit more consistent
(in the "RK3399 way"), and to reduce the amount of "code churn"
a bit.  I'll try to explain it further below.

> While I'm looking forward to the extra data to the OPP nodes, I don't
> think the amount of properties should determine whether it should have 
> a
> separator line or not.

True, the size of the node shouldn't be the determining factor.
The reason why I emphasized the node size was because other people
may be a bit "allergic" to whitespace changes and such "cosmetic"
code layout changes, so justifying such changes can only help.

See, just as you're "triggered" by whitespace inconsistency, some
other people may be "triggered" by cosmetic code changes.   It's
quite tough to strike some kind of balance there. :)

