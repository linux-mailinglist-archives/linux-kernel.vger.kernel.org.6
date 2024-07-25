Return-Path: <linux-kernel+bounces-262305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046B93C3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF13D2830F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F919D06B;
	Thu, 25 Jul 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWGPRl6z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C719AD94;
	Thu, 25 Jul 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917019; cv=none; b=mooOBXxsQXeJYCd3A9VYhAwfJpdrihOlKXmnXfvn++yqrlUwYAFut4ndAP40uhCa7o46hinNjUbgeJWArkCReM7KYmJUw3iCGfL2XUGCab57aSSmmKaOUvM3elfcKJEfJjQoIvvMMsmynUrLyosZf77pfasaVlg5mBbTvCCqKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917019; c=relaxed/simple;
	bh=r6dCvysR3gN+kQ220XRbk7Ss9uWNopX4IArNIRfBQc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m26Sz6rMBehD/gdkj8qZfVK/olBSziT2zrK5tlePy8GqK7yVfxnW9UMZqnPEscEmmXwARTnVk3So0oxInnww/FRsviS+ixwnCfiY1jXoMcgjVfvQXDuWZLAAyrZFO6iQifqKSQk5fybX/BHP/FFZcGphM+VKj1G253Sv9AJO25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWGPRl6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28039C116B1;
	Thu, 25 Jul 2024 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917019;
	bh=r6dCvysR3gN+kQ220XRbk7Ss9uWNopX4IArNIRfBQc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWGPRl6zUNWx//VydX3Qz57Lx0NRWH9pBjs4uMmJFpFaShaLmH2v3fphuClc6FlCW
	 mIw2EG3AXtn8nK/a15E+xEfiMEWi9yNnMDcMyOLyc73w/EH7uvn6Ro0UIk/otz0Hg7
	 vkaW/dJpnWEqPBA62qN5Cvt0dML3/XrZksIjjjy/OWAwXMOCDhzoEZQR3n48rVwuwx
	 OipZfdgOXWZx4QQ6o6FIBnCvbs5M0Fsglk9807713lDlSqprbXcbrw36yXe95Y1EsK
	 +VJEGJKG8/8MrLO1jatwaroAvka5fL2P05ARTNshaXn3sPreuvPtp+DhuNtay3cfHi
	 3nW5z291YIMAQ==
Date: Thu, 25 Jul 2024 15:16:55 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 03/17] dt-bindings: mbox: add PIC64GX mailbox
 compatibility to MPFS mailbox
Message-ID: <20240725-treachery-revenue-80e5262190b7@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-4-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T+jEq7Zw12QY1R2P"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-4-pierre-henry.moussay@microchip.com>


--T+jEq7Zw12QY1R2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:15:55PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX mailbox is compatible with MPFS mailbox driver

I don't want this one merged as-is. The mpfs binding here is wrong, and
doesn't describe the hardware properly. One of the regions should be
described as an mfd or syscon because there are several unrelated functions
(hwmon, a reset, mailbox cr/sr and trimming) there - see pfsoc_control_scb
in the regmap for more information. The mpfs binding should be fixed,
rather than adding something incorrect here for the pic64gx.

I'm on holidays atm, I'll try to explain more when I get back.

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mai=
lbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbo=
x.yaml
> index 404477910f02..9e45112e185a 100644
> --- a/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.ya=
ml
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.ya=
ml
> @@ -11,7 +11,11 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: microchip,mpfs-mailbox
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-mailbox
> +          - const: microchip,mpfs-mailbox
> +      - const: microchip,mpfs-mailbox
> =20
>    reg:
>      oneOf:
> --=20
> 2.30.2
>=20
>=20

--T+jEq7Zw12QY1R2P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJeVgAKCRB4tDGHoIJi
0sn3AQDgWg2Pm3tJQgDQV6PDReudh0FuTvKUewdsyxYm7or+hwEA1iiLwvJYd5W7
UemNeiHfI7e9Zv6mK4rizbYb73L7Tw8=
=GTjB
-----END PGP SIGNATURE-----

--T+jEq7Zw12QY1R2P--

