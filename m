Return-Path: <linux-kernel+bounces-305690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9E9632E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B54DB23091
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E31B14FB;
	Wed, 28 Aug 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/r1rjdB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B61AED3C;
	Wed, 28 Aug 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877902; cv=none; b=J99pOZDPQGPBv0ebSARdbVF+gpjMGzxQ0fgCgK3Ow/Zd1eQWv+SdPlY1dBil51LgMyabN1znDhZuQSCbbZ2aZV+noNHHYidivVuvFeDeVaBCxtcP9rER9cnWPwA3iD753el76A4a1MUduAUEa8b4npzxWuNL1XbgZBc9xW2Z2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877902; c=relaxed/simple;
	bh=r9OLa9sCrMPtwOvE5eP/+AJtMKA8f2kxrWtEkh/K8HM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pLdnEGAgexjN4w817nFXaOgsfLB6pnqIqKu7BvGg4b6QfurZIwD3jF7sOgT1Zim+YFAjOborAtHvE8SfUqheerW+XmtbRB2d7A8E4KflPcL6zLaCmbl9UcW6O2deBeFJSEZHgpCTnR3o4ktj2Oe7P4xkdr+aj0qQv5BUeQ7/eGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/r1rjdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA45CC4CEC0;
	Wed, 28 Aug 2024 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724877901;
	bh=r9OLa9sCrMPtwOvE5eP/+AJtMKA8f2kxrWtEkh/K8HM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j/r1rjdBjIUQUeG86lJ+MGdf6VkjChDXj4mljfW6hsEHCyolrbg0Oz3qqCOGXJN5b
	 iZFGQMwHdX9NcwSPyQniulKg5WxpUSMD0DSwrs5yiKKfYwk0mRJEdK+RPtl+YKGm8G
	 egNRXMNmyMG+uBReyvcm/Aq871LrhvRrq53HyvgnLNYalylfHu2gg5PbJbO1XdDEq+
	 uFsjW8QJv2N+9wUFpsD8X/QS/cpDzRiMSpOyA88az0TA3w3dljFFnbm39w2NY/4/MO
	 dhTEtWNZGOF+dQhLfvHMceez98SgK6sVRS5rEnXzyo1laRTBh9lKMPj2E0bolTBOVT
	 ZygV9OMf+uu/w==
Message-ID: <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240715-ep93xx-v11-3-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me> <20240715-ep93xx-v11-3-4e924efda795@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, nikita.shubin@maquefel.me
Date: Wed, 28 Aug 2024 13:44:59 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-07-15 01:38:07)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3e9099504fad..234b0a8b7650 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -218,6 +218,14 @@ config COMMON_CLK_EN7523
>           This driver provides the fixed clocks and gates present on Airo=
ha
>           ARM silicon.
> =20
> +config COMMON_CLK_EP93XX
> +       bool "Clock driver for Cirrus Logic ep93xx SoC"

tristate?

> +       depends on ARCH_EP93XX || COMPILE_TEST
> +       select MFD_SYSCON

Why is this selecting syscon?

> +       select REGMAP

Is this needed either?

> +       help
> +         This driver supports the SoC clocks on the Cirrus Logic ep93xx.
> +
>  config COMMON_CLK_FSL_FLEXSPI
>         tristate "Clock driver for FlexSPI on Layerscape SoCs"
>         depends on ARCH_LAYERSCAPE || COMPILE_TEST
> diff --git a/drivers/clk/clk-ep93xx.c b/drivers/clk/clk-ep93xx.c
> new file mode 100644
> index 000000000000..bb1cf59a3d47
> --- /dev/null
> +++ b/drivers/clk/clk-ep93xx.c
> @@ -0,0 +1,846 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Clock control for Cirrus EP93xx chips.
> + * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/clock.c:
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + */
> +#define pr_fmt(fmt) "ep93xx " KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk-provider.h>
> +#include <linux/math.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/soc/cirrus/ep93xx.h>
> +#include <dt-bindings/clock/cirrus,ep9301-syscon.h>
> +
> +#include <asm/div64.h>
[...]
> +
> +static const char adc_divisors[] =3D { 16, 4 };

These are global symbols in terms of namespace because we're in the
kernel. Please prefix with ep93xx_ to help tags.

> +static const char sclk_divisors[] =3D { 2, 4 };
> +static const char lrclk_divisors[] =3D { 32, 64, 128 };
> +
> +struct ep93xx_clk {
> +       struct clk_hw hw;
> +       u16 idx;
> +       u16 reg;
> +       u32 mask;
> +       u8 bit_idx;
> +       u8 shift;
> +       u8 width;
> +       u8 num_div;
> +       const char *div;
> +};
> +
> +struct ep93xx_clk_priv {
> +       spinlock_t lock;
> +       struct ep93xx_regmap_adev *aux_dev;
> +       struct device *dev;
> +       void __iomem *base;
> +       struct regmap *map;
> +       struct clk_hw *fixed[21];

Please make a define for '21'.

> +       struct ep93xx_clk reg[];
> +};
[...]
> +
> +static const struct clk_ops ep93xx_div_ops =3D {
> +       .enable =3D ep93xx_clk_enable,
> +       .disable =3D ep93xx_clk_disable,
> +       .is_enabled =3D ep93xx_clk_is_enabled,
> +       .recalc_rate =3D ep93xx_div_recalc_rate,
> +       .round_rate =3D ep93xx_div_round_rate,
> +       .set_rate =3D ep93xx_div_set_rate,
> +};
> +
> +static int clk_hw_register_div(struct ep93xx_clk *clk,

Please call this something like ep93xx_register_div(). It doesn't take a
clk_hw pointer so the clk_hw prefix doesn't make sense. This same
comment applies to other clk_hw prefixed functions in this file.

> +                              const char *name,
> +                              struct clk_parent_data *parent_data,

const?

> +                              unsigned int reg,
> +                              u8 enable_bit,
> +                              u8 shift,
> +                              u8 width,
> +                              const char *clk_divisors,
> +                              u8 num_div)
> +{
> +       struct ep93xx_clk_priv *priv =3D ep93xx_priv_from(clk);
> +       struct clk_init_data init =3D { };
> +
> +       init.name =3D name;
> +       init.ops =3D &ep93xx_div_ops;
> +       init.flags =3D 0;
> +       init.parent_data =3D parent_data;
> +       init.num_parents =3D 1;
> +
> +       clk->reg =3D reg;
> +       clk->bit_idx =3D enable_bit;
> +       clk->mask =3D GENMASK(shift + width - 1, shift);
> +       clk->shift =3D shift;
> +       clk->div =3D clk_divisors;
> +       clk->num_div =3D num_div;
> +       clk->hw.init =3D &init;
> +
> +       return devm_clk_hw_register(priv->dev, &clk->hw);
> +}
> +
> +struct ep93xx_gate {
> +       unsigned int idx;
> +       unsigned int bit;
> +       const char *name;
> +};
> +
> +static const struct ep93xx_gate ep93xx_uarts[] =3D {
> +       { EP93XX_CLK_UART1, EP93XX_SYSCON_DEVCFG_U1EN, "uart1" },
> +       { EP93XX_CLK_UART2, EP93XX_SYSCON_DEVCFG_U2EN, "uart2" },
> +       { EP93XX_CLK_UART3, EP93XX_SYSCON_DEVCFG_U3EN, "uart3" },
> +};
> +
> +static int ep93xx_uart_clock_init(struct ep93xx_clk_priv *priv)
> +{
> +       struct clk_parent_data parent_data =3D { };
> +       unsigned int i, idx, ret, clk_uart_div;
> +       struct ep93xx_clk *clk;
> +       u32 val;
> +
> +       regmap_read(priv->map, EP93XX_SYSCON_PWRCNT, &val);
> +       if (val & EP93XX_SYSCON_PWRCNT_UARTBAUD)
> +               clk_uart_div =3D 1;
> +       else
> +               clk_uart_div =3D 2;
> +
> +       priv->fixed[EP93XX_CLK_UART] =3D
> +               clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1,=
 clk_uart_div);

Pass a device instead of NULL. Don't use string names for parent ^

> +       parent_data.hw =3D priv->fixed[EP93XX_CLK_UART];
> +
> +       /* parenting uart gate clocks to uart clock */
> +       for (i =3D 0; i < ARRAY_SIZE(ep93xx_uarts); i++) {
> +               idx =3D ep93xx_uarts[i].idx - EP93XX_CLK_UART1;
> +               clk =3D &priv->reg[idx];
> +               clk->idx =3D idx;
> +               ret =3D ep93xx_clk_register_gate(clk,
> +                                       ep93xx_uarts[i].name,
> +                                       &parent_data, CLK_SET_RATE_PARENT,
> +                                       EP93XX_SYSCON_DEVCFG,
> +                                       ep93xx_uarts[i].bit);
> +               if (ret)
> +                       return dev_err_probe(priv->dev, ret,
> +                                            "failed to register uart[%d]=
 clock\n", i);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct ep93xx_gate ep93xx_dmas[] =3D {
> +       { EP93XX_CLK_M2M0, EP93XX_SYSCON_PWRCNT_DMA_M2M0, "m2m0" },
> +       { EP93XX_CLK_M2M1, EP93XX_SYSCON_PWRCNT_DMA_M2M1, "m2m1" },
> +       { EP93XX_CLK_M2P0, EP93XX_SYSCON_PWRCNT_DMA_M2P0, "m2p0" },
> +       { EP93XX_CLK_M2P1, EP93XX_SYSCON_PWRCNT_DMA_M2P1, "m2p1" },
> +       { EP93XX_CLK_M2P2, EP93XX_SYSCON_PWRCNT_DMA_M2P2, "m2p2" },
> +       { EP93XX_CLK_M2P3, EP93XX_SYSCON_PWRCNT_DMA_M2P3, "m2p3" },
> +       { EP93XX_CLK_M2P4, EP93XX_SYSCON_PWRCNT_DMA_M2P4, "m2p4" },
> +       { EP93XX_CLK_M2P5, EP93XX_SYSCON_PWRCNT_DMA_M2P5, "m2p5" },
> +       { EP93XX_CLK_M2P6, EP93XX_SYSCON_PWRCNT_DMA_M2P6, "m2p6" },
> +       { EP93XX_CLK_M2P7, EP93XX_SYSCON_PWRCNT_DMA_M2P7, "m2p7" },
> +       { EP93XX_CLK_M2P8, EP93XX_SYSCON_PWRCNT_DMA_M2P8, "m2p8" },
> +       { EP93XX_CLK_M2P9, EP93XX_SYSCON_PWRCNT_DMA_M2P9, "m2p9" },
> +};
> +
> +static int ep93xx_dma_clock_init(struct ep93xx_clk_priv *priv)
> +{
> +       struct clk_parent_data parent_data =3D { };
> +       unsigned int i, idx;
> +
> +       parent_data.hw =3D priv->fixed[EP93XX_CLK_HCLK];
> +       for (i =3D 0; i < ARRAY_SIZE(ep93xx_dmas); i++) {
> +               idx =3D ep93xx_dmas[i].idx;
> +               priv->fixed[idx] =3D devm_clk_hw_register_gate_parent_dat=
a(priv->dev,
> +                                       ep93xx_dmas[i].name,
> +                                       &parent_data, 0,
> +                                       priv->base + EP93XX_SYSCON_PWRCNT,
> +                                       ep93xx_dmas[i].bit,
> +                                       0,
> +                                       &priv->lock);
> +               if (IS_ERR(priv->fixed[idx]))
> +                       return PTR_ERR(priv->fixed[idx]);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct clk_hw *of_clk_ep93xx_get(struct of_phandle_args *clkspec,=
 void *data)
> +{
> +       struct ep93xx_clk_priv *priv =3D data;
> +       unsigned int idx =3D clkspec->args[0];
> +
> +       if (idx < EP93XX_CLK_UART1)
> +               return priv->fixed[idx];
> +
> +       if (idx <=3D EP93XX_CLK_I2S_LRCLK)
> +               return &priv->reg[idx - EP93XX_CLK_UART1].hw;
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +/*
> + * PLL rate =3D 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / =
2^PS
> + */
> +static unsigned long calc_pll_rate(u64 rate, u32 config_word)
> +{
> +       rate *=3D ((config_word >> 11) & GENMASK(4, 0)) + 1;      /* X1FB=
D */
> +       rate *=3D ((config_word >> 5) & GENMASK(5, 0)) + 1;       /* X2FB=
D */
> +       do_div(rate, (config_word & GENMASK(4, 0)) + 1);        /* X2IPD =
*/
> +       rate >>=3D (config_word >> 16) & GENMASK(1, 0);           /* PS */
> +
> +       return rate;
> +}
> +
> +#define devm_ep93xx_clk_hw_register_fixed_rate_parent_data(dev, name, pa=
rent_data, flags, fixed_rate)  \
> +       __clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL, \
> +                                    (parent_data), (flags), (fixed_rate)=
, 0, 0, true)

Is this to workaround a missing devm_clk_hw_register_fixed_rate_parent_data=
() macro?

