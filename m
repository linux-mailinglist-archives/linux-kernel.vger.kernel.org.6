Return-Path: <linux-kernel+bounces-362608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9599B6DE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AD2282C98
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174391474B8;
	Sat, 12 Oct 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="G+Nj+eUS"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062D81B977;
	Sat, 12 Oct 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728763292; cv=none; b=WopR9F+UUGPgV/sz1EOlTdryedXEY0LJ/lx24q3Ha+ObhMqq5FLULL0d3IhJf5cMn9D7prawQjYjZwgm+mr6OTw3Ik4RUhyEiwIyQ1UeS3GXKKT3c6RhItodbtKfQBCYkxI4ntNLaQgs4/+Gjs/2Zl/BScxQdeQatCauDn3hvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728763292; c=relaxed/simple;
	bh=L80+O0sp1idK5a/mB0HhVR0jRvSPn08cWKXRjUMNLSM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ovzYl0KvzLCx2qV7Bu4aAIhWY/dnB+BpnuDVby2HnPy481dEenqZD0O1TNK+xxL2xyAUvoGylQQitpP0iYNdPWw8q0A6Uaeu4w8or7gO1u41JcAIP3cytOz1/42FIwTcMk+0QTe5o1twPwK43IPqQxyNzHVxAVKifhPqOxjH/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=G+Nj+eUS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728763287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMzLkVtpuqhbfDhxMx/Dnmpxb8+f+kODoX6QtilGTB4=;
	b=G+Nj+eUSD5ppx1fw2MEZUoYdLD9HoMpDFs9qE3KdI5yPz5/qoKbjpXgi6cDvs5QaXcHrFS
	szGJWmVs7EcbUkhXNZHpJshjX4jQz5A80Q33FSAHeeQZ2dGARjPJJuwb9ztmAaGR6geu2M
	Yi2BqMbd8Qt/CkIB0AkDUaqc9jXangO7hzZbt3rKK4dtzQpTzXt8KWsBGobn5arVqa+mPO
	oFbyzV3FYSFaaotriGqdfU6JXr5gddmhwObssiKWxF4Hif0jls3WypAgLRybfp0RPKpT9u
	WQ4n8VuC9ztIlhp0NUtRuZLyFxPOJGGyHHTwS29JXsLB2OSCDIMb6Vf4dMxY9w==
Date: Sat, 12 Oct 2024 22:01:27 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Prepare RK356x SoC dtsi files
 for per-variant OPPs
In-Reply-To: <D4U30AUOH6UR.1QPH47KN5EWE4@cknow.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <cc2aed3116a57dd50e2bb15ab41b12784adfafe3.1728752527.git.dsimic@manjaro.org>
 <D4U30AUOH6UR.1QPH47KN5EWE4@cknow.org>
Message-ID: <e03fec2aa3bedb4710b27717cb2394df@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik,

On 2024-10-12 21:41, Diederik de Haas wrote:
> On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
>> Rename the Rockchip RK356x SoC dtsi files and, consequently, adjust 
>> their
>> contents appropriately, to prepare them for the ability to specify 
>> different
>> CPU and GPU OPPs for each of the supported RK356x SoC variants.
>> 
>> The first new RK356x SoC variant to be introduced is the RK3566T, 
>> which the
>> Pine64 Quartz64 Zero SBC is officially based on. [1]  Some other SBCs 
>> are
>> also based on the RK3566T variant, including Radxa ROCK 3C and ZERO 
>> 3E/3W,
>> but the slight trouble is that Radxa doesn't state that officially.  
>> Though,
>> it's rather easy to spot the RK3566T on such boards, because their 
>> official
>> specifications state that the maximum frequency for the Cortex-A55 
>> cores is
>> lower than the "full-fat" RK3566's 1.8 GHz. [2][3][4]
> 
> I think we changed terminology from "full-fat" to something else in the
> rk3588 variant? Would be nice to be consisten.

Back then, it was about the naming of one of the dtsi files, [*] not
about using "full-fat" in the commit description.  Using "full-fat"
in one of the file names was just part of the RFC, as a temporary
solution.  OTOH, frankly, I don't feel like using "full-fat" in this
commit description is inappropriate or inconsistent.

[*] 
https://lore.kernel.org/linux-rockchip/673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org/T/#u

>> These changes follow the approach used for the Rockchip RK3588 SoC 
>> variants,
>> which was introduced and described further in commit def88eb4d836 
>> ("arm64:
>> dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs").  
>> Please
>> see that commit for a more detailed explanation.
>> 
>> No functional changes are introduced, which was validated by 
>> decompiling and
> 
> No functional changes ...

This will be covered later in my response...

>> comparing all affected board dtb files before and after these changes. 
>>  In
>> more detail, the affected dtb files have some of their blocks shuffled 
>> around
>> a bit and some of their phandles have different values, as a result of 
>> the
>> changes to the order in which the building blocks from the parent dtsi 
>> files
>> are included, but they effectively remain the same as the originals.
>> 
>> [1] https://wiki.pine64.org/wiki/Quartz64
>> [2] 
>> https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
>> [3] 
>> https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
>> [4] 
>> https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
>> 
>> Related-to: def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC 
>> dtsi files for per-variant OPPs")
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>>  .../{rk3566.dtsi => rk3566-base.dtsi}         |   2 +-
>>  arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 116 
>> ++++++++++++++----
>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 114 +++++++++++++++--
>>  .../{rk356x.dtsi => rk356x-base.dtsi}         |  87 -------------
>>  4 files changed, 202 insertions(+), 117 deletions(-)
>>  copy arch/arm64/boot/dts/rockchip/{rk3566.dtsi => rk3566-base.dtsi} 
>> (95%)
>>  rename arch/arm64/boot/dts/rockchip/{rk356x.dtsi => rk356x-base.dtsi} 
>> (96%)
>> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
>> similarity index 95%
>> copy from arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> copy to arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
>> index 6c4b17d27bdc..e56e0b6ba941 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
>> @@ -1,6 +1,6 @@
>>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> 
>> -#include "rk356x.dtsi"
>> +#include "rk356x-base.dtsi"
>> 
>>  / {
>>  	compatible = "rockchip,rk3566";
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi 
>> b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> index 6c4b17d27bdc..3fcca79279f7 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> @@ -1,35 +1,107 @@
>>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> 
>> -#include "rk356x.dtsi"
>> +#include "rk3566-base.dtsi"
>> 
>>  / {
>> -	compatible = "rockchip,rk3566";
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
> 
> Just like with patch 1 of this series, drop the blank line?

I believe I've already explained the reasoning behind that. [**]

[**] 
https://lore.kernel.org/linux-rockchip/0a1f13d06ec3668c136997e72d0aea44@manjaro.org/

>> +
>> +		opp-1104000000 {
>> +			opp-hz = /bits/ 64 <1104000000>;
>> +			opp-microvolt = <900000 900000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1416000000 {
>> +			opp-hz = /bits/ 64 <1416000000>;
>> +			opp-microvolt = <1025000 1025000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1608000000 {
>> +			opp-hz = /bits/ 64 <1608000000>;
>> +			opp-microvolt = <1100000 1100000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <1150000 1150000 1150000>;
>> +			clock-latency-ns = <40000>;
>> +		};
>> +	};
>> +
>> +	gpu_opp_table: opp-table-1 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp-200000000 {
>> +			opp-hz = /bits/ 64 <200000000>;
>> +			opp-microvolt = <850000 850000 1000000>;
>> +		};
>> +
>> +		opp-300000000 {
>> +			opp-hz = /bits/ 64 <300000000>;
>> +			opp-microvolt = <850000 850000 1000000>;
>> +		};
>> +
>> +		opp-400000000 {
>> +			opp-hz = /bits/ 64 <400000000>;
>> +			opp-microvolt = <850000 850000 1000000>;
>> +		};
>> +
>> +		opp-600000000 {
>> +			opp-hz = /bits/ 64 <600000000>;
>> +			opp-microvolt = <900000 900000 1000000>;
>> +		};
>> +
>> +		opp-700000000 {
>> +			opp-hz = /bits/ 64 <700000000>;
>> +			opp-microvolt = <950000 950000 1000000>;
>> +		};
>> +
>> +		opp-800000000 {
>> +			opp-hz = /bits/ 64 <800000000>;
>> +			opp-microvolt = <1000000 1000000 1000000>;
>> +		};
>> +	};
>>  };
>> 
>> -&pipegrf {
>> -	compatible = "rockchip,rk3566-pipe-grf", "syscon";
> 
> This seems unrelated?

Yes, it looks completely out of place, but it's just the way this
diff ended up looking like.  It's actually fine.

>> +&cpu0 {
>> +	operating-points-v2 = <&cpu0_opp_table>;
>>  };
>> 
>> -&power {
>> -	power-domain@RK3568_PD_PIPE {
>> -		reg = <RK3568_PD_PIPE>;
>> -		clocks = <&cru PCLK_PIPE>;
>> -		pm_qos = <&qos_pcie2x1>,
>> -			 <&qos_sata1>,
>> -			 <&qos_sata2>,
>> -			 <&qos_usb3_0>,
>> -			 <&qos_usb3_1>;
>> -		#power-domain-cells = <0>;
>> -	};
> 
> This seems unrelated to me and possibly a functional change?
> If this was intended, then a description in the commit message would be
> nice why this is appropriate and possibly moved to a separate patch?

Just another instance of the diff ending up looking strange,
while there are actually no such changes.

>> +&cpu1 {
>> +	operating-points-v2 = <&cpu0_opp_table>;
>> +};
>> +
>> +&cpu2 {
>> +	operating-points-v2 = <&cpu0_opp_table>;
>>  };
>> 
>> -&usb_host0_xhci {
>> -	phys = <&usb2phy0_otg>;
>> -	phy-names = "usb2-phy";
>> -	extcon = <&usb2phy0>;
>> -	maximum-speed = "high-speed";
> 
> This also looks unrelated and a functional change?

Already explained above.

>> +&cpu3 {
>> +	operating-points-v2 = <&cpu0_opp_table>;
>>  };
>> 
>> -&vop {
>> -	compatible = "rockchip,rk3566-vop";
> 
> This also looks unrelated?

Already explained above.

