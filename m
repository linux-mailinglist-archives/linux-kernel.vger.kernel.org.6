Return-Path: <linux-kernel+bounces-425141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295239DBE10
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE65282059
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF081C7B6D;
	Thu, 28 Nov 2024 23:23:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6991DA23;
	Thu, 28 Nov 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836219; cv=none; b=hvFMyf7lIny6XWBNRyC1dNfpmVjsS8wQNGxYCQz9tCx0j2dPpwkRVNTnDz7Ke0JIaVyHWNCEQVDNULe/xi2jiCzwRx+fU2SAVyl+6S9DkG8oX6LIQ1G/361zIBd6xZgFLCcTTSpNbO53i/2DRhOBbDo2yNqDfUqnTnoIpOPkvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836219; c=relaxed/simple;
	bh=hHEcNzlmyMw9yeKuOWi7MOZ7zdWVNHImmRV0gxQkmms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Nu053CFI4v8T1GpVrxryDQnbK3HCRiFYxYce0vwcEX2ywIKgeVPGkzvHGK5t+qEMDksWiUvdJ3f4M+kronYPT8CphTt9LaRF8WEXQg4zQoGzza6kuQomTkRGtPTubfqRo8e9MMmExD9Yb1ryiBkmkW1U3AJb9qE8y9Q8ZWBwAHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C5391474;
	Thu, 28 Nov 2024 15:24:06 -0800 (PST)
Received: from [192.168.178.92] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5F83F66E;
	Thu, 28 Nov 2024 15:23:33 -0800 (PST)
Message-ID: <5b07cd47-868d-46a3-b365-ccac2a68b792@arm.com>
Date: Thu, 28 Nov 2024 23:23:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update H700 opp values
To: Philippe Simons <simons.philippe@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20241128154556.2743839-1-simons.philippe@gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
Cc: Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>
In-Reply-To: <20241128154556.2743839-1-simons.philippe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe,

thanks for taking care of sending a patch!
You would need prefixes on the subject line to point to the right 
subsystem. A "git log path/to/changed_file" would give you the prefix of 
previous patches, for you to copy from. In this case it would be:
arm64: dts: allwinner: h616: update H700 OPP values

On 28/11/2024 15:45, Philippe Simons wrote:
> My H700 (RG35XX-H, RG40XX-V and RG CubeXX) devices are very unstable,
> especially with some OPPs.
> Crashes were fairly easy to reproduce with any dynamic cpufreq governor
> and some load on CPU, usually in matter of minutes.
> Crashes manifested randomly as simply hanging or various kernel oops
> 
> Manufacturer (Anbernic) is using more conservative mircrovolt values,
> so let's use these.
> While using performance gov seems stables at 1.5Ghz, it still crashes
> using a dynamic gov (even with Andre reparenting patch), so let's drop
> it for now, like manufacturer does.
> 
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com

The change itself looks alright, bumping the OPP voltages by 50mV looks 
reasonable, and is a no-brainer if it stops the issues you have seen.

The loss of the 1.5GHz top OPP is a bummer, but stability comes 
definitely first, otherwise we will just fail faster ;-)

I would like to hear opinions from Ryan and Chris (both CC:ed). Did you 
see similar issues with say the ondemand governor?

The patch itself looks correct, so for that:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> index dd10aaf47..ac13fe169 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> @@ -50,24 +50,21 @@ opp-1008000000 {
>   			opp-microvolt-speed2 = <950000>;
>   			opp-microvolt-speed3 = <950000>;
>   			opp-microvolt-speed4 = <1020000>;
> -			opp-microvolt-speed5 = <900000>;
> +			opp-microvolt-speed5 = <950000>;
>   			clock-latency-ns = <244144>; /* 8 32k periods */
>   			opp-supported-hw = <0x3f>;
>   		};
>   
>   		opp-1032000000 {
>   			opp-hz = /bits/ 64 <1032000000>;
> -			opp-microvolt = <900000>;
> +			opp-microvolt = <950000>;
>   			clock-latency-ns = <244144>; /* 8 32k periods */
>   			opp-supported-hw = <0x20>;
>   		};
>   
>   		opp-1104000000 {
>   			opp-hz = /bits/ 64 <1104000000>;
> -			opp-microvolt-speed0 = <1000000>;
> -			opp-microvolt-speed2 = <1000000>;
> -			opp-microvolt-speed3 = <1000000>;
> -			opp-microvolt-speed5 = <950000>;
> +			opp-microvolt = <1000000>;			
>   			clock-latency-ns = <244144>; /* 8 32k periods */
>   			opp-supported-hw = <0x2d>;
>   		};
> @@ -79,7 +76,7 @@ opp-1200000000 {
>   			opp-microvolt-speed2 = <1050000>;
>   			opp-microvolt-speed3 = <1050000>;
>   			opp-microvolt-speed4 = <1100000>;
> -			opp-microvolt-speed5 = <1020000>;
> +			opp-microvolt-speed5 = <1050000>;
>   			clock-latency-ns = <244144>; /* 8 32k periods */
>   			opp-supported-hw = <0x3f>;
>   		};
> @@ -93,7 +90,10 @@ opp-1320000000 {
>   
>   		opp-1416000000 {
>   			opp-hz = /bits/ 64 <1416000000>;
> -			opp-microvolt = <1100000>;
> +			opp-microvolt-speed0 = <1100000>;
> +			opp-microvolt-speed2 = <1100000>;
> +			opp-microvolt-speed3 = <1100000>;
> +			opp-microvolt-speed5 = <1160000>;
>   			clock-latency-ns = <244144>; /* 8 32k periods */
>   			opp-supported-hw = <0x2d>;
>   		};
> @@ -102,9 +102,8 @@ opp-1512000000 {
>   			opp-hz = /bits/ 64 <1512000000>;
>   			opp-microvolt-speed1 = <1100000>;
>   			opp-microvolt-speed3 = <1100000>;
> -			opp-microvolt-speed5 = <1160000>;
>   			clock-latency-ns = <244144>; /* 8 32k periods */
> -			opp-supported-hw = <0x2a>;
> +			opp-supported-hw = <0x0a>;
>   		};
>   	};
>   };

