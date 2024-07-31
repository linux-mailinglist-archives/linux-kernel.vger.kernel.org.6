Return-Path: <linux-kernel+bounces-269901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A3943842
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9AE1C20A09
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA3916C869;
	Wed, 31 Jul 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st6nFkJe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F371AA3CC;
	Wed, 31 Jul 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722462632; cv=none; b=UGeuIrnhV8fVviB3NVWnqjmh8QtXVXhyvIrb6HmR/a2sle5+dndBRSzcVV1Ad5nF1o0HFkl6IxR6B4a20JWtJahxCM2BuN6u4IQlo/hgWfQlvWV5I3feCB8Pzhdx1OjqJo4QNWh762W6LO9qv5kOBJzWF+6oQ0eQDRwPdtGNEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722462632; c=relaxed/simple;
	bh=0azJuawRfkEQ9HX+igteIayZs72LS6c7O2Oeet8LuRo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BBzqx1z8k7x1HEwGzETHxVMMuVFXCyWTyGvUECHs7k14nocrqiUE0D2lUHzPuY4F1SW5DauoFI9+z4xgvQbio9N5CsEFDmOnQwlozFDfTM5JPOIic67BBkAc8xFi115ArUiWAadx+WCfUQsQTKr+2eV1YPA8mDJygQMIsEjdFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st6nFkJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E55C116B1;
	Wed, 31 Jul 2024 21:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722462631;
	bh=0azJuawRfkEQ9HX+igteIayZs72LS6c7O2Oeet8LuRo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=st6nFkJeVyvso6mJ9pYQILExCWK2BJ6swehZjA0W/wcofPPej2A8Qz6aXDpOvJ1ga
	 q+W7xaPeswbUOw9If9CPZLsh2LWdaYRqs24VYZiUJkS9sXd9AMsxA9U+pXY3YjtEOc
	 ydhx3fq/O/4byPRVkWqyxW8KgSCl3tvTXf9RbDD4WBn6wCh2nw34q4wyzux3Uh43p1
	 9D72vOzPGyxpnzzKdXHC1f0x+ilTJs3T0cZ30BLsKl/8CPFZwnpZUl2OWagewSQjoF
	 Hf1qhG7L7fnRBhjcBPECFqIgXeFkG26mE07xLG2GfuTsB4/xzEbgXoQUWHhmadi98w
	 iVvfmdhYZ8DOg==
Message-ID: <f8da29fb6aa8e212f786521b92c10163.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2E69FE3D-5D1B-4952-959F-06603BA21D98@toblux.com>
References: <20240710201844.710365-2-thorsten.blum@toblux.com> <817eef56fa3dcd4238198c7a964adfef.sboyd@kernel.org> <2E69FE3D-5D1B-4952-959F-06603BA21D98@toblux.com>
Subject: Re: [PATCH] clk: hisilicon: Remove unnecessary local variable
From: Stephen Boyd <sboyd@kernel.org>
Cc: abel.vesa@linaro.org, angelogioacchino.delregno@collabora.com, christophe.jaillet@wanadoo.fr, dinguyen@kernel.org, erick.archer@gmx.com, mturquette@baylibre.com, robh@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Thorsten Blum <thorsten.blum@toblux.com>
Date: Wed, 31 Jul 2024 14:50:29 -0700
User-Agent: alot/0.10

Quoting Thorsten Blum (2024-07-30 15:13:34)
> On 30. Jul 2024, at 01:23, Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Thorsten Blum (2024-07-10 13:18:45)
> >> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilic=
on/clk-hi3559a.c
> >> index c79a94f6d9d2..30d5a6ba8fa5 100644
> >> --- a/drivers/clk/hisilicon/clk-hi3559a.c
> >> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> >> @@ -407,7 +407,7 @@ static unsigned long clk_pll_recalc_rate(struct cl=
k_hw *hw,
> >>                unsigned long parent_rate)
> >> {
> >>        struct hi3559av100_clk_pll *clk =3D to_pll_clk(hw);
> >> -       u64 frac_val, fbdiv_val, refdiv_val;
> >> +       u64 frac_val, fbdiv_val;
> >>        u32 postdiv1_val, postdiv2_val;
> >>        u32 val;
> >=20
> > I see 'val' is u32 here.
> >=20
> >>        u64 tmp, rate;
> >> @@ -435,13 +435,12 @@ static unsigned long clk_pll_recalc_rate(struct =
clk_hw *hw,
> >>        val =3D readl_relaxed(clk->ctrl_reg2);
> >>        val =3D val >> clk->refdiv_shift;
> >>        val &=3D ((1 << clk->refdiv_width) - 1);
> >> -       refdiv_val =3D val;
> >>=20
> >>        /* rate =3D 24000000 * (fbdiv + frac / (1<<24) ) / refdiv  */
> >>        rate =3D 0;
> >>        tmp =3D 24000000 * fbdiv_val + (24000000 * frac_val) / (1 << 24=
);
> >>        rate +=3D tmp;
> >> -       do_div(rate, refdiv_val);
> >> +       do_div(rate, val);
> >=20
> > So this can be div_u64() now?
>=20
> Yes, it could be.
>=20
> Is div_u64() preferred over do_div() when the remainder doesn't matter?

Yes. The comment above the function says

  This is the most common 64bit divide and should be used if possible,
  as many 32bit archs can optimize this variant better than a full 64bit
  divide.

