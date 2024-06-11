Return-Path: <linux-kernel+bounces-210241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC254904136
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DFA2899EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D9A4176E;
	Tue, 11 Jun 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo8W7+Ns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683D3BB25;
	Tue, 11 Jun 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123062; cv=none; b=rNX0yp0FHOSHykzrMlDz1cboDZI0ocLoi0Nnvjx4s8taZfT5jHgR8u5kyXioRyoAbpSupOC3zsR8LkHGaNg+RcKue0Qzijxn3XAuyoiuaXw3xYX65CeNyp00bhyEDJJXJTZvD0qFtXmpJlGZqdxsZAGXYSO3FnbtIUTA9hRGswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123062; c=relaxed/simple;
	bh=e2JRZAInX4VbpDRXbsbxfaga+F/z//woWGhb8XL6kFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvtgyW8DgCSTTe9fKx5ssK0YREtMPG5G6AUab/mtbquMO5oeUDoI4C6TecpqRc24PQu3V8t4AtdUcWMc7YzKUCiRtl6ySdQE+vifgx0fse7YmVjycC8KAVuu4DcZRL/EiKAxbf1ak2mMPxz0+1MN635POZXsNOPIhAQ2cn3tpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo8W7+Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0867FC2BD10;
	Tue, 11 Jun 2024 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718123062;
	bh=e2JRZAInX4VbpDRXbsbxfaga+F/z//woWGhb8XL6kFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo8W7+Nsmby3FBoOMRdMQxnBcT41xKkNNkijVXEx+MFxGy3lE1nIwiamipM48xVaO
	 cxXeLblMLHoColDh6jSxBmQiTIet0GtPca+IGdMHHRxIUutbzqBf7S13DdBthpQ1wS
	 Yfb6/5gNUi3jL90M9/7OOZ36wNDW9d8JaOywWjKT5R/4IZPIJGN0KwuATCptlowdhy
	 AAALLHqCvERrV1gBKfKZMPfH1hQBcawKLvdXOgo6+aXZ8rH24VI4DdCNkaSlInMnBa
	 OHdG4X0mmJjQ9XRETAvKy4QfIIPhvPLwKZY+Ce+KWtavaZzVjKoon5Hc2Dh5+HlXIo
	 DOVW1zTBgzeFQ==
Date: Tue, 11 Jun 2024 17:24:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1] riscv: dts: starfive: add PCIe dts configuration for
 JH7110
Message-ID: <20240611-irk-hypocrite-a53e98e6c394@spud>
References: <20240611015200.40996-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wzZC5MCZUi+ZMG8A"
Content-Disposition: inline
In-Reply-To: <20240611015200.40996-1-minda.chen@starfivetech.com>


--wzZC5MCZUi+ZMG8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 09:52:00AM +0800, Minda Chen wrote:
> Add PCIe dts configuraion for JH7110 SoC platform.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7110-common.dtsi      | 64 ++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
>  2 files changed, 150 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 8ff6ea64f048..1da7379f4e08 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -294,6 +294,22 @@
>  	status =3D "okay";
>  };
> =20
> +&pcie0 {
> +	perst-gpios =3D <&sysgpio 26 GPIO_ACTIVE_LOW>;
> +	phys =3D <&pciephy0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie0_pins>;
> +	status =3D "okay";
> +};
> +
> +&pcie1 {
> +	perst-gpios =3D <&sysgpio 28 GPIO_ACTIVE_LOW>;
> +	phys =3D <&pciephy1>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie1_pins>;
> +	status =3D "okay";
> +};

Do all 3 of the mars, star64 and visionfive 2 have both PCIe ports
exposed? I assume if one does, all does, since they're basically
identical?

--wzZC5MCZUi+ZMG8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmh6MQAKCRB4tDGHoIJi
0v1MAP9PTX9Hu0d+NafLeM2JG8n5oxSljJKr6Q/CDKPbUeaOcgEAxScFlExYbnQb
F951+zWbwytmbr3baByHSjGl6D2Cigg=
=ds5C
-----END PGP SIGNATURE-----

--wzZC5MCZUi+ZMG8A--

