Return-Path: <linux-kernel+bounces-344167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2DB98A5AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8CD1F234E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51422190482;
	Mon, 30 Sep 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjnP+VHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960C18FDC5;
	Mon, 30 Sep 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703876; cv=none; b=MCrhPT/SFRbDG44SB9rEY2fwo8TKEThQMKLefS0sGzcEo9Jc2X36BrlgXAwsNfNJVsQ6dHLg8bp5G+gSLlrBzTUfSAx/TW2j2iiywEyk65c7gxiPxCW+Z1oLL8gyOyHVCwPpAW9lTMRMTukLKP5520raUvWxBPM1n0X7AWEc1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703876; c=relaxed/simple;
	bh=WII6XIL5oH0khuAitO4UjfztUkSH5Op+eXwv29J9F0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSjNtI89jOf+K9xQaETjWU9GK2fOwncjo86rWDxfabrtyYN2pTiq8moJ6msB3YG5imhHFPz4cZEuFgGyt6okPSPbiqj4F5kZgB99xhKd+8EOiOp9Uw2gPKxIHSG40I260XzUxYy9n/uExxn7jjUpkS0nvSu7fKJU7DjuWGI20RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjnP+VHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D176C4CEC7;
	Mon, 30 Sep 2024 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727703876;
	bh=WII6XIL5oH0khuAitO4UjfztUkSH5Op+eXwv29J9F0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjnP+VHpKy+LxbuIGuetn5TadwJJPcxwPHfHO/T363/vp+vA/BiQZtcd7sKa/I/l4
	 j4LMuFuOXmmuCWkvu84nqTVG7TSTKgN/43Dvv7V1Pc/2aTlWReObPiplH8nX2X/aDZ
	 oPIyorQMad8IapFoA6Vz2YmDgWm6a/TXZWneyQrN0wZM9wIATDPp10uikasUvd802y
	 Q2pihoSViDxkGMgj0sQZIF+pvNGafs3Ab4bVQAhCrGkwfJlfrTsLPJAbxcRz4jMOpm
	 qcYmBt7rOqt/ox9loPqNhklKu8aRnpbg2eI3y5n/G1Run7zcn7DZiuusKkfckAizMa
	 cCjZGrlNBPmSw==
Date: Mon, 30 Sep 2024 14:44:32 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [linux][PATCH v2 03/20] dt-bindings: mbox: add PIC64GX mailbox
 compatibility to MPFS mailbox
Message-ID: <20240930-undoing-hardener-90cf6b7ec292@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-4-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xotCooLs1WDY6rNk"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-4-pierre-henry.moussay@microchip.com>


--xotCooLs1WDY6rNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:32AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX mailbox is compatible with MPFS mailbox, just add fallback
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

NAK, needs the stuff that I mentioned on v1 to be done before it is
applicable.

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

--xotCooLs1WDY6rNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqrQAAKCRB4tDGHoIJi
0nPRAQDFscKG3KN9tD4+0li5RZxHUVxEdMkrdWLN6zamj//N9gD7BHzDW+nGvnfU
TXaLVumrP6iTqAAcV6CwbDof5BEWdwY=
=c7Z6
-----END PGP SIGNATURE-----

--xotCooLs1WDY6rNk--

