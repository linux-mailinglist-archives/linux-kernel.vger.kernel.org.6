Return-Path: <linux-kernel+bounces-362601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE999B6C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 21:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB71F21D1D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81AD152160;
	Sat, 12 Oct 2024 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="A6wN9CqB"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589D4EB38
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762085; cv=none; b=eDsoyZSU5IscCmiuA/zrdb8upz+lUZ2cHdb6OGuqBC6+GsiR+sJqysvxEwrgTMkv2xFIDYFwSVhw6mBD7VoVbk8sH4dozk8zYWZC3g6VStfL0M9NKYATlBYFAhs3ofGMopkAkxvt9dJQBxnLEGTX5nhlLTAd5r+KWWuVW/3bjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762085; c=relaxed/simple;
	bh=B+yLUaic7dpm1O0TFxZwdOCFuRltV9gtPivB0VEI3/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MoaxNBWpP6jqENXAVR7FrAd9XOMgAskrGuOUPvv4xkOvOk1dI2dUzbnznvSknpo25AzZH15jMNBYEWugoyHVidDgvBjrEy5Jga5Ewme0EEvIJEbq7WAcJ9owCtdn00R6b4xUFglVtQq19wfih9+NURhMcpgkS9UTnBIdMx7z3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=A6wN9CqB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728762080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UO3j/GOAOSD8wyZvMkmDxShNf5vExBkrilFxmG3hn+8=;
	b=A6wN9CqBVPFaWy8FtfOrLRTdDPmD+ksJakOTrSGhVv0HR27+JJ6fNKXKYi+rlTUNPG+Irj
	9dHjHh2xJlnXLNG0xkQA0qMHRJRIpoLlDUwJ+njK8xhM4BqwBXe6C2+R1DqPP/SV/Cf46X
	awEWTVFRX1/bd6W5bWKWKEE9C5+dBYepX+DdJEtkqT/zFY3JkqpyykcSWzT8IMPZLRuVL8
	Y1yHGQqDO6c7+eush5qc6cgNvH3ydsf/CluqRCh+7rfw0z0+ScR0k7VuI34zU1Skg2tJ0A
	6Atws2iWgPPMtXTbXJXa+P9mv7WU38VA0SdVyrjtjYDonMQzHaB7fKll/fjWIw==
Content-Type: multipart/signed;
 boundary=61fb12ab53aa8895f52b41f4f9fca6bd16aa98e69df586cfe9f98b2bb65f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 12 Oct 2024 21:41:09 +0200
Message-Id: <D4U30AUOH6UR.1QPH47KN5EWE4@cknow.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Prepare RK356x SoC dtsi files
 for per-variant OPPs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <cc2aed3116a57dd50e2bb15ab41b12784adfafe3.1728752527.git.dsimic@manjaro.org>
In-Reply-To: <cc2aed3116a57dd50e2bb15ab41b12784adfafe3.1728752527.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--61fb12ab53aa8895f52b41f4f9fca6bd16aa98e69df586cfe9f98b2bb65f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
> Rename the Rockchip RK356x SoC dtsi files and, consequently, adjust their
> contents appropriately, to prepare them for the ability to specify differ=
ent
> CPU and GPU OPPs for each of the supported RK356x SoC variants.
>
> The first new RK356x SoC variant to be introduced is the RK3566T, which t=
he
> Pine64 Quartz64 Zero SBC is officially based on. [1]  Some other SBCs are
> also based on the RK3566T variant, including Radxa ROCK 3C and ZERO 3E/3W=
,
> but the slight trouble is that Radxa doesn't state that officially.  Thou=
gh,
> it's rather easy to spot the RK3566T on such boards, because their offici=
al
> specifications state that the maximum frequency for the Cortex-A55 cores =
is
> lower than the "full-fat" RK3566's 1.8 GHz. [2][3][4]

I think we changed terminology from "full-fat" to something else in the
rk3588 variant? Would be nice to be consisten.

> These changes follow the approach used for the Rockchip RK3588 SoC varian=
ts,
> which was introduced and described further in commit def88eb4d836 ("arm64=
:
> dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs").  Ple=
ase
> see that commit for a more detailed explanation.
>
> No functional changes are introduced, which was validated by decompiling =
and

No functional changes ...

> comparing all affected board dtb files before and after these changes.  I=
n
> more detail, the affected dtb files have some of their blocks shuffled ar=
ound
> a bit and some of their phandles have different values, as a result of th=
e
> changes to the order in which the building blocks from the parent dtsi fi=
les
> are included, but they effectively remain the same as the originals.
>
> [1] https://wiki.pine64.org/wiki/Quartz64
> [2] https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
> [3] https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
> [4] https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
>
> Related-to: def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi =
files for per-variant OPPs")
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  .../{rk3566.dtsi =3D> rk3566-base.dtsi}         |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 116 ++++++++++++++----
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 114 +++++++++++++++--
>  .../{rk356x.dtsi =3D> rk356x-base.dtsi}         |  87 -------------
>  4 files changed, 202 insertions(+), 117 deletions(-)
>  copy arch/arm64/boot/dts/rockchip/{rk3566.dtsi =3D> rk3566-base.dtsi} (9=
5%)
>  rename arch/arm64/boot/dts/rockchip/{rk356x.dtsi =3D> rk356x-base.dtsi} =
(96%)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3566-base.dtsi
> similarity index 95%
> copy from arch/arm64/boot/dts/rockchip/rk3566.dtsi
> copy to arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
> index 6c4b17d27bdc..e56e0b6ba941 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> =20
> -#include "rk356x.dtsi"
> +#include "rk356x-base.dtsi"
> =20
>  / {
>  	compatible =3D "rockchip,rk3566";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3566.dtsi
> index 6c4b17d27bdc..3fcca79279f7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
> @@ -1,35 +1,107 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> =20
> -#include "rk356x.dtsi"
> +#include "rk3566-base.dtsi"
> =20
>  / {
> -	compatible =3D "rockchip,rk3566";
> +	cpu0_opp_table: opp-table-0 {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <850000 850000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <850000 850000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-816000000 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <850000 850000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +			opp-suspend;
> +		};

Just like with patch 1 of this series, drop the blank line?

> +
> +		opp-1104000000 {
> +			opp-hz =3D /bits/ 64 <1104000000>;
> +			opp-microvolt =3D <900000 900000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz =3D /bits/ 64 <1416000000>;
> +			opp-microvolt =3D <1025000 1025000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1608000000 {
> +			opp-hz =3D /bits/ 64 <1608000000>;
> +			opp-microvolt =3D <1100000 1100000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1800000000 {
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +			opp-microvolt =3D <1150000 1150000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +	};
> +
> +	gpu_opp_table: opp-table-1 {
> +		compatible =3D "operating-points-v2";
> +
> +		opp-200000000 {
> +			opp-hz =3D /bits/ 64 <200000000>;
> +			opp-microvolt =3D <850000 850000 1000000>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz =3D /bits/ 64 <300000000>;
> +			opp-microvolt =3D <850000 850000 1000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz =3D /bits/ 64 <400000000>;
> +			opp-microvolt =3D <850000 850000 1000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <900000 900000 1000000>;
> +		};
> +
> +		opp-700000000 {
> +			opp-hz =3D /bits/ 64 <700000000>;
> +			opp-microvolt =3D <950000 950000 1000000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz =3D /bits/ 64 <800000000>;
> +			opp-microvolt =3D <1000000 1000000 1000000>;
> +		};
> +	};
>  };
> =20
> -&pipegrf {
> -	compatible =3D "rockchip,rk3566-pipe-grf", "syscon";

This seems unrelated?

> +&cpu0 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
>  };
> =20
> -&power {
> -	power-domain@RK3568_PD_PIPE {
> -		reg =3D <RK3568_PD_PIPE>;
> -		clocks =3D <&cru PCLK_PIPE>;
> -		pm_qos =3D <&qos_pcie2x1>,
> -			 <&qos_sata1>,
> -			 <&qos_sata2>,
> -			 <&qos_usb3_0>,
> -			 <&qos_usb3_1>;
> -		#power-domain-cells =3D <0>;
> -	};

This seems unrelated to me and possibly a functional change?
If this was intended, then a description in the commit message would be
nice why this is appropriate and possibly moved to a separate patch?

> +&cpu1 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
>  };
> =20
> -&usb_host0_xhci {
> -	phys =3D <&usb2phy0_otg>;
> -	phy-names =3D "usb2-phy";
> -	extcon =3D <&usb2phy0>;
> -	maximum-speed =3D "high-speed";

This also looks unrelated and a functional change?

> +&cpu3 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
>  };
> =20
> -&vop {
> -	compatible =3D "rockchip,rk3566-vop";

This also looks unrelated?

Cheers,
  Diederik

> +&gpu {
> +	operating-points-v2 =3D <&gpu_opp_table>;
>  };
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3568.dtsi
> index 5c54898f6ed1..ecaefe208e3e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -3,11 +3,99 @@
>   * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
>   */
> =20
> -#include "rk356x.dtsi"
> +#include "rk356x-base.dtsi"
> =20
>  / {
>  	compatible =3D "rockchip,rk3568";
> =20
> +	cpu0_opp_table: opp-table-0 {
> +		compatible =3D "operating-points-v2";
> +		opp-shared;
> +
> +		opp-408000000 {
> +			opp-hz =3D /bits/ 64 <408000000>;
> +			opp-microvolt =3D <850000 850000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <850000 850000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-816000000 {
> +			opp-hz =3D /bits/ 64 <816000000>;
> +			opp-microvolt =3D <850000 850000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +			opp-suspend;
> +		};
> +
> +		opp-1104000000 {
> +			opp-hz =3D /bits/ 64 <1104000000>;
> +			opp-microvolt =3D <900000 900000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1416000000 {
> +			opp-hz =3D /bits/ 64 <1416000000>;
> +			opp-microvolt =3D <1025000 1025000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1608000000 {
> +			opp-hz =3D /bits/ 64 <1608000000>;
> +			opp-microvolt =3D <1100000 1100000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1800000000 {
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +			opp-microvolt =3D <1150000 1150000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +
> +		opp-1992000000 {
> +			opp-hz =3D /bits/ 64 <1992000000>;
> +			opp-microvolt =3D <1150000 1150000 1150000>;
> +			clock-latency-ns =3D <40000>;
> +		};
> +	};
> +
> +	gpu_opp_table: opp-table-1 {
> +		compatible =3D "operating-points-v2";
> +
> +		opp-200000000 {
> +			opp-hz =3D /bits/ 64 <200000000>;
> +			opp-microvolt =3D <850000 850000 1000000>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz =3D /bits/ 64 <300000000>;
> +			opp-microvolt =3D <850000 850000 1000000>;
> +		};
> +
> +		opp-400000000 {
> +			opp-hz =3D /bits/ 64 <400000000>;
> +			opp-microvolt =3D <850000 850000 1000000>;
> +		};
> +
> +		opp-600000000 {
> +			opp-hz =3D /bits/ 64 <600000000>;
> +			opp-microvolt =3D <900000 900000 1000000>;
> +		};
> +
> +		opp-700000000 {
> +			opp-hz =3D /bits/ 64 <700000000>;
> +			opp-microvolt =3D <950000 950000 1000000>;
> +		};
> +
> +		opp-800000000 {
> +			opp-hz =3D /bits/ 64 <800000000>;
> +			opp-microvolt =3D <1000000 1000000 1000000>;
> +		};
> +	};
> +
>  	sata0: sata@fc000000 {
>  		compatible =3D "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
>  		reg =3D <0 0xfc000000 0 0x1000>;
> @@ -269,12 +357,24 @@ combphy0: phy@fe820000 {
>  	};
>  };
> =20
> -&cpu0_opp_table {
> -	opp-1992000000 {
> -		opp-hz =3D /bits/ 64 <1992000000>;
> -		opp-microvolt =3D <1150000 1150000 1150000>;
> -		clock-latency-ns =3D <40000>;
> -	};
> +&cpu0 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +};
> +
> +&cpu1 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +};
> +
> +&cpu3 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +};
> +
> +&gpu {
> +	operating-points-v2 =3D <&gpu_opp_table>;
>  };
> =20
>  &pipegrf {
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk356x-base.dtsi
> similarity index 96%
> rename from arch/arm64/boot/dts/rockchip/rk356x.dtsi
> rename to arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> index 534593f2ed0b..62be06f3b863 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
> @@ -56,7 +56,6 @@ cpu0: cpu@0 {
>  			clocks =3D <&scmi_clk 0>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
> -			operating-points-v2 =3D <&cpu0_opp_table>;
>  			i-cache-size =3D <0x8000>;
>  			i-cache-line-size =3D <64>;
>  			i-cache-sets =3D <128>;
> @@ -72,7 +71,6 @@ cpu1: cpu@100 {
>  			reg =3D <0x0 0x100>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
> -			operating-points-v2 =3D <&cpu0_opp_table>;
>  			i-cache-size =3D <0x8000>;
>  			i-cache-line-size =3D <64>;
>  			i-cache-sets =3D <128>;
> @@ -88,7 +86,6 @@ cpu2: cpu@200 {
>  			reg =3D <0x0 0x200>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
> -			operating-points-v2 =3D <&cpu0_opp_table>;
>  			i-cache-size =3D <0x8000>;
>  			i-cache-line-size =3D <64>;
>  			i-cache-sets =3D <128>;
> @@ -104,7 +101,6 @@ cpu3: cpu@300 {
>  			reg =3D <0x0 0x300>;
>  			#cooling-cells =3D <2>;
>  			enable-method =3D "psci";
> -			operating-points-v2 =3D <&cpu0_opp_table>;
>  			i-cache-size =3D <0x8000>;
>  			i-cache-line-size =3D <64>;
>  			i-cache-sets =3D <128>;
> @@ -128,54 +124,6 @@ l3_cache: l3-cache {
>  		cache-sets =3D <512>;
>  	};
> =20
> -	cpu0_opp_table: opp-table-0 {
> -		compatible =3D "operating-points-v2";
> -		opp-shared;
> -
> -		opp-408000000 {
> -			opp-hz =3D /bits/ 64 <408000000>;
> -			opp-microvolt =3D <850000 850000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -		};
> -
> -		opp-600000000 {
> -			opp-hz =3D /bits/ 64 <600000000>;
> -			opp-microvolt =3D <850000 850000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -		};
> -
> -		opp-816000000 {
> -			opp-hz =3D /bits/ 64 <816000000>;
> -			opp-microvolt =3D <850000 850000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -			opp-suspend;
> -		};
> -
> -		opp-1104000000 {
> -			opp-hz =3D /bits/ 64 <1104000000>;
> -			opp-microvolt =3D <900000 900000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -		};
> -
> -		opp-1416000000 {
> -			opp-hz =3D /bits/ 64 <1416000000>;
> -			opp-microvolt =3D <1025000 1025000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -		};
> -
> -		opp-1608000000 {
> -			opp-hz =3D /bits/ 64 <1608000000>;
> -			opp-microvolt =3D <1100000 1100000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -		};
> -
> -		opp-1800000000 {
> -			opp-hz =3D /bits/ 64 <1800000000>;
> -			opp-microvolt =3D <1150000 1150000 1150000>;
> -			clock-latency-ns =3D <40000>;
> -		};
> -	};
> -
>  	display_subsystem: display-subsystem {
>  		compatible =3D "rockchip,display-subsystem";
>  		ports =3D <&vop_out>;
> @@ -196,40 +144,6 @@ scmi_clk: protocol@14 {
>  		};
>  	};
> =20
> -	gpu_opp_table: opp-table-1 {
> -		compatible =3D "operating-points-v2";
> -
> -		opp-200000000 {
> -			opp-hz =3D /bits/ 64 <200000000>;
> -			opp-microvolt =3D <850000 850000 1000000>;
> -		};
> -
> -		opp-300000000 {
> -			opp-hz =3D /bits/ 64 <300000000>;
> -			opp-microvolt =3D <850000 850000 1000000>;
> -		};
> -
> -		opp-400000000 {
> -			opp-hz =3D /bits/ 64 <400000000>;
> -			opp-microvolt =3D <850000 850000 1000000>;
> -		};
> -
> -		opp-600000000 {
> -			opp-hz =3D /bits/ 64 <600000000>;
> -			opp-microvolt =3D <900000 900000 1000000>;
> -		};
> -
> -		opp-700000000 {
> -			opp-hz =3D /bits/ 64 <700000000>;
> -			opp-microvolt =3D <950000 950000 1000000>;
> -		};
> -
> -		opp-800000000 {
> -			opp-hz =3D /bits/ 64 <800000000>;
> -			opp-microvolt =3D <1000000 1000000 1000000>;
> -		};
> -	};
> -
>  	hdmi_sound: hdmi-sound {
>  		compatible =3D "simple-audio-card";
>  		simple-audio-card,name =3D "HDMI";
> @@ -635,7 +549,6 @@ gpu: gpu@fde60000 {
>  		clocks =3D <&scmi_clk 1>, <&cru CLK_GPU>;
>  		clock-names =3D "gpu", "bus";
>  		#cooling-cells =3D <2>;
> -		operating-points-v2 =3D <&gpu_opp_table>;
>  		power-domains =3D <&power RK3568_PD_GPU>;
>  		status =3D "disabled";
>  	};
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--61fb12ab53aa8895f52b41f4f9fca6bd16aa98e69df586cfe9f98b2bb65f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwrQ2gAKCRDXblvOeH7b
bnnIAQCOaw0BDSSQZIpkP1UaiQICi6wX6TTNPg6CLnmZ6kpiaAEAn8cx/exw6cXp
+rixAOkHerNqGTGxWqzAxc2xp7Qgwwg=
=bABJ
-----END PGP SIGNATURE-----

--61fb12ab53aa8895f52b41f4f9fca6bd16aa98e69df586cfe9f98b2bb65f--

