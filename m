Return-Path: <linux-kernel+bounces-176554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E68C318C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22331F21901
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1CD51034;
	Sat, 11 May 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMBV/L0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C374F5ED;
	Sat, 11 May 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432889; cv=none; b=S+eWDeuwZTI4d/ZdAqG9pzWRqfnCFYHvGnW7Wm91w48JWi9c7mSWAZPVQ3QiTp/e8xP9EvYoIuLKjO0LhpGMkg5GGWTm3de9Gwlufzlwz8NTJHtf2hzgaKosGIIi0YY0lvxPK1LvNg+ip9ywAH2AoLWGvNz6wHswXU+JOxa3/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432889; c=relaxed/simple;
	bh=nn5CCGqDXRDW0kal5/Z0nExGsCcCmd7RqOdWPQZZ+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJzxrj/c/3RFCbTChuRcPipoaQ2OHONumAUyXR1FkzqSALYbslUSfGdh8z8XSMTk/uNu2rYeZAMjfgirBz7S73XSHg04xtC7Qra1GdHn/mTPM77fSHj/oob6m4rQic4/O55AEaS/dffk5C5MFc/ySlyKmbl/JW2B2YO4VcMEiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMBV/L0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08707C2BBFC;
	Sat, 11 May 2024 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432889;
	bh=nn5CCGqDXRDW0kal5/Z0nExGsCcCmd7RqOdWPQZZ+Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMBV/L0Rf02+pxMLC/ZTNs8StcL5fKgQTU5ppq5oaWJDipa8ukbCHuu/An38u5vZU
	 NnvuNdjhyXgdTFMGWo8KlgW8zLJmi3r7tGype6lRozJK8NjdT6VfopQtHp/fe1MEnX
	 SNlppIGviW72sy/N86tNc1o4u9AfAZcoo4x96htViPYEdUyh/egQzsQtT/0S6IIlND
	 TFqDsQ2KaXVatNx1bFwXu6QFyGvbnmYHwoV42p57DbnAQdI7Hri0K8vHJzciBLqfvz
	 +CRGOg8oJbrFXEHKBNvNDKDvLyF8imNkO+DwfSnPqPPxj4sWLcOAAAymdDRm15AbLo
	 LZgR1LdLH6XtQ==
Date: Sat, 11 May 2024 14:08:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
	kernel@sberdevices.ru, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240511-secret-barcode-e25c722ddf1d@spud>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
 <20240510090933.19464-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BapyMlBTqqZEbUPF"
Content-Disposition: inline
In-Reply-To: <20240510090933.19464-3-ddrokosov@salutedevices.com>


--BapyMlBTqqZEbUPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 12:08:54PM +0300, Dmitry Rokosov wrote:
> The 'syspll' PLL is a general-purpose PLL designed specifically for the
> CPU clock. It is capable of producing output frequencies within the
> range of 768MHz to 1536MHz.
>=20
> The clock source sys_pll_div16, being one of the GEN clock parents,
> plays a crucial role and cannot be tagged as "optional". Unfortunately,
> it was not implemented earlier due to the cpu clock ctrl driver's
> pending status on the TODO list.

It's fine to not mark it optional in the binding, but it should be
optional in the driver as otherwise backwards compatibility will be
broken. Given this is an integral clock driver, sounds like it would
quite likely break booting on these devices if the driver doesn't treat
syspll_in as optional.
A lesson perhaps in describing the hardware entirely, even if the
drivers don't make use of all the information yet?

Cheers,
Conor.

>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml     | 7 +++++--
>  include/dt-bindings/clock/amlogic,a1-pll-clkc.h            | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.=
yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> index a59b188a8bf5..fbba57031278 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -26,11 +26,13 @@ properties:
>      items:
>        - description: input fixpll_in
>        - description: input hifipll_in
> +      - description: input syspll_in
> =20
>    clock-names:
>      items:
>        - const: fixpll_in
>        - const: hifipll_in
> +      - const: syspll_in
> =20
>  required:
>    - compatible
> @@ -53,7 +55,8 @@ examples:
>              reg =3D <0 0x7c80 0 0x18c>;
>              #clock-cells =3D <1>;
>              clocks =3D <&clkc_periphs CLKID_FIXPLL_IN>,
> -                     <&clkc_periphs CLKID_HIFIPLL_IN>;
> -            clock-names =3D "fixpll_in", "hifipll_in";
> +                     <&clkc_periphs CLKID_HIFIPLL_IN>,
> +                     <&clkc_periphs CLKID_SYSPLL_IN>;
> +            clock-names =3D "fixpll_in", "hifipll_in", "syspll_in";
>          };
>      };
> diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt=
-bindings/clock/amlogic,a1-pll-clkc.h
> index 2b660c0f2c9f..a702d610589c 100644
> --- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> +++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> @@ -21,5 +21,7 @@
>  #define CLKID_FCLK_DIV5		8
>  #define CLKID_FCLK_DIV7		9
>  #define CLKID_HIFI_PLL		10
> +#define CLKID_SYS_PLL		11
> +#define CLKID_SYS_PLL_DIV16	12
> =20
>  #endif /* __A1_PLL_CLKC_H */
> --=20
> 2.43.0
>=20
>=20

--BapyMlBTqqZEbUPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9tswAKCRB4tDGHoIJi
0pj2AP9o4HZKD5fAbbwEJlMifsTMl/7hSOmkyRbcNK3IJjs/IwEAovKPd0n+svw5
TYMMJ7Bah8z91bGRNWgo/Zn/yyRxdw8=
=ohus
-----END PGP SIGNATURE-----

--BapyMlBTqqZEbUPF--

