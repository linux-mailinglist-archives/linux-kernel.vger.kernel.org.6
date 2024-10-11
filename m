Return-Path: <linux-kernel+bounces-360744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403E999EED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31BE1C22EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705E20ADF1;
	Fri, 11 Oct 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aXloB4Bk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C601CB334;
	Fri, 11 Oct 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634998; cv=none; b=oq/QK5ZiyDBgA6GwRJ+vKmbs/BoiWfVyo0FZQQQNbXKeDa3+dE0jKlz8b54X1V+maH2ol4d4StJB1Y9yxUOenvfwsiHsKjlvUQ+uMO5y4jT3QzkmmsHZvRNmKPDOv2UJ/Z7YgRtibD3o1nsvf/wxQHVcQAcOaUmMOGw+In22P8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634998; c=relaxed/simple;
	bh=1SCPoV+flAzo+FGqNybbdbTm68eB8EOQkNIGyYMJD2g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hyYOGQT94SvSCd+WFk9N1RETSoipCI0fcbyQm/KStXlX2mcZ5XYzcnpcbRE0JJOcdzuukdGhr5UWrwGeq8EsnewgjqkH4F2M8i+MZIH8CmPdLlI3MPR9xO2NzizOs+eAA1Tw7Gab1uhA0WDV6VAKS2rARI1VKpGko7lF6nJoLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aXloB4Bk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728634993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wtd4w3kPmY8STzgl3hbVfL0jzi8Spp87zTee4Cx7AxI=;
	b=aXloB4Bkt0Wtzcjbb28+LTGW/hzvUuVayg8nQDwrKVsHFY1UbGGO3G5qNPJ6/RE8A4CTRw
	G5v0XBUaAbhWY7/pyUVr7W2s0NVUpKV913bsFaWVUmK1kRWhGOkeAatdz11tRIwvZ3yD18
	5p6kvBY9bgcxkPaYEcmq1r7QDnWvd7ls03Jhq//X7fBORaghVLe/SxhNZcU3WsWhzAjnL+
	ScRiDn3zsDu9fHO7hXOD74VB/Ub7LwfBB+e2rpMxbBujicSnF2+WSkn4jwxuP5SO11qO9O
	NwESBzH69NHTZuuFvZQnm+qGa0i8pHxdNu3gSe78yMU0mVTF+X8QVAjKgh23Tw==
Date: Fri, 11 Oct 2024 10:23:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add dtsi file for RK3399S SoC
 variant
In-Reply-To: <D4STH4Z8LTHN.2X4BJJVACFSIS@cknow.org>
References: <c32622e4a6897378d9df81c8c3eda1bdb9211e0b.1728632052.git.dsimic@manjaro.org>
 <D4STH4Z8LTHN.2X4BJJVACFSIS@cknow.org>
Message-ID: <20da65423e77e13511cc7c7bb39e0246@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-11 10:00, Diederik de Haas wrote:
> On Fri Oct 11, 2024 at 9:40 AM CEST, Dragan Simic wrote:
>> Following the hierarchical representation of the SoC data that's been 
>> already
>> established in the commit 296602b8e5f7 ("arm64: dts: rockchip: Move 
>> RK3399
>> OPPs to dtsi files for SoC variants"), add new SoC dtsi file for the 
>> Rockchip
>> RK3399S SoC, which is yet another variant of the Rockchip RK3399 SoC.
>> ...
>> The RK3399S variant is used in the Pine64 PinePhone Pro only, [1] 
>> whose board
>> dts file included the necessary adjustments to the CPU DVFS OPPs.  
>> This commit
>> effectively moves those adjustments into the separate RK3399S SoC dtsi 
>> file,
>> following the above-mentioned "encapsulation" approach.
>> ...
>> ---
>> ...
>>  .../dts/rockchip/rk3399-pinephone-pro.dts     |  23 +---
>>  arch/arm64/boot/dts/rockchip/rk3399-s.dtsi    | 123 
>> ++++++++++++++++++
>>  2 files changed, 124 insertions(+), 22 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> index 1a44582a49fb..eee6cfb6de01 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
>> @@ -13,7 +13,7 @@
>>  #include <dt-bindings/input/gpio-keys.h>
>>  #include <dt-bindings/input/linux-event-codes.h>
>>  #include <dt-bindings/leds/common.h>
>> -#include "rk3399.dtsi"
>> +#include "rk3399-s.dtsi"
>> 
>>  / {
>>  	model = "Pine64 PinePhone Pro";
>> @@ -456,27 +456,6 @@ mpu6500@68 {
>>  	};
>>  };
>> 
>> -&cluster0_opp {
>> -	opp04 {
>> -		status = "disabled";
>> -	};
>> -
>> -	opp05 {
>> -		status = "disabled";
>> -	};
>> -};
>> -
>> -&cluster1_opp {
>> -	opp06 {
>> -		opp-hz = /bits/ 64 <1500000000>;
>> -		opp-microvolt = <1100000 1100000 1150000>;
>> -	};
>> -
>> -	opp07 {
>> -		status = "disabled";
>> -	};
>> -};
>> -
>>  &io_domains {
>>  	bt656-supply = <&vcc1v8_dvp>;
>>  	audio-supply = <&vcca1v8_codec>;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> new file mode 100644
>> index 000000000000..e54f451af9f3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-s.dtsi
>> @@ -0,0 +1,123 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
>> + */
>> +
>> +#include "rk3399-base.dtsi"
>> +
>> +/ {
>> +	cluster0_opp: opp-table-0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <825000 825000 1250000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +		opp01 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <825000 825000 1250000>;
>> +		};
>> +		opp02 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <850000 850000 1250000>;
>> +		};
> 
> Is there a reason why there isn't a line separator between the various
> opp nodes? Normally there is one between nodes.
> Note that in rk3588-opp.dtsi there are no separator lines between the
> opp nodes, while they do exist between other nodes.
> And in rk356x.dtsi the opp nodes do have a separator line.

That has also bothered me. :)  I already had a look around in various
dts(i) files long time ago and there seems to be no preferred layout.

In this particular case, it's better to have no separator lines because
that's what we already have lacking in rk3399.dtsi, rk3399-t.dtsi, etc.,
so running something like "diff rk3399.dtsi rk3399-s.dtsi" makes it easy
to see what actually differs in the RK3399 SoC variants, without having
to filter out any whitespace differences.

