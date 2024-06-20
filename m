Return-Path: <linux-kernel+bounces-222996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA3910B76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C4F1F2251E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A881B14E2;
	Thu, 20 Jun 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEE50IVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E93BB50;
	Thu, 20 Jun 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899880; cv=none; b=c+syIF8fx6WYp41qgfh7PWiPaRMwfh8BEh0cFHuTC8zKrrQ+pkg9qHFGNdppdvvVGN6zgb35LE5YE2IPLOfJpSmyGb22TSYDvyurHhe4xqOn4ygqsX78CdnSavWrS0bHS1plt+gSAiYJzn9XMiCYNN+t+FpPz7KHVYWY07LqaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899880; c=relaxed/simple;
	bh=OxkljKrow05q4da7B3GsfU2bTy755SQpG+GHmoDz1FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDyPdRiLaYFN2jYxkQzclksN+5DPbZkbEPIclyhG7YlErTO7xKKXZxbZwQG12XxpXzHs2r9rFsVt7/rGrngghSwTAeaAkL6CMNhlfMHI8KODoTKcQ/hMSIn7zbY+j+Du0g/z/ccr0Tl6/71iW7y+mh495x1VAaZdwsRzvIQeqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEE50IVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57F7C32786;
	Thu, 20 Jun 2024 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899879;
	bh=OxkljKrow05q4da7B3GsfU2bTy755SQpG+GHmoDz1FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEE50IVkbPtvw82RdiBMZQ1mNk+3cLyGhjLH/BWn4ChiAXvTrqQCRBAwhSffTND6r
	 NWu2lb/MaaE83hHXAXlmnxShUjmnwLv9PgCUwRaCQ3Wx67YsrTpzTE+bkpDyKM3Dkl
	 iqN2vZhldikA6kMGOvQUcHUau+R8JoInV9XnIUaoaqs7BGLRknpwR5JcXKBb9Z9w4h
	 8lG5cC3U0L7vkAnZWIkOnDQOY05qNAOJqJXGwb/6HATB/SU7lcxd9nnJ0uRdZJT90X
	 HSCTf37lVAyxUdr6mmP3X74POiLUfbKr/wNc/n0TRz0Tz+cxIuQcaO4eaSxySSQ11t
	 ebXUj06Aqaxng==
Date: Thu, 20 Jun 2024 17:11:15 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: mailbox: mediatek,gce-mailbox: Stop
 requiring clock-names
Message-ID: <20240620-pacify-family-c6cdaad66d70@spud>
References: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
 <20240620100750.1075790-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+8p3lhhqGn1CLu0k"
Content-Disposition: inline
In-Reply-To: <20240620100750.1075790-5-angelogioacchino.delregno@collabora.com>


--+8p3lhhqGn1CLu0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:07:50PM +0200, AngeloGioacchino Del Regno wrote:
> On all MediaTek SoCs, each GCE Mailbox have got only one single
> clock, and this is true in both SoCs with a single mailbox and
> ones with multiple mailboxes.
>=20
> Stop requiring clock-names on all GCEs, as there is and there
> will always be only one CMDQ clock per HW instance.

I'd like the commit message here to mention that there are no users
outside of Linux for this before making the property non-required.
And obviously you can only say that if it is true - although I think you
said to me earlier today that U-Boot etc don't support this device, only
Linux.

>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../bindings/mailbox/mediatek,gce-mailbox.yaml        | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index cef9d7601398..ff5d010fbcf0 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -56,17 +56,6 @@ required:
>    - interrupts
>    - clocks
> =20
> -allOf:
> -  - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              const: mediatek,mt8195-gce
> -    then:
> -      required:
> -        - clock-names
> -
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.45.2
>=20

--+8p3lhhqGn1CLu0k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRUowAKCRB4tDGHoIJi
0vxJAP9UxWxnp7qX0VpdMhL+fAihXvXOYRDUuJwD0piTz8VThgD/VoHZrPuBUkOP
2XWUqlQOEjQNdxiq8ne24Nl5UnF5uQM=
=6W/D
-----END PGP SIGNATURE-----

--+8p3lhhqGn1CLu0k--

