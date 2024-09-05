Return-Path: <linux-kernel+bounces-317682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B016596E21D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEC41C243E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6BC18453F;
	Thu,  5 Sep 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0khjj1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D91C2E;
	Thu,  5 Sep 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561356; cv=none; b=PMgQAu/QztR62TQj57FMPfoqMOASDpgnPGeQvyDrRd2ojqLjRuR2EpDofOryOUSM2PKIiwT5gn79jbcFil26vjNdiIRi5t3lkJsH4sUedepmFcKKMuIkZ6PXUvet6g0ijZiVNmTxxwcIm9J8ujJqm6UuXFVw7rkYek7k2i49gQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561356; c=relaxed/simple;
	bh=9+6JobrVEwIavAn3NGahdy36dtq2BeTyTirWMDBGnn4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pwsMMrgndLk6Qe1G0O9OAMQpnZlXCIgPIIDEU2Wa0LFPKSlolCwbb8v25WI5PUXp92GzoKUyzmvLcJa3zg2QHbFj/SuWz3mYNFwlzGJgQqg/WyLIiJADmwge2BCey3yJoCS2nueGAyrvIGy4UIBoP46cRs+RR04dX8aaH3mPOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0khjj1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26869C4CEC3;
	Thu,  5 Sep 2024 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561356;
	bh=9+6JobrVEwIavAn3NGahdy36dtq2BeTyTirWMDBGnn4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=a0khjj1h60pfADjGb3JE0RdMlDTMCoBUirk7J8QwefOdR+D7v4y3Q/sAUf5JWnWgM
	 +Sv9zwKzY61yJ+SS2fFH45ipNI7mjjxS8Ft5J6wCVAEawhUlLqDYukG5ubdaFVZoWK
	 NDq683OEQJYkV3XvNM0Gs2aPUxWF7HQ8pucizx9XA0f5etZ6q4VThoErz5OdeG81eI
	 PtvdJepXT4Y/PmhjpR3Jv1UZKXN1m3U0unzFFEAZNPolvxI+U0mSagw7LmhHPgXkLJ
	 aqxdTaLDuJBqq/+l8EqNCc7i9cM9BsHWik2geOkHhcV2hUHkFq0DNyIjbcYxRWovS9
	 pqLZMrtPyNKqw==
Message-ID: <0e1436511cadbe5eb6e0b567d61f0cea.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DU0PR01MB9382A24116486931F28843BA9D9C2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
References: <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com> <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com> <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com> <Zs7gXhohOyQ/abOf@linaro.org> <DU0PR01MB9382A2BBCCD8C786121975B89D922@DU0PR01MB9382.eurprd01.prod.exchangelabs.com> <PAXPR04MB84591356511162E61E074221889C2@PAXPR04MB8459.eurprd04.prod.outlook.com> <DU0PR01MB9382A24116486931F28843BA9D9C2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
Subject: Re: [PATCH v4] clk: imx8qxp: Defer instead of failing probe
From: Stephen Boyd <sboyd@kernel.org>
Cc: abelvesa@kernel.org <abelvesa@kernel.org>, linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>, shawnguo@kernel.org <shawnguo@kernel.org>, kernel@pengutronix.de <kernel@pengutronix.de>, s.hauer@pengutronix.de <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>, mturquette@baylibre.com <mturquette@baylibre.com>, festevam@gmail.com <festevam@gmail.com>, imx@lists.linux.dev <imx@lists.linux.dev>, EMC: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
To: Abel Vesa <abel.vesa@linaro.org>, Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>, Peng Fan <peng.fan@nxp.com>
Date: Thu, 05 Sep 2024 11:35:54 -0700
User-Agent: alot/0.10

Quoting Diogo Manuel Pais Silva (2024-09-03 23:50:02)
> When of_clk_parent_fill is ran without all the parent clocks having been
> probed then the probe function will return -EINVAL, making it so that
> the probe isn't attempted again. As fw_devlink is on by default this
> does not usually happen, but if fw_devlink is disabled then it is very
> possible that the parent clock will be probed after the lpcg first
> attempt.
>=20
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>
> ---

Please stop sending as replies to previous patches.

>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx=
8qxp-lpcg.c
> index d0ccaa040225..1c3e1a7df8ca 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct platfor=
m_device *pdev,
>=20
>         ret =3D of_clk_parent_fill(np, parent_names, count);

It would be better to move to struct clk_parent_data here and use the
.index member if possible. That would allow the clks to be registered
without their parent(s) being registered. It lets the core take care of
finding the parents.

