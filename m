Return-Path: <linux-kernel+bounces-524288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A306A3E171
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FF47ABCA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E9212B3D;
	Thu, 20 Feb 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSBaeyZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233A1DFD85;
	Thu, 20 Feb 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070211; cv=none; b=UrJYqJDnb1Ap4FCJgovigbJdR+Nb1FRq3Up0gBKHb75XAaEEnPaCjnywN0x3+Y+uXQ8lkTvgwWoI/bfoe6L6h7uX/3EOMUBZFsYp0oBnA/PS9I6kU1EQqpnKH0XXAA29WUz/Vzoz1frQSg6VmvGjo35l1O9rHjAeaAvLfNyZkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070211; c=relaxed/simple;
	bh=r7vEij098XePCNx1q/9h8YAgRgZb+uXXU16yRDQpoSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHh00R64DT9MYl7+yOzZ0UvV3JwG42EPev5NpYJnXF3GWJfh/K2FTANSfuWUFYZ34DKmsZUnkZH1B4nqzghWWjnZ7lIVJMBkpVx4n/A8RETQbHcOrwu2m1czOScXRZZnqpoVTk+RPsAKOELAIy7g6M9FA3/CyFM3RLks8jdTz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSBaeyZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AC6C4CED1;
	Thu, 20 Feb 2025 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070211;
	bh=r7vEij098XePCNx1q/9h8YAgRgZb+uXXU16yRDQpoSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSBaeyZFC671w2GzIv2T8buca6YJuGw6jDMXRB6BOhxoQ3xgitvpNvp4j9zQEwLXk
	 4I0v2sjtCAegGCBAcA8bGA27eJ4sb4olPi6VCs1Rn082i3KV/oKN0OpbLr0b9vM1XW
	 7Y7qUOAB+SHHW78oydrBrpxM1GmnwSTwP+JzSxitTY5SMOF3Ebbn642fm+HhfkkWYg
	 phJn2pj+PbFbFunMb2W0hhzNOAVlKHZ6F2xSgTk/BXus9jjoWOfvKwdtONqY8neO/y
	 pbqPBPU+NpYg6LLXixZmFCBNr4/tA9Z6Ml1okmG4OAcQWZ/3nYJl3G9JLDk697yt9I
	 dMYJSAF+T562Q==
Date: Thu, 20 Feb 2025 16:50:06 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, gene_chen@richtek.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: Re: [PATCH] dt-bindings: usb: richtek,rt1711h: Add missing vbus
 power supply
Message-ID: <20250220-countable-passenger-59144620d57b@spud>
References: <20250219140143.104037-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J037/kZKzyo6CE9E"
Content-Disposition: inline
In-Reply-To: <20250219140143.104037-1-angelogioacchino.delregno@collabora.com>


--J037/kZKzyo6CE9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 03:01:43PM +0100, AngeloGioacchino Del Regno wrote:
> The RichTek RT1711H and RT1719 chips do have a vbus pin that is
> used for attach/detach detection (respectively, pin A1 and 11):
> allow a vbus-supply phandle for that.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b=
/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> index 8da4d2ad1a91..ae611f7e57ca 100644
> --- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> +++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> @@ -30,6 +30,9 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  vbus-supply:
> +    description: VBUS power supply
> +
>    wakeup-source:
>      type: boolean
> =20
> --=20
> 2.48.1
>=20

--J037/kZKzyo6CE9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7ddPgAKCRB4tDGHoIJi
0jEsAP96MVC5KD9LhVk6tQKvH1Nc8949THj7womtWHiVIM3b4AEAyvTFu74qcapO
hWWa3LjqDspE991pZ/RDvXnh2bYxxg0=
=5wv4
-----END PGP SIGNATURE-----

--J037/kZKzyo6CE9E--

