Return-Path: <linux-kernel+bounces-439485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35D9EAFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A94916AB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61A78F4B;
	Tue, 10 Dec 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="rhbg1cnD"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8478F24
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830278; cv=none; b=R+ga0MoUct2P+SoxPY4OjTDW7WWcku4vIMxzbGgCcDucJ//NHXiTfUl0kFVWEZoYH1oW+CgbTN42f5bwpthpe3Bph0mMYM8rAHDllnIJc4b42unwH+uUstVPpJHs6cqF/IKiN4QM8IuiOBO5eKbbv8W6Hmko5LiK290VlTDfuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830278; c=relaxed/simple;
	bh=9keLN6u9MLaCHXqWbzaLWWtINTKiS3eNWIl3UFRz3c0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=d++2nrt3WV8bykd2g1WYrx1HoS65VCvBvy8lgOjnBiRe1F9gDLm3LbpXQoiXtPAXCLpbTsbVJ/9sr6JjN61/1v4Fu7FHIgzJ9WXGzWfyauH3VOt2lQnPrB550NlWNrHFuoQRuadsJ/1tjD7/oFkD2sXKXuCdjMlzFdrwpNCVf7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=rhbg1cnD; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1733830272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC9p5FCQHs2anWJcb1DSJZ9Qt5OmqJaqiCA2H3GVUdA=;
	b=rhbg1cnDCmr4+sq42ofOWItwWMMrQ/fu3jv83RueAD29byK8AuCHomk+TOanv7eTttbQ4O
	SlK3EjM51VoQtoedkuRdy9/wxUoYnw1tJb5P19ZzuLkzRPyIYhI/Xe9nRsIeXFGf6RZVyh
	PPRxoFJPVc+Ddh50sp6ecHS6VDOTRDXIA6KddPPRunRntp8cWBkfR+q7WrMsFPL7m6O1AB
	KLUl/t3jylitbOMRyfrs4zeQGCg2bQOlWC1TqPn3BTkkPJZVMt2Gt2CP/0TxispyBNtH/q
	RwHbfXmksyJ2Hrwjt2N+NcwGxdhaVhXsaLkqJpemT8rCJgdpM7+I0KEFca0zJA==
Content-Type: multipart/signed;
 boundary=768b44e4608be46521de5d39885a4e035e23bf1739a34b0bd3d7b81b3cbe;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 10 Dec 2024 12:31:02 +0100
Message-Id: <D67ZJ6MOM5TH.2WBYCCU20DDJO@cknow.org>
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: correct rk3328-roc regulator
 map
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Peter Geis" <pgwipeout@gmail.com>, "Heiko Stuebner" <heiko@sntech.de>
Cc: "Conor Dooley" <conor+dt@kernel.org>, "Dragan Simic"
 <dsimic@manjaro.org>, "Johan Jonker" <jbx6244@gmail.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Levin Du" <djw@t-chip.com.cn>, "Rob
 Herring" <robh@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-6-pgwipeout@gmail.com>
In-Reply-To: <20241210013010.81257-6-pgwipeout@gmail.com>
X-Migadu-Flow: FLOW_OUT

--768b44e4608be46521de5d39885a4e035e23bf1739a34b0bd3d7b81b3cbe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Peter,

Thanks for this series, I already saw some familiar error msgs
mentioned, so will try this series out soon (tm).

On Tue Dec 10, 2024 at 2:30 AM CET, Peter Geis wrote:
> The rk3328-roc-cc input power is sourced from a micro-usb port, while
> the rk3328-roc-pc input power is sourced from a usb-c port. Both inputs
> are 5vdc only. Remove the 12v input from the device tree.
>
> While we are at it, add missing voltages and supply to vcc_phy, missing
> voltages to vcc_host1_5v, and standardize the order of regulator
> properties among the fixed regulators.

Big fan of standardization :-) ...

>
> Fixes: 2171f4fdac06 ("arm64: dts: rockchip: add roc-rk3328-cc board")
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>
>  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 23 +++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3328-roc.dtsi
> index f782c8220dd3..6984387ff8b3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> @@ -24,22 +24,23 @@ gmac_clkin: external-gmac-clock {
>  		#clock-cells =3D <0>;
>  	};
> =20
> -	dc_12v: regulator-dc-12v {
> +	/* fed from passive usb input connector */
> +	dc_5v: regulator-dc-5v {
>  		compatible =3D "regulator-fixed";
> -		regulator-name =3D "dc_12v";
> +		regulator-name =3D "dc_5v";
>  		regulator-always-on;
>  		regulator-boot-on;
> -		regulator-min-microvolt =3D <12000000>;
> -		regulator-max-microvolt =3D <12000000>;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
>  	};
> =20
>  	vcc_sd: regulator-sdmmc {
>  		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc_sd";
>  		gpio =3D <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&sdmmc0m1_pin>;
>  		regulator-boot-on;
> -		regulator-name =3D "vcc_sd";
>  		regulator-min-microvolt =3D <3300000>;
>  		regulator-max-microvolt =3D <3300000>;
>  		vin-supply =3D <&vcc_io>;

... but why not put regulator-name as the first of the regulator
properties as is done in the rk3328-rock64.dts ...

> @@ -50,22 +51,25 @@ vcc_sdio: regulator-sdmmcio {
>  		states =3D <1800000 0x1>, <3300000 0x0>;
>  		regulator-name =3D "vcc_sdio";
>  		regulator-type =3D "voltage";
> +		regulator-always-on;
>  		regulator-min-microvolt =3D <1800000>;
>  		regulator-max-microvolt =3D <3300000>;
> -		regulator-always-on;
>  		vin-supply =3D <&vcc_sys>;
>  	};
> =20
>  	vcc_host1_5v: vcc_otg_5v: regulator-vcc-host1-5v {
>  		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc_host1_5v";
>  		enable-active-high;
>  		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&usb20_host_drv>;
> -		regulator-name =3D "vcc_host1_5v";
>  		regulator-always-on;
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
>  		vin-supply =3D <&vcc_sys>;
>  	};

... and was the case here?

Cheers,
  Diederik

> =20
> +	/* sourced from usb input through 3A fuse */
>  	vcc_sys: regulator-vcc-sys {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "vcc_sys";
> @@ -73,7 +77,7 @@ vcc_sys: regulator-vcc-sys {
>  		regulator-boot-on;
>  		regulator-min-microvolt =3D <5000000>;
>  		regulator-max-microvolt =3D <5000000>;
> -		vin-supply =3D <&dc_12v>;
> +		vin-supply =3D <&dc_5v>;
>  	};
> =20
>  	vcc_phy: regulator-vcc-phy {
> @@ -81,6 +85,9 @@ vcc_phy: regulator-vcc-phy {
>  		regulator-name =3D "vcc_phy";
>  		regulator-always-on;
>  		regulator-boot-on;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&vcc_io>;
>  	};
> =20
>  	leds {


--768b44e4608be46521de5d39885a4e035e23bf1739a34b0bd3d7b81b3cbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ1gmeQAKCRDXblvOeH7b
bmMBAQDzQzO1G+w5qzoBp5aUjpUNIUQhGVvq8MR3l/ziGJqI8gEAyBZ7Pt2t9Uc1
WSOu5/T6z7u4uJ8LYn9q97mYE7UlTg0=
=qRUc
-----END PGP SIGNATURE-----

--768b44e4608be46521de5d39885a4e035e23bf1739a34b0bd3d7b81b3cbe--

