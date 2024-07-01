Return-Path: <linux-kernel+bounces-235888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB691DADC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50C81F221F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51280127E3A;
	Mon,  1 Jul 2024 08:59:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA383CDA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824368; cv=none; b=gNAmQbB1ynd3kK8tePdxiN01cLs1uPTvhwLZUWAVNYTDKkaK0Gyb8/JXXFcTpyVz9BU/2wjfVs53+kmFmKcYdhSNJJ4EoeozNDwGY9hCfjlbpqsSkX9QxhWWqkwrmt0sJG6HoXkZKxwJQyWzOOhtbtrWyFJao9mWr1grFWQvYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824368; c=relaxed/simple;
	bh=0RIBWYStaSPnU7WU2CONhMOsIpIeGqRrv1x67lkXjvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K83tL42gnvJkDmGd3tl+e0O7ZzL9kDfx8YfF0/2k5Z1gmI9hoMlJAVXXBW3k1/Dk6pdVpExfZyL7yw96RKy7oQGoF/UlOGiVzXCHdyx34a5u0Rcu2AxNqQlnHAMjkxE7ci47xGVe0bGJf+tFzPAIpom71mKK9zCdMiKRFbFzRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOCsX-0007SC-DW; Mon, 01 Jul 2024 10:59:17 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOCsW-006Kec-SP; Mon, 01 Jul 2024 10:59:16 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOCsW-000Oa2-2a;
	Mon, 01 Jul 2024 10:59:16 +0200
Message-ID: <e9bfd8087ddef3d66f437719530df54a1f6529a4.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: eyeq: add platform driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, =?ISO-8859-1?Q?Gr=E9gory?=
 Clement <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Date: Mon, 01 Jul 2024 10:59:16 +0200
In-Reply-To: <20240628-mbly-reset-v1-2-2a8294fd4392@bootlin.com>
References: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
	 <20240628-mbly-reset-v1-2-2a8294fd4392@bootlin.com>
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

Hi Th=C3=A9o,

On Fr, 2024-06-28 at 18:11 +0200, Th=C3=A9o Lebrun wrote:
> Add Mobileye EyeQ reset controller driver, for EyeQ5, EyeQ6L and EyeQ6H
> SoCs. Instances belong to a shared register region called OLB and gets
> spawned as auxiliary device to the platform driver for clock.
>=20
> There is one OLB instance for EyeQ5 and EyeQ6L. There are seven OLB
> instances on EyeQ6H; three have a reset controller embedded:
>  - West and east get handled by the same compatible.
>  - Acc (accelerator) is another one.
>=20
> Each instance vary in the number and types of reset domains.
> Instances with single domain expect a single cell, others two.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/reset/Kconfig      |  13 ++
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-eyeq.c | 562 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 576 insertions(+)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..14f3f4af0b10 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -66,6 +66,19 @@ config RESET_BRCMSTB_RESCAL
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
>  	  BCM7216.
> =20
> +config RESET_EYEQ
> +	bool "Mobileye EyeQ reset controller"
> +	depends on AUXILIARY_BUS

This should

	select AUXILIARY_BUS

instead.

> +	depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
> +	default MACH_EYEQ5 || MACH_EYEQ6H
> +	help
> +	  This enables the Mobileye EyeQ reset controller, used in EyeQ5, EyeQ6=
L
> +	  and EyeQ6H SoCs.
> +
> +	  It has one or more domains, with a varying number of resets in each.
> +	  Registers are located in a shared register region called OLB. EyeQ6H
> +	  has multiple reset instances.
> +
>  config RESET_GPIO
>  	tristate "GPIO reset controller"
>  	help
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..a4e6fea29800 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_BCM6345) +=3D reset-bcm6345.o
>  obj-$(CONFIG_RESET_BERLIN) +=3D reset-berlin.o
>  obj-$(CONFIG_RESET_BRCMSTB) +=3D reset-brcmstb.o
>  obj-$(CONFIG_RESET_BRCMSTB_RESCAL) +=3D reset-brcmstb-rescal.o
> +obj-$(CONFIG_RESET_EYEQ) +=3D reset-eyeq.o
>  obj-$(CONFIG_RESET_GPIO) +=3D reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) +=3D reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) +=3D reset-imx7.o
> diff --git a/drivers/reset/reset-eyeq.c b/drivers/reset/reset-eyeq.c
> new file mode 100644
> index 000000000000..9717572ac4b3
> --- /dev/null
> +++ b/drivers/reset/reset-eyeq.c
> @@ -0,0 +1,562 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Reset driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H platforms.
> + *
> + * Controllers live in a shared register region called OLB. EyeQ5 and Ey=
eQ6L
> + * have a single OLB instance for a single reset controller. EyeQ6H has =
seven
> + * OLB instances; three host reset controllers.
> + *
> + * Each reset controller has one or more domain. Domains are of a given =
type
> + * (see enum eqr_domain_type), with a valid offset mask (up to 32 resets=
 per
> + * domain).
> + *
> + * Domain types define expected behavior: one-register-per-reset,
> + * one-bit-per-reset, status detection method, busywait duration, etc.
> + *
> + * We use eqr_ as prefix, as-in "EyeQ Reset", but way shorter.
> + *
> + * Known resets in EyeQ5 domain 0 (type EQR_EYEQ5_SARCR):
> + *  3. CAN0	 4. CAN1	 5. CAN2	 6. SPI0
> + *  7. SPI1	 8. SPI2	 9. SPI3	10. UART0
> + * 11. UART1	12. UART2	13. I2C0	14. I2C1
> + * 15. I2C2	16. I2C3	17. I2C4	18. TIMER0
> + * 19. TIMER1	20. TIMER2	21. TIMER3	22. TIMER4
> + * 23. WD0	24. EXT0	25. EXT1	26. GPIO
> + * 27. WD1
> + *
> + * Known resets in EyeQ5 domain 1 (type EQR_EYEQ5_ACRP):
> + *  0. VMP0	 1. VMP1	 2. VMP2	 3. VMP3
> + *  4. PMA0	 5. PMA1	 6. PMAC0	 7. PMAC1
> + *  8. MPC0	 9. MPC1	10. MPC2	11. MPC3
> + * 12. MPC4
> + *
> + * Known resets in EyeQ5 domain 2 (type EQR_EYEQ5_PCIE):
> + *  0. PCIE0_CORE	 1. PCIE0_APB		 2. PCIE0_LINK_AXI	 3. PCIE0_LINK_MGMT
> + *  4. PCIE0_LINK_HOT	 5. PCIE0_LINK_PIPE	 6. PCIE1_CORE		 7. PCIE1_APB
> + *  8. PCIE1_LINK_AXI	 9. PCIE1_LINK_MGMT	10. PCIE1_LINK_HOT	11. PCIE1_L=
INK_PIPE
> + * 12. MULTIPHY		13. MULTIPHY_APB	15. PCIE0_LINK_MGMT	16. PCIE1_LINK_MGM=
T
> + * 17. PCIE0_LINK_PM	18. PCIE1_LINK_PM
> + *
> + * Known resets in EyeQ6L domain 0 (type EQR_EYEQ5_SARCR):
> + *  0. SPI0	 1. SPI1	 2. UART0	 3. I2C0
> + *  4. I2C1	 5. TIMER0	 6. TIMER1	 7. TIMER2
> + *  8. TIMER3	 9. WD0		10. WD1		11. EXT0
> + * 12. EXT1	13. GPIO
> + *
> + * Known resets in EyeQ6L domain 1 (type EQR_EYEQ5_ACRP):
> + *  0. VMP0	 1. VMP1	 2. VMP2	 3. VMP3
> + *  4. PMA0	 5. PMA1	 6. PMAC0	 7. PMAC1
> + *  8. MPC0	 9. MPC1	10. MPC2	11. MPC3
> + * 12. MPC4
> + *
> + * Known resets in EyeQ6H west/east (type EQR_EYEQ6H_SARCR):
> + *  0. CAN	 1. SPI0	 2. SPI1	 3. UART0
> + *  4. UART1	 5. I2C0	 6. I2C1	 7. -hole-
> + *  8. TIMER0	 9. TIMER1	10. WD		11. EXT TIMER
> + * 12. GPIO
> + *
> + * Known resets in EyeQ6H acc (type EQR_EYEQ5_ACRP):
> + *  1. XNN0	 2. XNN1	 3. XNN2	 4. XNN3
> + *  5. VMP0	 6. VMP1	 7. VMP2	 8. VMP3
> + *  9. PMA0	10. PMA1	11. MPC0	12. MPC1
> + * 13. MPC2	14. MPC3	15. PERIPH
> + *
> + * Abbreviations:
> + *  - PMA: Programmable Macro Array
> + *  - MPC: Multi-threaded Processing Clusters
> + *  - VMP: Vector Microcode Processors
> + *
> + * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/lockdep.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +/*
> + * A reset ID, as returned by eqr_of_xlate_*(), is a (domain, offset) pa=
ir.
> + * Low byte is domain, rest is offset.
> + */
> +#define ID_DOMAIN_MASK	GENMASK(7, 0)
> +#define ID_OFFSET_MASK	GENMASK(31, 8)
> +
> +enum eqr_domain_type {
> +	EQR_EYEQ5_SARCR,
> +	EQR_EYEQ5_ACRP,
> +	EQR_EYEQ5_PCIE,
> +	EQR_EYEQ6H_SARCR,
> +};
> +
> +/*
> + * Domain type EQR_EYEQ5_SARCR register offsets.
> + */
> +#define EQR_EYEQ5_SARCR_REQUEST		(0x000)
> +#define EQR_EYEQ5_SARCR_STATUS		(0x004)
> +
> +/*
> + * Domain type EQR_EYEQ5_ACRP register masks.
> + * Registers are: base + 4 * offset.
> + */
> +#define EQR_EYEQ5_ACRP_PD_REQ		BIT(0)
> +#define EQR_EYEQ5_ACRP_ST_POWER_DOWN	BIT(27)
> +#define EQR_EYEQ5_ACRP_ST_ACTIVE	BIT(29)
> +
> +/*
> + * Domain type EQR_EYEQ6H_SARCR register offsets.
> + */
> +#define EQR_EYEQ6H_SARCR_RST_REQUEST	(0x000)
> +#define EQR_EYEQ6H_SARCR_CLK_STATUS	(0x004)
> +#define EQR_EYEQ6H_SARCR_RST_STATUS	(0x008)
> +#define EQR_EYEQ6H_SARCR_CLK_REQUEST	(0x00C)
> +
> +struct eqr_busy_wait_timings {
> +	unsigned long sleep_us;
> +	unsigned long timeout_us;
> +};
> +
> +static const struct eqr_busy_wait_timings eqr_timings[] =3D {
> +	[EQR_EYEQ5_SARCR]	=3D {1, 10},
> +	[EQR_EYEQ5_ACRP]	=3D {1, 40 * USEC_PER_MSEC}, /* LBIST implies long tim=
eout. */
> +	/* EQR_EYEQ5_PCIE does no busy waiting. */
> +	[EQR_EYEQ6H_SARCR]	=3D {1, 400},
> +};
> +
> +#define EQR_MAX_DOMAIN_COUNT 3
> +
> +struct eqr_domain_descriptor {
> +	enum eqr_domain_type	type;
> +	u32			valid_mask;
> +	unsigned int		offset;
> +};
> +
> +struct eqr_match_data {
> +	unsigned int				domain_count;
> +	const struct eqr_domain_descriptor	*domains;
> +};
> +
> +struct eqr_private {
> +	struct mutex			mutexes[EQR_MAX_DOMAIN_COUNT];

Is there any benefit from per-domain mutexes over just a single mutex?

> +	void __iomem			*base;
> +	const struct eqr_match_data	*data;
> +	struct reset_controller_dev	rcdev;
> +};
> +
> +#define rcdev_to_priv(rcdev) container_of(rcdev, struct eqr_private, rcd=
ev)

Please use checkpatch --strict, and ideally mention when you ignore a
warning on purpose. In this case, the macro parameter should named
something else, because the last parameter to container_of must be
"rcdev" verbatim. This only works by accident because the passed
parameter also happens to be called called "rcdev" at all call sites.

> +static u32 eqr_double_readl(void __iomem *addr_a, void __iomem *addr_b,
> +			    u32 *dest_a, u32 *dest_b)
> +{
> +	*dest_a =3D readl(addr_a);
> +	*dest_b =3D readl(addr_b);
> +	return 0; /* read_poll_timeout() op argument must return something. */
> +}
> +
> +static int eqr_busy_wait_locked(struct eqr_private *priv, struct device =
*dev,
> +				u32 domain, u32 offset, bool assert)
> +{
> +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type;
> +	unsigned long sleep_us, timeout_us;
> +	u32 val, mask, val0, val1;
> +	void __iomem *base, *reg;
> +	int ret;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	base =3D priv->base + priv->data->domains[domain].offset;
> +	sleep_us =3D eqr_timings[domain_type].sleep_us;
> +	timeout_us =3D eqr_timings[domain_type].timeout_us;

You can initialize these at the declaration.

> +
> +	switch (domain_type) {
> +	case EQR_EYEQ5_SARCR:
> +		reg =3D base + EQR_EYEQ5_SARCR_STATUS;
> +		mask =3D BIT(offset);
> +
> +		ret =3D readl_poll_timeout(reg, val, !(val & mask) =3D=3D assert,
> +					 sleep_us, timeout_us);
> +		break;
> +
> +	case EQR_EYEQ5_ACRP:
> +		reg =3D base + 4 * offset;
> +		if (assert)
> +			mask =3D EQR_EYEQ5_ACRP_ST_POWER_DOWN;
> +		else
> +			mask =3D EQR_EYEQ5_ACRP_ST_ACTIVE;
> +
> +		ret =3D readl_poll_timeout(reg, val, !!(val & mask),
> +					 sleep_us, timeout_us);
> +		break;
> +
> +	case EQR_EYEQ5_PCIE:
> +		ret =3D 0; /* No busy waiting. */
> +		break;
> +
> +	case EQR_EYEQ6H_SARCR:
> +		/*
> +		 * Wait until both bits change:
> +		 *	readl(base + EQR_EYEQ6H_SARCR_RST_STATUS) & BIT(offset)
> +		 *	readl(base + EQR_EYEQ6H_SARCR_CLK_STATUS) & BIT(offset)
> +		 */
> +		mask =3D BIT(offset);
> +		ret =3D read_poll_timeout(eqr_double_readl, val,
> +					(!(val0 & mask) =3D=3D assert) &&
> +						(!(val1 & mask) =3D=3D assert),

I'd remove a level of indentation here.

> +					sleep_us, timeout_us, false,
> +					base + EQR_EYEQ6H_SARCR_RST_STATUS,
> +					base + EQR_EYEQ6H_SARCR_CLK_STATUS,
> +					&val0, &val1);

Calling these variables something like rst_status and clk_status, would
make this a bit easier to parse.

> +		break;
> +
> +	default:
> +		WARN_ON(1);
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	if (ret =3D=3D -ETIMEDOUT)
> +		dev_dbg(dev, "%u-%u: timeout\n", domain, offset);
> +	return ret;
> +}
> +
> +static void eqr_assert_locked(struct eqr_private *priv, u32 domain, u32 =
offset)
> +{
> +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type;
> +	void __iomem *base, *reg;
> +	u32 val;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	base =3D priv->base + priv->data->domains[domain].offset;
> +
> +	switch (domain_type) {
> +	case EQR_EYEQ5_SARCR:
> +		reg =3D base + EQR_EYEQ5_SARCR_REQUEST;
> +		writel(readl(reg) & ~BIT(offset), reg);
> +		break;
> +
> +	case EQR_EYEQ5_ACRP:
> +		reg =3D base + 4 * offset;
> +		writel(readl(reg) | EQR_EYEQ5_ACRP_PD_REQ, reg);
> +		break;
> +
> +	case EQR_EYEQ5_PCIE:
> +		writel(readl(base) & ~BIT(offset), base);
> +		break;
> +
> +	case EQR_EYEQ6H_SARCR:
> +		val =3D readl(base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> +		val &=3D ~BIT(offset);
> +		writel(val, base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> +		writel(val, base + EQR_EYEQ6H_SARCR_CLK_REQUEST);

This looks peculiar. Why is it ok to write the value read from
RST_REQUEST into CLK_REQUEST?

> +		break;
> +
> +	default:
> +		WARN_ON(1);
> +		break;
> +	}
> +}
> +
> +static int eqr_assert(struct reset_controller_dev *rcdev, unsigned long =
id)
> +{
> +	struct eqr_private *priv =3D rcdev_to_priv(rcdev);
> +	u32 domain =3D FIELD_GET(ID_DOMAIN_MASK, id);
> +	u32 offset =3D FIELD_GET(ID_OFFSET_MASK, id);
> +
> +	dev_dbg(rcdev->dev, "%u-%u: assert request\n", domain, offset);
> +
> +	guard(mutex)(&priv->mutexes[domain]);
> +
> +	eqr_assert_locked(priv, domain, offset);
> +	return eqr_busy_wait_locked(priv, rcdev->dev, domain, offset, true);
> +}
> +
> +static void eqr_deassert_locked(struct eqr_private *priv, u32 domain,
> +				u32 offset)
> +{
> +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type;
> +	void __iomem *base, *reg;
> +	u32 val;
> +
> +	lockdep_assert_held(&priv->mutexes[domain]);
> +
> +	base =3D priv->base + priv->data->domains[domain].offset;
> +
> +	switch (domain_type) {
> +	case EQR_EYEQ5_SARCR:
> +		reg =3D base + EQR_EYEQ5_SARCR_REQUEST;
> +		writel(readl(reg) | BIT(offset), reg);
> +		break;
> +
> +	case EQR_EYEQ5_ACRP:
> +		reg =3D base + 4 * offset;
> +		writel(readl(reg) & ~EQR_EYEQ5_ACRP_PD_REQ, reg);
> +		break;
> +
> +	case EQR_EYEQ5_PCIE:
> +		writel(readl(base) | BIT(offset), base);
> +		break;
> +
> +	case EQR_EYEQ6H_SARCR:
> +		val =3D readl(base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> +		val |=3D BIT(offset);
> +		writel(val, base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> +		writel(val, base + EQR_EYEQ6H_SARCR_CLK_REQUEST);
> +		break;
> +
> +	default:
> +		WARN_ON(1);
> +		break;
> +	}
> +}
> +
> +static int eqr_deassert(struct reset_controller_dev *rcdev, unsigned lon=
g id)
> +{
> +	struct eqr_private *priv =3D rcdev_to_priv(rcdev);
> +	u32 domain =3D FIELD_GET(ID_DOMAIN_MASK, id);
> +	u32 offset =3D FIELD_GET(ID_OFFSET_MASK, id);
> +
> +	dev_dbg(rcdev->dev, "%u-%u: deassert request\n", domain, offset);
> +
> +	guard(mutex)(&priv->mutexes[domain]);
> +
> +	eqr_deassert_locked(priv, domain, offset);
> +	return eqr_busy_wait_locked(priv, rcdev->dev, domain, offset, false);
> +}
> +
> +static int eqr_status(struct reset_controller_dev *rcdev, unsigned long =
id)
> +{
> +	u32 domain =3D FIELD_GET(ID_DOMAIN_MASK, id);
> +	struct eqr_private *priv =3D rcdev_to_priv(rcdev);
> +	enum eqr_domain_type domain_type =3D priv->data->domains[domain].type;
> +	u32 offset =3D FIELD_GET(ID_OFFSET_MASK, id);

I'd put domain and offset declaration next to each other.


regards
Philipp

