Return-Path: <linux-kernel+bounces-307405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF0964D39
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968631F22B34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2851B790F;
	Thu, 29 Aug 2024 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY/8sdlE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3F4D8C1;
	Thu, 29 Aug 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953839; cv=none; b=Q1TKeAHv5+NIMj0Ul8RpTRwoBG1nBw8O/o7P+T0+YdURBXBxN3d3iYZQy/PtKsLMTjCc+F1I/MThStNtcdDll7lSRgBShKbLk1FQhdzefxJDIPN66QhPL1fGFooAVJ8ppXlhyjLTvFL8fBn3Ch7gG0XKYVF9kwnxWV5FwcnnfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953839; c=relaxed/simple;
	bh=Xy3NW4pFyHQqbMAZ00aMDkY+SK+roG6AjV6zLmJQKB4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=LqoHFDgzHHJC2DyILWvRZ2ikpAvuaBCtr7zMm7eGofKpESgoh0DR7sXCbxqjgooskyCaDrUMjgqzs8dJ5G/ztOOj3fEQsCDudIt79ebQ2oQFRCrzDaNxNdj3I/VJwHJrB3ocByI2QL2r32gdPpKsAVWUDJzwd2BRzfGDWZrNJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY/8sdlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A1C4CEC1;
	Thu, 29 Aug 2024 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953839;
	bh=Xy3NW4pFyHQqbMAZ00aMDkY+SK+roG6AjV6zLmJQKB4=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=gY/8sdlER4kFUWz2FBBAW3hOJ0idxFM12wivu7B21nS+1jiGPY5bWo0FGYDNGmzJZ
	 QpbxFv9OROwSSfuX2jqB4WHkP7hpR2IIzyq9irjlluazTmX3aQzquyWy9HxEeQFB1G
	 lP82I8WJRsORObFpaojziBrCrs91ZzWGBO6ig1+m9YM8l3vkHprJlb0Gam5bAz8HdI
	 a+OdbQ26HGCdmJU05TVbSLk+q0deArTeWRGBGWoSWR20yGnnLAr4SuCN0RQ86g5opS
	 oMBonC02+nhTT+FjSbUfmDWYOHvLN4+FjKsoNJ+xUuvHKaf32/++qC4b0TTq27MHsT
	 PfFglx6fbbggA==
Message-ID: <3569ef6d81adc41330c4002752ba3aa9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OS8PR06MB7541F12972412AE565A93287F2962@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com> <20240828062740.1614744-4-ryan_chen@aspeedtech.com> <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org> <OS8PR06MB7541F12972412AE565A93287F2962@OS8PR06MB7541.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
From: Stephen Boyd <sboyd@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org
Date: Thu, 29 Aug 2024 10:50:37 -0700
User-Agent: alot/0.10

Quoting Ryan Chen (2024-08-29 00:09:12)
> > Subject: Re: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
> >=20
> > Quoting Ryan Chen (2024-08-27 23:27:40)
> > > a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new file mode
> > > 100644 index 000000000000..7e0466e73980
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-ast2700.c
> > > @@ -0,0 +1,1198 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2024 ASPEED Technology Inc.
> > > + * Author: Ryan Chen <ryan_chen@aspeedtech.com>  */
> > > +
> > > +#include <linux/bits.h>
> > > +#include <linux/clk-provider.h>
> > [...]
> > > +
> > > +struct ast2700_reset {
> > > +       void __iomem *base;
> > > +       struct ast2700_reset_signal const *signal;
> > > +       struct reset_controller_dev rcdev; };
> >=20
> > Please move the reset controller to the drivers/reset directory by mean=
s of
> > using an auxiliary device. There are some existing examples in there if=
 you
> > grep for auxiliary_device in drivers/reset to help guide.
>=20
> Do you mean to have another reset controller driver?
> If yes, I may need syscon for remap two drivers.

Yes. A syscon is not necessary to do that.

> >=20
> > > +
> > > +#define to_rc_data(p) container_of(p, struct ast2700_reset, rcdev)
> > > +
> > [...]
> > > +
> > > +static int ast2700_soc0_clk_init(struct device_node *soc0_node) {
> > > +       struct clk_hw_onecell_data *clk_data;
> > > +       void __iomem *clk_base;
> > [...]
> > > +                                            0, clk_base +
> > SCU0_CLK_STOP,
> > > +                                            28, 0,
> > > + &ast2700_clk_lock);
> > > +
> > > +       of_clk_add_hw_provider(soc0_node, of_clk_hw_onecell_get,
> > > + clk_data);
> > > +
> > > +       return 0;
> > > +};
> > > +
> > > +CLK_OF_DECLARE_DRIVER(ast2700_soc0, "aspeed,ast2700-scu0",
> > > +ast2700_soc0_clk_init); CLK_OF_DECLARE_DRIVER(ast2700_soc1,
> > > +"aspeed,ast2700-scu1", ast2700_soc1_clk_init);
> >=20
> > Why can't this be a platform driver?
> Due to clk and reset will be the first driver in core.
> Do you think all drivers should be platform driver?

Yes all drivers should be a platform driver.

