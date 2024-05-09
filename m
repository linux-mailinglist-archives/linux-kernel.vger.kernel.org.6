Return-Path: <linux-kernel+bounces-174716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C18C138F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE771C20A96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FADDC1;
	Thu,  9 May 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTGvIKV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE365539A;
	Thu,  9 May 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274679; cv=none; b=A0qDlkfqWhBp17tWUblfXZRcx5veBby/PomAkQcDnmUPLvLiR5lhOR57epuwFP4O5ukPWP0nzFBO4z4K8iv7dHES+vDk1BB0kzQupCBzTHpppDU5/cMwpMuyKZFdgAgaWfguYuVVWdJ+3NA+JDfqhQMVEncyxsSbjbGNQTmyvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274679; c=relaxed/simple;
	bh=YA/u5mUcOxyTQK4E6Daw3gCqDJqZ+z0mf7v0UCWoLp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB/86MWlL63FwoNVunh5LR6IyCgiop/nhllUJzDD44fZEliQfvfTY+Zh/6N3CKpFma5CuTMqpGHzlYk2FYFS3Q6m0sqReSbodxtNKkA/75j0b1Pu/mCwShigq3QiuOu4rWkPPreVCi9pU8ywQmQuiAy3GKlootrh9DT3g8gkthQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTGvIKV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C539C116B1;
	Thu,  9 May 2024 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715274678;
	bh=YA/u5mUcOxyTQK4E6Daw3gCqDJqZ+z0mf7v0UCWoLp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTGvIKV3Q1U4y5xPkrsYLHkZEVfxKI5NSpA/MjGFH9qYIXb8ISw4VmwSYbRo3Wbpt
	 AUc17UJ2ENNqqBx/mzOFCwj4TDG9E5t499JPnvS2tgX6zKQzzyhspPT8OquDgx5LGL
	 ze8dMWHERjQ+aLj+EhFYiM5W0kjPL1KXaK50LQ09aUM1BSrKZIdnS5DfBX7E3jaeSH
	 iZykHvXUCEsYdzCQgK3pG2gzcqvnMmxVb/aWTx2n2kAtKvMQ7UiZ1JHwbt4xnA78Xl
	 f5DLkuB36V41YqYYP9cm4BriMD1pSpZN6rnhWZH7O9ldn3RRwdUsWH2x2dlVJA+Au2
	 ecUhVXGcZxHnA==
Date: Thu, 9 May 2024 18:11:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: fsl,xcvr: Add compatible string
 for i.MX95
Message-ID: <20240509-phonics-wound-58d3435165f0@spud>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
 <1715223460-32662-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o/G3P2Zf+UnkTwok"
Content-Disposition: inline
In-Reply-To: <1715223460-32662-2-git-send-email-shengjiu.wang@nxp.com>


--o/G3P2Zf+UnkTwok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 10:57:37AM +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx95-xcvr" for i.MX95 platform.

That's apparent from the diff. Why is it not compatible with existing
devices?

Cheers,
Conor.

>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Docu=
mentation/devicetree/bindings/sound/fsl,xcvr.yaml
> index 0eb0c1ba8710..1c74a32def09 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> @@ -22,6 +22,7 @@ properties:
>      enum:
>        - fsl,imx8mp-xcvr
>        - fsl,imx93-xcvr
> +      - fsl,imx95-xcvr
> =20
>    reg:
>      items:
> --=20
> 2.34.1
>=20

--o/G3P2Zf+UnkTwok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0DsQAKCRB4tDGHoIJi
0imKAQCYoCen/pDUqt0eydvNAg6kYtqxHG4j0dkiPPhCBQDTugD9ETg2kVQ8oDL8
pD2YGMysprBxoLeYVTWRCjCN8LvUCwU=
=iBRc
-----END PGP SIGNATURE-----

--o/G3P2Zf+UnkTwok--

