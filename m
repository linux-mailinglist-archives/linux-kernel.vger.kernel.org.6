Return-Path: <linux-kernel+bounces-359059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABF9986E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B53286879
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602D1C8FC4;
	Thu, 10 Oct 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GarzqXUR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452001C6F76;
	Thu, 10 Oct 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565145; cv=none; b=YLSiZuiB59i7peutxmH0Pi/90KzzIE2+tZDv8F68kc+2vLb23vqpxsCDazR6hV3EhWyDVcVuXUF8pT2Jv6RvQwKmmhLghQw0p5pMDQRZ8YiQEInFjhZtt0YyIOyod+YP6PIPt6xYRtA34JBO96KbaMBAWfjxp2mN/un1ulukFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565145; c=relaxed/simple;
	bh=qG07lweCtBAKOnQXgCoehTDupnHqaq1M91lS9S6Vfcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K43qxc1zdOElFNsV3tGtAkFNOG17dDCmyp4fq5LIOKEOJVKP6aMTtBy9457reRnpG1NginFy6sQOkp98tU+jmy8Eb0xSQrTypXqqiVVm0rDGhAlD2r9dXPrnlpCmzZYER1xUtRuE8QExrpGqUZKEuk/cd0yiDT4V4G8l8nzTAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GarzqXUR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728565141;
	bh=qG07lweCtBAKOnQXgCoehTDupnHqaq1M91lS9S6Vfcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GarzqXUR4X2v779CIciPxGeAekZ2tMC0aHXtHJiB36ZNuhI5LQeHdeOf65UryhGEf
	 BcY74oj8Xh7BgliJXDWijcsP6rXCglUKTgBSUbnTIoeklyEttma3alaIymDq8PZAyr
	 p188LUr5l88XbJuVafTcdhNGYVpEEx8Am27DSXy5SKHfMaNmKfuX4GZKYFprV81Yut
	 JL3zjHq+BC+BXQPPF9Tt5smmx7U2wbcjlUYn9PXiz8GE6ChUTpaFEXUS9Axu+Hh3xK
	 Wtm6KlkXzJkjueJclJrQUqLzyAY8eY2dUKLt9u3CIUfeDjGRUxqYgqQKx+hRMUAaOg
	 JTxThjytqr6uA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E634717E35F4;
	Thu, 10 Oct 2024 14:59:00 +0200 (CEST)
Message-ID: <d9bd5573-4860-4a59-b03c-2c353a9b556b@collabora.com>
Date: Thu, 10 Oct 2024 14:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] clk: mediatek: Add drivers for MediaTek MT6735
 main clock and reset drivers
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sam Shih <sam.shih@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20241010124529.78460-1-y.oudjana@protonmail.com>
 <20241010124529.78460-3-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241010124529.78460-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/10/24 14:45, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
> clock and reset controllers. These provide the base clocks and resets
> on the platform, enough to bring up all essential blocks including
> PWRAP, MSDC and peripherals (UART, I2C, SPI).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   MAINTAINERS                                  |   4 +
>   drivers/clk/mediatek/Kconfig                 |   9 +
>   drivers/clk/mediatek/Makefile                |   1 +
>   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 138 +++++++
>   drivers/clk/mediatek/clk-mt6735-infracfg.c   | 107 +++++
>   drivers/clk/mediatek/clk-mt6735-pericfg.c    | 124 ++++++
>   drivers/clk/mediatek/clk-mt6735-topckgen.c   | 394 +++++++++++++++++++
>   7 files changed, 777 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c
> 

You're so, so, so, so..... *so close* to get this one upstream.

Read the comments below and *please*, fix it and send a v6 *as soon as you can*,
so that we get a good chance to see this in v6.13 and so that you can move on
with upstreaming the other stuff that you got for this SoC.

..snip...

> diff --git a/drivers/clk/mediatek/clk-mt6735-infracfg.c b/drivers/clk/mediatek/clk-mt6735-infracfg.c
> new file mode 100644
> index 0000000000000..eceb13af3222a
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-infracfg.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-infracfg.h>
> +#include <dt-bindings/reset/mediatek,mt6735-infracfg.h>
> +
> +#define INFRA_RST0			0x30
> +#define INFRA_GLOBALCON_PDN0		0x40
> +#define INFRA_PDN1			0x44
> +#define	INFRA_PDN_STA			0x48

#define<tab>INFRA_PDN_STA .... I know this is a typo, but you'll have to fix it.

Please replace the tabulation with a space, so that this is consistent with all
of the other definitions that you have in here.

> +
> +#define RST_NR_PER_BANK			32
> +

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt6735-pericfg.c b/drivers/clk/mediatek/clk-mt6735-pericfg.c
> new file mode 100644
> index 0000000000000..6f298d5538782
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#include <dt-bindings/clock/mediatek,mt6735-pericfg.h>
> +#include <dt-bindings/reset/mediatek,mt6735-pericfg.h>
> +
> +#define PERI_GLOBALCON_RST0		0x00
> +#define PERI_GLOBALCON_RST1		0x04
> +#define PERI_GLOBALCON_PDN0_SET		0x08
> +#define PERI_GLOBALCON_PDN0_CLR		0x10
> +#define	PERI_GLOBALCON_PDN0_STA		0x18

same here

> +
> +#define RST_NR_PER_BANK			32
After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

