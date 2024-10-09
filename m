Return-Path: <linux-kernel+bounces-356731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D29965DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A774284431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2E18D645;
	Wed,  9 Oct 2024 09:49:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E852E18871D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467358; cv=none; b=LaWtFIWG0kFiO5N+GcejWzO0dy1GqYDpR5L3ncXkIXFTLDlpOxFNNbwa8pCNou5jMAEz2PwuE346WX/tFrk8Dh4GDDuKly1KUHbFv2xgyZNX+vJnUFclho3i80o7XklHQpUVCgypHybxJGFPofFxbSh3NQM4SzBrqtds6/OKRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467358; c=relaxed/simple;
	bh=6w//ZbY5ycgZCu6bpJ5NweHU1STFZHe0UMb/HLlDP4U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPocMHBsHG+XEttwn4mQuKHAKeI0QxRI8zXEgGjxobFU/uF4L2I49lpix7woV23zBFOVo/e63+zFiO7Tj+9cAkwcEAqY4vPpOh3fv1DWTuVbgk+ECx6h7Il3dom4LruXBbPCuL5l/JYTJQgBBYAKt1OVhllVJPWin0n6xdVWqAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTJW-0004cP-U6; Wed, 09 Oct 2024 11:49:02 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTJW-000ZhV-Ew; Wed, 09 Oct 2024 11:49:02 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTJW-000636-1E;
	Wed, 09 Oct 2024 11:49:02 +0200
Message-ID: <c4193d6115773a9bb9cb2616d5833165a64144c3.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/3] reset: aspeed: register AST2700 reset auxiliary
 bus device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>, dmitry.baryshkov@linaro.org, 
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au,  linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org
Date: Wed, 09 Oct 2024 11:49:02 +0200
In-Reply-To: <20241009060521.2971168-3-ryan_chen@aspeedtech.com>
References: <20241009060521.2971168-1-ryan_chen@aspeedtech.com>
	 <20241009060521.2971168-3-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2024-10-09 at 14:05 +0800, Ryan Chen wrote:
> The AST2700 reset driver is registered as an auxiliary device
> due to reset and clock controller share the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/reset/Kconfig        |   7 +
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-aspeed.c | 256 +++++++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 drivers/reset/reset-aspeed.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 67bce340a87e..71a3accea7cb 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -22,6 +22,13 @@ config RESET_A10SR
>  	  This option enables support for the external reset functions for
>  	  peripheral PHYs on the Altera Arria10 System Resource Chip.
> =20
> +config RESET_ASPEED
> +	tristate "ASPEED Reset Driver"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	select AUXILIARY_BUS
> +	help
> +	  This enables the reset controller driver for AST2700.
> +
>  config RESET_ATH79
>  	bool "AR71xx Reset Driver" if COMPILE_TEST
>  	default ATH79
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 27b0bbdfcc04..97482bb56416 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -5,6 +5,7 @@ obj-y +=3D starfive/
>  obj-y +=3D sti/
>  obj-y +=3D tegra/
>  obj-$(CONFIG_RESET_A10SR) +=3D reset-a10sr.o
> +obj-$(CONFIG_RESET_ASPEED) +=3D reset-aspeed.o
>  obj-$(CONFIG_RESET_ATH79) +=3D reset-ath79.o
>  obj-$(CONFIG_RESET_AXS10X) +=3D reset-axs10x.o
>  obj-$(CONFIG_RESET_BCM6345) +=3D reset-bcm6345.o
> diff --git a/drivers/reset/reset-aspeed.c b/drivers/reset/reset-aspeed.c
> new file mode 100644
> index 000000000000..8a2a68ac442b
> --- /dev/null
> +++ b/drivers/reset/reset-aspeed.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 ASPEED Technology Inc.
> + */
> +
> +#include <linux/auxiliary_bus.h>

Missing

#include <linux/cleanup.h>

for guard().

> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/reset/aspeed,ast2700-scu.h>
> +
> +#define SCU0_RESET_CTRL1 0x200
> +#define SCU0_RESET_CTRL2 0x220
> +#define SCU1_RESET_CTRL1 0x200
> +#define SCU1_RESET_CTRL2 0x220
> +#define SCU1_PCIE3_CTRL 0x908
> +
> +struct ast2700_reset_signal {
> +	bool dedicated_clr; /* dedicated reset clr offset */
> +	u32 offset, bit;
> +};
> +
> +struct aspeed_reset_info {
> +	unsigned int nr_resets;
> +	const struct ast2700_reset_signal *signal;
> +};
> +
> +struct aspeed_reset {
> +	struct reset_controller_dev rcdev;
> +	struct aspeed_reset_info *info;
> +	spinlock_t lock; /* Protect read-modify-write cycle */
> +	void __iomem *base;
> +};
> +
> +static const struct ast2700_reset_signal ast2700_reset0_signals[] =3D {
> +	[SCU0_RESET_SDRAM] =3D { true, SCU0_RESET_CTRL1, BIT(0) },
> +	[SCU0_RESET_DDRPHY] =3D { true, SCU0_RESET_CTRL1, BIT(1) },
> +	[SCU0_RESET_RSA] =3D { true, SCU0_RESET_CTRL1, BIT(2) },
> +	[SCU0_RESET_SHA3] =3D { true, SCU0_RESET_CTRL1, BIT(3) },
> +	[SCU0_RESET_HACE] =3D { true, SCU0_RESET_CTRL1, BIT(4) },
> +	[SCU0_RESET_SOC] =3D { true, SCU0_RESET_CTRL1, BIT(5) },
> +	[SCU0_RESET_VIDEO] =3D { true, SCU0_RESET_CTRL1, BIT(6) },
> +	[SCU0_RESET_2D] =3D { true, SCU0_RESET_CTRL1, BIT(7) },
> +	[SCU0_RESET_PCIS] =3D { true, SCU0_RESET_CTRL1, BIT(8) },
> +	[SCU0_RESET_RVAS0] =3D { true, SCU0_RESET_CTRL1, BIT(9) },
> +	[SCU0_RESET_RVAS1] =3D { true, SCU0_RESET_CTRL1, BIT(10) },
> +	[SCU0_RESET_SM3] =3D { true, SCU0_RESET_CTRL1, BIT(11) },
> +	[SCU0_RESET_SM4] =3D { true, SCU0_RESET_CTRL1, BIT(12) },
> +	[SCU0_RESET_CRT0] =3D { true, SCU0_RESET_CTRL1, BIT(13) },
> +	[SCU0_RESET_ECC] =3D { true, SCU0_RESET_CTRL1, BIT(14) },
> +	[SCU0_RESET_DP_PCI] =3D { true, SCU0_RESET_CTRL1, BIT(15) },
> +	[SCU0_RESET_UFS] =3D { true, SCU0_RESET_CTRL1, BIT(16) },
> +	[SCU0_RESET_EMMC] =3D { true, SCU0_RESET_CTRL1, BIT(17) },
> +	[SCU0_RESET_PCIE1RST] =3D { true, SCU0_RESET_CTRL1, BIT(18) },
> +	[SCU0_RESET_PCIE1RSTOE] =3D { true, SCU0_RESET_CTRL1, BIT(19) },
> +	[SCU0_RESET_PCIE0RST] =3D { true, SCU0_RESET_CTRL1, BIT(20) },
> +	[SCU0_RESET_PCIE0RSTOE] =3D { true, SCU0_RESET_CTRL1, BIT(21) },
> +	[SCU0_RESET_JTAG] =3D { true, SCU0_RESET_CTRL1, BIT(22) },
> +	[SCU0_RESET_MCTP0] =3D { true, SCU0_RESET_CTRL1, BIT(23) },
> +	[SCU0_RESET_MCTP1] =3D { true, SCU0_RESET_CTRL1, BIT(24) },
> +	[SCU0_RESET_XDMA0] =3D { true, SCU0_RESET_CTRL1, BIT(25) },
> +	[SCU0_RESET_XDMA1] =3D { true, SCU0_RESET_CTRL1, BIT(26) },
> +	[SCU0_RESET_H2X1] =3D { true, SCU0_RESET_CTRL1, BIT(27) },
> +	[SCU0_RESET_DP] =3D { true, SCU0_RESET_CTRL1, BIT(28) },
> +	[SCU0_RESET_DP_MCU] =3D { true, SCU0_RESET_CTRL1, BIT(29) },
> +	[SCU0_RESET_SSP] =3D { true, SCU0_RESET_CTRL1, BIT(30) },
> +	[SCU0_RESET_H2X0] =3D { true, SCU0_RESET_CTRL1, BIT(31) },
> +	[SCU0_RESET_PORTA_VHUB] =3D { true, SCU0_RESET_CTRL2, BIT(0) },
> +	[SCU0_RESET_PORTA_PHY3] =3D { true, SCU0_RESET_CTRL2, BIT(1) },
> +	[SCU0_RESET_PORTA_XHCI] =3D { true, SCU0_RESET_CTRL2, BIT(2) },
> +	[SCU0_RESET_PORTB_VHUB] =3D { true, SCU0_RESET_CTRL2, BIT(3) },
> +	[SCU0_RESET_PORTB_PHY3] =3D { true, SCU0_RESET_CTRL2, BIT(4) },
> +	[SCU0_RESET_PORTB_XHCI] =3D { true, SCU0_RESET_CTRL2, BIT(5) },
> +	[SCU0_RESET_PORTA_VHUB_EHCI] =3D { true, SCU0_RESET_CTRL2, BIT(6) },
> +	[SCU0_RESET_PORTB_VHUB_EHCI] =3D { true, SCU0_RESET_CTRL2, BIT(7) },
> +	[SCU0_RESET_UHCI] =3D { true, SCU0_RESET_CTRL2, BIT(8) },
> +	[SCU0_RESET_TSP] =3D { true, SCU0_RESET_CTRL2, BIT(9) },
> +	[SCU0_RESET_E2M0] =3D { true, SCU0_RESET_CTRL2, BIT(10) },
> +	[SCU0_RESET_E2M1] =3D { true, SCU0_RESET_CTRL2, BIT(11) },
> +	[SCU0_RESET_VLINK] =3D { true, SCU0_RESET_CTRL2, BIT(12) },
> +};
> +
> +static const struct ast2700_reset_signal ast2700_reset1_signals[] =3D {
> +	[SCU1_RESET_LPC0] =3D { true, SCU1_RESET_CTRL1, BIT(0) },
> +	[SCU1_RESET_LPC1] =3D { true, SCU1_RESET_CTRL1, BIT(1) },
> +	[SCU1_RESET_MII] =3D { true, SCU1_RESET_CTRL1, BIT(2) },
> +	[SCU1_RESET_PECI] =3D { true, SCU1_RESET_CTRL1, BIT(3) },
> +	[SCU1_RESET_PWM] =3D { true, SCU1_RESET_CTRL1, BIT(4) },
> +	[SCU1_RESET_MAC0] =3D { true, SCU1_RESET_CTRL1, BIT(5) },
> +	[SCU1_RESET_MAC1] =3D { true, SCU1_RESET_CTRL1, BIT(6) },
> +	[SCU1_RESET_MAC2] =3D { true, SCU1_RESET_CTRL1, BIT(7) },
> +	[SCU1_RESET_ADC] =3D { true, SCU1_RESET_CTRL1, BIT(8) },
> +	[SCU1_RESET_SD] =3D { true, SCU1_RESET_CTRL1, BIT(9) },
> +	[SCU1_RESET_ESPI0] =3D { true, SCU1_RESET_CTRL1, BIT(10) },
> +	[SCU1_RESET_ESPI1] =3D { true, SCU1_RESET_CTRL1, BIT(11) },
> +	[SCU1_RESET_JTAG1] =3D { true, SCU1_RESET_CTRL1, BIT(12) },
> +	[SCU1_RESET_SPI0] =3D { true, SCU1_RESET_CTRL1, BIT(13) },
> +	[SCU1_RESET_SPI1] =3D { true, SCU1_RESET_CTRL1, BIT(14) },
> +	[SCU1_RESET_SPI2] =3D { true, SCU1_RESET_CTRL1, BIT(15) },
> +	[SCU1_RESET_I3C0] =3D { true, SCU1_RESET_CTRL1, BIT(16) },
> +	[SCU1_RESET_I3C1] =3D { true, SCU1_RESET_CTRL1, BIT(17) },
> +	[SCU1_RESET_I3C2] =3D { true, SCU1_RESET_CTRL1, BIT(18) },
> +	[SCU1_RESET_I3C3] =3D { true, SCU1_RESET_CTRL1, BIT(19) },
> +	[SCU1_RESET_I3C4] =3D { true, SCU1_RESET_CTRL1, BIT(20) },
> +	[SCU1_RESET_I3C5] =3D { true, SCU1_RESET_CTRL1, BIT(21) },
> +	[SCU1_RESET_I3C6] =3D { true, SCU1_RESET_CTRL1, BIT(22) },
> +	[SCU1_RESET_I3C7] =3D { true, SCU1_RESET_CTRL1, BIT(23) },
> +	[SCU1_RESET_I3C8] =3D { true, SCU1_RESET_CTRL1, BIT(24) },
> +	[SCU1_RESET_I3C9] =3D { true, SCU1_RESET_CTRL1, BIT(25) },
> +	[SCU1_RESET_I3C10] =3D { true, SCU1_RESET_CTRL1, BIT(26) },
> +	[SCU1_RESET_I3C11] =3D { true, SCU1_RESET_CTRL1, BIT(27) },
> +	[SCU1_RESET_I3C12] =3D { true, SCU1_RESET_CTRL1, BIT(28) },
> +	[SCU1_RESET_I3C13] =3D { true, SCU1_RESET_CTRL1, BIT(29) },
> +	[SCU1_RESET_I3C14] =3D { true, SCU1_RESET_CTRL1, BIT(30) },
> +	[SCU1_RESET_I3C15] =3D { true, SCU1_RESET_CTRL1, BIT(31) },
> +	[SCU1_RESET_MCU0] =3D { true, SCU1_RESET_CTRL2, BIT(0) },
> +	[SCU1_RESET_MCU1] =3D { true, SCU1_RESET_CTRL2, BIT(1) },
> +	[SCU1_RESET_H2A_SPI1] =3D { true, SCU1_RESET_CTRL2, BIT(2) },
> +	[SCU1_RESET_H2A_SPI2] =3D { true, SCU1_RESET_CTRL2, BIT(3) },
> +	[SCU1_RESET_UART0] =3D { true, SCU1_RESET_CTRL2, BIT(4) },
> +	[SCU1_RESET_UART1] =3D { true, SCU1_RESET_CTRL2, BIT(5) },
> +	[SCU1_RESET_UART2] =3D { true, SCU1_RESET_CTRL2, BIT(6) },
> +	[SCU1_RESET_UART3] =3D { true, SCU1_RESET_CTRL2, BIT(7) },
> +	[SCU1_RESET_I2C_FILTER] =3D { true, SCU1_RESET_CTRL2, BIT(8) },
> +	[SCU1_RESET_CALIPTRA] =3D { true, SCU1_RESET_CTRL2, BIT(9) },
> +	[SCU1_RESET_XDMA] =3D { true, SCU1_RESET_CTRL2, BIT(10) },
> +	[SCU1_RESET_FSI] =3D { true, SCU1_RESET_CTRL2, BIT(12) },
> +	[SCU1_RESET_CAN] =3D { true, SCU1_RESET_CTRL2, BIT(13) },
> +	[SCU1_RESET_MCTP] =3D { true, SCU1_RESET_CTRL2, BIT(14) },
> +	[SCU1_RESET_I2C] =3D { true, SCU1_RESET_CTRL2, BIT(15) },
> +	[SCU1_RESET_UART6] =3D { true, SCU1_RESET_CTRL2, BIT(16) },
> +	[SCU1_RESET_UART7] =3D { true, SCU1_RESET_CTRL2, BIT(17) },
> +	[SCU1_RESET_UART8] =3D { true, SCU1_RESET_CTRL2, BIT(18) },
> +	[SCU1_RESET_UART9] =3D { true, SCU1_RESET_CTRL2, BIT(19) },
> +	[SCU1_RESET_LTPI0] =3D { true, SCU1_RESET_CTRL2, BIT(20) },
> +	[SCU1_RESET_VGAL] =3D { true, SCU1_RESET_CTRL2, BIT(21) },
> +	[SCU1_RESET_LTPI1] =3D { true, SCU1_RESET_CTRL2, BIT(22) },
> +	[SCU1_RESET_ACE] =3D { true, SCU1_RESET_CTRL2, BIT(23) },
> +	[SCU1_RESET_E2M] =3D { true, SCU1_RESET_CTRL2, BIT(24) },
> +	[SCU1_RESET_UHCI] =3D { true, SCU1_RESET_CTRL2, BIT(25) },
> +	[SCU1_RESET_PORTC_USB2UART] =3D { true, SCU1_RESET_CTRL2, BIT(26) },
> +	[SCU1_RESET_PORTC_VHUB_EHCI] =3D { true, SCU1_RESET_CTRL2, BIT(27) },
> +	[SCU1_RESET_PORTD_USB2UART] =3D { true, SCU1_RESET_CTRL2, BIT(28) },
> +	[SCU1_RESET_PORTD_VHUB_EHCI] =3D { true, SCU1_RESET_CTRL2, BIT(29) },
> +	[SCU1_RESET_H2X] =3D { true, SCU1_RESET_CTRL2, BIT(30) },
> +	[SCU1_RESET_I3CDMA] =3D { true, SCU1_RESET_CTRL2, BIT(31) },
> +	[SCU1_RESET_PCIE2RST] =3D { false, SCU1_PCIE3_CTRL, BIT(0) },
> +};
> +
> +static inline struct aspeed_reset *to_aspeed_reset(struct reset_controll=
er_dev *rcdev)
> +{
> +	return container_of(rcdev, struct aspeed_reset, rcdev);
> +}
> +
> +static int aspeed_reset_assert(struct reset_controller_dev *rcdev, unsig=
ned long id)
> +{
> +	struct aspeed_reset *rc =3D to_aspeed_reset(rcdev);
> +	void __iomem *reg_offset =3D rc->base + rc->info->signal[id].offset;
> +
> +	if (rc->info->signal[id].dedicated_clr) {
> +		writel(rc->info->signal[id].bit, reg_offset);
> +	} else {
> +		guard(spinlock_irqsave)(&rc->lock);
> +		writel(readl(reg_offset) & ~rc->info->signal[id].bit, reg_offset);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_reset_deassert(struct reset_controller_dev *rcdev, uns=
igned long id)
> +{
> +	struct aspeed_reset *rc =3D to_aspeed_reset(rcdev);
> +	void __iomem *reg_offset =3D rc->base + rc->info->signal[id].offset;
> +
> +	if (rc->info->signal[id].dedicated_clr) {
> +		writel(rc->info->signal[id].bit, reg_offset + 0x04);
> +	} else {
> +		guard(spinlock_irqsave)(&rc->lock);
> +		writel(readl(reg_offset) | rc->info->signal[id].bit, reg_offset);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_reset_status(struct reset_controller_dev *rcdev, unsig=
ned long id)
> +{
> +	struct aspeed_reset *rc =3D to_aspeed_reset(rcdev);
> +	void __iomem *reg_offset =3D rc->base + rc->info->signal[id].offset;
> +
> +	return (readl(reg_offset) & rc->info->signal[id].bit) ? 1 : 0;
> +}
> +
> +static const struct reset_control_ops aspeed_reset_ops =3D {
> +	.assert =3D aspeed_reset_assert,
> +	.deassert =3D aspeed_reset_deassert,
> +	.status =3D aspeed_reset_status,
> +};
> +
> +static int aspeed_reset_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct aspeed_reset *reset;
> +	struct device *dev =3D &adev->dev;
> +
> +	reset =3D devm_kzalloc(dev, sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&reset->lock);
> +
> +	reset->info =3D (struct aspeed_reset_info *)id->driver_data;
> +	reset->rcdev.owner =3D THIS_MODULE;
> +	reset->rcdev.nr_resets =3D reset->info->nr_resets;
> +	reset->rcdev.ops =3D &aspeed_reset_ops;
> +	reset->rcdev.of_node =3D dev->parent->of_node;
> +	reset->rcdev.dev =3D dev;
> +	reset->rcdev.of_reset_n_cells =3D 1;
> +	reset->base =3D (void __iomem *)adev->dev.platform_data;
> +
> +	if (!reset->base)
> +		return -ENOMEM;

Looks like this should be -EINVAL to me.

If aspeed_reset_controller_register() is moved into the reset driver,
like it is done in reset-mpfs, this check could be dropped completely.

With these issues addressed,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

