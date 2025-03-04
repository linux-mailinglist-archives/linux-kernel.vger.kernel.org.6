Return-Path: <linux-kernel+bounces-543851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27FA4DAB8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3127A689D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90F1FECAA;
	Tue,  4 Mar 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g197VdAA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FD1FDE35;
	Tue,  4 Mar 2025 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084427; cv=none; b=I36rbJLzOBPNew81pt5sKuktwaj/RVKwDjoaGRLBu429aI8lHPYW/7IJRj7Anfnt7MfjDRiV1m382sdi6UEaOnA+67orgdyGkmgjwb8BDOh+w2umo++Usxtcg4WkyXuUqwMUT2d0uLdf920tra9J5ULbN22wxketdaRVyZn/P30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084427; c=relaxed/simple;
	bh=oxfH1b29Jy5NXagTLRaZznTNYVx5Cxlh0iPVEkxx5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWjLuQImEMa3MCAB7q54e/8QI+GlUW2fZgtB/hW2hxB49Ugaj0mw3k6P9QNTG9iOw4K7/fYfnXiYnCN0o/2BLSy0Im4dDoSjraoUNjIPaSdcNT0D4eSCAXNbajfA1WtTWcoQRYU4lAKkPJbDMljLIZi9jOQOxEzo+cg6G8gPk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g197VdAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4778CC4CEE5;
	Tue,  4 Mar 2025 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084426;
	bh=oxfH1b29Jy5NXagTLRaZznTNYVx5Cxlh0iPVEkxx5ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g197VdAAYYTjRZKbfgFXGAvD7HV6HNzMZEtn3V+Uq4SVwSAu9q4joTn3fDjaC/4gZ
	 QAa69KyTC+qhSiCefQwEw77zkBzKMYQZ2XrDeqoyckA5Yj6EBSlwYSy0QPSGJ25pl2
	 Xad8txPvgBLyyShLVUlmx32yUvyahXcY+qT+fLX4p6dqpJgPLVLaUBI4WG+1DKWIaT
	 NNq3ao2mEHd5kXSwhDKQdVJ9AhBRwiMysYB6umTjCWmB6btNVBdvsgvKFdCGQ3iH6A
	 NDoDcGk++yJPE8OgUK1Lhdc85EUR6zIN7c9rRUS6bCZVz48MHivhnM+Nj7xGvLLUUQ
	 UharaEHU2clxw==
Date: Tue, 4 Mar 2025 11:33:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 1/5] dt-bindings: display: Document DPI color codings
Message-ID: <20250304-deer-of-striking-pride-ff6e86@houat>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-2-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="cj2zylo7nvilgql5"
Content-Disposition: inline
In-Reply-To: <20250304101530.969920-2-victor.liu@nxp.com>


--cj2zylo7nvilgql5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: display: Document DPI color codings
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:15:26PM +0800, Liu Ying wrote:
> Document DPI color codings according to MIPI Alliance Standard for
> Display Pixel Interface(DPI-2) Version 2.00(15 September 2005).
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../bindings/display/dpi-color-coding.yaml    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/dpi-color-c=
oding.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/dpi-color-coding.y=
aml b/Documentation/devicetree/bindings/display/dpi-color-coding.yaml
> new file mode 100644
> index 000000000000..6430d6f1ddd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/dpi-color-coding.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/dpi-color-coding.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MIPI DPI Interface Color Coding
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description:
> +  MIPI Alliance Standard for Display Pixel Interface(DPI-2) Version 2.00=
(15
> +  September 2005) specifies color codings at the DPI interface.
> +
> +properties:
> +  dpi-color-coding:
> +    enum:
> +      - 16bit-configuration1
> +      - 16bit-configuration2
> +      - 16bit-configuration3
> +      - 18bit-configuration1
> +      - 18bit-configuration2
> +      - 24bit

Do we really needs strings there? It would be much better to use an int
plus a header

Maxime

--cj2zylo7nvilgql5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8bXBwAKCRAnX84Zoj2+
dt1IAX9V1mlAI1Gl75oEmrf11qBXqppa8x3GWIJnJLuNlT9ukdKeaLCrQX1wn479
eHm4Ol4BegL0L7cndLVYuxBHxQPptolpuxW4+J/3gbKcG28DPUVdqmmu2icZfev0
HafXHYBLEg==
=Pg8P
-----END PGP SIGNATURE-----

--cj2zylo7nvilgql5--

