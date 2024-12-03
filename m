Return-Path: <linux-kernel+bounces-430330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5A9E2FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C43B28C22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01820A5DB;
	Tue,  3 Dec 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoF4aw4g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9461362;
	Tue,  3 Dec 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266234; cv=none; b=iCFPP574pEBlAA5Iq8raryEeBM/U1M44RMso5IYii92HrMCcFGN1s6JLSjoywANVJC7EjuI/6EVZit1JC8BAg3n5xz7xaVfI91o8wG37FfdHuXOS6Xciff3Fe607Q3JM553Qot/gn1P56Prpk074novKguqVwkJ6RHS4GzGRoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266234; c=relaxed/simple;
	bh=xpMyFwhRCnmcEjI08hn/SUz/O7fqhnlbsjpYSWl1Yyk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=o6+wLnTZF6eGYV5IoEmU4vAPzS2ksoXPmc8DRY7sHVxNLk10OX6JcCKwcZRj11L4QrcZGPXUHu+gNYKwVcdUf0XJdDfbP+ZY9mcgaumrKZY1Ks57VVRuqmwDuAajNJEN3oNMJohlPiWfS8c2OpEPOC3MQ7CpeTtSFBSH+ZpiN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoF4aw4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA6C4CEDC;
	Tue,  3 Dec 2024 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733266233;
	bh=xpMyFwhRCnmcEjI08hn/SUz/O7fqhnlbsjpYSWl1Yyk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UoF4aw4glikqFASKrgnnQeNUaYaK2nGi+qG3uJhjUbFSmdhPCSOFdMl4VNP0uGqmM
	 AeX4wnePyKZcjYaFJ8o493ncSfpEYtU/1zEfyhDdAl95+lHnSLhLlVJOUMGTbgjvWb
	 QBLcz6e1JlHzT0fvu9CqMMCqNcazkUOOSp1/ooSsCl4A7PJsK58ErCEcyDfpXEJzDi
	 00luS40McWXBhczuJ/a06nHx0BJgVkJCZpJCVdxm3awwX7a84iGD47CUmAuuSjfzZa
	 zK2As/Gl88QPG1lP/w3WMqeHqCG4VrWJGXcSMK9SNv24pHiysPTD9tVAHyJpgR+Ygf
	 ssofq1Ym2x4kg==
Message-ID: <e53adbf9fdf6e3f142083b0d40d074ca.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241128-monstrous-embargo-a665d921410d@wendy>
References: <20241002-private-unequal-33cfa6101338@spud> <20241002-hula-unwashed-1c4ddbadbec2@spud> <2b49c4df-a34a-42c5-8d44-9e47da630fe8@linaro.org> <1jwmiqsks3.fsf@starbuckisacylon.baylibre.com> <20241003-tacking-ladylike-dfe2b633e647@spud> <20241106-freefall-slider-db379b05821e@spud> <430bde3b35382e640843e32a9f351326.sboyd@kernel.org> <20241128-monstrous-embargo-a665d921410d@wendy>
Subject: Re: [PATCH v1 08/11] clk: move meson clk-regmap implementation to common code
From: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, Daire McNamara <daire.mcnamara@microchip.com>, pierre-henry.moussay@microchip.com, valentina.fernandezalanis@microchip.com, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 03 Dec 2024 14:50:31 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Conor Dooley (2024-11-28 02:36:16)
> On Thu, Nov 14, 2024 at 05:29:54PM -0800, Stephen Boyd wrote:
> > Quoting Conor Dooley (2024-11-06 04:56:25)
> > > My use case doesn't
> > > actually need the registration code changes either as, currently, onl=
y reg
> > > gets set at runtime, but leaving that out is a level of incomplete I'=
d not
> > > let myself away with.
> > > Obviously shoving the extra members into the clk structs has the down=
side
> > > of taking up a pointer and a offset worth of memory for each clock of
> > > that type registered, but it is substantially easier to support devic=
es
> > > with multiple regmaps that way. Probably moot though since the approa=
ch you
> > > suggested in the thread linked above that implements a clk_hw_get_reg=
map()
> > > has to store a pointer to the regmap's identifier which would take up=
 an
> > > identical amount of memory.
> >=20
> > We don't need to store the regmap identifier in the struct clk. We can
> > store it in the 'struct clk_init_data' with some new field, and only do
> > that when/if we actually need to. We would need to pass the init data to
> > the clk_ops::init() callback though. We currently knock that out during
> > registration so that clk_hw->init is NULL. Probably we can just set that
> > to NULL after the init routine runs in __clk_core_init().
> >=20
> > Long story short, don't add something to 'struct clk_core', 'struct
> > clk', or 'struct clk_hw' for these details. We can have a 'struct
> > clk_regmap_hw' that everyone else can build upon:
> >=20
> >   struct clk_regmap_hw {
> >         struct regmap *regmap;
> >         struct clk_hw hw;
> >   };
>=20
> What's the point of this? I don't understand why you want to do this over
> what clk_divider et al already do, where clk_hw and the iomem pointer
> are in the struct itself.

Can you give an example? I don't understand what you're suggesting. I
prefer a struct clk_regmap_hw like above so that the existing struct
clk_hw in the kernel aren't increased by a pointer. SoC drivers can use
the same struct as a replacement for their struct clk_hw member today.

