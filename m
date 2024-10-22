Return-Path: <linux-kernel+bounces-377121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273EB9ABA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4961F23AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF261CEAB5;
	Tue, 22 Oct 2024 23:30:56 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EA19CC17;
	Tue, 22 Oct 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639855; cv=none; b=Fc8/UTkx+DtIpUHf95HcvGKf0rQ4sMjBRxkuvoXN3IJvtZ/m03IjsqK3YX5hEWCTLUvbfrlIgszVVwsldiRB23G8FezI1ltE/1evVUX8VddPmKYJGtB02Hi1ujp9FuaLrMiRVegOT4+Vy2o4NHmqbjnhzuORby9P3z5W0lD0E5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639855; c=relaxed/simple;
	bh=3o0Q1NRy2o/cdZfGKiKydob/soTt3l+zr6Ivj0/0PiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwiEDwXc+sbvehjGc1V8fx19DT0W5qGP/lDysfhlzHoJnB1SXnH06CR7H7IluEHvweHmd5oVOitrBzMM19BDkxvcONDYm/s6Qtvou9kBa0RHenGrv6khRhFOuXNPAlwvVBQlq7a8PPAZ/3TrkRpslTpPLYCBdukJuGE2JlKHmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1729639831tliqsfj
X-QQ-Originating-IP: 0/DcOEYPZguikRtnu/sJNedCkil5KiU4+s0+y6B+8K0=
Received: from [IPV6:240f:10b:7440:1:c796:8e4d ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Oct 2024 07:30:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14738271466555509775
Message-ID: <1663957A755BE820+acc57e45-954f-4b33-90fb-47f97815db96@radxa.com>
Date: Wed, 23 Oct 2024 08:30:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add new SoC dtsi for the
 RK3566T variant
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, TL Lim <tllim@pine64.org>,
 Marek Kraus <gamiee@pine64.org>, Tom Cubie <tom@radxa.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <95fc64aaf6d3ac7124926bcb0c664406b4e5fe3d.1728752527.git.dsimic@manjaro.org>
 <CE605641E53903DC+0f0ea6b2-9423-4aa2-ac9d-652a9ac5c237@radxa.com>
 <ce54f171dfb145ce85d9a0192562e174@manjaro.org>
 <850ad8c6645b4c54bcecb7df79f9ab3a@manjaro.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <850ad8c6645b4c54bcecb7df79f9ab3a@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQI66KMdBntWcI6zpKnKgys7HXA8EtU0nKCcd0wDBRHDfrPZuJAMUzlu
	jQ9c4TcVYeDeW3Hs8t1bko73UORUx4C2pbzqmnFINSh2Z2fN7a7uTbn6qRkdKu2PPepHyXK
	0npxqnS5CY0A8/IocXFmYSdnUrTqLZFE7MoVBxv4meLFLKOpM0X1dRjUl9Pt7fjFE9iNE8p
	R6ErI1d73gRgwOka1+//64b3oEw+hBxs88y7A4Mm6vcCO9k67QlLDyyPjjYgDyIvC79MGjN
	kXDRRQmITKHfJlYJHr8oxLyhofXj+Rha8BLq72je3kva5fYVl0Hhcj+gRKRRg69bxC5j7pW
	rDWgh/EzEk9zUF9Tvxdb+O6Rg6r8/JWf8O+uP49H7gNnBb7YeCAuc3OT7E3L+5S/jYapVKF
	tQEwg8auyee4fpsBGC/2/ggBXzoXR+YFqiO+fPa3Lk8WxnTexjLsA4Vuw7+yG03ntfcmM9q
	rGrXh7ZahsdfRz5leF1HSAn8wQFQZb0DYAgvpF8LyHgO4ImYVDaXPyrHpMEufGLMfMWgTxx
	o3gLtVPq1Vc3LtlFjWQrgsCzJUU09/ZYgXWP5PZ5oA6qrMo2b0OQk+d4h9MO5xaG93I2m78
	vSF19mReXMe8ye5pTv5VZG2CMOoCa3GTKigDiItUhcOu6C6gCPmi8VWP2ks9Y2tcKDvy/0V
	KBFOlqEaWXbLKIRyRBX2u02ROIYlyKVrpMMCu9MHyugEONbS/kygrM92833Yb6m3mjVJ5Oa
	WzJ+zc1eiFMr4l2GtkWzcX7OT/uIOZ9A0dCXqFd4rlgAGOw+io6nLmw3SLisJDvROazLTb9
	Jp58XsojEWNiItOPsfTLWYToGTokQw97ZPY2ESgNjP5es+rZdd2+cf2eQ5cgEVRjNJx5IP6
	hAfqOHk33hQfPPVI9nkdkXzoV/4d4epcKXj8GJ0wpZHMjW/CLtK9rB3grObB5qq8hVCVBWs
	6OEY=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Dragan Simic,

On 10/23/24 05:13, Dragan Simic wrote:
> Hello Fukaumi and Tom,
> 
> On 2024-10-14 07:16, Dragan Simic wrote:
>> On 2024-10-14 06:38, FUKAUMI Naoki wrote:
>>> On 10/13/24 02:04, Dragan Simic wrote:
>>>> Add new SoC dtsi file for the RK3566T variant of the Rockchip RK3566 
>>>> SoC.
>>>> The difference between the RK3566T variant and the "full-fat" RK3566 
>>>> variant
>>>> is in fewer supported CPU and GPU OPPs on the RK3566T, and in the 
>>>> absence of
>>>> a functional NPU, which we currently don't have to worry about.
>>>>
>>>> Examples of the boards based on the RK3566T include the Pine64 
>>>> Quartz64 Zero
>>>> SBC, [2] the Radxa ROCK 3C and the Radxa ZERO 3E/3W SBCs. 
>>>> Unfortunately,
>>>> Radxa doesn't mention the use of RK3566T officially, but its 
>>>> official SBC
>>>> specifications do state that the maximum frequency for the 
>>>> Cortex-A55 cores
>>>> on those SBCs is lower than the "full-fat" RK3566's 1.8 GHz, which 
>>>> makes
>>>> spotting the presence of the RK3566T SoC variant rather easy. 
>>>> [3][4][5]  An
>>>> additional, helpful cue is that Radxa handles the CPU and GPU OPPs 
>>>> for the
>>>> RK3566T variant separately in its downstream kernel. [6]
>>>>
>>>> The CPU and GPU OPPs supported on the RK3566T SoC variant are taken 
>>>> from the
>>>> vendor kernel source, [1] which uses the values of the 
>>>> "opp-supported-hw" OPP
>>>> properties to determine which ones are supported on a particular SoC 
>>>> variant.
>>>> The actual values of the "opp-supported-hw" properties make it 
>>>> rather easy
>>>> to see what OPPs are supported on the RK3566T SoC variant, but that, 
>>>> rather
>>>> unfortunately, clashes with the maximum frequencies advertised 
>>>> officially
>>>> for the Cortex-A55 CPU cores on the above-mentioned SBCs. 
>>>> [2][3][4][5]  The
>>>> vendor kernel source indicates that the maximum frequency for the 
>>>> CPU cores
>>>> is 1.4 GHz, while the SBC specifications state that to be 1.6 GHz. 
>>>> Unless
>>>> that discrepancy is resolved somehow, let's take the safe approach 
>>>> and use
>>>> the lower maximum frequency for the CPU cores.
>>>>
>>>> Update the dts files of the currently supported RK3566T-based boards 
>>>> to use
>>>> the new SoC dtsi for the RK3566T variant.  This actually takes the 
>>>> CPU cores
>>>> and the GPUs found on these boards out of their earlier overclocks, 
>>>> but it
>>>> also means that the officially advertised specifications 
>>>> [2][3][4][5] of the
>>>> highest supported frequencies for the Cortex-A55 CPU cores on these 
>>>> boards
>>>> may actually be wrong, as already explained above.
>>>>
>>>> The correctness of the introduced changes was validated by 
>>>> decompiling and
>>>> comparing all affected board dtb files before and after these changes.
>>>>
>>>> [1] 
>>>> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>>>> [2] https://wiki.pine64.org/wiki/Quartz64
>>>> [3] 
>>>> https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
>>>> [4] 
>>>> https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
>>>> [5] 
>>>> https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
>>>> [6] 
>>>> https://github.com/radxa/kernel/commit/2dfd51da472e7ebb5ef0d3db78f902454af826b8
>>>>
>>>> Cc: TL Lim <tllim@pine64.org>
>>>> Cc: Marek Kraus <gamiee@pine64.org>
>>>> Cc: Tom Cubie <tom@radxa.com>
>>>> Cc: FUKAUMI Naoki <naoki@radxa.com>
>>>> Helped-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>>> Helped-by: Jonas Karlman <jonas@kwiboo.se>
>>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>>> ---
>>>>   .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |  2 +-
>>>>   .../boot/dts/rockchip/rk3566-rock-3c.dts      |  2 +-
>>>>   arch/arm64/boot/dts/rockchip/rk3566t.dtsi     | 90 
>>>> +++++++++++++++++++
>>>>   3 files changed, 92 insertions(+), 2 deletions(-)
>>>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi 
>>>> b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
>>>> index de390d92c35e..1ee5d96a46a1 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
>>>> @@ -3,7 +3,7 @@
>>>>   #include <dt-bindings/gpio/gpio.h>
>>>>   #include <dt-bindings/leds/common.h>
>>>>   #include <dt-bindings/soc/rockchip,vop2.h>
>>>> -#include "rk3566.dtsi"
>>>> +#include "rk3566t.dtsi"
>>>
>>> could you drop this change for now?
>>
>> This patch is also going to be used for the upcoming board dts
>> for the Pine64 Quartz64 Zero, so there's no need for dropping it.
>> The Quartz64 Zero definitely uses the RK3566T.
>>
>>> We (Radxa) think we use RK3566.
>>
>> Well, the available documentation for the Radxa ROCK 3C and ZERO
>> 3E/3W boards doesn't say so; instead, everything points to the
>> RK3566T being used.  The referenced commit in the Radxa downstream
>> kernel also indicates that RK3566T is used at least on some boards.
>>
>> Also, some independent testing, by reading the efuses, has showed
>> that at least some ROCK 3C and ZERO 3E/3W boards actually have the
>> RK3566T, which means that we should handle them all as having the
>> RK3566T, to avoid overclocking the CPU cores and the GPU.  I'll
>> get back to this below.
>>
>>> and vendor kernel[6] refers efuse value to determine it's -T or not.
>>> can you do similar way?
>>
>> Unfortunately not at the moment, because that would require major
>> changes to the way OPPs are handled in the upstream kernel.  Maybe
>> we can do that at some point in the future, as part of my planned
>> work on supporting SoC binning.
>>
>> With that in place, hopefully, we could handle any ROCK 3C and ZERO
>> 3E/3W boards that actually have the "full-fat" RK3566 variant as
>> such, but until then, it's much safer to treat them all as having
>> the RK3566T, and avoid the possible overclocking.
> 
> Just checking, and having the subsequent discussion on IRC in mind,
> are you fine with the above-proposed approach?  Please let me know
> if some further clarification is needed.

we have no objection. please do safer way.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>>>>   / {
>>>>       chosen {
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts 
>>>> b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
>>>> index f2cc086e5001..9a8f4f774dbc 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
>>>> @@ -5,7 +5,7 @@
>>>>   #include <dt-bindings/leds/common.h>
>>>>   #include <dt-bindings/pinctrl/rockchip.h>
>>>>   #include <dt-bindings/soc/rockchip,vop2.h>
>>>> -#include "rk3566.dtsi"
>>>> +#include "rk3566t.dtsi"
>>>
>>> same here.
>>>
>>>>   / {
>>>>       model = "Radxa ROCK 3C";
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566t.dtsi 
>>>> b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>>>> new file mode 100644
>>>> index 000000000000..cd89bd3b125b
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>>>> @@ -0,0 +1,90 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +
>>>> +#include "rk3566-base.dtsi"
>>>> +
>>>> +/ {
>>>> +    cpu0_opp_table: opp-table-0 {
>>>> +        compatible = "operating-points-v2";
>>>> +        opp-shared;
>>>> +
>>>> +        opp-408000000 {
>>>> +            opp-hz = /bits/ 64 <408000000>;
>>>> +            opp-microvolt = <850000 850000 1150000>;
>>>> +            clock-latency-ns = <40000>;
>>>> +        };
>>>> +
>>>> +        opp-600000000 {
>>>> +            opp-hz = /bits/ 64 <600000000>;
>>>> +            opp-microvolt = <850000 850000 1150000>;
>>>> +            clock-latency-ns = <40000>;
>>>> +        };
>>>> +
>>>> +        opp-816000000 {
>>>> +            opp-hz = /bits/ 64 <816000000>;
>>>> +            opp-microvolt = <850000 850000 1150000>;
>>>> +            clock-latency-ns = <40000>;
>>>> +            opp-suspend;
>>>> +        };
>>>> +
>>>> +        opp-1104000000 {
>>>> +            opp-hz = /bits/ 64 <1104000000>;
>>>> +            opp-microvolt = <900000 900000 1150000>;
>>>> +            clock-latency-ns = <40000>;
>>>> +        };
>>>> +
>>>> +        opp-1416000000 {
>>>> +            opp-hz = /bits/ 64 <1416000000>;
>>>> +            opp-microvolt = <1025000 1025000 1150000>;
>>>> +            clock-latency-ns = <40000>;
>>>> +        };
>>>> +    };
>>>> +
>>>> +    gpu_opp_table: opp-table-1 {
>>>> +        compatible = "operating-points-v2";
>>>> +
>>>> +        opp-200000000 {
>>>> +            opp-hz = /bits/ 64 <200000000>;
>>>> +            opp-microvolt = <850000 850000 1000000>;
>>>> +        };
>>>> +
>>>> +        opp-300000000 {
>>>> +            opp-hz = /bits/ 64 <300000000>;
>>>> +            opp-microvolt = <850000 850000 1000000>;
>>>> +        };
>>>> +
>>>> +        opp-400000000 {
>>>> +            opp-hz = /bits/ 64 <400000000>;
>>>> +            opp-microvolt = <850000 850000 1000000>;
>>>> +        };
>>>> +
>>>> +        opp-600000000 {
>>>> +            opp-hz = /bits/ 64 <600000000>;
>>>> +            opp-microvolt = <900000 900000 1000000>;
>>>> +        };
>>>> +
>>>> +        opp-700000000 {
>>>> +            opp-hz = /bits/ 64 <700000000>;
>>>> +            opp-microvolt = <950000 950000 1000000>;
>>>> +        };
>>>> +    };
>>>> +};
>>>> +
>>>> +&cpu0 {
>>>> +    operating-points-v2 = <&cpu0_opp_table>;
>>>> +};
>>>> +
>>>> +&cpu1 {
>>>> +    operating-points-v2 = <&cpu0_opp_table>;
>>>> +};
>>>> +
>>>> +&cpu2 {
>>>> +    operating-points-v2 = <&cpu0_opp_table>;
>>>> +};
>>>> +
>>>> +&cpu3 {
>>>> +    operating-points-v2 = <&cpu0_opp_table>;
>>>> +};
>>>> +
>>>> +&gpu {
>>>> +    operating-points-v2 = <&gpu_opp_table>;
>>>> +};
> 

