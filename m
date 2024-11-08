Return-Path: <linux-kernel+bounces-401862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959679C2040
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217FC1F241F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C19202628;
	Fri,  8 Nov 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="t+x/QbDS"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4C2003D5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079299; cv=none; b=adV9tm9lrX6Ct0rK23TyiNdgZoyVtwjhKJMCMAX7TNg7oob0sbE/2NISD4it0DVqT5B+Di1rt8DuQh7COdHGWaxCw3rL7gZFiDDgwPZSrXp66JKUx+9BHswkOJ6NM5oAVmoesGNlYkp4gZEWly0eaHT+G6flyphcTWwe06BdNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079299; c=relaxed/simple;
	bh=e+Pa8YWopsKAa8QiJ2eunYriZ42+6huIs58dZW7ia7Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LRWWEwwSSovgLRcMy6dLcnKsyaxaTN1n089BQ2EOwy4jfTJtyh6zqDbuIzJ/uKhmb0HKB0yGwoXbUowY5YcHdRxsP74CC9h6p456be3S38lLrsSYNaeMSL0kAQycBl2Hc4e5W1dHODsEcFemP0yohMF+bcEzL84HaMemoh69BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=t+x/QbDS; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1731079294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbapVfiISm/C5v4STghpJz/FC3c1tBmcfEax3HYjIC8=;
	b=t+x/QbDSVdb7on8vS3OSrapcTgojup2aIR6Cy24hufGcWfv9y+GVzYVVrnV8q9YQg/jGwz
	RoYJft2EYWVmF+VMIF15NSgGLI6J1TjJC5XxKgDHpk3htlWU8AHGpa3IeZLIYPOH+QYcR6
	xFRuQyuJdc0B82KgSFh5b1OrNSkRivnqEiq8gs2QzZdRBkl6H1HCfCtwQELZ1FJBjVKUCn
	lQEQWVmgWTz7eQKGvFJvqoI3VxghiGAPONykjBDc1nIOTPSH4PzuR54+x3h86l48yc0+xY
	FW/f+Yg1BJp2nCVkNUdD2aYqMcw2K2Wxn+6p58iB1KZTBTSjsPzX+7eruVlDyg==
Content-Type: multipart/signed;
 boundary=4dd0f36deef0a2c52894bfee2e5787b1a3b4ab4cc0e383fc236d6d0b6477;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 08 Nov 2024 16:21:24 +0100
Message-Id: <D5GWE4WJZMM8.1MPHPPQR2QW46@cknow.org>
Cc: <dsimic@manjaro.org>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, "Heiko Stuebner"
 <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] drm/rockchip: dsi: convert to dev_err_probe in probe
 function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>,
 <linux-rockchip@lists.infradead.org>, <dri-devel@lists.freedesktop.org>
References: <20241108144425.1009916-1-heiko@sntech.de>
In-Reply-To: <20241108144425.1009916-1-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

--4dd0f36deef0a2c52894bfee2e5787b1a3b4ab4cc0e383fc236d6d0b6477
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 8, 2024 at 3:44 PM CET, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> DRM_DEV_ERROR is deprecated and using dev_err_probe saves quite a number
> of lines too, so convert the error prints for the dsi-driver.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Should this have a Fixes tag?
Because in the PineTab2 case it reported an error, which was actually
just a deferred probe.

> ---
>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 80 ++++++-------------
>  1 file changed, 26 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 58a44af0e9ad..3224ab749352 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> ...
> @@ -1378,67 +1376,47 @@ static int dw_mipi_dsi_rockchip_probe(struct plat=
form_device *pdev)
>  		i++;
>  	}
> =20
> -	if (!dsi->cdata) {
> -		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> -		return -EINVAL;
> -	}
> +	if (!dsi->cdata)
> +		return dev_err_probe(dev, -EINVAL, "No dsi-config for %s node\n", np->=
name);
> =20
>  	/* try to get a possible external dphy */
>  	dsi->phy =3D devm_phy_optional_get(dev, "dphy");
> -	if (IS_ERR(dsi->phy)) {
> -		ret =3D PTR_ERR(dsi->phy);
> -		DRM_DEV_ERROR(dev, "failed to get mipi dphy: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(dsi->phy))
> +		return dev_err_probe(dev, PTR_ERR(dsi->phy), "Failed to get mipi dphy\=
n");

I think from this line.

Cheers,
  Diederik

> =20
>  	dsi->pclk =3D devm_clk_get(dev, "pclk");
> -	if (IS_ERR(dsi->pclk)) {
> -		ret =3D PTR_ERR(dsi->pclk);
> -		DRM_DEV_ERROR(dev, "Unable to get pclk: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(dsi->pclk))
> +		return dev_err_probe(dev, PTR_ERR(dsi->pclk), "Unable to get pclk\n");
> =20
>  	dsi->pllref_clk =3D devm_clk_get(dev, "ref");
>  	if (IS_ERR(dsi->pllref_clk)) {
> -		if (dsi->phy) {
> +		if (dsi->phy)
>  			/*
>  			 * if external phy is present, pll will be
>  			 * generated there.
>  			 */
>  			dsi->pllref_clk =3D NULL;
> -		} else {
> -			ret =3D PTR_ERR(dsi->pllref_clk);
> -			DRM_DEV_ERROR(dev,
> -				      "Unable to get pll reference clock: %d\n",
> -				      ret);
> -			return ret;
> -		}
> +		else
> +			return dev_err_probe(dev, PTR_ERR(dsi->pllref_clk),
> +					     "Unable to get pll reference clock\n");
>  	}
> =20
>  	if (dsi->cdata->flags & DW_MIPI_NEEDS_PHY_CFG_CLK) {
>  		dsi->phy_cfg_clk =3D devm_clk_get(dev, "phy_cfg");
> -		if (IS_ERR(dsi->phy_cfg_clk)) {
> -			ret =3D PTR_ERR(dsi->phy_cfg_clk);
> -			DRM_DEV_ERROR(dev,
> -				      "Unable to get phy_cfg_clk: %d\n", ret);
> -			return ret;
> -		}
> +		if (IS_ERR(dsi->phy_cfg_clk))
> +			return dev_err_probe(dev, PTR_ERR(dsi->phy_cfg_clk),
> +					     "Unable to get phy_cfg_clk\n");
>  	}
> =20
>  	if (dsi->cdata->flags & DW_MIPI_NEEDS_GRF_CLK) {
>  		dsi->grf_clk =3D devm_clk_get(dev, "grf");
> -		if (IS_ERR(dsi->grf_clk)) {
> -			ret =3D PTR_ERR(dsi->grf_clk);
> -			DRM_DEV_ERROR(dev, "Unable to get grf_clk: %d\n", ret);
> -			return ret;
> -		}
> +		if (IS_ERR(dsi->grf_clk))
> +			return dev_err_probe(dev, PTR_ERR(dsi->grf_clk), "Unable to get grf_c=
lk\n");
>  	}
> =20
>  	dsi->grf_regmap =3D syscon_regmap_lookup_by_phandle(np, "rockchip,grf")=
;
> -	if (IS_ERR(dsi->grf_regmap)) {
> -		DRM_DEV_ERROR(dev, "Unable to get rockchip,grf\n");
> -		return PTR_ERR(dsi->grf_regmap);
> -	}
> +	if (IS_ERR(dsi->grf_regmap))
> +		return dev_err_probe(dev, PTR_ERR(dsi->grf_regmap), "Unable to get roc=
kchip,grf\n");
> =20
>  	dsi->dev =3D dev;
>  	dsi->pdata.base =3D dsi->base;
> ...


--4dd0f36deef0a2c52894bfee2e5787b1a3b4ab4cc0e383fc236d6d0b6477
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZy4sdgAKCRDXblvOeH7b
bs6QAP9s5Ew76jJkNqCXwe5IlvoY4Fy0rg7N0YgsTnhrcB1TIAEAzoK75L8/hZIu
nxxBEI37Ah9YK1707qq4PYkorbQbFgo=
=fOhD
-----END PGP SIGNATURE-----

--4dd0f36deef0a2c52894bfee2e5787b1a3b4ab4cc0e383fc236d6d0b6477--

