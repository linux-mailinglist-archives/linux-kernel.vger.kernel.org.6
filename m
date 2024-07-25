Return-Path: <linux-kernel+bounces-262341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4C93C449
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807D61F21CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4319D090;
	Thu, 25 Jul 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoZZuPm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41419D068;
	Thu, 25 Jul 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918127; cv=none; b=YSbqOwos2Pg/xW39GTjeIZVOusXv/z3yWgpT4TdV/MJYe39KyeVNzz771CQ1u0+5FgRymOZYs2GP5UHnpN+hqRm8vdcQPIIC2PQcFsZWbzS/i+YMLI6mpdSr3OgTg7A061zoSJnAuNF3hIEKqrZOj1aXI8UlX22z/6TwTDkW5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918127; c=relaxed/simple;
	bh=dWHk/SHpnPTKCLsDctksze4Kfo/ASX42EotFciliEv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3zc2DyLCGQ2hqlTxroUVWUnPsyL+yPt98XcA7wC7A4sCqPZSsRq4ZD+w8QPkMfYYsUgp8+85CTlBf/79ZZZUz8/87cCIhPTNTUCUk1R2UxOerDydQV6NrAzxVtffDQSg0VKYAah1kao82ihWSPjGHimolSR28bTbCtOaaQK9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoZZuPm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D9C32782;
	Thu, 25 Jul 2024 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721918126;
	bh=dWHk/SHpnPTKCLsDctksze4Kfo/ASX42EotFciliEv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoZZuPm3i0aH3yLncV6e7FXvyD9dOK0856uFSu9h35JDDJ7jdWL7E/VKnuTpU9Wfr
	 UHL+O88SASJ4OvrzVMx1G35NtbFmbBx8svvT6Fu/tc1dlrZdf8F46rLf2JjWvalXT/
	 qwqo0jHvGvzMmWpH/0ooLxBF4W8NArOA/S9hcraQMSK1VX9CaAGzBtDPy3y/Cak2xP
	 xmbp3nH4YEy95AUz/yi6bhwmVJIcGGabMYi9ou/IXmfXfqPTPlHeGRdHDHXV64NpiP
	 /2j9tqIjDGzUKbYcrkNQOr/eY1iCWWOGYLINx51Po9ekkoIO+3erQ3bslr3OuM2pnW
	 iwR4dqhvMv4qQ==
Date: Thu, 25 Jul 2024 15:35:22 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] riscv: dts: microchip: add PIC64GX Curiosity Kit
 dts
Message-ID: <20240725-taco-jailbreak-6630da00cda4@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-18-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yPwJHk3tpKNwQYbJ"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-18-pierre-henry.moussay@microchip.com>


--yPwJHk3tpKNwQYbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:16:09PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> The Curiosity-GX10000 (PIC64GX SoC Curiosity Kit) is a compact SoC
> prototyping board featuring a Microchip PIC64GX SoC
> PIC64GC-1000. Features include:
> - 1 GB DDR4 SDRAM
> - Gigabit Ethernet
> - microSD-card slot
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/Makefile        |   1 +
>  .../dts/microchip/pic64gx-curiosity-kit.dts   | 114 ++++
>  arch/riscv/boot/dts/microchip/pic64gx.dtsi    | 616 ++++++++++++++++++
>  3 files changed, 731 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.d=
ts
>  create mode 100644 arch/riscv/boot/dts/microchip/pic64gx.dtsi
>=20
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts=
/microchip/Makefile
> index e177815bf1a2..78ba2952a164 100644
> --- a/arch/riscv/boot/dts/microchip/Makefile
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) +=3D mpfs-m100pfse=
vp.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) +=3D mpfs-polarberry.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) +=3D mpfs-sev-kit.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) +=3D mpfs-tysom-m.dtb
> +dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) +=3D pic64gx-curiosity-kit.dtb

s/MICROCHIP_// please. And a patch renaming the others would be neat too
;)

--yPwJHk3tpKNwQYbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJiqgAKCRB4tDGHoIJi
0pNIAQDsNaXHT+ww+2ANltZ46PqzzFdkcKcI6MA0PVMYZzWjnQD8DY1vvjdvMqQf
W3/o/h02Wbut5DXZqtSm+FHFS7ISLgI=
=ZQmA
-----END PGP SIGNATURE-----

--yPwJHk3tpKNwQYbJ--

