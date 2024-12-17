Return-Path: <linux-kernel+bounces-449772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795039F55F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCCC188F544
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57F8F5A;
	Tue, 17 Dec 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiYNZob8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B851448DC;
	Tue, 17 Dec 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459581; cv=none; b=X0X4mc6QOTbbWlbiiHYbcpbcRRBaA4rR4i9b4j6llx9t+DOVd459af0cgkVVWN+YjimeOlLyOWJEQDKJhaC8QkkPI43wO8Nx+P/lOZHWJor99EC5R7kNo5dyUZ1k2tv2dtSnrD7/KbXbmEFZIfJV3eOPYV8j8pz4X82y6B3EcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459581; c=relaxed/simple;
	bh=zjTy9PBs8BSDM1TkG0RnyrT/0yguGM7/vr/qLKrQTkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9t2VzJB0hU33bpbSepKAofDC+LHIzLHLRdzZXPpNgVYKbJv4rOBNTg1MHrpmLttz4hYVmX6mZIjAvErajDxI1KTW+Uge41Ij4d2NwpqaNsa4X/m96BxucSWsixWqIeqDa1F5cKGx7IYeIUfIGCO2cS75OebHaQjuxwJvSV3CHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiYNZob8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E703C4CED3;
	Tue, 17 Dec 2024 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459580;
	bh=zjTy9PBs8BSDM1TkG0RnyrT/0yguGM7/vr/qLKrQTkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiYNZob8Ax8L07w3zPUx50m7fFlOxbbbRMUmalVLA5KBGu07rZWlzo8Oab2wphGl7
	 xPDMkjDVFdxFcYTMmsvqxBFdTW/RTGgrLqa5WH2r+8KrEghEqSjt2uhQoCwQK3nVDC
	 /+XR2GUNF4C+bQFAtdAbDaWyXMH9Sm2nffyRKHs/2MErB8+PwsgHgbtMjaqO/GJlE/
	 Ao6y+2rOJuXRM3G3kkCjWHDPObsFeTgXC3FI+y6KluojcL3oJLaAFvdft7ERX8vEpL
	 hSI6IIl/JiSbVIBLtt89SpXzjmDHwWM1MTusWCwnO2HGv+iUnfvzYIi8cOlJ79JbVi
	 JAaRArGrBeawQ==
Date: Tue, 17 Dec 2024 18:19:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, conor+dt@kernel.org,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] riscv: sbi: vendorid_list: Add Microchip
 Technology to the vendor list
Message-ID: <20241217-jokester-sift-b37121e01c90@spud>
References: <20241217113134.3508333-1-valentina.fernandezalanis@microchip.com>
 <20241217113134.3508333-2-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZciibEyPyM8v9fA"
Content-Disposition: inline
In-Reply-To: <20241217113134.3508333-2-valentina.fernandezalanis@microchip.com>


--YZciibEyPyM8v9fA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:31:31AM +0000, Valentina Fernandez wrote:
> Add Microchip Technology to the RISC-V vendor list.
>=20
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.c=
om>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/include/asm/vendorid_list.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/=
asm/vendorid_list.h
> index 2f2bb0c84f9a..a5150cdf34d8 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -6,6 +6,7 @@
>  #define ASM_VENDOR_LIST_H
> =20
>  #define ANDES_VENDOR_ID		0x31e
> +#define MICROCHIP_VENDOR_ID	0x029
>  #define SIFIVE_VENDOR_ID	0x489
>  #define THEAD_VENDOR_ID		0x5b7
> =20
> --=20
> 2.34.1
>=20

--YZciibEyPyM8v9fA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HAuAAKCRB4tDGHoIJi
0hBGAQCPyVG132M5iB3YlvelNPQPD5CsGWjpcHNrXltseqFkaQD/Vill4S/cEaIZ
n4wyM5C0r8vQ3RvGkWdGEVSwACFEaQ8=
=KcMb
-----END PGP SIGNATURE-----

--YZciibEyPyM8v9fA--

