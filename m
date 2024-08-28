Return-Path: <linux-kernel+bounces-305554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9696306B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BD71C21511
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5A1AB513;
	Wed, 28 Aug 2024 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG/Wu4bH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574A328DB;
	Wed, 28 Aug 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870877; cv=none; b=ppuHuuIZoKdkDKBSa1qqtdIBbkYu0aT8Pl6g5MRyks2AeIoKTu32j0QCiCKuXR41xXeKzGwQ241F5irmuY72zTT8h5SZRihZPcIMt4ku4QMcYgcrFmNVcLbWUDbpTzOpWr0l5H7fwFEyYg7TrQuf384vSoWxgac9wOpz0O0Ar3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870877; c=relaxed/simple;
	bh=BWqtKeZjzI89ouRoevpj7gC/9WLPfDVqSv+VnjFUUv4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=hBW3su/CYRivwwv+T/qIqmmV1slY1PdHvNv32mKJ/fQ5P49JL3xYjVf2koPnxkX+LhYWrFujwB5ZEo0DDGz3PIovaTmCZ7gRwwaj+r2eydRm4OTWpU8hdFl8f2dlnnk2+FPljae3S/SE8HVVz+eRDPcsSDb/8MbkVgafdZpkh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG/Wu4bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A123C4CEC0;
	Wed, 28 Aug 2024 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724870876;
	bh=BWqtKeZjzI89ouRoevpj7gC/9WLPfDVqSv+VnjFUUv4=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=QG/Wu4bH7Skgv9fh1+BCAdSlUsc+q6ygbSJwP+eAJzkAkDo/FjXXFnKVLtNtbHmVC
	 xcQRuKe48fV5FFzyL32N9b2GJBiqH/rchG1C6MgwQ7x4o1znlQXFpzUPw5aI3pKfhK
	 qVlspvwIujse9n9OsmH25IPpg9Mmi2+T/+x5DVhYvhumHLEoQPQi5AMrfWNhXwJAAQ
	 sr1UxEJX0N3te3bC2kFfutZ8pZ4ZifyjLi2MdD9uWeDPcv13sA1bjFNUHTAF8z0Bhh
	 PB9Qg6YJkrO/QgJ8wehkqWAAWsSpdBCttQb2/hu+qaaKt9sC8g8FOvSl5TZkUGnRvm
	 oH+c2DMzAXvzA==
Message-ID: <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com> <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
From: Stephen Boyd <sboyd@kernel.org>
To: andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, ryan_chen@aspeedtech.com
Date: Wed, 28 Aug 2024 11:47:54 -0700
User-Agent: alot/0.10

Quoting Ryan Chen (2024-08-27 23:27:40)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 983ef4f36d8c..855b65f2d6dd 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -269,6 +269,16 @@ config COMMON_CLK_ASPEED
>           The G4 and G5 series, including the ast2400 and ast2500, are su=
pported
>           by this driver.
> =20
> +config COMMON_CLK_AST2700
> +       bool "Clock driver for AST2700 SoC"
> +       depends on ARCH_ASPEED || COMPILE_TEST
> +       select MFD_SYSCON

Why is this a syscon?

> +       select RESET_CONTROLLER
> +       help
> +         This driver provides support for clock on AST2700 SoC.
> +         This driver is responsible for managing the various clocks requ=
ired
> +         by the peripherals and cores within the AST2700.
> +
>  config COMMON_CLK_S2MPS11
>         tristate "Clock driver for S2MPS1X/S5M8767 MFD"
>         depends on MFD_SEC_CORE || COMPILE_TEST
> diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c
> new file mode 100644
> index 000000000000..7e0466e73980
> --- /dev/null
> +++ b/drivers/clk/clk-ast2700.c
> @@ -0,0 +1,1198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 ASPEED Technology Inc.
> + * Author: Ryan Chen <ryan_chen@aspeedtech.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
[...]
> +
> +struct ast2700_reset {
> +       void __iomem *base;
> +       struct ast2700_reset_signal const *signal;
> +       struct reset_controller_dev rcdev;
> +};

Please move the reset controller to the drivers/reset directory by means
of using an auxiliary device. There are some existing examples in there
if you grep for auxiliary_device in drivers/reset to help guide.

> +
> +#define to_rc_data(p) container_of(p, struct ast2700_reset, rcdev)
> +
[...]
> +
> +static int ast2700_soc0_clk_init(struct device_node *soc0_node)
> +{
> +       struct clk_hw_onecell_data *clk_data;
> +       void __iomem *clk_base;
[...]
> +                                            0, clk_base + SCU0_CLK_STOP,
> +                                            28, 0, &ast2700_clk_lock);
> +
> +       of_clk_add_hw_provider(soc0_node, of_clk_hw_onecell_get, clk_data=
);
> +
> +       return 0;
> +};
> +
> +CLK_OF_DECLARE_DRIVER(ast2700_soc0, "aspeed,ast2700-scu0", ast2700_soc0_=
clk_init);
> +CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1", ast2700_soc1_=
clk_init);

Why can't this be a platform driver?

