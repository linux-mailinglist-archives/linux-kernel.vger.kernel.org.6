Return-Path: <linux-kernel+bounces-309515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F21966C2B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7890A2850EC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1431C1AD3;
	Fri, 30 Aug 2024 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M71grJzl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1741BDAB1;
	Fri, 30 Aug 2024 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056180; cv=none; b=JvbdUddawi0m6Lnur9vmffniFNE1D8uOVHFgagBb2pC+srnppZ7wqduarar72tNi3ODbrsbKRaom//RxHUf/4zyshRAxmjNXVCq3jfsULPh7XFyl+MQRQkwxWUwBsq/Gz9qmA9PiUHJ3ztDsVeM2gr77/CRbsnxWd58lcJx+Ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056180; c=relaxed/simple;
	bh=fJOk64w1KvNsgFSNifgZViqLAi1eNKi+j0BhblwmrqI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=dSkeA3tF2v+r8/wXl7Zr6iQ2EZThmKvFyXSWXGyqEXCNCr2xsY4aFsbAWG1i7JllT6aPQZehoAXxJ5WYAOJFKp00I+x2qyV++Tp0qrRlgGYjnitrRmWRYYvNwizqFKjG55hTzPaoUl9mPz3pdbNd4flLnkrowEioY4zXQW3Rf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M71grJzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966AC4CEC2;
	Fri, 30 Aug 2024 22:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725056180;
	bh=fJOk64w1KvNsgFSNifgZViqLAi1eNKi+j0BhblwmrqI=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=M71grJzlvDD6cLtOVpcRPMqiP3ECPrxcF6jYFTtWUOZYK2zIxVVnixshiJ/zCiqU0
	 HGNwMPngVcz3Cxkt5qRTeLfER3GJScGke3fhsK+eQwPWJa4lzZEdI0pxwgak+e3Pdi
	 DUk+1AEFZ7ds7SlcKDm3YeDFgOVb72p50fn2HAzr4Of7uONRlzlrZ48aPAykaP7CsZ
	 G6ZBalQyGL5+OpO9l7XEGqbx27MtkJ6qBivaU1/djv5FJYti9h58Lrhhy8Xn0k/Orq
	 m9L/ofkc3+rmzH1SyDr0iGe4vNrZuSaOXePM/e4DhXUnHA8t6JhTFgS96MlL6N4Pge
	 8c3BWK9Y0ebKQ==
Message-ID: <45c7cf75876c5822f8c51f05375af507.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <OS8PR06MB7541BFDC6D2E490ECDAE085CF2972@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com> <20240828062740.1614744-4-ryan_chen@aspeedtech.com> <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org> <OS8PR06MB7541F12972412AE565A93287F2962@OS8PR06MB7541.apcprd06.prod.outlook.com> <3569ef6d81adc41330c4002752ba3aa9.sboyd@kernel.org> <OS8PR06MB7541BFDC6D2E490ECDAE085CF2972@OS8PR06MB7541.apcprd06.prod.outlook.com>
Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
From: Stephen Boyd <sboyd@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org
Date: Fri, 30 Aug 2024 15:16:18 -0700
User-Agent: alot/0.10

Quoting Ryan Chen (2024-08-30 00:50:21)
> > Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
> >=20
> > Quoting Ryan Chen (2024-08-29 00:09:12)
> > > > Subject: Re: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
> > > >
> > > > Quoting Ryan Chen (2024-08-27 23:27:40)
> > > > > a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new file
> > > > > mode
> > > > > 100644 index 000000000000..7e0466e73980
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/clk-ast2700.c
> > > > > @@ -0,0 +1,1198 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2024 ASPEED Technology Inc.
> > > > > + * Author: Ryan Chen <ryan_chen@aspeedtech.com>  */
> > > > > +
> > > > > +#include <linux/bits.h>
> > > > > +#include <linux/clk-provider.h>
> > > > [...]
> > > > > +
> > > > > +struct ast2700_reset {
> > > > > +       void __iomem *base;
> > > > > +       struct ast2700_reset_signal const *signal;
> > > > > +       struct reset_controller_dev rcdev; };
> > > >
> > > > Please move the reset controller to the drivers/reset directory by
> > > > means of using an auxiliary device. There are some existing examples
> > > > in there if you grep for auxiliary_device in drivers/reset to help =
guide.
> > >
> > > Do you mean to have another reset controller driver?
> > > If yes, I may need syscon for remap two drivers.
> >=20
> > Yes. A syscon is not necessary to do that.
> Thanks for point out auxiliary device.
> Since our SoC reset and clock share the same register region.
> Your recommend will use clk auxiliary_device_add for reset driver am I ri=
ght?

Yes. Either the clk or the reset driver can be a platform driver and the
other an auxiliary driver.

