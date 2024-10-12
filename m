Return-Path: <linux-kernel+bounces-362603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65799B6CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 21:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E14B22071
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4E18453C;
	Sat, 12 Oct 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="MWr6fxQI"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BE1CA84
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728762177; cv=none; b=lALZYZ0FbI7tLIrLnoFUXZR3lrs4IWOIVImHD+aSTpn4NqQ2cPMYL9MLz3gixnCbo9r7joXJedkuw2/ZvB5JiLmNIF3CewTmVoq2uR2I/iyXtYI1ZkBL3up6SplzKuxhxClXx/A7oVEG0QP/+slZmZaRRJMUEHwSAqHHsFj3cwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728762177; c=relaxed/simple;
	bh=QuJ8EyXMBvgKTbug7NRvw49B8+obtP4UJFFQ1NnOby0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=izKsv72dc9Pfyznyy0D2/1dZzD7BfTswQ0VS/+ftGzLXe4Bi5p3TOLmck81cnneZ40iSi7M2NU0X5rRVhp+g4Y4L8SGKo/2L/nmfSUiEC2BoDu7kqc+0qP7jyXN7zSXMlNzT/SQwrMYcNk06FeaM1VHZlt13oaPpDmj7U40KBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=MWr6fxQI; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728762173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b64LRzS0K1xNpUCxz5A33hxeBDQfr+W1xfxRyrbN/Vo=;
	b=MWr6fxQIQPPgIeAl5dgj7l0bAlEBPcvWfZZeKHQXRoBu84aYdBilYwohPNrR7NA/1UOBa0
	58yFspj7LGAOQlvodhYsvjBQeS6q7mw4FTV7rcdRHZjYdWD1E+q4e1w8oWJRerGWbOymAb
	rX+h/QIcsEp48ElZ+SYaCnoDZWdsB/OVxO0VBXhkFiw3fveB3FBfsy6aHfsOt1wBr5//3r
	MCACn6VHrQw/pOyni6GIUbC2f4Hg9/xy4YQN0ytb76D2iilJTbdXQOKMQGPzXRavmdoS6d
	muC7yi/QnDbeLoGgrQ3Af0X3F+NCQNUJ5WIqNTRjsGwtKn5nMnPB76a3EFG7yA==
Content-Type: multipart/signed;
 boundary=2ac6e6696d22f858c7a33b96674888b04300dffc6f4ecc92215db824f2a3;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 12 Oct 2024 21:42:50 +0200
Message-Id: <D4U31LE9JG2Q.CW68BA95B9QZ@cknow.org>
To: "Dragan Simic" <dsimic@manjaro.org>,
 <linux-rockchip@lists.infradead.org>
Cc: <heiko@sntech.de>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>, "TL Lim"
 <tllim@pine64.org>, "Marek Kraus" <gamiee@pine64.org>, "Tom Cubie"
 <tom@radxa.com>, "FUKAUMI Naoki" <naoki@radxa.com>, "Nicolas Frattaroli"
 <frattaroli.nicolas@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add new SoC dtsi for the
 RK3566T variant
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <cover.1728752527.git.dsimic@manjaro.org>
 <95fc64aaf6d3ac7124926bcb0c664406b4e5fe3d.1728752527.git.dsimic@manjaro.org>
In-Reply-To: <95fc64aaf6d3ac7124926bcb0c664406b4e5fe3d.1728752527.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

--2ac6e6696d22f858c7a33b96674888b04300dffc6f4ecc92215db824f2a3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dragan,

On Sat Oct 12, 2024 at 7:04 PM CEST, Dragan Simic wrote:
> Add new SoC dtsi file for the RK3566T variant of the Rockchip RK3566 SoC.
> The difference between the RK3566T variant and the "full-fat" RK3566 vari=
ant
> is in fewer supported CPU and GPU OPPs on the RK3566T, and in the absence=
 of
> a functional NPU, which we currently don't have to worry about.
>
> Examples of the boards based on the RK3566T include the Pine64 Quartz64 Z=
ero
> SBC, [2] the Radxa ROCK 3C and the Radxa ZERO 3E/3W SBCs.  Unfortunately,
> Radxa doesn't mention the use of RK3566T officially, but its official SBC
> specifications do state that the maximum frequency for the Cortex-A55 cor=
es
> on those SBCs is lower than the "full-fat" RK3566's 1.8 GHz, which makes
> spotting the presence of the RK3566T SoC variant rather easy. [3][4][5]  =
An
> additional, helpful cue is that Radxa handles the CPU and GPU OPPs for th=
e
> RK3566T variant separately in its downstream kernel. [6]
>
> The CPU and GPU OPPs supported on the RK3566T SoC variant are taken from =
the
> vendor kernel source, [1] which uses the values of the "opp-supported-hw"=
 OPP
> properties to determine which ones are supported on a particular SoC vari=
ant.
> The actual values of the "opp-supported-hw" properties make it rather eas=
y
> to see what OPPs are supported on the RK3566T SoC variant, but that, rath=
er
> unfortunately, clashes with the maximum frequencies advertised officially
> for the Cortex-A55 CPU cores on the above-mentioned SBCs. [2][3][4][5]  T=
he
> vendor kernel source indicates that the maximum frequency for the CPU cor=
es
> is 1.4 GHz, while the SBC specifications state that to be 1.6 GHz.  Unles=
s
> that discrepancy is resolved somehow, let's take the safe approach and us=
e
> the lower maximum frequency for the CPU cores.
>
> Update the dts files of the currently supported RK3566T-based boards to u=
se
> the new SoC dtsi for the RK3566T variant.  This actually takes the CPU co=
res
> and the GPUs found on these boards out of their earlier overclocks, but i=
t
> also means that the officially advertised specifications [2][3][4][5] of =
the
> highest supported frequencies for the Cortex-A55 CPU cores on these board=
s
> may actually be wrong, as already explained above.
>
> The correctness of the introduced changes was validated by decompiling an=
d
> comparing all affected board dtb files before and after these changes.
>
> [1] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed=
561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> [2] https://wiki.pine64.org/wiki/Quartz64
> [3] https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
> [4] https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
> [5] https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf
> [6] https://github.com/radxa/kernel/commit/2dfd51da472e7ebb5ef0d3db78f902=
454af826b8
>
> Cc: TL Lim <tllim@pine64.org>
> Cc: Marek Kraus <gamiee@pine64.org>
> Cc: Tom Cubie <tom@radxa.com>
> Cc: FUKAUMI Naoki <naoki@radxa.com>
> Helped-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Helped-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |  2 +-
>  .../boot/dts/rockchip/rk3566-rock-3c.dts      |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3566t.dtsi     | 90 +++++++++++++++++++
>  3 files changed, 92 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> index de390d92c35e..1ee5d96a46a1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
> @@ -3,7 +3,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/soc/rockchip,vop2.h>
> -#include "rk3566.dtsi"
> +#include "rk3566t.dtsi"
> =20
>  / {
>  	chosen {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts b/arch/arm64=
/boot/dts/rockchip/rk3566-rock-3c.dts
> index f2cc086e5001..9a8f4f774dbc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-rock-3c.dts
> @@ -5,7 +5,7 @@
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/soc/rockchip,vop2.h>
> -#include "rk3566.dtsi"
> +#include "rk3566t.dtsi"
> =20
>  / {
>  	model =3D "Radxa ROCK 3C";
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566t.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3566t.dtsi
> new file mode 100644
> index 000000000000..cd89bd3b125b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566t.dtsi
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3566-base.dtsi"
> +
> +/ {
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

For consistency, no blank lines between the opp nodes would be nice ;)

Cheers,
  Diederik

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
> +	};
> +};
> +
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
> +};
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--2ac6e6696d22f858c7a33b96674888b04300dffc6f4ecc92215db824f2a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZwrRPQAKCRDXblvOeH7b
bmjcAQCeNqqm97Nc2PFzycIlqCXV5PD0AHf+jeMsvHLDdu49rwEAxBVEpDXvqpbP
9IwtMSL7LErw4w7ecjk/M7h8qJJIpwo=
=Wms1
-----END PGP SIGNATURE-----

--2ac6e6696d22f858c7a33b96674888b04300dffc6f4ecc92215db824f2a3--

