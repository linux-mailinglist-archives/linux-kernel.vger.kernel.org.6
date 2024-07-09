Return-Path: <linux-kernel+bounces-246614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5792C454
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9351C22142
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9D185616;
	Tue,  9 Jul 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH2tVJe7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D3185600;
	Tue,  9 Jul 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555685; cv=none; b=aHLVVYq/vOcIjdQDcDbdWtyxMscopBOQ7cgoRN12Yxhh2tbNfWQJdpKzRgJv9n8X2FuVbRL2PTUWkipRmO0bCQlAeqI265OcVi/OZBFCR1nSCohJFY802gM2j9t6uEIhc26d7xXCIhw9QugR1+suZLfhD5czzDUqoVInoxhZFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555685; c=relaxed/simple;
	bh=MoR3W7mtnrB2W6ItWK+BYwzrIvTxtgWGdPafp0dW8lc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Z6iT1/W7uKGLRu++i3zCwB0jJ75CrYLT98eMtJpTzyeoDsBlg4xEMdxVPsFtuwiELqu+WHCvrtYi+RtquSEomOCQEHaN2KFCfF/G/2FoyFpPfC02TplJZKOKgpxGKEV5qRKbStUp0ATGRoQq1P5e4XFxgzCRK96Dfn1gJeGHkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH2tVJe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2742DC3277B;
	Tue,  9 Jul 2024 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720555685;
	bh=MoR3W7mtnrB2W6ItWK+BYwzrIvTxtgWGdPafp0dW8lc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vH2tVJe75PG/wmvoNdRJu7ygGtePWAHIyb649iPACNg40ONqxuqGCZP/tWo2/WK3C
	 JTxUIXa3UAkNwoE21ghpoIY3HKuI1gWLQJk7YQy8D0yehvWlheOyzCRxm8nbQ2uwp1
	 lC46OkDE9Sp2NsCLklpNT2nXjIOcXRoMUVZFUZxD/E6wyC5qsnitjjPZrDb+0OoMH6
	 Kxxh62/Y2i86bkBWxvjWmyBjHX2r81Kzf6F11561hVwoYBVCNU3cQtzPpppuHz1SiP
	 tNv/IbpFDd0QPw8RR2DGPt0b2cwAkWI2BTydh33dwhkSA1J8MvnegI4GXGI0GvB0S8
	 woDB0JVC7iIeQ==
Message-ID: <065ab85945db26eed25ea874fce92524.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA+D8APumdP97QQHObF6NEw6jwDJRb+0R=aAjqftrX1wR170Yw@mail.gmail.com>
References: <1719996771-11220-1-git-send-email-shengjiu.wang@nxp.com> <232c2342061b17b9f750c4ad52b0766e.sboyd@kernel.org> <CAA+D8APumdP97QQHObF6NEw6jwDJRb+0R=aAjqftrX1wR170Yw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: imx8: Add .name for "acm_aud_clk0_sel" and "acm_aud_clk1_sel"
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, mturquette@baylibre.com, peng.fan@nxp.com, s.hauer@pengutronix.de, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 09 Jul 2024 13:08:03 -0700
User-Agent: alot/0.10

Quoting Shengjiu Wang (2024-07-08 20:20:56)
> On Tue, Jul 9, 2024 at 6:45=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> >
> > Quoting Shengjiu Wang (2024-07-03 01:52:51)
> > > "acm_aud_clk0_sel" and "acm_aud_clk1_sel" are registered by this ACM
> > > driver, but they are the parent clocks for other clocks, in order to
> > > use assigned-clock-parents in device tree, they need to have the
> > > global name.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx8-acm.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx=
8-acm.c
> > > index 1bdb480cc96c..a1affcf6daff 100644
> > > --- a/drivers/clk/imx/clk-imx8-acm.c
> > > +++ b/drivers/clk/imx/clk-imx8-acm.c
> > > @@ -114,8 +114,8 @@ static const struct clk_parent_data imx8qm_mclk_o=
ut_sels[] =3D {
> > >  static const struct clk_parent_data imx8qm_mclk_sels[] =3D {
> > >         { .fw_name =3D "aud_pll_div_clk0_lpcg_clk" },
> > >         { .fw_name =3D "aud_pll_div_clk1_lpcg_clk" },
> > > -       { .fw_name =3D "acm_aud_clk0_sel" },
> > > -       { .fw_name =3D "acm_aud_clk1_sel" },
> > > +       { .fw_name =3D "acm_aud_clk0_sel", .name =3D "acm_aud_clk0_se=
l" },
> > > +       { .fw_name =3D "acm_aud_clk1_sel", .name =3D "acm_aud_clk1_se=
l" },
> >
> > This doesn't make any sense. Why are we adding fallback names?  Is
> > "acm_aud_clk0_sel" not part of the DT binding for this clk controller?
>=20
> It is not part of DT binding for this clk controller.  it is registered b=
y this
> clk controller itself.  As it is a parent clock, so my understanding
> is that we need to add a fallback name,  or change "fw_name" to "name",
> please correct me if I am wrong.

If it's registered by this clk controller itself then it should be a
clk_hw pointer and not use any string name.

