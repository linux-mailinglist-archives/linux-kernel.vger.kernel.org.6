Return-Path: <linux-kernel+bounces-435736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BD9E7B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FE2283C75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B235212FB0;
	Fri,  6 Dec 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvqzUsXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300622C6C1;
	Fri,  6 Dec 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523349; cv=none; b=tRxLPDBwA8NANuwEbQlOL+A/onAmW122VRWtJdDHI+23pkeNi4ymjfuiq1xGU3lEnk5G83C5J4IpA0A6ATcFhs4lcprvszt4DZ7btiCyhz6hKq4LJcG8V6zyZk0x4nl6fRsgVRhZlZamtbwGypQDpcIPulAiMX7LI3skJ3GhJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523349; c=relaxed/simple;
	bh=5hI/uypdQ/H8IoEyLiu4ZQJXiF2mNJEIaK8PWV6n+Us=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=Cydu4We1My/mMTtYM4BX+KwwbXKsRiWvOMuK+JtluvsYkqoZzq3L6JlYoEN7BFUtspqsY+hinG3b4KE1JqUFU5VhGCajJG67yr1lHsBlhpSy6jd+/SgWThYmt7YH84kJr45S16xey4BPJZC88a4+B8SUiWUm4nGsCM5gCt45neA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvqzUsXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0D1C4CED1;
	Fri,  6 Dec 2024 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733523349;
	bh=5hI/uypdQ/H8IoEyLiu4ZQJXiF2mNJEIaK8PWV6n+Us=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=GvqzUsXZoGMcNUjVnwdwKwQVvHQX3ZGAVH/1iCL4fI1Att4BK5LiOOpASFiQUA4p1
	 p+bONBwTrRgrlGDAOYAOmowbokEdDtazIvMBcOKBtsi+W3G4dr57OH3vGpUSlNJO1I
	 uwcQ8VtvlQlhR/ktqYNx97hG/IBDHkThDgtQLffUYtHfZKgXIx6VZusZdp0kGT8iiG
	 S1+5EoLHmj9ZIwfRmstGG2N7U7HRbQepRqApC7i0+qlyvQu8UGY1jlZMFXG7AZwQ10
	 A8QMNELaAHuyoclDsPYHiFEw+CZlXv6FmrCw4R77ukLGfhUhEC9TI3FL5d42aDMEx4
	 cm16AMPPg28sg==
Message-ID: <c898338622625cbfc825e8d4cc5f0fff.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OS8PR06MB75418449B451224C5AB46FBFF2302@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com> <20241028053018.2579200-4-ryan_chen@aspeedtech.com> <287924eed186e3b6b52cd13bcf939ab6.sboyd@kernel.org> <SI6PR06MB7535F5D22E3FCCF5C610B307F2552@SI6PR06MB7535.apcprd06.prod.outlook.com> <a68516df98c8b8fb80f094e6e55fcb8d.sboyd@kernel.org> <OS8PR06MB75419637D55A022300E00850F2352@OS8PR06MB7541.apcprd06.prod.outlook.com> <9ccfb478d9a122db6c634e9559e211ff.sboyd@kernel.org> <OS8PR06MB75418449B451224C5AB46FBFF2302@OS8PR06MB7541.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
From: Stephen Boyd <sboyd@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, joel@jms.id.au, krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org
Date: Fri, 06 Dec 2024 14:15:47 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Ryan Chen (2024-12-04 16:48:42)
> > > struct ast2700_clk_info {
> > >         const char *name;
> > >         u8 clk_idx;
> > >         u32 reg;
> > >         u32 type;
> > >         union {
> > >                 struct ast2700_clk_fixed_factor_data factor;
> > >                 struct ast2700_clk_fixed_rate_data rate;
> > >                 struct ast2700_clk_gate_data gate;
> > >                 struct ast2700_clk_div_data div;
> > >                 struct ast2700_clk_pll_data pll;
> > >                 struct ast2700_clk_mux_data mux;
> > >         } data;
> > > };
> > >
> > > struct ast2700_clk_div_data {
> > >         const struct clk_div_table *div_table;
> > >         const struct clk_parent_data *parent;
> > >         u8 bit_shift;
> > >         u8 bit_width;
> > >         u32 reg;
> > > };
> > >
> > > static const struct ast2700_clk_info ast2700_scu0_clk_info[]
> > > __initconst =3D { ...........................
> > >         DIVIDER_CLK(SCU0_CLK_AHB, "soc0-ahb", soc0_ahbmux,
> >=20
> > Can you also show what soc0_ahbmux is?
> It will be following.=20
>=20
> static const struct clk_parent_data soc0_ahbmux[] =3D {
>         { .fw_name =3D "soc0-ahbmux", .name =3D "soc0-ahbmux" },
> };

Instead of that, please use only the index.

 static const struct clk_parent_data soc0_ahbmux[] =3D {
         { .index =3D <number from DT binding> },
 };

