Return-Path: <linux-kernel+bounces-244960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79892AC40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827541F22E73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC9D6F2E3;
	Mon,  8 Jul 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+xozJoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068845BEF;
	Mon,  8 Jul 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478743; cv=none; b=fTybRQDwbVUrT+MLJ0zWGgR+xE+qgArhbXgehnzsehxaUquRpAi7gTyRb/5fI7xtQWBW5ZYIW2xgbl304lgDyn9VIU8IYLoM8KyVSBKImIeHei91G5FAu3EPa2d7AWCVjVK3Huqc8k97igqBBFCK/0fPzWfTvrbFMEMc9PobSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478743; c=relaxed/simple;
	bh=5Bj4mfHABx1NE5EIeXJOYIM0rpkZPkJMea6TmXqAFOE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YqNHi84L6uwEi1s9Rdyz/32GGM2+Obe1O377du6OmzW1MgUaXm+d29Z2mwTHxaQGJkyJpMaVD3pf0bqKjc7okVln8xz+ERr8CeOZQRKslrO7j6yFLhG30svYZhex7JmBSFK2sZ5bpbM7OMt2tFaFThSpUQJXFm7qc1XK7JXRvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+xozJoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23195C116B1;
	Mon,  8 Jul 2024 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720478743;
	bh=5Bj4mfHABx1NE5EIeXJOYIM0rpkZPkJMea6TmXqAFOE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=I+xozJoNsd4zVOsALiXWV96n36e7MJp4cZ4XcSlGG8x4EsVSEy+CULfd2+jFDkHMw
	 VLPxhrQxYnjGwbg2h0yskTbMhAEexZc34OohD1N6Jyh9z8jQMXswUsga+viODi0mbW
	 NvAQaRGrht1EZGbmm2pU7KZM5XR9qUl1o4t5wuqj/vY7SClwIn+MadEVPQPXCY2qBU
	 +gm6ERKxktjJAMlyG81RsIon0e6SpXKAv0GqzdFVTdky26NazKWpUgTDjxZgr6xVeM
	 UikPXyp5yRpwwdcCAIEB5IlDspIfUrtYADoKNaTag1DlRNuWPNfe/FVE5bvgoMyU4q
	 4pFoVIDhGWKDA==
Message-ID: <232c2342061b17b9f750c4ad52b0766e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1719996771-11220-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719996771-11220-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8: Add .name for "acm_aud_clk0_sel" and "acm_aud_clk1_sel"
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, mturquette@baylibre.com, peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@gmail.com
Date: Mon, 08 Jul 2024 15:45:40 -0700
User-Agent: alot/0.10

Quoting Shengjiu Wang (2024-07-03 01:52:51)
> "acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this ACM
> driver, but they are the parent clocks for other clocks, in order to
> use assigned-clock-parents in device tree, they need to have the
> global name.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8-acm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-ac=
m.c
> index 1bdb480cc96c..a1affcf6daff 100644
> --- a/drivers/clk/imx/clk-imx8-acm.c
> +++ b/drivers/clk/imx/clk-imx8-acm.c
> @@ -114,8 +114,8 @@ static const struct clk_parent_data imx8qm_mclk_out_s=
els[] =3D {
>  static const struct clk_parent_data imx8qm_mclk_sels[] =3D {
>         { .fw_name =3D "aud_pll_div_clk0_lpcg_clk" },
>         { .fw_name =3D "aud_pll_div_clk1_lpcg_clk" },
> -       { .fw_name =3D "acm_aud_clk0_sel" },
> -       { .fw_name =3D "acm_aud_clk1_sel" },
> +       { .fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_sel" },
> +       { .fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_sel" },

This doesn't make any sense. Why are we adding fallback names?  Is
"acm_aud_clk0_sel" not part of the DT binding for this clk controller?

