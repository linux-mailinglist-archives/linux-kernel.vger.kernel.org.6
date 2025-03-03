Return-Path: <linux-kernel+bounces-542421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA796A4C997
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C005B179EFF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7F2512F3;
	Mon,  3 Mar 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of7odUmJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37218236A61;
	Mon,  3 Mar 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021892; cv=none; b=c7sW3zpxhmQyFuItAsrTn6YUHfW0UfSZ2n5KczYaxk5kRINKrdjstHFSIqB9ypvVj7sTA0b6ro+dvM/9Pl6djPcQ9biAvdfO6DJVJTT2OHq5gReFOWP9N6SOqIhcCLxWiBAGBvy6LfM9PvC4uK1W8fC/wwz1WSXMnJQpU2QHwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021892; c=relaxed/simple;
	bh=eizNalHCTuxVF3+1ahCWWok9u/AgiM8Ny0irTXJi51k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/SF8g2nE7VO3wMz+bTJX/eJJi3YAQpGAZx7oq8tq9ThOkge/ykLr1AT0cLtHDdjJvEaCYPMQgv+K48sdyEU4+o9KhIvjytwQ+PA3VebK3zcpbA+jOHgx6fqUulPohGsjqMxK/ABvYJbiqrpzxnFb6mgGtGJYGjBVYr9mX2hrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of7odUmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E6C4CED6;
	Mon,  3 Mar 2025 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021891;
	bh=eizNalHCTuxVF3+1ahCWWok9u/AgiM8Ny0irTXJi51k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=of7odUmJ4GW9tgOsLsWTabrhv9EKztee8MTxrKncRQhZ9zl4LdrKPVrrzI7+uQe+l
	 Jz7nKTiJOBMlz+A+eVjL3+k2tLGB+bMHzI2XEHZiEBHNdMi44kt+fKATFk4VbeK+Fa
	 7ntIcHcijQR18eYJOviPqI0Fmdal9PxTFe1XtH2Qm7/bxRaDG+2yXAf0+v3hGEJnzZ
	 u3eUVnEOmjDQyxiV+gDcE++to7dS9MFB8d7wdXs+hRc3tIDx9+dER4IWGawpXdzlLL
	 BQH3o58pOvLn/XyuCCOWg/CRl4QEDENEBf2KtaqUGUosaPxnANoYGwz3PA0xqfGYLN
	 cw6msE1rTWvGA==
Date: Mon, 3 Mar 2025 17:11:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: frank.li@nxp.com, miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 1/4] dt-bindings: i3c: silvaco: Add npcm845 compatible
 string
Message-ID: <20250303-chest-presoak-5d3f3b821d1f@spud>
References: <20250220054330.1711979-1-yschu@nuvoton.com>
 <20250220054330.1711979-2-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VzlPWCTDiZiwVyeE"
Content-Disposition: inline
In-Reply-To: <20250220054330.1711979-2-yschu@nuvoton.com>


--VzlPWCTDiZiwVyeE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 01:43:27PM +0800, Stanley Chu wrote:
> Add a compatible string for Nuvoton BMC NPCM845 i3c controller.

Why is a fallback not an option here? Your commit message should call
out why not.

>=20
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yam=
l b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> index c56ff77677f1..9be4bc4cc482 100644
> --- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> @@ -14,7 +14,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: silvaco,i3c-master-v1
> +    enum:
> +      - silvaco,i3c-master-v1
> +      - nuvoton,npcm845-i3c
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20
>=20

--VzlPWCTDiZiwVyeE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8XivwAKCRB4tDGHoIJi
0gSPAQDrU/Mgy4KedvZ0NfvAWGiJ0jnOqPXnQOk0r089AFRSXAD+OnTmtaJUfc3I
q3e3xQUV5qSfsRKa0s8ClZFRs72+PAE=
=RiRD
-----END PGP SIGNATURE-----

--VzlPWCTDiZiwVyeE--

