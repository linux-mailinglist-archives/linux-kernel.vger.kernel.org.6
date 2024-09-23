Return-Path: <linux-kernel+bounces-335667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C9797E8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3ED281744
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90413194A7C;
	Mon, 23 Sep 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY3GGgTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE283D528;
	Mon, 23 Sep 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084260; cv=none; b=eA0H6gN/BctCJI+8urpzXVeAPUdk3lc5/7tY7ianXrPfOeqhUfSAvjWB+yZLlPegGHhIvQ9ch7BwzEAEbrRKN+qdi+kIHZu/Fb/YyCTDFjMEjvOb5ZMEbFv64A9xBDgfI/CymY9j5bgopY/pf1QZ7cegppAhfJ0Oz7RQ+m2+JAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084260; c=relaxed/simple;
	bh=w3AXe7Q7QQ2NbwO91Ot+VgUMJcArPUctZY4zNwKUOLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRH2dJ3OlUGAj+0S0u1we468b3N4YQmu1cyBGjFr63Zz73DTx0yYVViqecFkiv8eHh2FWnQ/BRK6iSFjFu7bJRQ3ytWYnskP2AHbLqap+L530TcVLrrsSSExUOMOkakROJkC05b/5XFkvYBhZq9nAIfMwVJCUAwhIWypIz0Szc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY3GGgTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CAEC4CEC4;
	Mon, 23 Sep 2024 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727084259;
	bh=w3AXe7Q7QQ2NbwO91Ot+VgUMJcArPUctZY4zNwKUOLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aY3GGgTUzXPqD0IvOVjLBC+pCX5A2+Wp0O1iTfphzGduzGxqjZiiJtQjnQ2MI6/TV
	 Gg0GuVNGAOpkKcsEbzaUsGgwkDereXbpeHH2OYIc4c4rMR3hbrGrbwW30W85CJYGTR
	 11/MtlSOovKbKzbChcuEJSwp3mkbOM+dGt8s50Vi+wQhxOH//Z/9xkw0jmCtnZYGOW
	 WLD5/V/B0LFrW55hmItPr3oq4wUqJq90ZVBM8hHspbixOzN2pYVv0d2XI0CmxpAofX
	 UJotxLa6WZ7RtXkIl9xGcwCagBgB8a+wDN9+6173DGkvX1PZFz0aa0gRbh/sBaFNnH
	 AB0DYIfw3O1oA==
Date: Mon, 23 Sep 2024 10:37:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv:dts:starfive:add framework dts
Message-ID: <20240923-rehydrate-daintily-1199bce1456c@spud>
References: <20240923053621.1585972-2-sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vaw+pNIvYxNDsg5l"
Content-Disposition: inline
In-Reply-To: <20240923053621.1585972-2-sandie.cao@deepcomputing.io>


--vaw+pNIvYxNDsg5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Firstly your $subject should have a space after each :

On Mon, Sep 23, 2024 at 01:36:20PM +0800, Sandie Cao wrote:
> Add dts to support RISC-V Framework Laptop 13 Mainboard.=20
>=20
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../boot/dts/starfive/jh7110-framework.dts    | 35 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts
>=20
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/=
starfive/Makefile
> index 7a163a7d6ba3..ebc8966fde0c 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -12,3 +12,4 @@ dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.3b.dtb
> +dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-framework.dtb

Can you add this in alphanumerical order please?

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-framework.dts b/arch/ris=
cv/boot/dts/starfive/jh7110-framework.dts
> new file mode 100644
> index 000000000000..4da7ade5c8e7
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model =3D "jh7110 framework";
> +	compatible =3D "jh7110 framework", "starfive,jh7110";

"jh7110 framework" is not a real compatible (you need a vendor prefix
and no spaces) nor is it documented - which produces warnings:
arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: compatible: 'oneOf' c=
onditional failed, one must be fixed:
        'jh7110 framework' is not one of ['beagle,beaglev-starlight-jh7100-=
r0', 'starfive,visionfive-v1']
        'jh7110 framework' is not one of ['milkv,mars', 'pine64,star64', 's=
tarfive,visionfive-2-v1.2a', 'starfive,visionfive-2-v1.3b']
        'starfive,jh7100' was expected
        from schema $id: http://devicetree.org/schemas/riscv/starfive.yaml#
arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: compatible:0: 'jh7110=
 framework' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
        from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/riscv/boot/dts/starfive/jh7110-framework.dtb: /: failed to match any s=
chema with compatible: ['jh7110 framework', 'starfive,jh7110']

Please run dtbs_check on future versions and fix reported warnings
by documenting things in dt-bindings.
"jh7110 framework" isn't very specific, so if there's a model number
attached to the mainboard that'd be good to have. The vendor in the
vendor prefix should be deepcomputing, so you'll likely have to add a
new vendor prefix for that.

The model field could also be improved, check out the visionfive 2 and
see how that property was written there.


> +};
> +
> +&gmac0 {
> +	status =3D "disabled";
> +};
> +
> +&gmac1 {
> +	status =3D "disabled";
> +};
> +
> +&usb0 {
> +	dr_mode =3D "host"; /*host or peripheral*/

What does the comment here mean?

Cheers,
Conor.

> +	status =3D "okay";
> +};
> +
> +&pwmdac {
> +	status =3D "disabled";
> +};
> +
> +
> +&pcie0 {
> +	status =3D "disabled";
> +};
> --=20
> 2.34.1
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--vaw+pNIvYxNDsg5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvE23wAKCRB4tDGHoIJi
0gyvAQDz1vZH2TIvBpTQC58kuTqgGDt/GaaUbL8JEK34HqmPngEAkbAv7lmlYVTe
qxriIGgNgbxTqp7ZIFQHEzAcLKDa6Ak=
=sUq6
-----END PGP SIGNATURE-----

--vaw+pNIvYxNDsg5l--

