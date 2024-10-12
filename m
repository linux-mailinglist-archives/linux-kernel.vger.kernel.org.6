Return-Path: <linux-kernel+bounces-362611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682299B6E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B181C21034
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EEB19308A;
	Sat, 12 Oct 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="j8vdUPus"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68541B977;
	Sat, 12 Oct 2024 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728763677; cv=none; b=gvYYFqbz3JYMc7Tlo2RWZuDqoq08U3WhRCngLo8VWTdQ9WWWBVlzTZwbKAxxpKlTaZGQ4pvw0dCGGKYTtF95tt/fR2pV1XEcm3yxCml6RfY0q9DLgcYRc8ACkgon5mGlUKiHiaGVfSdvWqeP6gqPQf897CD8CXVDnZHwcXmWCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728763677; c=relaxed/simple;
	bh=1W6NZKzWtl+yNyhdtQxFFgJAAh4eJe3YUSLPj71h28g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XmiFrfmxQeHOn+K6zaQzvzz1oD11TlP5wqyYsbOjus2SXKFId3GyLst9GIu+7jVyXf7IiFrY567ZYDit904fd/MqNlfdfQDxJjcbV2BmTU6WdsQKD52n4vIA/dYTub4NUrE/0tkJKh/o1M7M9Rgz7c9EG5ZTOl1eyVw8CY+8uAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=j8vdUPus; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728763673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZtiiUmH2IoIAMZC0AlguTFkTu67X2W4mJtt55A/9rc=;
	b=j8vdUPus9jvR/7tCH2d+fWrvO+eZ4Bm3DAmLJzkL7momfxtrylPExR+YncIXyZZDk3O6pc
	RtqstQcEt2VSdOabrJKjFuoynuXPbGBIwpF7QPofxbAK/L8D3nLeAXL+rSW11UjGsyfRE2
	ItNZHnFaKtCVfYhiiCDQtDZhQa/qHCiMOjMEN+GEjtKp9pZpP0DoU/hltLfKhselzXji7c
	Z7wLHb0UG9KdxtsxvAAoz1gyRz4L+yI1ymiYOoA7PcTx7wk+k/ly1DWaFqSwYgzqKBj0iS
	TE9Jrd6UBD2c5BVZ/DBO71cuoVCvpERClw7qaK6Bbkzf003qCCqOf+EeeufB1A==
Date: Sat, 12 Oct 2024 22:07:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, TL Lim <tllim@pine64.org>, Marek Kraus
 <gamiee@pine64.org>, Tom Cubie <tom@radxa.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add new SoC dtsi for the
 RK3566T variant
In-Reply-To: <D4U31LE9JG2Q.CW68BA95B9QZ@cknow.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <95fc64aaf6d3ac7124926bcb0c664406b4e5fe3d.1728752527.git.dsimic@manjaro.org>
 <D4U31LE9JG2Q.CW68BA95B9QZ@cknow.org>
Message-ID: <da32bf7d522b0b55dc574526c81cae77@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-12 21:42, Diederik de Haas wrote:
> On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
>> Add new SoC dtsi file for the RK3566T variant of the Rockchip RK3566 
>> SoC.
>> The difference between the RK3566T variant and the "full-fat" RK3566 
>> variant
>> is in fewer supported CPU and GPU OPPs on the RK3566T, and in the 
>> absence of
>> a functional NPU, which we currently don't have to worry about.
>> 
>> Examples of the boards based on the RK3566T include the Pine64 
>> Quartz64 Zero
>> SBC, [2] the Radxa ROCK 3C and the Radxa ZERO 3E/3W SBCs.  
>> Unfortunately,
>> Radxa doesn't mention the use of RK3566T officially, but its official 
>> SBC
>> specifications do state that the maximum frequency for the Cortex-A55 
>> cores
>> on those SBCs is lower than the "full-fat" RK3566's 1.8 GHz, which 
>> makes
>> spotting the presence of the RK3566T SoC variant rather easy. 
>> [3][4][5]  An
>> additional, helpful cue is that Radxa handles the CPU and GPU OPPs for 
>> the
>> RK3566T variant separately in its downstream kernel. [6]
>> 
>> The CPU and GPU OPPs supported on the RK3566T SoC variant are taken 
>> from the
>> vendor kernel source, [1] which uses the values of the 
>> "opp-supported-hw" OPP
>> properties to determine which ones are supported on a particular SoC 
>> variant.
>> The actual values of the "opp-supported-hw" properties make it rather 
>> easy
>> to see what OPPs are supported on the RK3566T SoC variant, but that, 
>> rather
>> unfortunately, clashes with the maximum frequencies advertised 
>> officially
>> for the Cortex-A55 CPU cores on the above-mentioned SBCs. [2][3][4][5] 
>>  The
>> vendor kernel source indicates that the maximum frequency for the CPU 
>> cores
>> is 1.4 GHz, while the SBC specifications state that to be 1.6 GHz.  
>> Unless
>> that discrepancy is resolved somehow, let's take the safe approach and 
>> use
>> the lower maximum frequency for the CPU cores.
>> 
>> Update the dts files of the currently supported RK3566T-based boards 
>> to use
>> the new SoC dtsi for the RK3566T variant.  This actually takes the CPU 
>> cores
>> and the GPUs found on these boards out of their earlier overclocks, 
>> but it
>> also means that the officially advertised specifications [2][3][4][5] 
>> of the
>> highest supported frequencies for the Cortex-A55 CPU cores on these 
>> boards
>> may actually be wrong, as already explained above.
>> 
>> The correctness of the introduced changes was validated by decompiling 
>> and
>> comparing all affected board dtb files before and after these changes.
>> 
>> [1] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> [2] https://wiki.pine64.org/wiki/Quartz64
>> [3] 
>> https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
>> [4] 
>> https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
>> [5] 
>> https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
>> [6] 
>> https://github.com/radxa/kernel/commit/2dfd51da472e7ebb5ef0d3db78f902454af826b8
>> 
>> Cc: TL Lim <tllim@pine64.org>
>> Cc: Marek Kraus <gamiee@pine64.org>
>> Cc: Tom Cubie <tom@radxa.com>
>> Cc: FUKAUMI Naoki <naoki@radxa.com>
>> Helped-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>> Helped-by: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |  2 +-
>>  .../boot/dts/rockchip/rk3566-rock-3c.dts      |  2 +-
>>  arch/arm64/boot/dts/rockchip/rk3566t.dtsi     | 90 
>> +++++++++++++++++++
>>  3 files changed, 92 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
>> index de390d92c35e..1ee5d96a46a1 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
>> @@ -3,7 +3,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/soc/rockchip,vop2.h>
>> -#include "rk3566.dtsi"
>> +#include "rk3566t.dtsi"
>> 
>>  / {
>>  	chosen {
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts 
>> b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
>> index f2cc086e5001..9a8f4f774dbc 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
>> @@ -5,7 +5,7 @@
>>  #include <dt-bindings/leds/common.h>
>>  #include <dt-bindings/pinctrl/rockchip.h>
>>  #include <dt-bindings/soc/rockchip,vop2.h>
>> -#include "rk3566.dtsi"
>> +#include "rk3566t.dtsi"
>> 
>>  / {
>>  	model = "Radxa ROCK 3C";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566t.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>> new file mode 100644
>> index 000000000000..cd89bd3b125b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3566-base.dtsi"
>> +
>> +/ {
>> +	cpu0_opp_table: opp-table-0 {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp-408000000 {
>> +			opp-hz = /bits/ 64 <408000000>;
>> +			opp-microvolt = <850000 850000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <850000 850000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-816000000 {
>> +			opp-hz = /bits/ 64 <816000000>;
>> +			opp-microvolt = <850000 850000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +			opp-suspend;
>> +		};
>> +
> 
> For consistency, no blank lines between the opp nodes would be nice ;)

I hope the way I already explained the background [*] provides
a satisfactory explanation for this choice. :)

[*] 
https://lore.kernel.org/linux-rockchip/0a1f13d06ec3668c136997e72d0aea44@manjaro.org/

