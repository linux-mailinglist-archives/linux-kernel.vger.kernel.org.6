Return-Path: <linux-kernel+bounces-423505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF9A9DA890
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FF81624DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E11FCF73;
	Wed, 27 Nov 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g4z+tzqW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FC5B1FB;
	Wed, 27 Nov 2024 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714490; cv=none; b=LPaCarnK0K/UUSHdcNZjrw1iG9SV8+4rrgLJJ80f9DY7SqiDpHVRJznx/uswa1ErJkPt8CboI29JILhJmTjP+uEhsHF7cLsOIfITdnS+EVgAYwp8dFRDUzV/l8yN1YZDa9WcIKpYsKLQ6w0ApZJ32HEqfe6ooHVYye6PMf9rNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714490; c=relaxed/simple;
	bh=O5oYtOeSE4rI0DjNjJKhJIfR3k7dbcgXA3hmMsI7WCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFgJvdxMo4Rp7nOJlMomHUQFR0dVWcbCVybaJlRP3Co3+C265Fv3QzMM7PeTVC1232XOICeiG1OjEa7oqQEoj7Kj1xgoeyC+lclzrhHFjsxgULfwLlVxX0FHtRh2o5J1kEoq7KlKUlBJuIcqbq5+op7BnybnWx8rATcJoTVsMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g4z+tzqW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732714487;
	bh=O5oYtOeSE4rI0DjNjJKhJIfR3k7dbcgXA3hmMsI7WCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g4z+tzqWqcWJhUP9AcGj0/fS1Om5bDHKaAIoWhb1WVhTla7N1+Dsxubp2x09mrslt
	 /q8eTuAOnJMTozWOrZIPD1BVqUE3adTUg9R4DtrJ0beOjFvE8zNjBWlk1asvdGclJ8
	 2U1xUDQBwX7NV4w6V6hivvtYbn9ZBRlFfUPX58l/HDWOzdMW5cZHHRVrL1R0D0D9zL
	 oSV83Q3SWPEs2/YGhK+EqOaoKaf24prwNu74spAKjIQKIbdTPJF5aJUwl/QYvsTLd2
	 f74+VtnsdZNQClWS/PxXwnPZ7WA10QzPKBkNiYFns4vlsxk5vWttJFhShQ6gBbefht
	 4avz03QcKj46A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C3B517E3700;
	Wed, 27 Nov 2024 14:34:46 +0100 (CET)
Message-ID: <6660a681-c02a-443a-a1f2-14af5b4477eb@collabora.com>
Date: Wed, 27 Nov 2024 14:34:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 14/14] arm64: dts: mediatek: mt7988: add operating-points
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241029103937.45852-1-linux@fw-web.de>
 <20241029103937.45852-15-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241029103937.45852-15-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/10/24 11:39, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add operating points defining frequency/voltages of cpu cores.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 45 +++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index e037854666c1..25669d498617 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -16,32 +16,69 @@ cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> -		cpu@0 {
> +		cpu0: cpu@0 {

Where are those cpuX labels used? I don't see any usage.

>   			compatible = "arm,cortex-a73";
>   			reg = <0x0>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
> +				 <&topckgen CLK_TOP_XTAL>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
>   		};
>   
> -		cpu@1 {
> +		cpu1: cpu@1 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x1>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
> +				 <&topckgen CLK_TOP_XTAL>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
>   		};
>   
> -		cpu@2 {
> +		cpu2: cpu@2 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x2>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
> +				 <&topckgen CLK_TOP_XTAL>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
>   		};
>   
> -		cpu@3 {
> +		cpu3: cpu@3 {
>   			compatible = "arm,cortex-a73";
>   			reg = <0x3>;
>   			device_type = "cpu";
>   			enable-method = "psci";
> +			clocks = <&mcusys CLK_MCU_ARM_DIV_SEL>,
> +				 <&topckgen CLK_TOP_XTAL>;
> +			clock-names = "cpu", "intermediate";
> +			operating-points-v2 = <&cluster0_opp>;
> +		};
> +
> +		cluster0_opp: opp-table-0 {
> +			compatible = "operating-points-v2";
> +			opp-shared;
> +			opp00 {

...But you can also be consistent with other devicetrees and follow the pattern
for the node names of the OPP entries.

opp-800000000
opp-1100000000
...etc

Cheers,
Angelo

> +				opp-hz = /bits/ 64 <800000000>;
> +				opp-microvolt = <850000>;
> +			};
> +			opp01 {
> +				opp-hz = /bits/ 64 <1100000000>;
> +				opp-microvolt = <850000>;
> +			};
> +			opp02 {
> +				opp-hz = /bits/ 64 <1500000000>;
> +				opp-microvolt = <850000>;
> +			};
> +			opp03 {
> +				opp-hz = /bits/ 64 <1800000000>;
> +				opp-microvolt = <900000>;
> +			};
>   		};
>   	};
>   



