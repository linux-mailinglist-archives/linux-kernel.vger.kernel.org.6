Return-Path: <linux-kernel+bounces-520832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1FA3AFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C795616E566
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7182D91;
	Wed, 19 Feb 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studer.dev header.i=@studer.dev header.b="TBUdQCJW"
Received: from mail-b.studer.dev (mail-b.studer.dev [3.21.136.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A435977;
	Wed, 19 Feb 2025 03:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.21.136.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934164; cv=none; b=KJYNGC3vMYMcxdf4xrQqC7v0HP67cZZuG0uZ4kfduMXjZowAeDCLRbPKbZPCoc7ESzREJtF3Xp2RG5mnsMiy9I5IPSw6zJErdmev5Y0VeTcbUoVtCsxqDkIL2BC/+mogLZ3BxFUSbkPJPvS3GbxDRscX5gbqjMAZqS+buifOCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934164; c=relaxed/simple;
	bh=2F3LU4Eq0gKjABF4rvIZDq5JKefAkZzwch+Ft+j7CYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXm0bdssfR5+rZJqkSVECcC5PWiibAAUa4RX/s0xvR7nT/nuO5I2NeI7z5hlnId567pUkrB4/YuaYUoa18ETraYHY1BUdieXzcuONG//H1GobonOKKTR6mIbqF7DXtAU6pXU8OwHjLjvdG5Nm2b4G7hywtxoEVJD6VJt17eEBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=studer.dev; spf=pass smtp.mailfrom=studer.dev; dkim=pass (2048-bit key) header.d=studer.dev header.i=@studer.dev header.b=TBUdQCJW; arc=none smtp.client-ip=3.21.136.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=studer.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studer.dev
Received: from mail.studer.dev (mail.studer.dev [168.62.161.121])
	by mail-b.studer.dev (Postfix) with ESMTPSA id A4B6240047;
	Wed, 19 Feb 2025 03:02:35 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=studer.dev; s=hmail;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
	bh=qd6qp1+ybi0MHi3xmDnOya6FXacrtJVptDj7+jwoBCs=;
	b=TBUdQCJWM1Gle0QybTdOW2kMgDrTXfMtboFQ20aQBjD5bfSQ92pWUNYKTZk543HV67pnT5HyOk7RHFoJ7TY/TuN283Ir1ce2yv9ggDuX82NPctt/pcJPqDEPxwqddiOcb3jOZ3RUPFOUc1a3DVtiMlPWTNAGYEauGTyAEW1Wc4g+NrrFoIZpgBsF60kybfL8NuxTaQmGRK7herpMtN/sHiFQQ/sNcpwdyNhynrpWFyaKLamRbdFJVKpUTS
	vuZ7QUXTeIrE2qfQ03Lqpd5iwNtB5QXas5632DTZ+nByQd07N1mcMjTnNEZy7zZrUSYXVoRiaWH8gHkRqZi7MKgspVMw==
Received: from [192.168.1.166] (pool-68-239-44-167.bstnma.fios.verizon.net [68.239.44.167])
	by mail.studer.dev with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128)
	; Wed, 19 Feb 2025 03:02:33 +0000
Message-ID: <56fe8762-5b05-4b41-b7fd-f08f35012ba9@studer.dev>
Date: Tue, 18 Feb 2025 22:02:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Add CPU thermal sensor and
 zone
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250218020629.1476126-1-alex@studer.dev>
 <4628970.LvFx2qVVIh@jernej-laptop>
From: Alex Studer <alex@studer.dev>
Content-Language: en-US
In-Reply-To: <4628970.LvFx2qVVIh@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 12:23 PM, Jernej Škrabec wrote:
> Dne torek, 18. februar 2025 ob 03:06:29 Srednjeevropski standardni čas je Alex Studer napisal(a):
>> The sun20i THS (built in CPU thermal sensor) is supported in code, but
>> was never added to the device tree. So, add it to the device tree,
>> along with a thermal zone for the CPU.
>>
>> Signed-off-by: Alex Studer <alex@studer.dev>
>> ---
>>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 31 +++++++++++++++++++
>>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 16 ++++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>> index 6367112e6..bdde82aa8 100644
>> --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>> +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>> @@ -3,6 +3,8 @@
>>  
>>  #define SOC_PERIPHERAL_IRQ(nr)	(nr + 16)
>>  
>> +#include <dt-bindings/thermal/thermal.h>
> Put above line on top (before SOC_PERIPHERAL_IRQ()).
Will fix in v2.
>> +
>>  #include "sunxi-d1s-t113.dtsi"
>>  
>>  / {
>> @@ -115,4 +117,33 @@ pmu {
>>  			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
>>  			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
>>  	};
>> +
>> +	thermal-zones {
>> +		cpu-thermal {
>> +			polling-delay-passive = <0>;
>> +			polling-delay = <0>;
>> +			thermal-sensors = <&ths>;
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu_alert>;
>> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>> +			trips {
>> +				cpu_alert: cpu-alert {
>> +					temperature = <85000>;
>> +					hysteresis = <2000>;
>> +					type = "passive";
>> +				};
>> +
>> +				cpu-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <0>;
>> +					type = "critical";
>> +				};
> Where do those limits come from?
I took them from the definitions in
arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi, which is what I generally
based this patch on. I checked the D1s datasheet and it does specify a
max "Ambient Operating Temperature" of 70 C and a max "Working Junction
Temperature Range" of 110 C. So I could use those, but the dtsi files
for the other sunxi chips don't seem to follow their respective
datasheets, so I wasn't sure what to do here.
>> +			};
>> +		};
>> +	};
>>  };
>> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>> index e4175adb0..fcfcaf06c 100644
>> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
>> @@ -426,6 +426,10 @@ sid: efuse@3006000 {
>>  			reg = <0x3006000 0x1000>;
>>  			#address-cells = <1>;
>>  			#size-cells = <1>;
>> +
>> +			ths_calibration: thermal-sensor-calibration@14 {
>> +				reg = <0x14 0x8>;
>> +			};
>>  		};
>>  
>>  		crypto: crypto@3040000 {
>> @@ -934,5 +938,17 @@ rtc: rtc@7090000 {
>>  			clock-names = "bus", "hosc", "ahb";
>>  			#clock-cells = <1>;
>>  		};
>> +
>> +		ths: thermal-sensor@2009400 {
>> +			compatible = "allwinner,sun20i-d1-ths";
>> +			reg = <0x2009400 0x100>;
> Size should be 0x400.
Will fix in v2.
>
> Best regards,
> Jernej

Thanks,
Alex

>
>> +			interrupts = <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_THS>;
>> +			clock-names = "bus";
>> +			resets = <&ccu RST_BUS_THS>;
>> +			nvmem-cells = <&ths_calibration>;
>> +			nvmem-cell-names = "calibration";
>> +			#thermal-sensor-cells = <0>;
>> +		};
>>  	};
>>  };
>>
>
>
>


