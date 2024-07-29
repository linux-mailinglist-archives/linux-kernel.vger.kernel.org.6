Return-Path: <linux-kernel+bounces-266566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1139401B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9BD1F22A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1518EFF1;
	Mon, 29 Jul 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF3BOcBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37838145FE5;
	Mon, 29 Jul 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722295383; cv=none; b=VFY3Y5viqE69B3udNC4so1+xX6nVprjh9s88hUE8r/ggH2amdYgI0glMCYCBAz1WPcVeSszFIkcNNz2gYp7/80/ahnBzlQtplD3R7uwbUMTYqmJj+e359LLYW323U3qFkTRQ/Jcsh2UQq1WoHTFwJ7G9H1NxpWkiEqJlWhDLfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722295383; c=relaxed/simple;
	bh=xHexflFziBqP6cLpKuiGNaoJLuxa+BVhHINNAm5b+0k=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=huZsemNjMqR7TTNNphfvMtX2nIj0eptA+PD3QQizWdLuEzG1DpmbDLtQvU8f2VZb6GUOW7yycXNr19kIo0amznVa/hQeiGAKeHyEI5d204seh1SPp78wcofj/I+mDvZW4b87enQFbyVRk84AG2O5i0UrU4SC97nV0cXdvAm0dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF3BOcBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA886C32786;
	Mon, 29 Jul 2024 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722295382;
	bh=xHexflFziBqP6cLpKuiGNaoJLuxa+BVhHINNAm5b+0k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MF3BOcBM5OUwCa8C2Q72qzgAUBsD4yvq75nA8WbSFKcYkHpr9Rl8EpCFf7tjkIEQZ
	 eHxSB9LsCIkP9ZF/JXPw9f1AaGywDGEQVe0SDW0hjxEXcRv0wBk/0I3Fhcg+ZURBiI
	 QAMecrEn6LiMIWO2JKAROvt/9rnNaD2VCC2x+0NMTWckVVhlY8hT+n65CSeqMj8TzZ
	 FAfAbRBQuE9yhCVYfQT2vEO20DGZ2gffpDF4cZrVIR+/MsxJEbqFt1MkfKPQF1YCJS
	 XoQvgFSr6yZH5rae4nzyu5GQHba/l3XKmTfZXgWTSvW6HL5ZozhCu5G9OElcZ2FSVy
	 C8Ic1GlotKorQ==
Message-ID: <817eef56fa3dcd4238198c7a964adfef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201844.710365-2-thorsten.blum@toblux.com>
References: <20240710201844.710365-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH] clk: hisilicon: Remove unnecessary local variable
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, abel.vesa@linaro.org, angelogioacchino.delregno@collabora.com, christophe.jaillet@wanadoo.fr, dinguyen@kernel.org, erick.archer@gmx.com, mturquette@baylibre.com, robh@kernel.org
Date: Mon, 29 Jul 2024 16:23:00 -0700
User-Agent: alot/0.10

Quoting Thorsten Blum (2024-07-10 13:18:45)
> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/=
clk-hi3559a.c
> index c79a94f6d9d2..30d5a6ba8fa5 100644
> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> @@ -407,7 +407,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_h=
w *hw,
>                 unsigned long parent_rate)
>  {
>         struct hi3559av100_clk_pll *clk =3D to_pll_clk(hw);
> -       u64 frac_val, fbdiv_val, refdiv_val;
> +       u64 frac_val, fbdiv_val;
>         u32 postdiv1_val, postdiv2_val;
>         u32 val;

I see 'val' is u32 here.

>         u64 tmp, rate;
> @@ -435,13 +435,12 @@ static unsigned long clk_pll_recalc_rate(struct clk=
_hw *hw,
>         val =3D readl_relaxed(clk->ctrl_reg2);
>         val =3D val >> clk->refdiv_shift;
>         val &=3D ((1 << clk->refdiv_width) - 1);
> -       refdiv_val =3D val;
> =20
>         /* rate =3D 24000000 * (fbdiv + frac / (1<<24) ) / refdiv  */
>         rate =3D 0;
>         tmp =3D 24000000 * fbdiv_val + (24000000 * frac_val) / (1 << 24);
>         rate +=3D tmp;
> -       do_div(rate, refdiv_val);
> +       do_div(rate, val);

So this can be div_u64() now?

>         do_div(rate, postdiv1_val * postdiv2_val);

