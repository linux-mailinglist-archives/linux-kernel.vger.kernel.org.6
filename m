Return-Path: <linux-kernel+bounces-333881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB097CF59
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430021C2189F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC381B2EC1;
	Thu, 19 Sep 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrNpDwHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FDC2594;
	Thu, 19 Sep 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787315; cv=none; b=kApD6pKIX1AfnWMsEN7PL/F/sgcLb0ZFKVuJjIP0mUv2kNjmReT9ERMPCfJZr9QHZHXcO/nVwzdr1AzWyTu+sG+TAH+BIGNkVf4EJzw6YHejw3T3WxDyzhclH7DGI8XEvvkrksHrJaTYF5Is+yecEmaQ1J+CIT90TREcDqEto5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787315; c=relaxed/simple;
	bh=dIaQlby2Fbdyj6Yvdw3LnxYGyHmrnkwKiWxyGLkOqCc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=S2aLJWcGqsVIc9lksP/bWv3+i8txPAsM+6J6fRII76cnAH27P867OwiRE8ws5FwB7Qyad/irGpux0YKztLn5TCGP/w/1B3JZsVntZ8R17p90Zla7XKGUDXTfpNlTCCrPJuD7RCT224XC/RU16vE9/rYFxsB7lzJbXfaVT4bIxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrNpDwHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53372C4CEC4;
	Thu, 19 Sep 2024 23:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726787314;
	bh=dIaQlby2Fbdyj6Yvdw3LnxYGyHmrnkwKiWxyGLkOqCc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YrNpDwHjd+e3vyJUuuOoj0jvQ7tAjBKbMvXc9gKZBJ6kQWlKucKhUnnt2SviEPpXM
	 CEt6NvetiWPHJu+xrNIZ4xQTD9i3sFnkXxQe/ymTCkz97Amr99R/HYxAfK3JtdmqUN
	 kDP2xw9Xdn1U90sAWYyobo0W7e3JB0vOVIOldG2wojXcIWe279hBRg/wg6AKZCQImb
	 oabZxinIh0O7t2fhRPiGVYMnu15JH7Nhn49aAmcTBiyRlFqzPoHuQcPqVzkyRcTAML
	 wQMLMeYYoVGfYpizcK6iq3JKaQrgLIzo2yGczMuQMBaAFYbA9lHDDxF2M9dukeJxxx
	 nEaA0/JWnO9Yg==
Message-ID: <a680b539e815f2e38f23126fede76591.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SEYPR01MB4221AA2CA9C91A695FEFA777D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com> <SEYPR01MB4221AA2CA9C91A695FEFA777D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Subject: Re: [PATCH v2 3/3] clk: spacemit: Add clock support for Spacemit K1 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>, Haylen Chu <heylenay@outlook.com>
To: Conor Dooley <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>
Date: Thu, 19 Sep 2024 16:08:32 -0700
User-Agent: alot/0.10

Quoting Haylen Chu (2024-09-16 15:23:10)
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> new file mode 100644
> index 000000000000..ef6c8bc50a98
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -0,0 +1,1341 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_pll.h"
> +#include "ccu_mix.h"
> +#include "ccu_ddn.h"
> +
> +#include <dt-bindings/clock/spacemit,k1-ccu.h>
> +
> +/*     APBS register offset    */
> +/*     pll1    */
> +#define APB_SPARE1_REG                 0x100
> +#define APB_SPARE2_REG                 0x104
> +#define APB_SPARE3_REG                 0x108
> +/*     pll2    */
> +#define APB_SPARE7_REG                 0x118
> +#define APB_SPARE8_REG                 0x11c
> +#define APB_SPARE9_REG                 0x120
> +/*     pll3    */
> +#define APB_SPARE10_REG                        0x124
> +#define APB_SPARE11_REG                        0x128
> +#define APB_SPARE12_REG                        0x12c
> +
> +/* MPMU register offset */
> +#define MPMU_POSR                      0x10
> +#define POSR_PLL1_LOCK                 BIT(27)
> +#define POSR_PLL2_LOCK                 BIT(28)
> +#define POSR_PLL3_LOCK                 BIT(29)
> +
> +#define MPMU_WDTPCR                    0x200
> +#define MPMU_RIPCCR                    0x210
> +#define MPMU_ACGR                      0x1024
> +#define MPMU_SUCCR                     0x14
> +#define MPMU_ISCCR                     0x44
> +#define MPMU_SUCCR_1                   0x10b0
> +#define MPMU_APBCSCR                   0x1050
> +
> +/* APBC register offset */
> +#define APBC_UART1_CLK_RST             0x0
> +#define APBC_UART2_CLK_RST             0x4
> +#define APBC_GPIO_CLK_RST              0x8
> +#define APBC_PWM0_CLK_RST              0xc
> +#define APBC_PWM1_CLK_RST              0x10
> +#define APBC_PWM2_CLK_RST              0x14
> +#define APBC_PWM3_CLK_RST              0x18
> +#define APBC_TWSI8_CLK_RST             0x20
> +#define APBC_UART3_CLK_RST             0x24
> +#define APBC_RTC_CLK_RST               0x28
> +#define APBC_TWSI0_CLK_RST             0x2c
> +#define APBC_TWSI1_CLK_RST             0x30
> +#define APBC_TIMERS1_CLK_RST           0x34
> +#define APBC_TWSI2_CLK_RST             0x38
> +#define APBC_AIB_CLK_RST               0x3c
> +#define APBC_TWSI4_CLK_RST             0x40
> +#define APBC_TIMERS2_CLK_RST           0x44
> +#define APBC_ONEWIRE_CLK_RST           0x48
> +#define APBC_TWSI5_CLK_RST             0x4c
> +#define APBC_DRO_CLK_RST               0x58
> +#define APBC_IR_CLK_RST                        0x5c
> +#define APBC_TWSI6_CLK_RST             0x60
> +#define APBC_COUNTER_CLK_SEL           0x64
> +#define APBC_TWSI7_CLK_RST             0x68
> +#define APBC_TSEN_CLK_RST              0x6c
> +#define APBC_UART4_CLK_RST             0x70
> +#define APBC_UART5_CLK_RST             0x74
> +#define APBC_UART6_CLK_RST             0x78
> +#define APBC_SSP3_CLK_RST              0x7c
> +#define APBC_SSPA0_CLK_RST             0x80
> +#define APBC_SSPA1_CLK_RST             0x84
> +#define APBC_IPC_AP2AUD_CLK_RST                0x90
> +#define APBC_UART7_CLK_RST             0x94
> +#define APBC_UART8_CLK_RST             0x98
> +#define APBC_UART9_CLK_RST             0x9c
> +#define APBC_CAN0_CLK_RST              0xa0
> +#define APBC_PWM4_CLK_RST              0xa8
> +#define APBC_PWM5_CLK_RST              0xac
> +#define APBC_PWM6_CLK_RST              0xb0
> +#define APBC_PWM7_CLK_RST              0xb4
> +#define APBC_PWM8_CLK_RST              0xb8
> +#define APBC_PWM9_CLK_RST              0xbc
> +#define APBC_PWM10_CLK_RST             0xc0
> +#define APBC_PWM11_CLK_RST             0xc4
> +#define APBC_PWM12_CLK_RST             0xc8
> +#define APBC_PWM13_CLK_RST             0xcc
> +#define APBC_PWM14_CLK_RST             0xd0
> +#define APBC_PWM15_CLK_RST             0xd4
> +#define APBC_PWM16_CLK_RST             0xd8
> +#define APBC_PWM17_CLK_RST             0xdc
> +#define APBC_PWM18_CLK_RST             0xe0
> +#define APBC_PWM19_CLK_RST             0xe4
> +
> +/* APMU register offset */
> +#define APMU_CCI550_CLK_CTRL           0x300
> +#define APMU_CPU_C0_CLK_CTRL           0x38C
> +#define APMU_CPU_C1_CLK_CTRL           0x390
> +#define APMU_JPG_CLK_RES_CTRL          0x20
> +#define APMU_CSI_CCIC2_CLK_RES_CTRL    0x24
> +#define APMU_ISP_CLK_RES_CTRL          0x38
> +#define APMU_LCD_CLK_RES_CTRL1         0x44
> +#define APMU_LCD_SPI_CLK_RES_CTRL      0x48
> +#define APMU_LCD_CLK_RES_CTRL2         0x4c
> +#define APMU_CCIC_CLK_RES_CTRL         0x50
> +#define APMU_SDH0_CLK_RES_CTRL         0x54
> +#define APMU_SDH1_CLK_RES_CTRL         0x58
> +#define APMU_USB_CLK_RES_CTRL          0x5c
> +#define APMU_QSPI_CLK_RES_CTRL         0x60
> +#define APMU_USB_CLK_RES_CTRL          0x5c
> +#define APMU_DMA_CLK_RES_CTRL          0x64
> +#define APMU_AES_CLK_RES_CTRL          0x68
> +#define APMU_VPU_CLK_RES_CTRL          0xa4
> +#define APMU_GPU_CLK_RES_CTRL          0xcc
> +#define APMU_SDH2_CLK_RES_CTRL         0xe0
> +#define APMU_PMUA_MC_CTRL              0xe8
> +#define APMU_PMU_CC2_AP                        0x100
> +#define APMU_PMUA_EM_CLK_RES_CTRL      0x104
> +#define APMU_AUDIO_CLK_RES_CTRL                0x14c
> +#define APMU_HDMI_CLK_RES_CTRL         0x1B8
> +#define APMU_CCI550_CLK_CTRL           0x300
> +#define APMU_ACLK_CLK_CTRL             0x388
> +#define APMU_CPU_C0_CLK_CTRL           0x38C
> +#define APMU_CPU_C1_CLK_CTRL           0x390
> +#define APMU_PCIE_CLK_RES_CTRL_0       0x3cc
> +#define APMU_PCIE_CLK_RES_CTRL_1       0x3d4
> +#define APMU_PCIE_CLK_RES_CTRL_2       0x3dc
> +#define APMU_EMAC0_CLK_RES_CTRL                0x3e4
> +#define APMU_EMAC1_CLK_RES_CTRL                0x3ec
> +
> +/*     APBS clocks start       */
> +
> +/* Frequency of pll{1,2} should not be updated at runtime */
> +static const struct ccu_pll_rate_tbl pll1_rate_tbl[] =3D {
> +       CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd=
),
> +};
> +
> +static const struct ccu_pll_rate_tbl pll2_rate_tbl[] =3D {
> +       CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000=
),
> +};
> +
> +static const struct ccu_pll_rate_tbl pll3_rate_tbl[] =3D {
> +       CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000=
),
> +       CCU_PLL_RATE(3200000000UL, 0x67, 0xdd, 0x50, 0x00, 0x43, 0xeaaaab=
),
> +       CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd=
),
> +};
> +
> +static CCU_PLL_DEFINE(pll1, "pll1", pll1_rate_tbl,
> +                     APB_SPARE1_REG, APB_SPARE2_REG, APB_SPARE3_REG,
> +                     MPMU_POSR, POSR_PLL1_LOCK, 0);
> +static CCU_PLL_DEFINE(pll2, "pll2", pll2_rate_tbl,
> +                     APB_SPARE7_REG, APB_SPARE8_REG, APB_SPARE9_REG,
> +                     MPMU_POSR, POSR_PLL2_LOCK, 0);
> +static CCU_PLL_DEFINE(pll3, "pll3", pll3_rate_tbl,
> +                     APB_SPARE10_REG, APB_SPARE11_REG, APB_SPARE12_REG,
> +                     MPMU_POSR, POSR_PLL3_LOCK, 0);
> +
> +static CCU_GATE_FACTOR_DEFINE(pll1_d2, "pll1_d2", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(1), BIT(1), 0, 2, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d3, "pll1_d3", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(2), BIT(2), 0, 3, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d4, "pll1_d4", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(3), BIT(3), 0, 4, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d5, "pll1_d5", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(4), BIT(4), 0, 5, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d6, "pll1_d6", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(5), BIT(5), 0, 6, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d7, "pll1_d7", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(6), BIT(6), 0, 7, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d8, "pll1_d8", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(7), BIT(7), 0, 8, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d11_223p4, "pll1_d11_223p4",
> +                             "pll1", APB_SPARE2_REG,
> +                             BIT(15), BIT(15), 0, 11, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d13_189, "pll1_d13_189", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(16), BIT(16), 0, 13, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d23_106p8, "pll1_d23_106p8",
> +                             "pll1", APB_SPARE2_REG,
> +                             BIT(20), BIT(20), 0, 23, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d64_38p4, "pll1_d64_38p4", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(0), BIT(0), 0, 64, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_aud_245p7, "pll1_aud_245p7",
> +                             "pll1", APB_SPARE2_REG,
> +                             BIT(10), BIT(10), 0, 10, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_aud_24p5, "pll1_aud_24p5", "pll1",
> +                             APB_SPARE2_REG,
> +                             BIT(11), BIT(11), 0, 100, 1, 0);
> +
> +static CCU_GATE_FACTOR_DEFINE(pll2_d1, "pll2_d1", "pll2", APB_SPARE8_REG,
> +                             BIT(0), BIT(0), 0, 1, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d2, "pll2_d2", "pll2", APB_SPARE8_REG,
> +                             BIT(1), BIT(1), 0, 2, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d3, "pll2_d3", "pll2", APB_SPARE8_REG,
> +                             BIT(2), BIT(2), 0, 3, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d4, "pll2_d4", "pll2", APB_SPARE8_REG,
> +                             BIT(3), BIT(3), 0, 4, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d5, "pll2_d5", "pll2", APB_SPARE8_REG,
> +                             BIT(4), BIT(4), 0, 5, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d6, "pll2_d6", "pll2", APB_SPARE8_REG,
> +                             BIT(5), BIT(5), 0, 6, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d7, "pll2_d7", "pll2", APB_SPARE8_REG,
> +                             BIT(6), BIT(6), 0, 7, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll2_d8, "pll2_d8", "pll2", APB_SPARE8_REG,
> +                             BIT(7), BIT(7), 0, 8, 1, 0);
> +
> +static CCU_GATE_FACTOR_DEFINE(pll3_d1, "pll3_d1", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(0), BIT(0), 0, 1, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d2, "pll3_d2", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(1), BIT(1), 0, 2, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d3, "pll3_d3", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(2), BIT(2), 0, 3, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d4, "pll3_d4", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(3), BIT(3), 0, 4, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d5, "pll3_d5", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(4), BIT(4), 0, 5, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d6, "pll3_d6", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(5), BIT(5), 0, 6, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d7, "pll3_d7", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(6), BIT(6), 0, 7, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll3_d8, "pll3_d8", "pll3", APB_SPARE11_RE=
G,
> +                             BIT(7), BIT(7), 0, 8, 1, 0);
> +
> +static CCU_FACTOR_DEFINE(pll3_20, "pll3_20", "pll3_d8", 20, 1);
> +static CCU_FACTOR_DEFINE(pll3_40, "pll3_40", "pll3_d8", 10, 1);
> +static CCU_FACTOR_DEFINE(pll3_80, "pll3_80", "pll3_d8", 5, 1);
> +
> +/*     APBS clocks end         */
> +
> +/*     MPMU clocks start       */
> +static CCU_GATE_DEFINE(pll1_d8_307p2, "pll1_d8_307p2", "pll1_d8",
> +       MPMU_ACGR,
> +       BIT(13), BIT(13), 0, 0);
> +static CCU_FACTOR_DEFINE(pll1_d32_76p8, "pll1_d32_76p8", "pll1_d8_307p2",
> +                        4, 1);
> +static CCU_FACTOR_DEFINE(pll1_d40_61p44, "pll1_d40_61p44", "pll1_d8_307p=
2",
> +                        5, 1);
> +static CCU_FACTOR_DEFINE(pll1_d16_153p6, "pll1_d16_153p6", "pll1_d8",
> +                        2, 1);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d24_102p4, "pll1_d24_102p4", "pll1_d8=
",
> +                             MPMU_ACGR,
> +                             BIT(12), BIT(12), 0, 3, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2, "pll1_d48_51p2", "pll1_d8",
> +                             MPMU_ACGR,
> +                             BIT(7), BIT(7), 0, 6, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2_ap, "pll1_d48_51p2_ap", "pll=
1_d8",
> +                             MPMU_ACGR,
> +                             BIT(11), BIT(11), 0, 6, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_m3d128_57p6, "pll1_m3d128_57p6", "pll=
1_d8",
> +                             MPMU_ACGR,
> +                             BIT(8), BIT(8), 0, 16, 3, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d96_25p6, "pll1_d96_25p6", "pll1_d8",
> +                             MPMU_ACGR,
> +                             BIT(4), BIT(4), 0, 12, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8, "pll1_d192_12p8", "pll1_d8=
",
> +                             MPMU_ACGR,
> +                             BIT(3), BIT(3), 0, 24, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8_wdt, "pll1_d192_12p8_wdt",
> +                             "pll1_d8", MPMU_ACGR,
> +                             BIT(19), BIT(19), 0x0, 24, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d384_6p4, "pll1_d384_6p4", "pll1_d8",
> +                             MPMU_ACGR,
> +                             BIT(2), BIT(2), 0, 48, 1, 0);
> +static CCU_FACTOR_DEFINE(pll1_d768_3p2, "pll1_d768_3p2", "pll1_d384_6p4",
> +                        2, 1);
> +static CCU_FACTOR_DEFINE(pll1_d1536_1p6, "pll1_d1536_1p6", "pll1_d384_6p=
4",
> +                        4, 1);
> +static CCU_FACTOR_DEFINE(pll1_d3072_0p8, "pll1_d3072_0p8", "pll1_d384_6p=
4",
> +                        8, 1);
> +
> +static CCU_FACTOR_DEFINE(pll1_d7_351p08, "pll1_d7_351p08", "pll1_d7",
> +                        1, 1);
> +
> +static CCU_GATE_DEFINE(pll1_d6_409p6, "pll1_d6_409p6", "pll1_d6",
> +                      MPMU_ACGR,
> +                      BIT(0), BIT(0), 0, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d12_204p8, "pll1_d12_204p8", "pll1_d6=
",
> +                             MPMU_ACGR,
> +                             BIT(5), BIT(5), 0, 2, 1, 0);
> +
> +static CCU_GATE_DEFINE(pll1_d5_491p52, "pll1_d5_491p52", "pll1_d5",
> +                      MPMU_ACGR, BIT(21), BIT(21), 0, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d10_245p76, "pll1_d10_245p76", "pll1_=
d5",
> +                             MPMU_ACGR,
> +                             BIT(18), BIT(18), 0, 2, 1, 0);
> +
> +static CCU_GATE_DEFINE(pll1_d4_614p4, "pll1_d4_614p4", "pll1_d4",
> +                      MPMU_ACGR,
> +                      BIT(15), BIT(15), 0, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d52_47p26, "pll1_d52_47p26", "pll1_d4=
",
> +                             MPMU_ACGR,
> +                             BIT(10), BIT(10), 0, 13, 1, 0);
> +static CCU_GATE_FACTOR_DEFINE(pll1_d78_31p5, "pll1_d78_31p5", "pll1_d4",
> +                             MPMU_ACGR,
> +                             BIT(6), BIT(6), 0, 39, 2, 0);
> +
> +static CCU_GATE_DEFINE(pll1_d3_819p2, "pll1_d3_819p2", "pll1_d3",
> +                      MPMU_ACGR,
> +                      BIT(14), BIT(14), 0, 0);
> +
> +static CCU_GATE_DEFINE(pll1_d2_1228p8, "pll1_d2_1228p8", "pll1_d2",
> +                      MPMU_ACGR,
> +                      BIT(16), BIT(16), 0, 0);
> +
> +static struct ccu_ddn_info uart_ddn_mask_info =3D {
> +       .factor         =3D 2,
> +       .num_mask       =3D 0x1fff,
> +       .den_mask       =3D 0x1fff,
> +       .num_shift      =3D 16,
> +       .den_shift      =3D 0,
> +};
> +static struct ccu_ddn_tbl slow_uart1_tbl[] =3D {
> +       { .num =3D 125, .den =3D 24 },
> +};
> +static struct ccu_ddn_tbl slow_uart2_tbl[] =3D {
> +       { .num =3D 6144, .den =3D 960 },
> +};
> +static CCU_GATE_NO_PARENT_DEFINE(slow_uart, "slow_uart",
> +                                MPMU_ACGR,
> +                                BIT(1), BIT(1), 0, 0);
> +static CCU_DDN_DEFINE(slow_uart1_14p74, "slow_uart1_14p74", "pll1_d16_15=
3p6",
> +                     &uart_ddn_mask_info, slow_uart1_tbl,
> +                     MPMU_SUCCR, 0);
> +static CCU_DDN_DEFINE(slow_uart2_48, "slow_uart2_48", "pll1_d4_614p4",
> +                     &uart_ddn_mask_info, slow_uart2_tbl,
> +                     MPMU_SUCCR_1, 0);
> +
> +static CCU_GATE_DEFINE(wdt_clk, "wdt_clk", "pll1_d96_25p6",
> +                      MPMU_WDTPCR,
> +                      0x3, 0x3, 0x0,
> +                      0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(ripc_clk, "ripc_clk",
> +                                MPMU_RIPCCR,
> +                                0x3, 0x3, 0x0,
> +                                0);
> +
> +static CCU_GATE_FACTOR_DEFINE(i2s_sysclk, "i2s_sysclk", "pll1_d16_153p6",
> +                             MPMU_ISCCR,
> +                             BIT(31), BIT(31), 0x0, 50, 1,
> +                             0);
> +static CCU_GATE_FACTOR_DEFINE(i2s_bclk, "i2s_bclk", "i2s_sysclk",
> +                             MPMU_ISCCR,
> +                             BIT(29), BIT(29), 0x0, 1, 1,
> +                             0);
> +
> +static const char * const apb_parent_names[] =3D {

Please don't use strings for parents. Either use struct clk_parent_data
or clk_hw pointers directly.

> +       "pll1_d96_25p6", "pll1_d48_51p2", "pll1_d96_25p6", "pll1_d24_102p=
4"
> +};
> +static CCU_MUX_DEFINE(apb_clk, "apb_clk", apb_parent_names,
> +                     MPMU_APBCSCR,
> +                     0, 2,
> +                     0);
> +/*     MPMU clocks end         */
> +
> +/*     APBC clocks start       */
> +static const char * const uart_clk_parents[] =3D {
> +       "pll1_m3d128_57p6", "slow_uart1_14p74", "slow_uart2_48",
> +};
> +static CCU_MUX_GATE_DEFINE(uart0_clk, "uart0_clk", uart_clk_parents,
> +                          APBC_UART1_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart2_clk, "uart2_clk", uart_clk_parents,
> +                          APBC_UART2_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart3_clk, "uart3_clk", uart_clk_parents,
> +                          APBC_UART3_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart4_clk, "uart4_clk", uart_clk_parents,
> +                          APBC_UART4_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart5_clk, "uart5_clk", uart_clk_parents,
> +                          APBC_UART5_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart6_clk, "uart6_clk", uart_clk_parents,
> +                          APBC_UART6_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart7_clk, "uart7_clk", uart_clk_parents,
> +                          APBC_UART7_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart8_clk, "uart8_clk", uart_clk_parents,
> +                          APBC_UART8_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(uart9_clk, "uart9_clk", uart_clk_parents,
> +                          APBC_UART9_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +
> +static CCU_GATE_DEFINE(gpio_clk, "gpio_clk", "vctcxo_24",
> +                      APBC_GPIO_CLK_RST,
> +                      0x3, 0x3, 0x0,
> +                      0);
> +
> +static const char * const pwm_parent_names[] =3D {
> +       "pll1_d192_12p8", "clk_32k"
> +};
> +static CCU_MUX_GATE_DEFINE(pwm0_clk, "pwm0_clk", pwm_parent_names,
> +                          APBC_PWM0_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm1_clk, "pwm1_clk", pwm_parent_names,
> +                          APBC_PWM1_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm2_clk, "pwm2_clk", pwm_parent_names,
> +                          APBC_PWM2_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm3_clk, "pwm3_clk", pwm_parent_names,
> +                          APBC_PWM3_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm4_clk, "pwm4_clk", pwm_parent_names,
> +                          APBC_PWM4_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm5_clk, "pwm5_clk", pwm_parent_names,
> +                          APBC_PWM5_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm6_clk, "pwm6_clk", pwm_parent_names,
> +                          APBC_PWM6_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm7_clk, "pwm7_clk", pwm_parent_names,
> +                          APBC_PWM7_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm8_clk, "pwm8_clk", pwm_parent_names,
> +                          APBC_PWM8_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm9_clk, "pwm9_clk", pwm_parent_names,
> +                          APBC_PWM9_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm10_clk, "pwm10_clk", pwm_parent_names,
> +                          APBC_PWM10_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm11_clk, "pwm11_clk", pwm_parent_names,
> +                          APBC_PWM11_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm12_clk, "pwm12_clk", pwm_parent_names,
> +                          APBC_PWM12_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm13_clk, "pwm13_clk", pwm_parent_names,
> +                          APBC_PWM13_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm14_clk, "pwm14_clk", pwm_parent_names,
> +                          APBC_PWM14_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm15_clk, "pwm15_clk", pwm_parent_names,
> +                          APBC_PWM15_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm16_clk, "pwm16_clk", pwm_parent_names,
> +                          APBC_PWM16_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm17_clk, "pwm17_clk", pwm_parent_names,
> +                          APBC_PWM17_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm18_clk, "pwm18_clk", pwm_parent_names,
> +                          APBC_PWM18_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(pwm19_clk, "pwm19_clk", pwm_parent_names,
> +                          APBC_PWM19_CLK_RST,
> +                          4, 3, 0x2, 0x2, 0x0,
> +                          0);
> +
> +static const char * const ssp_parent_names[] =3D {
> +       "pll1_d384_6p4", "pll1_d192_12p8", "pll1_d96_25p6", "pll1_d48_51p=
2",
> +       "pll1_d768_3p2", "pll1_d1536_1p6", "pll1_d3072_0p8"
> +};
> +static CCU_MUX_GATE_DEFINE(ssp3_clk, "ssp3_clk", ssp_parent_names,
> +                          APBC_SSP3_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +
> +static CCU_GATE_DEFINE(rtc_clk, "rtc_clk", "clk_32k",
> +                      APBC_RTC_CLK_RST,
> +                      0x83, 0x83, 0x0, 0);
> +
> +static const char * const twsi_parent_names[] =3D {
> +       "pll1_d78_31p5", "pll1_d48_51p2", "pll1_d40_61p44"
> +};
> +static CCU_MUX_GATE_DEFINE(twsi0_clk, "twsi0_clk", twsi_parent_names,
> +                          APBC_TWSI0_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi1_clk, "twsi1_clk", twsi_parent_names,
> +                          APBC_TWSI1_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi2_clk, "twsi2_clk", twsi_parent_names,
> +                          APBC_TWSI2_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi4_clk, "twsi4_clk", twsi_parent_names,
> +                          APBC_TWSI4_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi5_clk, "twsi5_clk", twsi_parent_names,
> +                          APBC_TWSI5_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi6_clk, "twsi6_clk", twsi_parent_names,
> +                          APBC_TWSI6_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi7_clk, "twsi7_clk", twsi_parent_names,
> +                          APBC_TWSI7_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(twsi8_clk, "twsi8_clk", twsi_parent_names,
> +                          APBC_TWSI8_CLK_RST,
> +                          4, 3, 0x7, 0x3, 0x4,
> +                          0);
> +
> +static const char * const timer_parent_names[] =3D {
> +       "pll1_d192_12p8", "clk_32k", "pll1_d384_6p4", "vctcxo_3", "vctcxo=
_1"
> +};
> +static CCU_MUX_GATE_DEFINE(timers1_clk, "timers1_clk", timer_parent_name=
s,
> +                          APBC_TIMERS1_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(timers2_clk, "timers2_clk", timer_parent_name=
s,
> +                          APBC_TIMERS2_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +
> +static CCU_GATE_DEFINE(aib_clk, "aib_clk", "vctcxo_24",
> +                      APBC_AIB_CLK_RST,
> +                      0x3, 0x3, 0x0, 0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(onewire_clk, "onewire_clk",
> +                                APBC_ONEWIRE_CLK_RST,
> +                                0x3, 0x3, 0x0,
> +                                0);
> +
> +static const char * const sspa_parent_names[] =3D {
> +       "pll1_d384_6p4", "pll1_d192_12p8", "pll1_d96_25p6", "pll1_d48_51p=
2",
> +       "pll1_d768_3p2", "pll1_d1536_1p6", "pll1_d3072_0p8", "i2s_bclk"
> +};
> +static CCU_MUX_GATE_DEFINE(sspa0_clk, "sspa0_clk", sspa_parent_names,
> +                          APBC_SSPA0_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_MUX_GATE_DEFINE(sspa1_clk, "sspa1_clk", sspa_parent_names,
> +                          APBC_SSPA1_CLK_RST,
> +                          4, 3, 0x3, 0x3, 0x0,
> +                          0);
> +static CCU_GATE_NO_PARENT_DEFINE(dro_clk, "dro_clk",
> +                                APBC_DRO_CLK_RST,
> +                                0x1, 0x1, 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(ir_clk, "ir_clk",
> +                                APBC_IR_CLK_RST,
> +                                0x1, 0x1, 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(tsen_clk, "tsen_clk",
> +                                APBC_TSEN_CLK_RST,
> +                                0x3, 0x3, 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(ipc_ap2aud_clk, "ipc_ap2aud_clk",
> +                                APBC_IPC_AP2AUD_CLK_RST,
> +                                0x3, 0x3, 0x0,
> +                                0);
> +
> +static const char * const can_parent_names[] =3D {
> +       "pll3_20", "pll3_40", "pll3_80"
> +};
> +static CCU_MUX_GATE_DEFINE(can0_clk, "can0_clk", can_parent_names,
> +                          APBC_CAN0_CLK_RST,
> +                          4, 3, BIT(1), BIT(1), 0x0,
> +                          0);
> +static CCU_GATE_NO_PARENT_DEFINE(can0_bus_clk, "can0_bus_clk",
> +                                APBC_CAN0_CLK_RST,
> +                                BIT(0), BIT(0), 0x0,
> +                                0);
> +/*     APBC clocks end         */
> +
> +/*     APMU clocks start       */
> +static const char * const cci550_clk_parents[] =3D {
> +       "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d3_819p2", "pll2_d3"
> +};
> +static CCU_DIV_FC_MUX_DEFINE(cci550_clk, "cci550_clk", cci550_clk_parent=
s,
> +                            APMU_CCI550_CLK_CTRL,
> +                            8, 3, BIT(12), 0, 2, CLK_IS_CRITICAL);
> +
> +static const char * const cpu_c0_hi_clk_parents[] =3D { "pll3_d2", "pll3=
_d1" };
> +static CCU_MUX_DEFINE(cpu_c0_hi_clk, "cpu_c0_hi_clk", cpu_c0_hi_clk_pare=
nts,
> +                     APMU_CPU_C0_CLK_CTRL,
> +                     13, 1, 0);
> +static const char * const cpu_c0_clk_parents[] =3D {
> +       "pll1_d4_614p4", "pll1_d3_819p2", "pll1_d6_409p6", "pll1_d5_491p5=
2",
> +       "pll1_d2_1228p8", "pll3_d3", "pll2_d3", "cpu_c0_hi_clk"
> +};
> +static CCU_MUX_FC_DEFINE(cpu_c0_core_clk, "cpu_c0_core_clk", cpu_c0_clk_=
parents,
> +                        APMU_CPU_C0_CLK_CTRL,
> +                        BIT(12), 0, 3, CLK_IS_CRITICAL);
> +static CCU_DIV_DEFINE(cpu_c0_ace_clk, "cpu_c0_ace_clk", "cpu_c0_core_clk=
",
> +                     APMU_CPU_C0_CLK_CTRL,
> +                     6, 3, CLK_IS_CRITICAL);
> +static CCU_DIV_DEFINE(cpu_c0_tcm_clk, "cpu_c0_tcm_clk", "cpu_c0_core_clk=
",
> +                     APMU_CPU_C0_CLK_CTRL, 9, 3, CLK_IS_CRITICAL);
> +
> +static const char * const cpu_c1_hi_clk_parents[] =3D { "pll3_d2", "pll3=
_d1" };
> +static CCU_MUX_DEFINE(cpu_c1_hi_clk, "cpu_c1_hi_clk", cpu_c1_hi_clk_pare=
nts,
> +                     APMU_CPU_C1_CLK_CTRL,
> +                     13, 1, CLK_IS_CRITICAL);
> +static const char * const cpu_c1_clk_parents[] =3D {
> +       "pll1_d4_614p4", "pll1_d3_819p2", "pll1_d6_409p6", "pll1_d5_491p5=
2",
> +       "pll1_d2_1228p8", "pll3_d3", "pll2_d3", "cpu_c1_hi_clk"
> +};
> +static CCU_MUX_FC_DEFINE(cpu_c1_core_clk, "cpu_c1_core_clk", cpu_c1_clk_=
parents,
> +                        APMU_CPU_C1_CLK_CTRL,
> +                        BIT(12), 0, 3, CLK_IS_CRITICAL);
> +static CCU_DIV_DEFINE(cpu_c1_ace_clk, "cpu_c1_ace_clk", "cpu_c1_core_clk=
",
> +                     APMU_CPU_C1_CLK_CTRL,
> +                     6, 3, CLK_IS_CRITICAL);
> +
> +static const char * const jpg_parent_names[] =3D {
> +       "pll1_d4_614p4", "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d3_819p=
2",
> +       "pll1_d2_1228p8", "pll2_d4", "pll2_d3"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(jpg_clk, "jpg_clk", jpg_parent_names,
> +                                 APMU_JPG_CLK_RES_CTRL,
> +                                 5, 3, BIT(15),
> +                                 2, 3, BIT(1), BIT(1), 0x0,
> +                                 0);
> +static CCU_GATE_NO_PARENT_DEFINE(jpg_4kafbc_clk, "jpg_4kafbc_clk",
> +                                APMU_JPG_CLK_RES_CTRL,
> +                                BIT(16), BIT(16), 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(jpg_2kafbc_clk, "jpg_2kafbc_clk",
> +                                APMU_JPG_CLK_RES_CTRL,
> +                                BIT(17), BIT(17), 0x0,
> +                                0);
> +
> +static const char * const ccic2phy_parent_names[] =3D {
> +       "pll1_d24_102p4", "pll1_d48_51p2_ap"
> +};
> +static CCU_MUX_GATE_DEFINE(ccic2phy_clk, "ccic2phy_clk", ccic2phy_parent=
_names,
> +                          APMU_CSI_CCIC2_CLK_RES_CTRL,
> +                          7, 1, BIT(5), BIT(5), 0x0,
> +                          0);
> +
> +static const char * const ccic3phy_parent_names[] =3D {
> +       "pll1_d24_102p4", "pll1_d48_51p2_ap"
> +};
> +static CCU_MUX_GATE_DEFINE(ccic3phy_clk, "ccic3phy_clk", ccic3phy_parent=
_names,
> +                          APMU_CSI_CCIC2_CLK_RES_CTRL,
> +                          31, 1, BIT(30), BIT(30), 0x0,
> +                          0);
> +
> +static const char * const csi_parent_names[] =3D {
> +       "pll1_d5_491p52", "pll1_d6_409p6", "pll1_d4_614p4", "pll1_d3_819p=
2",
> +       "pll2_d2", "pll2_d3", "pll2_d4", "pll1_d2_1228p8"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(csi_clk, "csi_clk", csi_parent_names,
> +                                 APMU_CSI_CCIC2_CLK_RES_CTRL,
> +                                 20, 3, BIT(15),
> +                                 16, 3, BIT(4), BIT(4), 0x0,
> +                                 0);
> +
> +static const char * const camm_parent_names[] =3D {
> +       "pll1_d8_307p2", "pll2_d5", "pll1_d6_409p6", "vctcxo_24"
> +};
> +static CCU_DIV_MUX_GATE_DEFINE(camm0_clk, "camm0_clk", camm_parent_names,
> +                              APMU_CSI_CCIC2_CLK_RES_CTRL,
> +                              23, 4, 8, 2,
> +                              BIT(28), BIT(28), 0x0,
> +                              0);
> +static CCU_DIV_MUX_GATE_DEFINE(camm1_clk, "camm1_clk", camm_parent_names,
> +                              APMU_CSI_CCIC2_CLK_RES_CTRL,
> +                              23, 4, 8, 2, BIT(6), BIT(6), 0x0,
> +                              0);
> +static CCU_DIV_MUX_GATE_DEFINE(camm2_clk, "camm2_clk", camm_parent_names,
> +                              APMU_CSI_CCIC2_CLK_RES_CTRL,
> +                              23, 4, 8, 2, BIT(3), BIT(3), 0x0,
> +                              0);
> +
> +static const char * const isp_cpp_parent_names[] =3D {
> +       "pll1_d8_307p2", "pll1_d6_409p6"
> +};
> +static CCU_DIV_MUX_GATE_DEFINE(isp_cpp_clk, "isp_cpp_clk", isp_cpp_paren=
t_names,
> +                              APMU_ISP_CLK_RES_CTRL,
> +                              24, 2, 26, 1, BIT(28), BIT(28), 0x0,
> +                              0);
> +static const char * const isp_bus_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d8_307p2", "pll1_d10_245=
p76"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(isp_bus_clk, "isp_bus_clk",
> +                                 isp_bus_parent_names,
> +                                 APMU_ISP_CLK_RES_CTRL,
> +                                 18, 3, BIT(23),
> +                                 21, 2, BIT(17), BIT(17), 0x0,
> +                                 0);
> +static const char * const isp_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p=
2"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(isp_clk, "isp_clk", isp_parent_names,
> +                                 APMU_ISP_CLK_RES_CTRL,
> +                                 4, 3, BIT(7),
> +                                 8, 2, BIT(1), BIT(1), 0x0,
> +                                 0);
> +
> +static const char * const dpumclk_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p=
2"
> +};
> +static CCU_DIV2_FC_MUX_GATE_DEFINE(dpu_mclk, "dpu_mclk", dpumclk_parent_=
names,
> +                                  APMU_LCD_CLK_RES_CTRL1,
> +                                  APMU_LCD_CLK_RES_CTRL2,
> +                                  1, 4, BIT(29),
> +                                  5, 3, BIT(0), BIT(0), 0x0,
> +                                  0);
> +
> +static const char * const dpuesc_parent_names[] =3D {
> +       "pll1_d48_51p2_ap", "pll1_d52_47p26", "pll1_d96_25p6", "pll1_d32_=
76p8"
> +};
> +static CCU_MUX_GATE_DEFINE(dpu_esc_clk, "dpu_esc_clk", dpuesc_parent_nam=
es,
> +                          APMU_LCD_CLK_RES_CTRL1,
> +                          0, 2, BIT(2), BIT(2), 0x0,
> +                          0);
> +
> +static const char * const dpubit_parent_names[] =3D {
> +       "pll1_d3_819p2", "pll2_d2", "pll2_d3", "pll1_d2_1228p8", "pll2_d4=
",
> +       "pll2_d5", "pll2_d8", "pll2_d8"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_bit_clk, "dpu_bit_clk",
> +                                 dpubit_parent_names,
> +                                 APMU_LCD_CLK_RES_CTRL1,
> +                                 17, 3, BIT(31),
> +                                 20, 3, BIT(16), BIT(16), 0x0,
> +                                 0);
> +
> +static const char * const dpupx_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p=
2", "pll2_d7", "pll2_d8"
> +};
> +static CCU_DIV2_FC_MUX_GATE_DEFINE(dpu_pxclk, "dpu_pxclk", dpupx_parent_=
names,
> +                                 APMU_LCD_CLK_RES_CTRL1,
> +                                 APMU_LCD_CLK_RES_CTRL2,
> +                                 17, 4, BIT(30),
> +                                 21, 3, BIT(16), BIT(16), 0x0,
> +                                 0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(dpu_hclk, "dpu_hclk",
> +                                APMU_LCD_CLK_RES_CTRL1,
> +                                BIT(5), BIT(5), 0x0,
> +                                0);
> +
> +static const char * const dpu_spi_parent_names[] =3D {
> +       "pll1_d8_307p2", "pll1_d6_409p6", "pll1_d10_245p76", "pll1_d11_22=
3p4",
> +       "pll1_d13_189", "pll1_d23_106p8", "pll2_d3", "pll2_d5"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_spi_clk, "dpu_spi_clk",
> +                                 dpu_spi_parent_names,
> +                                 APMU_LCD_SPI_CLK_RES_CTRL,
> +                                 8, 3, BIT(7),
> +                                 12, 3, BIT(1), BIT(1), 0x0,
> +                                 0);
> +static CCU_GATE_NO_PARENT_DEFINE(dpu_spi_hbus_clk, "dpu_spi_hbus_clk",
> +                                APMU_LCD_SPI_CLK_RES_CTRL,
> +                                BIT(3), BIT(3), 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(dpu_spi_bus_clk, "dpu_spi_bus_clk",
> +                                APMU_LCD_SPI_CLK_RES_CTRL,
> +                                BIT(5), BIT(5), 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(dpu_spi_aclk, "dpu_spi_aclk",
> +                                APMU_LCD_SPI_CLK_RES_CTRL,
> +                                BIT(6), BIT(6), 0x0,
> +                                0);
> +
> +static const char * const v2d_parent_names[] =3D {
> +       "pll1_d5_491p52", "pll1_d6_409p6", "pll1_d8_307p2", "pll1_d4_614p=
4",
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(v2d_clk, "v2d_clk", v2d_parent_names,
> +                                 APMU_LCD_CLK_RES_CTRL1,
> +                                 9, 3, BIT(28),
> +                                 12, 2, BIT(8), BIT(8), 0x0,
> +                                 0);
> +
> +static const char * const ccic_4x_parent_names[] =3D {
> +       "pll1_d5_491p52", "pll1_d6_409p6", "pll1_d4_614p4", "pll1_d3_819p=
2",
> +       "pll2_d2", "pll2_d3", "pll2_d4", "pll1_d2_1228p8"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(ccic_4x_clk, "ccic_4x_clk",
> +                                 ccic_4x_parent_names,
> +                                 APMU_CCIC_CLK_RES_CTRL,
> +                                 18, 3, BIT(15),
> +                                 23, 2, BIT(4), BIT(4), 0x0,
> +                                 0);
> +
> +static const char * const ccic1phy_parent_names[] =3D {
> +       "pll1_d24_102p4", "pll1_d48_51p2_ap"
> +};
> +static CCU_MUX_GATE_DEFINE(ccic1phy_clk, "ccic1phy_clk", ccic1phy_parent=
_names,
> +                          APMU_CCIC_CLK_RES_CTRL,
> +                          7, 1, BIT(5), BIT(5), 0x0,
> +                          0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(sdh_axi_aclk, "sdh_axi_aclk",
> +                                APMU_SDH0_CLK_RES_CTRL,
> +                                BIT(3), BIT(3), 0x0,
> +                                0);
> +static const char * const sdh01_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d4_614p4", "pll2_d8", "pll2_d5",
> +       "pll1_d11_223p4", "pll1_d13_189", "pll1_d23_106p8"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(sdh0_clk, "sdh0_clk", sdh01_parent_nam=
es,
> +                                 APMU_SDH0_CLK_RES_CTRL,
> +                                 8, 3, BIT(11),
> +                                 5, 3, BIT(4), BIT(4), 0x0,
> +                                 0);
> +static CCU_DIV_FC_MUX_GATE_DEFINE(sdh1_clk, "sdh1_clk", sdh01_parent_nam=
es,
> +                                 APMU_SDH1_CLK_RES_CTRL,
> +                                 8, 3, BIT(11),
> +                                 5, 3, BIT(4), BIT(4), 0x0,
> +                                 0);
> +static const char * const sdh2_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d4_614p4", "pll2_d8", "pll1_d3_819p2",
> +       "pll1_d11_223p4", "pll1_d13_189", "pll1_d23_106p8"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(sdh2_clk, "sdh2_clk", sdh2_parent_name=
s,
> +                                 APMU_SDH2_CLK_RES_CTRL,
> +                                 8, 3, BIT(11),
> +                                 5, 3, BIT(4), BIT(4), 0x0,
> +                                 0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(usb_axi_clk, "usb_axi_clk",
> +                                APMU_USB_CLK_RES_CTRL,
> +                                BIT(1), BIT(1), 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(usb_p1_aclk, "usb_p1_aclk",
> +                                APMU_USB_CLK_RES_CTRL,
> +                                BIT(5), BIT(5), 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(usb30_clk, "usb30_clk",
> +                                APMU_USB_CLK_RES_CTRL,
> +                                BIT(8), BIT(8), 0x0,
> +                                0);
> +
> +static const char * const qspi_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll2_d8", "pll1_d8_307p2", "pll1_d10_245p76",
> +       "pll1_d11_223p4", "pll1_d23_106p8", "pll1_d5_491p52", "pll1_d13_1=
89"
> +};
> +static CCU_DIV_MFC_MUX_GATE_DEFINE(qspi_clk, "qspi_clk", qspi_parent_nam=
es,
> +                                  APMU_QSPI_CLK_RES_CTRL,
> +                                  9, 3, BIT(12),
> +                                  6, 3, BIT(4), BIT(4), 0x0,
> +                                  0);
> +static CCU_GATE_NO_PARENT_DEFINE(qspi_bus_clk, "qspi_bus_clk",
> +                                APMU_QSPI_CLK_RES_CTRL,
> +                                BIT(3), BIT(3), 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(dma_clk, "dma_clk",
> +                                APMU_DMA_CLK_RES_CTRL,
> +                                BIT(3), BIT(3), 0x0,
> +                                0);
> +
> +static const char * const aes_parent_names[] =3D {
> +       "pll1_d12_204p8", "pll1_d24_102p4"
> +};
> +static CCU_MUX_GATE_DEFINE(aes_clk, "aes_clk", aes_parent_names,
> +                          APMU_AES_CLK_RES_CTRL,
> +                          6, 1, BIT(5), BIT(5), 0x0,
> +                          0);
> +
> +static const char * const vpu_parent_names[] =3D {
> +       "pll1_d4_614p4", "pll1_d5_491p52", "pll1_d3_819p2", "pll1_d6_409p=
6",
> +       "pll3_d6", "pll2_d3", "pll2_d4", "pll2_d5"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(vpu_clk, "vpu_clk", vpu_parent_names,
> +                                 APMU_VPU_CLK_RES_CTRL,
> +                                 13, 3, BIT(21),
> +                                 10, 3,
> +                                 BIT(3), BIT(3), 0x0,
> +                                 0);
> +
> +static const char * const gpu_parent_names[] =3D {
> +       "pll1_d4_614p4", "pll1_d5_491p52", "pll1_d3_819p2", "pll1_d6_409p=
6",
> +       "pll3_d6", "pll2_d3", "pll2_d4", "pll2_d5"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(gpu_clk, "gpu_clk", gpu_parent_names,
> +                                 APMU_GPU_CLK_RES_CTRL,
> +                                 12, 3, BIT(15),
> +                                 18, 3,
> +                                 BIT(4), BIT(4), 0x0,
> +                                 0);
> +
> +static const char * const emmc_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d4_614p4", "pll1_d52_47p26", "pll1_d3_819p=
2"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(emmc_clk, "emmc_clk", emmc_parent_name=
s,
> +                                 APMU_PMUA_EM_CLK_RES_CTRL,
> +                                 8, 3, BIT(11),
> +                                 6, 2,
> +                                 0x18, 0x18, 0x0,
> +                                 0);
> +static CCU_DIV_GATE_DEFINE(emmc_x_clk, "emmc_x_clk", "pll1_d2_1228p8",
> +                          APMU_PMUA_EM_CLK_RES_CTRL,
> +                          12, 3, BIT(15), BIT(15), 0x0,
> +                          0);
> +
> +static const char * const audio_parent_names[] =3D {
> +       "pll1_aud_245p7", "pll1_d8_307p2", "pll1_d6_409p6"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(audio_clk, "audio_clk", audio_parent_n=
ames,
> +                                 APMU_AUDIO_CLK_RES_CTRL,
> +                                 4, 3, BIT(15),
> +                                 7, 3,
> +                                 BIT(12), BIT(12), 0x0,
> +                                 0);
> +
> +static const char * const hdmi_parent_names[] =3D {
> +       "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p=
2"
> +};
> +static CCU_DIV_FC_MUX_GATE_DEFINE(hdmi_mclk, "hdmi_mclk", hdmi_parent_na=
mes,
> +                                 APMU_HDMI_CLK_RES_CTRL,
> +                                 1, 4, BIT(29),
> +                                 5, 3,
> +                                 BIT(0), BIT(0), 0x0,
> +                                 0);
> +
> +static const char * const pmua_aclk_parent_names[] =3D {
> +       "pll1_d10_245p76", "pll1_d8_307p2"
> +};
> +static CCU_DIV_FC_MUX_DEFINE(pmua_aclk, "pmua_aclk", pmua_aclk_parent_na=
mes,
> +                            APMU_ACLK_CLK_CTRL,
> +                            1, 2, BIT(4),
> +                            0, 1,
> +                            0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(pcie0_clk, "pcie0_clk",
> +                                APMU_PCIE_CLK_RES_CTRL_0,
> +                                0x7, 0x7, 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(pcie1_clk, "pcie1_clk",
> +                                APMU_PCIE_CLK_RES_CTRL_1,
> +                                0x7, 0x7, 0x0,
> +                                0);
> +static CCU_GATE_NO_PARENT_DEFINE(pcie2_clk, "pcie2_clk",
> +                                APMU_PCIE_CLK_RES_CTRL_2,
> +                                0x7, 0x7, 0x0,
> +                                0);
> +
> +static CCU_GATE_NO_PARENT_DEFINE(emac0_bus_clk, "emac0_bus_clk",
> +                                APMU_EMAC0_CLK_RES_CTRL,
> +                                BIT(0), BIT(0), 0x0,
> +                                0);
> +static CCU_GATE_DEFINE(emac0_ptp_clk, "emac0_ptp_clk", "pll2_d6",
> +                      APMU_EMAC0_CLK_RES_CTRL,
> +                      BIT(15), BIT(15), 0x0,
> +                      0);
> +static CCU_GATE_NO_PARENT_DEFINE(emac1_bus_clk, "emac1_bus_clk",
> +                                APMU_EMAC1_CLK_RES_CTRL,
> +                                BIT(0), BIT(0), 0x0,
> +                                0);
> +static CCU_GATE_DEFINE(emac1_ptp_clk, "emac1_ptp_clk", "pll2_d6",
> +                      APMU_EMAC1_CLK_RES_CTRL,
> +                      BIT(15), BIT(15), 0x0,
> +                      0);
> +/*     APMU clocks end         */
> +
> +static struct clk_hw_onecell_data k1_ccu_apbs_clks =3D {
> +       .hws =3D {
> +               [CLK_PLL1]              =3D &pll1.common.hw,
> +               [CLK_PLL2]              =3D &pll2.common.hw,
> +               [CLK_PLL3]              =3D &pll3.common.hw,
> +               [CLK_PLL1_D2]           =3D &pll1_d2.common.hw,
> +               [CLK_PLL1_D3]           =3D &pll1_d3.common.hw,
> +               [CLK_PLL1_D4]           =3D &pll1_d4.common.hw,
> +               [CLK_PLL1_D5]           =3D &pll1_d5.common.hw,
> +               [CLK_PLL1_D6]           =3D &pll1_d6.common.hw,
> +               [CLK_PLL1_D7]           =3D &pll1_d7.common.hw,
> +               [CLK_PLL1_D8]           =3D &pll1_d8.common.hw,
> +               [CLK_PLL1_D11]          =3D &pll1_d11_223p4.common.hw,
> +               [CLK_PLL1_D13]          =3D &pll1_d13_189.common.hw,
> +               [CLK_PLL1_D23]          =3D &pll1_d23_106p8.common.hw,
> +               [CLK_PLL1_D64]          =3D &pll1_d64_38p4.common.hw,
> +               [CLK_PLL1_D10_AUD]      =3D &pll1_aud_245p7.common.hw,
> +               [CLK_PLL1_D100_AUD]     =3D &pll1_aud_24p5.common.hw,
> +               [CLK_PLL2_D1]           =3D &pll2_d1.common.hw,
> +               [CLK_PLL2_D2]           =3D &pll2_d2.common.hw,
> +               [CLK_PLL2_D3]           =3D &pll2_d3.common.hw,
> +               [CLK_PLL2_D3]           =3D &pll2_d4.common.hw,
> +               [CLK_PLL2_D5]           =3D &pll2_d5.common.hw,
> +               [CLK_PLL2_D6]           =3D &pll2_d6.common.hw,
> +               [CLK_PLL2_D7]           =3D &pll2_d7.common.hw,
> +               [CLK_PLL2_D8]           =3D &pll2_d8.common.hw,
> +               [CLK_PLL3_D1]           =3D &pll3_d1.common.hw,
> +               [CLK_PLL3_D2]           =3D &pll3_d2.common.hw,
> +               [CLK_PLL3_D3]           =3D &pll3_d3.common.hw,
> +               [CLK_PLL3_D4]           =3D &pll3_d4.common.hw,
> +               [CLK_PLL3_D5]           =3D &pll3_d5.common.hw,
> +               [CLK_PLL3_D6]           =3D &pll3_d6.common.hw,
> +               [CLK_PLL3_D7]           =3D &pll3_d7.common.hw,
> +               [CLK_PLL3_D8]           =3D &pll3_d8.common.hw,
> +               [CLK_PLL3_80]           =3D &pll3_80.common.hw,
> +               [CLK_PLL3_40]           =3D &pll3_40.common.hw,
> +               [CLK_PLL3_20]           =3D &pll3_20.common.hw,
> +
> +       },
> +       .num =3D CLK_APBS_NUM,
> +};
> +
> +static struct clk_hw_onecell_data k1_ccu_mpmu_clks =3D {
> +       .hws =3D {
> +               [CLK_PLL1_307P2]        =3D &pll1_d8_307p2.common.hw,
> +               [CLK_PLL1_76P8]         =3D &pll1_d32_76p8.common.hw,
> +               [CLK_PLL1_61P44]        =3D &pll1_d40_61p44.common.hw,
> +               [CLK_PLL1_153P6]        =3D &pll1_d16_153p6.common.hw,
> +               [CLK_PLL1_102P4]        =3D &pll1_d24_102p4.common.hw,
> +               [CLK_PLL1_51P2]         =3D &pll1_d48_51p2.common.hw,
> +               [CLK_PLL1_51P2_AP]      =3D &pll1_d48_51p2_ap.common.hw,
> +               [CLK_PLL1_57P6]         =3D &pll1_m3d128_57p6.common.hw,
> +               [CLK_PLL1_25P6]         =3D &pll1_d96_25p6.common.hw,
> +               [CLK_PLL1_12P8]         =3D &pll1_d192_12p8.common.hw,
> +               [CLK_PLL1_12P8_WDT]     =3D &pll1_d192_12p8_wdt.common.hw,
> +               [CLK_PLL1_6P4]          =3D &pll1_d384_6p4.common.hw,
> +               [CLK_PLL1_3P2]          =3D &pll1_d768_3p2.common.hw,
> +               [CLK_PLL1_1P6]          =3D &pll1_d1536_1p6.common.hw,
> +               [CLK_PLL1_0P8]          =3D &pll1_d3072_0p8.common.hw,
> +               [CLK_PLL1_351]          =3D &pll1_d7_351p08.common.hw,
> +               [CLK_PLL1_409P6]        =3D &pll1_d6_409p6.common.hw,
> +               [CLK_PLL1_204P8]        =3D &pll1_d12_204p8.common.hw,
> +               [CLK_PLL1_491]          =3D &pll1_d5_491p52.common.hw,
> +               [CLK_PLL1_245P76]       =3D &pll1_d10_245p76.common.hw,
> +               [CLK_PLL1_614]          =3D &pll1_d4_614p4.common.hw,
> +               [CLK_PLL1_47P26]        =3D &pll1_d52_47p26.common.hw,
> +               [CLK_PLL1_31P5]         =3D &pll1_d78_31p5.common.hw,
> +               [CLK_PLL1_819]          =3D &pll1_d3_819p2.common.hw,
> +               [CLK_PLL1_1228]         =3D &pll1_d2_1228p8.common.hw,
> +               [CLK_SLOW_UART]         =3D &slow_uart.common.hw,
> +               [CLK_SLOW_UART1]        =3D &slow_uart1_14p74.common.hw,
> +               [CLK_SLOW_UART2]        =3D &slow_uart2_48.common.hw,
> +               [CLK_WDT]               =3D &wdt_clk.common.hw,
> +               [CLK_RIPC]              =3D &ripc_clk.common.hw,
> +               [CLK_I2S_SYSCLK]        =3D &i2s_sysclk.common.hw,
> +               [CLK_I2S_BCLK]          =3D &i2s_bclk.common.hw,
> +               [CLK_APB]               =3D &apb_clk.common.hw,
> +       },
> +       .num =3D CLK_MPMU_NUM,
> +};
> +
> +static struct clk_hw_onecell_data k1_ccu_apbc_clks =3D {
> +       .hws =3D {
> +               [CLK_UART0]             =3D &uart0_clk.common.hw,
> +               [CLK_UART2]             =3D &uart2_clk.common.hw,
> +               [CLK_UART3]             =3D &uart3_clk.common.hw,
> +               [CLK_UART4]             =3D &uart4_clk.common.hw,
> +               [CLK_UART5]             =3D &uart5_clk.common.hw,
> +               [CLK_UART6]             =3D &uart6_clk.common.hw,
> +               [CLK_UART7]             =3D &uart7_clk.common.hw,
> +               [CLK_UART8]             =3D &uart8_clk.common.hw,
> +               [CLK_UART9]             =3D &uart9_clk.common.hw,
> +               [CLK_GPIO]              =3D &gpio_clk.common.hw,
> +               [CLK_PWM0]              =3D &pwm0_clk.common.hw,
> +               [CLK_PWM1]              =3D &pwm1_clk.common.hw,
> +               [CLK_PWM2]              =3D &pwm2_clk.common.hw,
> +               [CLK_PWM3]              =3D &pwm3_clk.common.hw,
> +               [CLK_PWM4]              =3D &pwm4_clk.common.hw,
> +               [CLK_PWM5]              =3D &pwm5_clk.common.hw,
> +               [CLK_PWM6]              =3D &pwm6_clk.common.hw,
> +               [CLK_PWM7]              =3D &pwm7_clk.common.hw,
> +               [CLK_PWM8]              =3D &pwm8_clk.common.hw,
> +               [CLK_PWM9]              =3D &pwm9_clk.common.hw,
> +               [CLK_PWM10]             =3D &pwm10_clk.common.hw,
> +               [CLK_PWM11]             =3D &pwm11_clk.common.hw,
> +               [CLK_PWM12]             =3D &pwm12_clk.common.hw,
> +               [CLK_PWM13]             =3D &pwm13_clk.common.hw,
> +               [CLK_PWM14]             =3D &pwm14_clk.common.hw,
> +               [CLK_PWM15]             =3D &pwm15_clk.common.hw,
> +               [CLK_PWM16]             =3D &pwm16_clk.common.hw,
> +               [CLK_PWM17]             =3D &pwm17_clk.common.hw,
> +               [CLK_PWM18]             =3D &pwm18_clk.common.hw,
> +               [CLK_PWM19]             =3D &pwm19_clk.common.hw,
> +               [CLK_SSP3]              =3D &ssp3_clk.common.hw,
> +               [CLK_RTC]               =3D &rtc_clk.common.hw,
> +               [CLK_TWSI0]             =3D &twsi0_clk.common.hw,
> +               [CLK_TWSI1]             =3D &twsi1_clk.common.hw,
> +               [CLK_TWSI2]             =3D &twsi2_clk.common.hw,
> +               [CLK_TWSI4]             =3D &twsi4_clk.common.hw,
> +               [CLK_TWSI5]             =3D &twsi5_clk.common.hw,
> +               [CLK_TWSI6]             =3D &twsi6_clk.common.hw,
> +               [CLK_TWSI7]             =3D &twsi7_clk.common.hw,
> +               [CLK_TWSI8]             =3D &twsi8_clk.common.hw,
> +               [CLK_TIMERS1]           =3D &timers1_clk.common.hw,
> +               [CLK_TIMERS2]           =3D &timers2_clk.common.hw,
> +               [CLK_AIB]               =3D &aib_clk.common.hw,
> +               [CLK_ONEWIRE]           =3D &onewire_clk.common.hw,
> +               [CLK_SSPA0]             =3D &sspa0_clk.common.hw,
> +               [CLK_SSPA1]             =3D &sspa1_clk.common.hw,
> +               [CLK_DRO]               =3D &dro_clk.common.hw,
> +               [CLK_IR]                =3D &ir_clk.common.hw,
> +               [CLK_TSEN]              =3D &tsen_clk.common.hw,
> +               [CLK_IPC_AP2AUD]        =3D &ipc_ap2aud_clk.common.hw,
> +               [CLK_CAN0]              =3D &can0_clk.common.hw,
> +               [CLK_CAN0_BUS]          =3D &can0_bus_clk.common.hw,
> +       },
> +       .num =3D CLK_APBC_NUM,
> +};
> +
> +static struct clk_hw_onecell_data k1_ccu_apmu_clks =3D {
> +       .hws =3D {
> +               [CLK_CCI550]            =3D &cci550_clk.common.hw,
> +               [CLK_CPU_C0_HI]         =3D &cpu_c0_hi_clk.common.hw,
> +               [CLK_CPU_C0_CORE]       =3D &cpu_c0_core_clk.common.hw,
> +               [CLK_CPU_C0_ACE]        =3D &cpu_c0_ace_clk.common.hw,
> +               [CLK_CPU_C0_TCM]        =3D &cpu_c0_tcm_clk.common.hw,
> +               [CLK_CPU_C1_HI]         =3D &cpu_c1_hi_clk.common.hw,
> +               [CLK_CPU_C1_CORE]       =3D &cpu_c1_core_clk.common.hw,
> +               [CLK_CPU_C1_ACE]        =3D &cpu_c1_ace_clk.common.hw,
> +               [CLK_CCIC_4X]           =3D &ccic_4x_clk.common.hw,
> +               [CLK_CCIC1PHY]          =3D &ccic1phy_clk.common.hw,
> +               [CLK_SDH_AXI]           =3D &sdh_axi_aclk.common.hw,
> +               [CLK_SDH0]              =3D &sdh0_clk.common.hw,
> +               [CLK_SDH1]              =3D &sdh1_clk.common.hw,
> +               [CLK_SDH2]              =3D &sdh2_clk.common.hw,
> +               [CLK_USB_P1]            =3D &usb_p1_aclk.common.hw,
> +               [CLK_USB_AXI]           =3D &usb_axi_clk.common.hw,
> +               [CLK_USB30]             =3D &usb30_clk.common.hw,
> +               [CLK_QSPI]              =3D &qspi_clk.common.hw,
> +               [CLK_QSPI_BUS]          =3D &qspi_bus_clk.common.hw,
> +               [CLK_DMA]               =3D &dma_clk.common.hw,
> +               [CLK_AES]               =3D &aes_clk.common.hw,
> +               [CLK_VPU]               =3D &vpu_clk.common.hw,
> +               [CLK_GPU]               =3D &gpu_clk.common.hw,
> +               [CLK_EMMC]              =3D &emmc_clk.common.hw,
> +               [CLK_EMMC_X]            =3D &emmc_x_clk.common.hw,
> +               [CLK_AUDIO]             =3D &audio_clk.common.hw,
> +               [CLK_HDMI]              =3D &hdmi_mclk.common.hw,
> +               [CLK_PMUA_ACLK]         =3D &pmua_aclk.common.hw,
> +               [CLK_PCIE0]             =3D &pcie0_clk.common.hw,
> +               [CLK_PCIE1]             =3D &pcie1_clk.common.hw,
> +               [CLK_PCIE2]             =3D &pcie2_clk.common.hw,
> +               [CLK_EMAC0_BUS]         =3D &emac0_bus_clk.common.hw,
> +               [CLK_EMAC0_PTP]         =3D &emac0_ptp_clk.common.hw,
> +               [CLK_EMAC1_BUS]         =3D &emac1_bus_clk.common.hw,
> +               [CLK_EMAC1_PTP]         =3D &emac1_ptp_clk.common.hw,
> +               [CLK_JPG]               =3D &jpg_clk.common.hw,
> +               [CLK_JPF_4KAFBC]        =3D &jpg_4kafbc_clk.common.hw,
> +               [CLK_JPF_2KAFBC]        =3D &jpg_2kafbc_clk.common.hw,
> +               [CLK_CCIC2PHY]          =3D &ccic2phy_clk.common.hw,
> +               [CLK_CCIC3PHY]          =3D &ccic3phy_clk.common.hw,
> +               [CLK_CSI]               =3D &csi_clk.common.hw,
> +               [CLK_CAMM0]             =3D &camm0_clk.common.hw,
> +               [CLK_CAMM1]             =3D &camm1_clk.common.hw,
> +               [CLK_CAMM2]             =3D &camm2_clk.common.hw,
> +               [CLK_ISP_CPP]           =3D &isp_cpp_clk.common.hw,
> +               [CLK_ISP_BUS]           =3D &isp_bus_clk.common.hw,
> +               [CLK_ISP]               =3D &isp_clk.common.hw,
> +               [CLK_DPU_MCLK]          =3D &dpu_mclk.common.hw,
> +               [CLK_DPU_ESC]           =3D &dpu_esc_clk.common.hw,
> +               [CLK_DPU_BIT]           =3D &dpu_bit_clk.common.hw,
> +               [CLK_DPU_PXCLK]         =3D &dpu_pxclk.common.hw,
> +               [CLK_DPU_HCLK]          =3D &dpu_hclk.common.hw,
> +               [CLK_DPU_SPI]           =3D &dpu_spi_clk.common.hw,
> +               [CLK_DPU_SPI_HBUS]      =3D &dpu_spi_hbus_clk.common.hw,
> +               [CLK_DPU_SPIBUS]        =3D &dpu_spi_bus_clk.common.hw,
> +               [CLK_DPU_SPI_ACLK]      =3D &dpu_spi_aclk.common.hw,
> +               [CLK_V2D]               =3D &v2d_clk.common.hw,
> +       },
> +       .num =3D CLK_APMU_NUM
> +};
> +
> +struct spacemit_ccu_data {
> +       struct clk_hw_onecell_data *hw_clks;
> +       bool need_pll_lock;
> +};
> +
> +struct spacemit_ccu_priv {
> +       const struct spacemit_ccu_data *data;
> +       struct regmap *base;
> +       struct regmap *lock_base;
> +       spinlock_t lock;
> +};
> +
> +static int spacemit_ccu_register(struct device *dev,
> +                                struct spacemit_ccu_priv *priv)
> +{
> +       const struct spacemit_ccu_data *data =3D priv->data;
> +       int i, ret;
> +
> +       for (i =3D 0; i < data->hw_clks->num; i++) {
> +               struct clk_hw *hw =3D data->hw_clks->hws[i];
> +               struct ccu_common *common;
> +               const char *name;
> +
> +               if (!hw)
> +                       continue;
> +
> +               common =3D hw_to_ccu_common(hw);
> +               name =3D hw->init->name;
> +
> +               common->lock            =3D &priv->lock;
> +               common->base            =3D priv->base;
> +               common->lock_base       =3D priv->lock_base;
> +
> +               ret =3D devm_clk_hw_register(dev, hw);
> +               if (ret) {
> +                       dev_err(dev, "Cannot register clock %d - %s\n",
> +                               i, name);
> +                       return ret;
> +               }
> +       }
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                          data->hw_clks);
> +}
> +
> +static int k1_ccu_probe(struct platform_device *pdev)
> +{
> +       const struct spacemit_ccu_data *data;
> +       struct regmap *base_map, *lock_map;
> +       struct device *dev =3D &pdev->dev;
> +       struct spacemit_ccu_priv *priv;
> +       struct device_node *parent;
> +       int ret;
> +
> +       data =3D of_device_get_match_data(dev);
> +       if (WARN_ON(!data))
> +               return -EINVAL;
> +
> +       parent   =3D of_get_parent(dev->of_node);
> +       base_map =3D syscon_node_to_regmap(parent);
> +       of_node_put(parent);
> +
> +       if (IS_ERR(base_map))
> +               return dev_err_probe(dev, PTR_ERR(base_map),
> +                                    "failed to get regmap\n");
> +
> +       if (data->need_pll_lock) {
> +               lock_map =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> +                                                          "spacemit,mpmu=
");
> +               if (IS_ERR(lock_map))
> +                       return dev_err_probe(dev, PTR_ERR(lock_map),
> +                                            "failed to get lock regmap\n=
");
> +       }
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->data      =3D data;
> +       priv->base      =3D base_map;
> +       priv->lock_base =3D lock_map;
> +       spin_lock_init(&priv->lock);
> +
> +       ret =3D spacemit_ccu_register(dev, priv);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to register clocks=
");

Missing newline on printk

> +
> +       return 0;
> +}
> +
> +static const struct spacemit_ccu_data k1_ccu_apbs_data =3D {
> +       .need_pll_lock  =3D true,
> +       .hw_clks        =3D &k1_ccu_apbs_clks,
> +};
> +
> +static const struct spacemit_ccu_data k1_ccu_mpmu_data =3D {
> +       .need_pll_lock  =3D false,
> +       .hw_clks        =3D &k1_ccu_mpmu_clks,
> +};
> +
> +static const struct spacemit_ccu_data k1_ccu_apbc_data =3D {
> +       .need_pll_lock  =3D false,
> +       .hw_clks        =3D &k1_ccu_apbc_clks,
> +};
> +
> +static const struct spacemit_ccu_data k1_ccu_apmu_data =3D {
> +       .need_pll_lock  =3D false,
> +       .hw_clks        =3D &k1_ccu_apmu_clks,
> +};
> +
> +static const struct of_device_id of_k1_ccu_match[] =3D {
> +       {
> +               .compatible     =3D "spacemit,k1-ccu-apbs",
> +               .data           =3D &k1_ccu_apbs_data,
> +       },
> +       {
> +               .compatible     =3D "spacemit,k1-ccu-mpmu",
> +               .data           =3D &k1_ccu_mpmu_data,
> +       },
> +       {
> +               .compatible     =3D "spacemit,k1-ccu-apbc",
> +               .data           =3D &k1_ccu_apbc_data,
> +       },
> +       {
> +               .compatible     =3D "spacemit,k1-ccu-apmu",
> +               .data           =3D &k1_ccu_apmu_data,
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
> +
> +static struct platform_driver k1_ccu_driver =3D {
> +       .driver =3D {
> +               .name           =3D "spacemit,k1-ccu",
> +               .of_match_table =3D of_k1_ccu_match,
> +       },
> +       .probe  =3D k1_ccu_probe,
> +};
> +module_platform_driver(k1_ccu_driver);
> +
> +MODULE_DESCRIPTION("Spacemit K1 CCU driver");
> +MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu=
_common.h
> new file mode 100644
> index 000000000000..c4406099c3fc
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_common.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#ifndef _CCU_COMMON_H_
> +#define _CCU_COMMON_H_
> +
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +
> +enum ccu_div_type {
> +       CLK_DIV_TYPE_1REG_NOFC_V1 =3D 0,
> +       CLK_DIV_TYPE_1REG_FC_V2,
> +       CLK_DIV_TYPE_2REG_NOFC_V3,
> +       CLK_DIV_TYPE_2REG_FC_V4,
> +       CLK_DIV_TYPE_1REG_FC_DIV_V5,
> +       CLK_DIV_TYPE_1REG_FC_MUX_V6,
> +};
> +
> +struct ccu_common {
> +       struct regmap *base;
> +       struct regmap *lock_base;
> +       spinlock_t *lock;
> +
> +       enum ccu_div_type reg_type;
> +       u32 reg_ctrl;
> +       u32 reg_sel;
> +       u32 reg_xtc;
> +       u32 fc;
> +       bool is_pll;
> +
> +       unsigned long flags;
> +       const char *name;
> +       const char * const *parent_names;
> +       int num_parents;
> +
> +       struct clk_hw hw;
> +};
> +
> +static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
> +{
> +       return container_of(hw, struct ccu_common, hw);
> +}
> +
> +#define ccu_read(reg, c, val)  regmap_read((c)->base, (c)->reg_##reg, va=
l)
> +#define ccu_write(reg, c, val) regmap_write((c)->base, (c)->reg_##reg, v=
al)
> +#define ccu_update(reg, c, mask, val) \
> +       regmap_update_bits((c)->base, (c)->reg_##reg, mask, val)
> +#define ccu_poll(reg, c, tmp, cond, sleep, timeout) \
> +       regmap_read_poll_timeout_atomic((c)->base, (c)->reg_##reg,      \
> +                                       tmp, cond, sleep, timeout)
> +
> +#endif /* _CCU_COMMON_H_ */
> diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_dd=
n.c
> new file mode 100644
> index 000000000000..2672da6b6179
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_ddn.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type ddn
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_ddn.h"
> +
> +#define ddn_read_sel(common, val)      ccu_read(sel, common, val)
> +#define ddn_read_ctrl(common, val)     ccu_read(ctrl, common, val)
> +#define ddn_update_sel(common, m, v)   ccu_update(sel, common, m, v)
> +#define ddn_update_ctrl(common, m, v)  ccu_update(ctrl, common, m, v)
> +
> +/*
> + * It is M/N clock
> + *
> + * Fout from synthesizer can be given from two equations:
> + * numerator/denominator =3D Fin / (Fout * factor)
> + */
> +static void ccu_ddn_disable(struct clk_hw *hw)
> +{
> +       struct ccu_ddn *ddn =3D hw_to_ccu_ddn(hw);
> +       struct ccu_common *common =3D &ddn->common;
> +       unsigned long flags;
> +
> +       if (!ddn->gate)
> +               return;
> +
> +       spin_lock_irqsave(common->lock, flags);

The regmap can have a lock. Can you use that?

> +
> +       ddn_update_sel(common, ddn->gate, 0);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +}
> +
> +static int ccu_ddn_enable(struct clk_hw *hw)
> +{
> +       struct ccu_ddn *ddn =3D hw_to_ccu_ddn(hw);
> +       struct ccu_common *common =3D &ddn->common;
> +       unsigned long flags;
> +
> +       if (!ddn->gate)
> +               return 0;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       ddn_update_sel(common, ddn->gate, ddn->gate);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int ccu_ddn_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_ddn *ddn =3D hw_to_ccu_ddn(hw);
> +       struct ccu_common *common =3D &ddn->common;
> +       u32 tmp;
> +
> +       if (!ddn->gate)
> +               return 1;
> +
> +       ddn_read_sel(common, &tmp);
> +
> +       return tmp & ddn->gate;
> +}
> +
> +static long clk_ddn_round_rate(struct clk_hw *hw, unsigned long drate,
> +                              unsigned long *prate)
> +{
> +       struct ccu_ddn *ddn =3D hw_to_ccu_ddn(hw);
> +       struct ccu_ddn_config *params =3D &ddn->ddn;
> +       unsigned long rate =3D 0, prev_rate;
> +       unsigned long result;
> +       int i;
> +
> +       for (i =3D 0; i < params->tbl_size; i++) {
> +               prev_rate =3D rate;
> +               rate =3D (((*prate / 10000) * params->tbl[i].den) /
> +                       (params->tbl[i].num * params->info->factor)) * 10=
000;
> +               if (rate > drate)
> +                       break;
> +       }
> +
> +       if ((i =3D=3D 0) || (i =3D=3D params->tbl_size)) {
> +               result =3D rate;
> +       } else {
> +               if ((drate - prev_rate) > (rate - drate))
> +                       result =3D rate;
> +               else
> +                       result =3D prev_rate;
> +       }
> +
> +       return result;
> +}
> +
> +static unsigned long clk_ddn_recalc_rate(struct clk_hw *hw,
> +               unsigned long parent_rate)
> +{
> +       struct ccu_ddn *ddn =3D hw_to_ccu_ddn(hw);
> +       struct ccu_ddn_config *params =3D &ddn->ddn;
> +       unsigned int val, num, den;
> +       unsigned long rate;
> +
> +       ddn_read_ctrl(&ddn->common, &val);
> +
> +       num =3D (val >> params->info->num_shift) & params->info->num_mask;
> +       den =3D (val >> params->info->den_shift) & params->info->den_mask;
> +
> +       if (!den)
> +               return 0;
> +
> +       rate =3D ((parent_rate / 10000)  * den) / (num * params->info->fa=
ctor);
> +       rate *=3D 10000;
> +
> +       return rate;
> +}
> +
> +/* Configures new clock rate*/
> +static int clk_ddn_set_rate(struct clk_hw *hw, unsigned long drate,
> +                           unsigned long prate)
> +{
> +       struct ccu_ddn *ddn =3D hw_to_ccu_ddn(hw);
> +       struct ccu_ddn_config *params =3D &ddn->ddn;
> +       struct ccu_ddn_info *info =3D params->info;
> +       unsigned long prev_rate, rate =3D 0;
> +       unsigned long flags;
> +       int i;
> +
> +       for (i =3D 0; i < params->tbl_size; i++) {
> +               prev_rate =3D rate;
> +               rate =3D ((prate / 10000) * params->tbl[i].den) /
> +                      (params->tbl[i].num * info->factor);
> +               rate *=3D 10000;
> +
> +               if (rate > drate)
> +                       break;
> +       }
> +
> +       if (i > 0)
> +               i--;
> +
> +       spin_lock_irqsave(ddn->common.lock, flags);
> +
> +       ddn_update_ctrl(&ddn->common,
> +                       info->num_mask | info->den_mask,
> +                       (params->tbl[i].num << info->num_shift) |
> +                       (params->tbl[i].den << info->den_shift));
> +
> +       spin_unlock_irqrestore(ddn->common.lock, flags);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops spacemit_ccu_ddn_ops =3D {
> +       .disable        =3D ccu_ddn_disable,
> +       .enable         =3D ccu_ddn_enable,
> +       .is_enabled     =3D ccu_ddn_is_enabled,
> +       .recalc_rate    =3D clk_ddn_recalc_rate,
> +       .round_rate     =3D clk_ddn_round_rate,
> +       .set_rate       =3D clk_ddn_set_rate,
> +};
> diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_dd=
n.h
> new file mode 100644
> index 000000000000..ffbbe073199b
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_ddn.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenayy@outlook.com>
> + */
> +
> +#ifndef _CCU_DDN_H_
> +#define _CCU_DDN_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_ddn_tbl {
> +       unsigned int num;
> +       unsigned int den;
> +};
> +
> +struct ccu_ddn_info {
> +       unsigned int factor;
> +       unsigned int num_mask;
> +       unsigned int den_mask;
> +       unsigned int num_shift;
> +       unsigned int den_shift;
> +};
> +
> +struct ccu_ddn_config {
> +       struct ccu_ddn_info *info;
> +       struct ccu_ddn_tbl *tbl;
> +       u32 tbl_size;
> +};
> +
> +struct ccu_ddn {
> +       struct ccu_ddn_config  ddn;
> +       struct ccu_common       common;
> +       u32 gate;
> +};
> +
> +#define CCU_DDN_CONFIG(_info, _table)                                  \
> +       {                                                               \
> +               .info           =3D (struct ccu_ddn_info *)_info,        =
 \
> +               .tbl            =3D (struct ccu_ddn_tbl *)&_table,       =
 \
> +               .tbl_size       =3D ARRAY_SIZE(_table),                  =
 \
> +       }
> +
> +#define CCU_DDN_DEFINE(_struct, _name, _parent, _info, _table,         \
> +                      _reg_ctrl, _flags)                               \
> +       struct ccu_ddn _struct =3D {                                     =
 \
> +               .ddn    =3D CCU_DDN_CONFIG(_info, _table),               =
 \
> +               .common =3D {                                            =
 \
> +                       .reg_ctrl =3D _reg_ctrl,                         =
 \
> +                       .hw.init  =3D CLK_HW_INIT(_name, _parent,        =
 \
> +                                              &spacemit_ccu_ddn_ops,   \
> +                                              _flags),                 \
> +               }                                                       \
> +       }
> +
> +#define CCU_DDN_GATE_DEFINE(_struct, _name, _parent, _info, _table,    \
> +                           _reg_ddn, _reg_gate, _gate_mask, _flags)    \
> +       struct ccu_ddn _struct =3D {                                     =
 \
> +               .ddn    =3D CCU_DDN_CONFIG(_info, _table),               =
 \
> +               .common =3D {                                            =
 \
> +                       .reg_ctrl       =3D _reg_ddn,                    =
 \
> +                       .reg_sel        =3D _reg_gate,                   =
 \
> +                       .hw.init =3D CLK_HW_INIT(_name, _parent,         =
 \
> +                                              &spacemit_ccu_ddn_ops,   \
> +                                              _flags),                 \
> +               }                                                       \
> +               .gate   =3D _gate_mask,                                  =
 \
> +       }
> +
> +
> +static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
> +{
> +       struct ccu_common *common =3D hw_to_ccu_common(hw);
> +
> +       return container_of(common, struct ccu_ddn, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_ddn_ops;
> +
> +#endif
> diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mi=
x.c
> new file mode 100644
> index 000000000000..750882b6ed93
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_mix.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type mix(div/mux/gate/factor)
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_mix.h"
> +
> +#define MIX_TIMEOUT    10000
> +
> +#define mix_read_sel(c, val)           ccu_read(sel, c, val)
> +#define mix_read_ctrl(c, val)          ccu_read(ctrl, c, val)
> +#define mix_update_sel(c, m, v)                ccu_update(sel, c, m, v)
> +#define mix_update_ctrl(c, m, v)       ccu_update(ctrl, c, m, v)
> +
> +#define mix_hwparam_in_sel(c) \
> +       ((c)->reg_type =3D=3D CLK_DIV_TYPE_2REG_NOFC_V3 || \
> +        (c)->reg_type =3D=3D CLK_DIV_TYPE_2REG_FC_V4)
> +
> +static void ccu_mix_disable(struct clk_hw *hw)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_gate_config *gate =3D mix->gate;
> +       unsigned long flags =3D 0;
> +
> +       if (!gate)
> +               return;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_update_sel(common, gate->gate_mask, gate->val_disable=
);
> +       else
> +               mix_update_ctrl(common, gate->gate_mask, gate->val_disabl=
e);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +}
> +
> +static int ccu_mix_enable(struct clk_hw *hw)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_gate_config *gate =3D mix->gate;
> +       u32 val_enable, mask;
> +       unsigned long flags;
> +       u32 tmp;
> +
> +       if (!gate)
> +               return 0;
> +
> +       val_enable      =3D gate->val_enable;
> +       mask            =3D gate->gate_mask;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_update_sel(common, mask, val_enable);
> +       else
> +               mix_update_ctrl(common, mask, val_enable);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       if (common->reg_type =3D=3D CLK_DIV_TYPE_2REG_NOFC_V3 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_2REG_FC_V4)
> +               return ccu_poll(sel, common, tmp, (tmp & mask) =3D=3D val=
_enable,
> +                               10, MIX_TIMEOUT);
> +       else
> +               return ccu_poll(ctrl, common, tmp, (tmp & mask) =3D=3D va=
l_enable,
> +                               10, MIX_TIMEOUT);
> +}
> +
> +static int ccu_mix_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_gate_config *gate =3D mix->gate;
> +       unsigned long flags =3D 0;
> +       u32 tmp;
> +
> +       if (!gate)
> +               return 1;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_read_sel(common, &tmp);
> +       else
> +               mix_read_ctrl(common, &tmp);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return (tmp & gate->gate_mask) =3D=3D gate->val_enable;
> +}
> +
> +static unsigned long ccu_mix_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_div_config *div =3D mix->div;
> +       unsigned long val;
> +       u32 reg;
> +
> +       if (!div) {
> +               if (mix->factor)
> +                       return parent_rate * mix->factor->mul / mix->fact=
or->div;
> +
> +               return parent_rate;
> +       }
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_read_sel(common, &reg);
> +       else
> +               mix_read_ctrl(common, &reg);
> +
> +       val =3D reg >> div->shift;
> +       val &=3D (1 << div->width) - 1;
> +
> +       val =3D divider_recalc_rate(hw, parent_rate, val, div->table,
> +                                 div->flags, div->width);
> +
> +       return val;
> +}
> +
> +
> +static int ccu_mix_trigger_fc(struct clk_hw *hw)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       int ret =3D 0, timeout =3D 50;
> +       unsigned int val =3D 0;
> +
> +       if (common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_V2 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_2REG_FC_V4 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_DIV_V5 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_MUX_V6) {
> +               timeout =3D 50;
> +               mix_update_ctrl(common, common->fc, common->fc);
> +
> +               ret =3D ccu_poll(ctrl, common, val, !(val & common->fc),
> +                              5, MIX_TIMEOUT);
> +       }
> +
> +       return ret;
> +}
> +
> +static int ccu_mix_determine_rate(struct clk_hw *hw,
> +                                 struct clk_rate_request *req)
> +{
> +       return 0;
> +}
> +
> +static long ccu_mix_round_rate(struct clk_hw *hw, unsigned long rate,
> +                               unsigned long *prate)
> +{
> +       return rate;
> +}
> +
> +static unsigned long
> +ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate, u32 *mux_v=
al,
> +                      u32 *div_val)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_div_config *div =3D mix->div ? mix->div : NULL;
> +       struct clk_hw *parent;
> +       unsigned long parent_rate =3D 0, best_rate =3D 0;
> +       u32 i, j, div_max;
> +
> +       for (i =3D 0; i < common->num_parents; i++) {
> +               parent =3D clk_hw_get_parent_by_index(hw, i);
> +               if (!parent)
> +                       continue;
> +
> +               parent_rate =3D clk_hw_get_rate(parent);
> +
> +               if (div)
> +                       div_max =3D 1 << div->width;
> +               else
> +                       div_max =3D 1;
> +
> +               for (j =3D 1; j <=3D div_max; j++) {
> +                       if (abs(parent_rate/j - rate) < abs(best_rate - r=
ate)) {
> +                               best_rate =3D DIV_ROUND_UP_ULL(parent_rat=
e, j);
> +                               *mux_val =3D i;
> +                               *div_val =3D j - 1;
> +                       }
> +               }
> +       }
> +
> +       return best_rate;
> +}
> +
> +static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
> +                          unsigned long parent_rate)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_div_config *div =3D mix->div;
> +       struct ccu_mux_config *mux =3D mix->mux;
> +       u32 cur_mux, cur_div, mux_val =3D 0, div_val =3D 0;
> +       unsigned long best_rate =3D 0;
> +       unsigned long flags;
> +       int ret =3D 0, tmp =3D 0;
> +
> +       if (!div && !mux)
> +               return 0;
> +
> +       best_rate =3D ccu_mix_calc_best_rate(hw, rate, &mux_val, &div_val=
);
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_read_sel(common, &tmp);
> +       else
> +               mix_read_ctrl(common, &tmp);
> +
> +       if (mux) {
> +               cur_mux =3D tmp >> mux->shift;
> +               cur_mux &=3D (1 << mux->width) - 1;
> +
> +               if (cur_mux !=3D mux_val)
> +                       clk_hw_set_parent(hw,
> +                                         clk_hw_get_parent_by_index(hw,
> +                                                                    mux_=
val));
> +       }
> +
> +       if (div) {
> +               cur_div =3D tmp >> div->shift;
> +               cur_div &=3D (1 << div->width) - 1;
> +
> +               if (cur_div =3D=3D div_val)
> +                       return 0;
> +       } else {
> +               return 0;
> +       }
> +
> +       tmp =3D GENMASK(div->width + div->shift - 1, div->shift);
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_update_sel(common, tmp, div_val << div->shift);
> +       else
> +               mix_update_ctrl(common, tmp, div_val << div->shift);
> +
> +       if (common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_V2 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_2REG_FC_V4 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_DIV_V5)
> +               ret =3D ccu_mix_trigger_fc(hw);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return ret;
> +}
> +
> +static u8 ccu_mix_get_parent(struct clk_hw *hw)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_mux_config *mux =3D mix->mux;
> +       u32 reg;
> +       u8 parent;
> +
> +       if (!mux)
> +               return 0;
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_read_sel(common, &reg);
> +       else
> +               mix_read_ctrl(common, &reg);
> +
> +       parent =3D reg >> mux->shift;
> +       parent &=3D (1 << mux->width) - 1;
> +
> +       if (mux->table) {
> +               int num_parents =3D clk_hw_get_num_parents(&common->hw);
> +               int i;
> +
> +               for (i =3D 0; i < num_parents; i++)
> +                       if (mux->table[i] =3D=3D parent)
> +                               return i;
> +       }
> +
> +       return parent;
> +}
> +
> +static int ccu_mix_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_common *common =3D &mix->common;
> +       struct ccu_mux_config *mux =3D mix->mux;
> +       unsigned long flags;
> +       int ret =3D 0;
> +       u32 mask;
> +
> +       if (!mux)
> +               return 0;
> +
> +       if (mux->table)
> +               index =3D mux->table[index];
> +
> +       mask =3D GENMASK(mux->width + mux->shift - 1, mux->shift);
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       if (mix_hwparam_in_sel(common))
> +               mix_update_sel(common, mask, index << mux->shift);
> +       else
> +               mix_update_ctrl(common, mask, index << mux->shift);
> +
> +       if (common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_V2 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_2REG_FC_V4 ||
> +           common->reg_type =3D=3D CLK_DIV_TYPE_1REG_FC_MUX_V6)
> +               ret =3D ccu_mix_trigger_fc(hw);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return ret;
> +}
> +
> +const struct clk_ops spacemit_ccu_mix_ops =3D {
> +       .disable         =3D ccu_mix_disable,
> +       .enable          =3D ccu_mix_enable,
> +       .is_enabled      =3D ccu_mix_is_enabled,
> +       .get_parent      =3D ccu_mix_get_parent,
> +       .set_parent      =3D ccu_mix_set_parent,
> +       .determine_rate  =3D ccu_mix_determine_rate,
> +       .round_rate      =3D ccu_mix_round_rate,

Only implement determine_rate

> +       .recalc_rate     =3D ccu_mix_recalc_rate,
> +       .set_rate        =3D ccu_mix_set_rate,
> +};
> +
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mi=
x.h
> new file mode 100644
> index 000000000000..753bc6177df7
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -0,0 +1,348 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#ifndef _CCU_MIX_H_
> +#define _CCU_MIX_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_gate_config {
> +       u32 gate_mask;
> +       u32 val_enable;
> +       u32 val_disable;
> +       u32 flags;
> +};
> +
> +struct ccu_factor_config {
> +       u32 div;
> +       u32 mul;
> +};
> +
> +struct ccu_mux_config {
> +       const u8 *table;
> +       u32 flags;
> +       u8 shift;
> +       u8 width;
> +};
> +
> +struct ccu_div_config {
> +       struct clk_div_table *table;
> +       u32 max;
> +       u32 offset;
> +       u32 flags;
> +       u8 shift;
> +       u8 width;
> +};
> +
> +struct ccu_mix {
> +       struct ccu_factor_config *factor;
> +       struct ccu_gate_config *gate;
> +       struct ccu_div_config *div;
> +       struct ccu_mux_config *mux;
> +       struct ccu_common common;
> +};
> +
> +#define CCU_GATE_INIT(_gate_mask, _val_enable, _val_disable, _flags)    =
       \
> +       (&(struct ccu_gate_config) {                                     =
       \
> +               .gate_mask   =3D _gate_mask,                             =
         \
> +               .val_enable  =3D _val_enable,                            =
         \
> +               .val_disable =3D _val_disable,                           =
         \
> +               .flags       =3D _flags,                                 =
         \
> +       })
> +
> +#define CCU_FACTOR_INIT(_div, _mul)                                    \
> +       (&(struct ccu_factor_config) {                                  \
> +               .div =3D _div,                                           =
 \
> +               .mul =3D _mul,                                           =
 \
> +       })
> +
> +
> +#define CCU_MUX_INIT(_shift, _width, _table, _flags)                   \
> +       (&(struct ccu_mux_config) {                                     \
> +               .shift  =3D _shift,                                      =
 \
> +               .width  =3D _width,                                      =
 \
> +               .table  =3D _table,                                      =
 \
> +               .flags  =3D _flags,                                      =
 \
> +       })
> +
> +#define CCU_DIV_INIT(_shift, _width, _table, _flags)                   \
> +       (&(struct ccu_div_config) {                                     \
> +               .shift  =3D _shift,                                      =
 \
> +               .width  =3D _width,                                      =
 \
> +               .flags  =3D _flags,                                      =
 \
> +               .table  =3D _table,                                      =
 \
> +       })
> +
> +#define CCU_MIX_INITHW(_name, _parent, _flags) \
> +       CLK_HW_INIT(_name, _parent, &spacemit_ccu_mix_ops, _flags)
> +
> +#define CCU_MIX_ORPHAN_INITHW(_name, _flags) \
> +       CLK_HW_INIT_NO_PARENT(_name, &spacemit_ccu_mix_ops, _flags)
> +
> +#define CCU_MIX_INITHW_PARENTS(_name, _parents, _flags) \
> +       CLK_HW_INIT_PARENTS(_name, _parents, &spacemit_ccu_mix_ops, _flag=
s)
> +
> +#define CCU_GATE_DEFINE(_struct, _name, _parent, _reg, _gate_mask,     \
> +                        _val_enable, _val_disable, _flags)             \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 1,                                   =
 \
> +               .hw.init        =3D CCU_MIX_INITHW(_name, _parent,       =
 \
> +                                                _flags),               \
> +       }                                                               \
> +}
> +#define CCU_GATE_NO_PARENT_DEFINE(_struct, _name,  _reg, _gate_mask,   \
> +                                 _val_enable, _val_disable, _flags)    \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 0,                                   =
 \
> +               .hw.init        =3D CCU_MIX_ORPHAN_INITHW(_name, _flags) =
 \
> +       }                                                               \
> +}
> +
> +#define CCU_FACTOR_DEFINE(_struct, _name, _parent, _div, _mul)         \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .factor =3D CCU_FACTOR_INIT(_div, _mul),                         =
 \
> +       .common =3D {                                                    =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 1,                                   =
 \
> +               .hw.init        =3D CCU_MIX_INITHW(_name, _parent, 0),   =
 \
> +       }                                                               \
> +}
> +
> +#define CCU_MUX_DEFINE(_struct, _name, _parents, _reg, _shift, _width, \
> +                      _flags)                                          \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .mux    =3D CCU_MUX_INIT(_shift, _width, NULL, 0),               =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       }                                                               \
> +}
> +
> +#define CCU_DIV_DEFINE(_struct, _name, _parent, _reg, _shift, _width,  \
> +                      _flags)                                          \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .div    =3D CCU_DIV_INIT(_shift, _width, NULL, 0),               =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 1,                                   =
 \
> +               .hw.init =3D CCU_MIX_INITHW(_name, _parent, _flags)      =
 \
> +       }                                                               \
> +}
> +
> +#define CCU_GATE_FACTOR_DEFINE(_struct, _name, _parent, _reg,          \
> +                              _gate_mask, _val_enable, _val_disable,   \
> +                              _div, _mul, _flags)                      \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .factor =3D CCU_FACTOR_INIT(_div, _mul),                         =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 1,                                   =
 \
> +               .hw.init =3D CCU_MIX_INITHW(_name, _parent, _flags)      =
 \
> +       }                                                               \
> +}
> +
> +
> +#define CCU_MUX_GATE_DEFINE(_struct, _name, _parents, _reg, _shift,    \
> +                           _width, _gate_mask, _val_enable,            \
> +                           _val_disable, _flags)                       \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .mux    =3D CCU_MUX_INIT(_shift, _width, NULL, 0),               =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       }                                                               \
> +}
> +
> +#define CCU_DIV_GATE_DEFINE(_struct, _name, _parent, _reg, _shift,     \
> +                           _width, _gate_mask, _val_enable,            \
> +                           _val_disable, _flags)                       \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .div    =3D CCU_DIV_INIT(_shift, _width, NULL, 0),               =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg,                                =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 1,                                   =
 \
> +               .hw.init        =3D CCU_MIX_INITHW(_name, _parent,       =
 \
> +                                                _flags),               \
> +       }                                                               \
> +}
> +
> +
> +#define CCU_DIV_MUX_GATE_DEFINE(_struct, _name, _parents,  _reg_ctrl,  \
> +                               _mshift, _mwidth, _muxshift, _muxwidth, \
> +                               _gate_mask, _val_enable, _val_disable,  \
> +                               _flags)                                 \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .div    =3D CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),             =
 \
> +       .mux    =3D CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),         =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       },                                                              \
> +}
> +
> +#define CCU_DIV2_FC_MUX_GATE_DEFINE(_struct, _name, _parents,          \
> +                                   _reg_ctrl, _reg_sel, _mshift,       \
> +                                   _mwidth, _fc, _muxshift, _muxwidth, \
> +                                   _gate_mask, _val_enable,            \
> +                                   _val_disable, _flags)               \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .div    =3D CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),             =
 \
> +       .mux    =3D CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),         =
 \
> +       .common =3D {                                                    =
 \
> +           .reg_type =3D CLK_DIV_TYPE_2REG_FC_V4,                       =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .reg_sel        =3D _reg_sel,                            =
 \
> +               .fc             =3D _fc,                                 =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       },                                                              \
> +}
> +
> +
> +#define CCU_DIV_FC_MUX_GATE_DEFINE(_struct, _name, _parents, _reg_ctrl, =
       \
> +                                  _mshift, _mwidth, _fc, _muxshift,    \
> +                                  _muxwidth, _gate_mask, _val_enable,  \
> +                                  _val_disable, _flags)                \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .div    =3D CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),             =
 \
> +       .mux    =3D CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),         =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_type       =3D CLK_DIV_TYPE_1REG_FC_V2,             =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .fc             =3D _fc,                                 =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       },                                                              \
> +}
> +
> +#define CCU_DIV_MFC_MUX_GATE_DEFINE(_struct, _name, _parents,          \
> +                                   _reg_ctrl, _mshift, _mwidth, _fc,   \
> +                                   _muxshift, _muxwidth, _gate_mask,   \
> +                                   _val_enable, _val_disable, _flags)  \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .div    =3D CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),             =
 \
> +       .mux    =3D CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),         =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_type =3D CLK_DIV_TYPE_1REG_FC_MUX_V6,               =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .fc             =3D _fc,                                 =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       },                                                              \
> +}
> +
> +#define CCU_DIV_FC_WITH_GATE_DEFINE(_struct, _name, _parent, _reg_ctrl, =
       \
> +                                   _mshift, _mwidth, _fc, _gate_mask,  \
> +                                   _val_enable, _val_disable, _flags)  \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .gate   =3D CCU_GATE_INIT(_gate_mask, _val_enable,               =
 \
> +                               _val_disable, 0),                       \
> +       .div    =3D CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),             =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_type =3D CLK_DIV_TYPE_1REG_FC_V2,                   =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .fc             =3D _fc,                                 =
 \
> +               .name           =3D _name,                               =
 \
> +               .num_parents    =3D 1,                                   =
 \
> +               .hw.init        =3D CCU_MIXINITHW(_name, _parent,        =
 \
> +                                               _flags),                \
> +       },                                                              \
> +}
> +
> +#define CCU_DIV_FC_MUX_DEFINE(_struct, _name, _parents, _reg_ctrl,     \
> +                             _mshift, _mwidth, _fc, _muxshift,         \
> +                             _muxwidth, _flags)                        \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .div    =3D CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),             =
 \
> +       .mux    =3D CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),         =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_type       =3D CLK_DIV_TYPE_1REG_FC_V2,             =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .fc             =3D _fc,                                 =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags),              \
> +       },                                                              \
> +}
> +
> +#define CCU_MUX_FC_DEFINE(_struct, _name, _parents, _reg_ctrl, _fc,    \
> +                         _muxshift, _muxwidth, _flags)                 \
> +struct ccu_mix _struct =3D {                                            =
 \
> +       .mux    =3D CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),         =
 \
> +       .common =3D {                                                    =
 \
> +               .reg_type       =3D CLK_DIV_TYPE_1REG_FC_V2,             =
 \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
 \
> +               .fc             =3D _fc,                                 =
 \
> +               .name           =3D _name,                               =
 \
> +               .parent_names   =3D _parents,                            =
 \
> +               .num_parents    =3D ARRAY_SIZE(_parents),                =
 \
> +               .hw.init =3D CCU_MIX_INITHW_PARENTS(_name, _parents,     =
 \
> +                                                 _flags)               \
> +       },                                                              \
> +}
> +
> +static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
> +{
> +       struct ccu_common *common =3D hw_to_ccu_common(hw);
> +
> +       return container_of(common, struct ccu_mix, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_mix_ops;
> +
> +#endif /* _CCU_DIV_H_ */
> diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pl=
l.c
> new file mode 100644
> index 000000000000..1f0ece6abcac
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_pll.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type pll
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_pll.h"
> +
> +#define PLL_MIN_FREQ   600000000
> +#define PLL_MAX_FREQ   3400000000
> +#define PLL_DELAY_TIME 3000
> +
> +#define pll_read_swcr1(c, v)   ccu_read(ctrl, c, v)
> +#define pll_read_swcr2(c, v)   ccu_read(sel, c, v)
> +#define pll_read_swcr3(c, v)   ccu_read(xtc, c, v)
> +
> +#define pll_update_swcr1(c, m, v)      ccu_update(ctrl, c, m, v)
> +#define pll_update_swcr2(c, m, v)      ccu_update(sel, c, m, v)
> +#define pll_update_swcr3(c, m, v)      ccu_update(xtc, c, m, v)

Please stop wrapping regmap APIs. Just use them directly.

> +
> +#define PLL_SWCR1_REG5_OFF     0
> +#define PLL_SWCR1_REG5_MASK    GENMASK(7, 0)
> +#define PLL_SWCR1_REG6_OFF     8
> +#define PLL_SWCR1_REG6_MASK    GENMASK(15, 8)
> +#define PLL_SWCR1_REG7_OFF     16
> +#define PLL_SWCR1_REG7_MASK    GENMASK(23, 16)
> +#define PLL_SWCR1_REG8_OFF     24
> +#define PLL_SWCR1_REG8_MASK    GENMASK(31, 24)
> +
> +#define PLL_SWCR2_DIVn_EN(n)   BIT(n + 1)
> +#define PLL_SWCR2_ATEST_EN     BIT(12)
> +#define PLL_SWCR2_CKTEST_EN    BIT(13)
> +#define PLL_SWCR2_DTEST_EN     BIT(14)
> +
> +#define PLL_SWCR3_DIV_FRC_OFF  0
> +#define PLL_SWCR3_DIV_FRC_MASK GENMASK(23, 0)
> +#define PLL_SWCR3_DIV_INT_OFF  24
> +#define PLL_SWCR3_DIV_INT_MASK GENMASK(30, 24)
> +#define PLL_SWCR3_EN           BIT(31)
> +
> +static int ccu_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct ccu_pll *p =3D hw_to_ccu_pll(hw);
> +       u32 tmp;
> +
> +       pll_read_swcr3(&p->common, &tmp);
> +
> +       return tmp & PLL_SWCR3_EN;
> +}
> +
> +/* frequency unit Mhz, return pll vco freq */
> +static unsigned long __get_vco_freq(struct clk_hw *hw)
> +{
> +       unsigned int reg5, reg6, reg7, reg8, size, i;
> +       unsigned int div_int, div_frc;
> +       struct ccu_pll_rate_tbl *freq_pll_regs_table;
> +       struct ccu_pll *p =3D hw_to_ccu_pll(hw);
> +       struct ccu_common *common =3D &p->common;
> +       u32 tmp;
> +
> +       pll_read_swcr1(common, &tmp);
> +       reg5 =3D (tmp & PLL_SWCR1_REG5_MASK) >> PLL_SWCR1_REG5_OFF;
> +       reg6 =3D (tmp & PLL_SWCR1_REG6_MASK) >> PLL_SWCR1_REG6_OFF;
> +       reg7 =3D (tmp & PLL_SWCR1_REG7_MASK) >> PLL_SWCR1_REG7_OFF;
> +       reg8 =3D (tmp & PLL_SWCR1_REG8_MASK) >> PLL_SWCR1_REG8_OFF;
> +
> +       pll_read_swcr3(common, &tmp);
> +       div_int =3D (tmp & PLL_SWCR3_DIV_INT_MASK) >> PLL_SWCR3_DIV_INT_O=
FF;
> +       div_frc =3D (tmp & PLL_SWCR3_DIV_FRC_MASK) >> PLL_SWCR3_DIV_FRC_O=
FF;
> +
> +       freq_pll_regs_table =3D p->pll.rate_tbl;
> +       size =3D p->pll.tbl_size;
> +
> +       for (i =3D 0; i < size; i++)
> +               if ((freq_pll_regs_table[i].reg5 =3D=3D reg5) &&
> +                   (freq_pll_regs_table[i].reg6 =3D=3D reg6) &&
> +                   (freq_pll_regs_table[i].reg7 =3D=3D reg7) &&
> +                   (freq_pll_regs_table[i].reg8 =3D=3D reg8) &&
> +                   (freq_pll_regs_table[i].div_int =3D=3D div_int) &&
> +                   (freq_pll_regs_table[i].div_frac =3D=3D div_frc))
> +                       return freq_pll_regs_table[i].rate;
> +
> +       WARN_ON_ONCE(1);
> +
> +       return 0;
> +}
> +
> +static int ccu_pll_enable(struct clk_hw *hw)
> +{
> +       struct ccu_pll *p =3D hw_to_ccu_pll(hw);
> +       struct ccu_common *common =3D &p->common;
> +       unsigned long flags;
> +       unsigned int tmp;
> +       int ret;
> +
> +       if (ccu_pll_is_enabled(hw))
> +               return 0;
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       pll_update_swcr3(common, PLL_SWCR3_EN, PLL_SWCR3_EN);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       /* check lock status */
> +       ret =3D regmap_read_poll_timeout_atomic(common->lock_base,
> +                                             p->pll.reg_lock,
> +                                             tmp,
> +                                             tmp & p->pll.lock_enable_bi=
t,
> +                                             5, PLL_DELAY_TIME);
> +
> +       return ret;
> +}
> +
> +static void ccu_pll_disable(struct clk_hw *hw)
> +{
> +       struct ccu_pll *p =3D hw_to_ccu_pll(hw);
> +       struct ccu_common *common =3D &p->common;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(p->common.lock, flags);
> +
> +       pll_update_swcr3(common, PLL_SWCR3_EN, 0);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +}
> +
> +/*
> + * pll rate change requires sequence:
> + * clock off -> change rate setting -> clock on
> + * This function doesn't really change rate, but cache the config
> + */
> +static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       struct ccu_pll *p =3D hw_to_ccu_pll(hw);
> +       struct ccu_common *common =3D &p->common;
> +       struct ccu_pll_config *params =3D &p->pll;
> +       struct ccu_pll_rate_tbl *entry;
> +       unsigned long old_rate;
> +       unsigned long flags;
> +       bool found =3D false;
> +       u32 mask, val;
> +       int i;
> +
> +       if (ccu_pll_is_enabled(hw)) {
> +               pr_err("%s %s is enabled, ignore the setrate!\n",
> +                      __func__, __clk_get_name(hw->clk));
> +               return 0;
> +       }
> +
> +       old_rate =3D __get_vco_freq(hw);
> +
> +       for (i =3D 0; i < params->tbl_size; i++) {
> +               if (rate =3D=3D params->rate_tbl[i].rate) {
> +                       found =3D true;
> +                       entry =3D &params->rate_tbl[i];
> +                       break;
> +               }
> +       }
> +       WARN_ON_ONCE(!found);
> +
> +       spin_lock_irqsave(common->lock, flags);
> +
> +       mask =3D PLL_SWCR1_REG5_MASK | PLL_SWCR1_REG6_MASK;
> +       mask |=3D PLL_SWCR1_REG7_MASK | PLL_SWCR1_REG8_MASK;
> +       val |=3D entry->reg5 << PLL_SWCR1_REG5_OFF;
> +       val |=3D entry->reg6 << PLL_SWCR1_REG6_OFF;
> +       val |=3D entry->reg7 << PLL_SWCR1_REG7_OFF;
> +       val |=3D entry->reg8 << PLL_SWCR1_REG8_OFF;
> +       pll_update_swcr1(common, mask, val);
> +
> +       mask =3D PLL_SWCR3_DIV_INT_MASK | PLL_SWCR3_DIV_FRC_MASK;
> +       val =3D entry->div_int << PLL_SWCR3_DIV_INT_OFF;
> +       val |=3D entry->div_frac << PLL_SWCR3_DIV_FRC_OFF;
> +       pll_update_swcr3(common, mask, val);
> +
> +       spin_unlock_irqrestore(common->lock, flags);
> +
> +       return 0;
> +}
> +
> +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> +                                        unsigned long parent_rate)
> +{
> +       return __get_vco_freq(hw);
> +}
> +
> +static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long *prate)
> +{
> +       struct ccu_pll *p =3D hw_to_ccu_pll(hw);
> +       struct ccu_pll_config *params =3D &p->pll;
> +       unsigned long max_rate =3D 0;
> +       unsigned int i;
> +
> +       if (rate > PLL_MAX_FREQ || rate < PLL_MIN_FREQ) {
> +               pr_err("%lu rate out of range!\n", rate);

We should simply clamp the rate here. It doesn't matter what 'rate' is
when this function is called. The callback is supposed to determine what
the clk rate will be if a consumer called clk_set_rate() with 'rate'.
Don't fail that if the rate is requested to be larger than max, just
tell clk_round_rate() that if you ask for something larger you'll get
PLL_MAX_FREQ.

> +               return -EINVAL;
> +       }
> +

