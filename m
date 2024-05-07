Return-Path: <linux-kernel+bounces-171833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE48BE941
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D531C217D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E916C846;
	Tue,  7 May 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DThB9SCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7916C6A1;
	Tue,  7 May 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099600; cv=none; b=kwkdmKC0/Qck9XS8A2JXdtlnDIcfeHYFrVMhDg7UgC0AEgkjEovHilcyZWMvqCQp1f+zpd3KlC+ZxtDgCIMI+7qixmMZJ5vJiimHuBH8FyJ+jGHolgm3zJeBqfQE6GiqFEHeE16/Rn1kJK7HGJM+SmYMFFqDBcnEOAkQPHhxYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099600; c=relaxed/simple;
	bh=4HiJms5M5hQwpyB05lhvUuD9PuV/187jPsAb+jO8nmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CifGEZEDiHo8+Mypcq0T+6YjXiGKW2asNV6eCIks+wzFjq9HZ1u0sti/UaNf4vZUiMn5c+2ow4dnm1UJ6jU46kvZZG+R/d09ASX8/ZcC9Fqopq3UKhC3CsCC1GGkTEW66GiD+w+9Ns8RdxWOqPCnzZqyxXUejgTtZOZdZZml2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DThB9SCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A7CC2BBFC;
	Tue,  7 May 2024 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099599;
	bh=4HiJms5M5hQwpyB05lhvUuD9PuV/187jPsAb+jO8nmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DThB9SCaaZTikfmQTN7szbt1csD26aPMZptIBbYHWnRzgGq/KOHhxVt8D7aeqcrYQ
	 pLdeTGRn/cMGj4aN/7t3Av88TL4ikuYzWcgVeHpDxo7lQvRheic1m5ivYNiGZ+++zl
	 AvhPgx/TeoHWRm2iGnKiyIaJ+KNGiMFuKfXTKBpriVZ2YWzdpauLCYkz3M5QrkLUCS
	 SN+gaTcYdJn9FGrHDOeS2AYm/DoKxO5jqkY3J4+pbo5AJmSWJMRcquTYBOfwyATqR/
	 rvLcpRtJRxpOsaJ63HfdeONGGepbsqx070AY6oxOY52yij4ai/y+awATHA2Pk0tiZn
	 M3Dgi0AVZo+Nw==
Date: Tue, 7 May 2024 17:33:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v4 4/7] dt-bindings: display: panel: Add compatible for
 BOE nv110wum-l60
Message-ID: <20240507-sponsor-outrank-354086fe1492@spud>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-5-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/R2mCHLi4D2gWEX"
Content-Disposition: inline
In-Reply-To: <20240507135234.1356855-5-yangcong5@huaqin.corp-partner.google.com>


--J/R2mCHLi4D2gWEX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 09:52:31PM +0800, Cong Yang wrote:
> The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel with himax-hx83102
> controller. Hence, we add a new compatible with panel specific config.
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Chage since V4:
>=20
> - No change.
>=20
> V3: https://lore.kernel.org/all/20240424023010.2099949-5-yangcong5@huaqin=
=2Ecorp-partner.google.com
>=20
> Chage since V3:
>=20
> - Update commit message.
>=20
> V2: https://lore.kernel.org/all/20240422090310.3311429-5-yangcong5@huaqin=
=2Ecorp-partner.google.com
>=20
> ---
>  .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8310=
2.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> index 7cd720eb4981..53a6ace75ada 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
> @@ -16,6 +16,8 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
> +          - boe,nv110wum-l60
>            # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
>            - starry,himax83102-j02
>        - const: himax,hx83102
> --=20
> 2.25.1
>=20

--J/R2mCHLi4D2gWEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpXygAKCRB4tDGHoIJi
0lY8AP9J/7fYRiI1uUY4RsRlNMljvE0OzLfPALpJk//EPuOgPQEAr3Nt2x2b9xf7
4z0WKSF8s7jkjEYCj9derRqlZWvRnw4=
=qRFp
-----END PGP SIGNATURE-----

--J/R2mCHLi4D2gWEX--

