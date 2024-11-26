Return-Path: <linux-kernel+bounces-422687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDDC9D9CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E2285D41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE451DD55A;
	Tue, 26 Nov 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGpCcL44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013541DC1A7;
	Tue, 26 Nov 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643760; cv=none; b=W3t/qXomeVCkXDVCQTLpDBT83hWRlESk2mLkFU4VXPxwlMdymlm6FqyN4NQl9X+bMtniWo/NBnIQ5Gvt8Dy4TNSa5NfXG2GFcERjMBsTdjBsIJFpju5GvZ6msbwHT/m4pX0GfAGDEqQ/+ycSGbAzrUnhRoVz3u00bqEsM9z138Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643760; c=relaxed/simple;
	bh=yoe2aMfpN0ZQwA0Nsmhpzu/IECyL8ebWI8rzUr9nDcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qiwm5+rtL5hxFmsGRODP/3vSmwSDqGaMhNt+pZ43M/6/OxtfGjn6pqYCqVFTcE0G1aU4eRS5ToBv3rELpFletjmfCojUGwoyO8NJ5DaDwjMGyNYmbwabhSy4VIgn/8kLQc5WIy6JPjI1a/nwYZGRRH4bd5yzoHRak3yvO7akfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGpCcL44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93DBC4CED2;
	Tue, 26 Nov 2024 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643759;
	bh=yoe2aMfpN0ZQwA0Nsmhpzu/IECyL8ebWI8rzUr9nDcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGpCcL44tIaBfqJ9h8Z6sSrq9vHUy4aknC6G7Yo/7UA9UmZIDIDMX/8kSL4GCCuo6
	 QV5fzIM7GEq4Ta01ZJzxgDNeG0SFr1FDaCrvwzGS2acld1bmJYq67cwvE6sYlXPloa
	 21h8NgWZvFUYQD6RyqnVUxqPLACQdFPNO78BzwBxBVo2nw4279WZVO1Ybt9IkJf/Wl
	 dqPqmO30OHeDEypdbWQ0lJ7KTj+iATvqEI8I9bSa9Scqwz16j338xUMegFUdS6ERpI
	 hc4lpSrUv8SguVxbCQl0N5ffOqsXIAq0FRMICd4SPqQMd58cNxqElEZ7slI/xfeqcz
	 Hx+j55aj3Ml6g==
Date: Tue, 26 Nov 2024 17:55:55 +0000
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] riscv: dts: starfive: jh7110-milkv-mars: enable
 usb0 host function
Message-ID: <20241126-overlying-estranged-97adaac4d1aa@spud>
References: <20241126075740.17419-1-e@freeshell.de>
 <20241126075740.17419-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z5dDKqBsszanwcNU"
Content-Disposition: inline
In-Reply-To: <20241126075740.17419-2-e@freeshell.de>


--Z5dDKqBsszanwcNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Emil,

On Mon, Nov 25, 2024 at 11:57:25PM -0800, E Shattow wrote:
> Milk-V Mars set JH7110 on-chip USB host mode and vbus pin assignment
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Could you look at this please?

Thanks,
Conor.

> ---
>  .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/ri=
scv/boot/dts/starfive/jh7110-milkv-mars.dts
> index 0d248b671d4b..3bd62ab78523 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -53,7 +53,23 @@ &spi0 {
>  	status =3D "okay";
>  };
> =20
> +&sysgpio {
> +	usb0_pins: usb0-0 {
> +		vbus-pins {
> +			pinmux =3D <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +	};
> +};
> +
>  &usb0 {
> -	dr_mode =3D "peripheral";
> +	dr_mode =3D "host";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&usb0_pins>;
>  	status =3D "okay";
>  };
> --=20
> 2.45.2
>=20

--Z5dDKqBsszanwcNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0YLqwAKCRB4tDGHoIJi
0sjcAP0XHuNi8u8P9di83xPPA/z8nh20Ql4kpuMWbj0CYh8ibgD+No+pVtoiDPwV
dh4QqWI+PJHY/AoivxsquLxdzqhPYgg=
=Tsrh
-----END PGP SIGNATURE-----

--Z5dDKqBsszanwcNU--

