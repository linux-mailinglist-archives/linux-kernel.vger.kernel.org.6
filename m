Return-Path: <linux-kernel+bounces-224587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9759912450
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626571F24351
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671A175544;
	Fri, 21 Jun 2024 11:45:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65816DEB9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970354; cv=none; b=JGImCYGdV1PZnRg+6+Lw+BW+GbP80sOkfZkunCC1mdcRLCZKU303bd8/TDlHPl2UK0NZl3bvnJIHl3Uo5an+1NHgh5oXCBzvbYkBaxti3K/I7neN9CoDTeclNo4M2QpSzhdbNOJbpGUrhFZLlm6/cxkGHcdRNXoB4eAzcy5V74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970354; c=relaxed/simple;
	bh=uWTRWW7B95x3LGJfYoqRdq663wzUpFIq+873sqtjHjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A3T6GRLK/0UTb5Z/lDNp7F3Mv8vv16vcFl69w4pTMXUB6BSGZzYQHrDlsDo+BjSsg1ApcDSiLv+rRiObYEzBGcdPf9EAjzdzyFHzZbfLLU2sOACJeeoP9Zv85uIfO0Ufgt6lpv1PoMHGMug/ojpr38e5Gqek51cFUTAjBLPDWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKchx-00089F-JS; Fri, 21 Jun 2024 13:45:33 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKchu-003vp1-IG; Fri, 21 Jun 2024 13:45:30 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKchu-0008vo-1Y;
	Fri, 21 Jun 2024 13:45:30 +0200
Message-ID: <bd0e85f42ef74f6f927020cbee6879351d1c3e9e.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI
 driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com,  pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org,  prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com,  tmaimon77@gmail.com, andy.shevchenko@gmail.com, 
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
Date: Fri, 21 Jun 2024 13:45:30 +0200
In-Reply-To: <20240619054641.277062-3-shanchun1218@gmail.com>
References: <20240619054641.277062-1-shanchun1218@gmail.com>
	 <20240619054641.277062-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-06-19 at 13:46 +0800, Shan-Chun Hung wrote:
> This adds the SDHCI driver for the MA35 series SoC. It is based upon the
> SDHCI interface, but requires some extra initialization.
>=20
> Signed-off-by: schung <schung@nuvoton.com>
> ---
>  drivers/mmc/host/Kconfig           |  13 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c | 297 +++++++++++++++++++++++++++++
>  3 files changed, 311 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
>=20
[...]
> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-=
of-ma35d1.c
> new file mode 100644
> index 000000000000..7714a5ab463d
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -0,0 +1,297 @@
[...]
> +static int ma35_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct ma35_priv *priv;
> +	int err;
> +	u32 extra, ctl;
> +
> +	host =3D sdhci_pltfm_init(pdev, &sdhci_ma35_pdata,
> +				sizeof(struct ma35_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	/*
> +	 * extra adma table cnt for cross 128M boundary handling.
> +	 */
> +	extra =3D DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> +	if (extra > SDHCI_MAX_SEGS)
> +		extra =3D SDHCI_MAX_SEGS;
> +	host->adma_table_cnt +=3D extra;
> +	pltfm_host =3D sdhci_priv(host);
> +	priv =3D sdhci_pltfm_priv(pltfm_host);
> +
> +	if (dev->of_node) {
> +		pltfm_host->clk =3D devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(pltfm_host->clk)) {
> +			err =3D PTR_ERR(pltfm_host->clk);
> +			dev_err(&pdev->dev, "failed to get clk: %d\n", err);
> +			goto free_pltfm;
> +		}
> +		err =3D clk_prepare_enable(pltfm_host->clk);
> +		if (err)
> +			goto free_pltfm;
> +	}
> +
> +	err =3D mmc_of_parse(host->mmc);
> +	if (err)
> +		goto err_clk;
> +
> +	priv->rst =3D devm_reset_control_get(&pdev->dev, NULL);

Please use devm_reset_control_get_exclusive() instead.

regards
Philipp

