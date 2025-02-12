Return-Path: <linux-kernel+bounces-511771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9392A32F71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7EB165F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD082627E3;
	Wed, 12 Feb 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5ynI4nw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E641D5CCC;
	Wed, 12 Feb 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387884; cv=none; b=ohXoFmI7DOG+m+jqtEGGww9yzwdHVQTx6WwYJYVZIgSnOqCBicepGiVtckMy+jnUR6vnMcxquBU1fxzSY1Vs56nbvP5Q6fMcPYl5ijbKHPJocrfN3fabGLG8F+2ySDfGW24c16ZX65AZ1F7NznzuEyBQnbRCTZR/8D30MeAIglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387884; c=relaxed/simple;
	bh=KE8NFBZhke42TjOODGp2XRVLni+shJE2sRyusGK/pag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UePzgj5jOm2L769iXuaGKt272lmkTny2LlSpqsjrzfte9+nKjf5/4Ohwv2ZmzVAr++nZKDqayyqdCJyrNZko/rthwU+wxUMu0+5lAQki4hNjXZeFVawhZTSPa/hoSRgYHrON9hFOjGMkKktuJBylwKqHAiELLFn6xltXiqMl2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5ynI4nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9DC4CEDF;
	Wed, 12 Feb 2025 19:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739387884;
	bh=KE8NFBZhke42TjOODGp2XRVLni+shJE2sRyusGK/pag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5ynI4nwc6w1XNI9qPwckWeV4YuE4E65ocyJWXxfyjAmbKPlnB8qJgHRCG3LYBig1
	 6bGafsyrO2f8/XyQwSaoPiVaQ53Xic3ygFkdmOmHeH9sKpvHpowLJ2sOR62m87jPtY
	 mKavz+BbG7/j0p3ItzfZXC96KbYPTGRyvjfMmCafzxtYRN/H5dm+v09dn7FwKX4M8f
	 MpYAb24OGkh8+kOl/YNvzBBmVw1bg6U2zQq6loB9xTpiuuy4PERbVpIhOLlpntqTMm
	 IC7qm+ycr3pr/rQBStyhe7F7Gbv120TcdHY8uEln7YyhARZv2wz1KeGBH4vJKCbjPP
	 g8pB07jSEpYCQ==
Date: Wed, 12 Feb 2025 19:17:58 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, u.kleine-koenig@baylibre.com,
	amergnat@baylibre.com, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, macpaul.lin@mediatek.com,
	pablo.sun@mediatek.com
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek,mt8188: Add
 VDO1_DPI1_HDMI clock
Message-ID: <20250212-arming-gyration-103e42b94ed6@spud>
References: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LekUKq0CadfRs7yd"
Content-Disposition: inline
In-Reply-To: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>


--LekUKq0CadfRs7yd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:03:41AM +0100, AngeloGioacchino Del Regno wrote:
> Add binding for the HDMI TX clock found in the VDO1 controller.
> While at it, also remove the unused CLK_VDO1_NR_CLK.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  include/dt-bindings/clock/mediatek,mt8188-clk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/clock/mediatek,mt8188-clk.h b/include/dt=
-bindings/clock/mediatek,mt8188-clk.h
> index bd5cd100b796..0e87f61c90f4 100644
> --- a/include/dt-bindings/clock/mediatek,mt8188-clk.h
> +++ b/include/dt-bindings/clock/mediatek,mt8188-clk.h
> @@ -721,6 +721,6 @@
>  #define CLK_VDO1_DPINTF				58
>  #define CLK_VDO1_DISP_MONITOR_DPINTF		59
>  #define CLK_VDO1_26M_SLOW			60
> -#define CLK_VDO1_NR_CLK				61
> +#define CLK_VDO1_DPI1_HDMI			61

Acked-by: Conor Dooley <conor.dooley@microchip.com>

btw, I see the mt8195 has this same CLK_VDO1_NR_CLK define in it, if you
fancy getting rid of that too.

--LekUKq0CadfRs7yd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6zz5gAKCRB4tDGHoIJi
0lA+AP9ZvwrE6cb7EIWC6+imuEZ4+HNaO4ihg1Gx2VOD2gTcogD9EUucq+I84ADz
YOvqTsY6j0BbiLvG+Hw8gfslDBKozAI=
=Pmfl
-----END PGP SIGNATURE-----

--LekUKq0CadfRs7yd--

