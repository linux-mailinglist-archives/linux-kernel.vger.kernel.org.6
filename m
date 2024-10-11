Return-Path: <linux-kernel+bounces-360775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96401999F60
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D36B21CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACC420ADE4;
	Fri, 11 Oct 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OegMyo4h"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCD20C47D;
	Fri, 11 Oct 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636841; cv=none; b=PONJmxcM+JRYe9LV2W7Kx5gzzz9Dws6nMHd1ITfL/UFBUg4euVgWNAYSTDBUQfNszTp1G9uDXMcHkZuhO14S3RJx/hI3cBf8y6cKgWDwdPWRS9YT4770Nll4HfnbTZMHJ3E7bIA+fiTjVXJsFAeIDY5HnuVt9Qm8wuqwK1zuNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636841; c=relaxed/simple;
	bh=54Gx2qUiNgWU+v/F9liAlg+w8InkTbHxQh2Kf7Keigo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gZ+yMSWrH3pMp5DMuPoNJQOffEprNS25ujcr4rFmKH49pYGMpSG1hfv8m5JaVY5BcPHMc5JYvruc64RRG+3bJ8Eh7Cooor9XS2rOPkHegqAy4e4mvuh271ARkoMxEBni9tb+tkUXm1+5k8NLt6ZqWomSq7YOT7cmsUkO/m16X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OegMyo4h; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728636836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B61H3AsIRefgNI5gLBJtHOe90Y7/nRLePBmPSNiOvqE=;
	b=OegMyo4hlpc/uuHG2hS1bMCRK/Pzq5AA4XS5Dfszn4bcvWtAq/mQjiWmszbgGTVEwYAbPT
	nojCU1iuZF0ujESnzfA/N8zuE6WBEs5fOCN/ycOQAJTYXvVpEQxf32hnObhhMWVBHKS9iA
	whqihiVCcWxThrhYofkKDHIDkfHnDlIFvnyqu0TfnErmqSKaHuduGMsU9mQT3ImWmKyxKn
	u3ZOhFy0qqAtJtqFPdE0kOOSaqgXKpqtx+Ce5I15OfEBp6IjItxdHUiw7A9EsZGUgabYKt
	L0cQZa0OfX9tkzgHD855KYMiANu/stJI2wp03KSZMde7ygk7vUZL1uUB+qwh+Q==
Date: Fri, 11 Oct 2024 10:53:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC
 variant
In-Reply-To: <1999678.yKVeVyVuyW@diego>
References: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
 <20da65423e77e13511cc7c7bb39e0246@manjaro.org>
 <D4SU6WHZCN34.2XL5W4D2T188G@cknow.org> <1999678.yKVeVyVuyW@diego>
Message-ID: <c3270b51d026d69b4eb1a3793ee81e32@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko and Diederik,

On 2024-10-11 10:43, Heiko Stübner wrote:
> Am Freitag, 11. Oktober 2024, 10:33:56 CEST schrieb Diederik de Haas:
>> On Fri Oct 11, 2024 at 10:23 AM CEST, Dragan Simic wrote:
>> > On 2024-10-11 10:00, Diederik de Haas wrote:
>> > > On Fri Oct 11, 2024 at 9:40 AM CEST, Dragan Simic wrote:
>> > >> Following the hierarchical representation of the SoC data that's been
>> > >> already
>> > >> established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move
>> > >> RK3399
>> > >> OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the
>> > >> Rockchip
>> > >> RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.
>> > >> ...
>> > >> The RK3399S variant is used in the Pine64 PinePhone Pro only, [1]
>> > >> whose board
>> > >> dts file included the necessary adjustments to the CPU DVFS OPPs.
>> > >> This commit
>> > >> effectively moves those adjustments into the separate RK3399S SoC dtsi
>> > >> file,
>> > >> following the above-mentioned "encapsulation" approach.
>> > >> ...
>> > >> ---
>> > >> ...
>> > >>  .../dts/rockchip/rk3399-pinephone-pro.dts     |  23 +---
>> > >>  arch/arm64/boot/dts/rockchip/rk3399-s.dtsi    | 123
>> > >> ++++++++++++++++++
>> > >>  2 files changed, 124 insertions(+), 22 deletions(-)
>> > >>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> > >>
>> > >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> > >> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> > >> index 1a44582a49fb..eee6cfb6de01 100644
>> > >> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> > >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> > >> @@ -13,7 +13,7 @@
>> > >>  #include <dt-bindings/input/gpio-keys.h>
>> > >>  #include <dt-bindings/input/linux-event-codes.h>
>> > >>  #include <dt-bindings/leds/common.h>
>> > >> -#include "rk3399.dtsi"
>> > >> +#include "rk3399-s.dtsi"
>> > >>
>> > >>  / {
>> > >>  	model = "Pine64 PinePhone Pro";
>> > >> @@ -456,27 +456,6 @@ mpu6500@68 {
>> > >>  	};
>> > >>  };
>> > >>
>> > >> -&cluster0_opp {
>> > >> -	opp04 {
>> > >> -		status = "disabled";
>> > >> -	};
>> > >> -
>> > >> -	opp05 {
>> > >> -		status = "disabled";
>> > >> -	};
>> > >> -};
>> > >> -
>> > >> -&cluster1_opp {
>> > >> -	opp06 {
>> > >> -		opp-hz = /bits/ 64 <1500000000>;
>> > >> -		opp-microvolt = <1100000 1100000 1150000>;
>> > >> -	};
>> > >> -
>> > >> -	opp07 {
>> > >> -		status = "disabled";
>> > >> -	};
>> > >> -};
>> > >> -
>> > >>  &io_domains {
>> > >>  	bt656-supply = <&vcc1v8_dvp>;
>> > >>  	audio-supply = <&vcca1v8_codec>;
>> > >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> > >> b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> > >> new file mode 100644
>> > >> index 000000000000..e54f451af9f3
>> > >> --- /dev/null
>> > >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> > >> @@ -0,0 +1,123 @@
>> > >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> > >> +/*
>> > >> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
>> > >> + */
>> > >> +
>> > >> +#include "rk3399-base.dtsi"
>> > >> +
>> > >> +/ {
>> > >> +	cluster0_opp: opp-table-0 {
>> > >> +		compatible = "operating-points-v2";
>> > >> +		opp-shared;
>> > >> +
>> > >> +		opp00 {
>> > >> +			opp-hz = /bits/ 64 <408000000>;
>> > >> +			opp-microvolt = <825000 825000 1250000>;
>> > >> +			clock-latency-ns = <40000>;
>> > >> +		};
>> > >> +		opp01 {
>> > >> +			opp-hz = /bits/ 64 <600000000>;
>> > >> +			opp-microvolt = <825000 825000 1250000>;
>> > >> +		};
>> > >> +		opp02 {
>> > >> +			opp-hz = /bits/ 64 <816000000>;
>> > >> +			opp-microvolt = <850000 850000 1250000>;
>> > >> +		};
>> > >
>> > > Is there a reason why there isn't a line separator between the various
>> > > opp nodes? Normally there is one between nodes.
>> > > Note that in rk3588-opp.dtsi there are no separator lines between the
>> > > opp nodes, while they do exist between other nodes.
>> > > And in rk356x.dtsi the opp nodes do have a separator line.
>> >
>> > That has also bothered me. :)  I already had a look around in various
>> > dts(i) files long time ago and there seems to be no preferred layout.
> 
> I guess "with" lines in between is sort-of preferred in general.
> I sometime add them in new board-dts when applying and noticing them,
> but also sometimes miss them.
> 
> I guess empty lines are helpful when the nodes are "not the same",
> but I guess for OPPs it doesn't matter so much, as the individual nodes
> are all the same.

Ah, sorry, I wasn't precise enough in my earlier response to
Diederik...  My research that I referred to was about the OPP nodes
in various dts(i) files, for which there seems to be no preferred
or commonly used layout.

For other nodes, in most cases it's much better to have separator
lines, because they represent different things, which also seems to
be the preferred layout used in most places.

> But in the end, I guess just follow the other OPPs in rk3399 for now 
> ;-)
> [as this patch does]

Agreed.  We'd need to patch a few additional RK3399 files otherwise,
because we'd then need to add separator lines into other RK3399 files
as well...  Inconsistency is also not so great. :)

>> I'm inclined to say the opp ones are the odd ones.
>> 
>> > In this particular case, it's better to have no separator lines because
>> > that's what we already have lacking in rk3399.dtsi, rk3399-t.dtsi, etc.,
>> > so running something like "diff rk3399.dtsi rk3399-s.dtsi" makes it easy
>> > to see what actually differs in the RK3399 SoC variants, without having
>> > to filter out any whitespace differences.
>> 
>> Besides that inconsistencies always seem to 'trigger' me, I especially
>> noticed it as this patch changed it from having separator lines to
>> having no separator lines.

Ah, totally understood. :)

