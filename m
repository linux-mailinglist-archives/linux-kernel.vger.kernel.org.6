Return-Path: <linux-kernel+bounces-347059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAE898CD30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0163B1C21608
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986312C474;
	Wed,  2 Oct 2024 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncjxFHpx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E9374CB;
	Wed,  2 Oct 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727850717; cv=none; b=fjpCegV7X7OJXRea+dx+hhhDKU3MiEOcz0N703hsQ6ySjRlFqyEKxhpGlSKX4yRZ8j8pWHakiZx484vO8wEKD5hncJURVfCQXu57Zr0hxm39jSkNvgojJbN4GSbIzURP4g04kzpg7m5q/dQKk7P657xcDXXKnKJhWkGOuf1yBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727850717; c=relaxed/simple;
	bh=9mmW3A2mka4fNt/DPUrZkJU0+CpxJBPkqAKENYhBKAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYbVB0rS6Oa4lTyBGKduLe26HW2fn/4zRU2QvkP35i90ILXR7wkcFvG6cAGVDIs6ac34qNmMAosbN0z4EO/qRtA3ZZvGavR73r9F79TLRNuZXg7xroeOHq3rzR/J5Kyc2gy5LUSnjg5XIZ2TBnaCSbA3vAWP9O/S5WvlIsfOarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncjxFHpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772A8C4CEC5;
	Wed,  2 Oct 2024 06:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727850717;
	bh=9mmW3A2mka4fNt/DPUrZkJU0+CpxJBPkqAKENYhBKAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncjxFHpx/tAa4VQQ8d79hb9t2wUz7dmGIZW2H4jvEE60uM3oQHdkcFfVTe1TXMvJl
	 2Kl8Mah5jmcZB2bgz2anaOGDTzpe5K3iWEWJxWrxwQLaNWJzGjCj8O2di1Bj40TE/p
	 TWzpfvThAKFGjkPLfzEr/om80Q12qI8DFW+cEuyCyH+Uf0biGtDyiGqDNy+T0kZeO5
	 mfB+6Codfjz54tYG7w5wvSl37MdPP9eMgYVmtmIhXR/U870cZN5bNVY228Axq/LhlI
	 XyaZkgyTpSdrruh3Mm5oVYvRzRVYHpA8FLBG/iip20UIX5NLYV362N//KSKc8lpZTn
	 IzUS+iwXIPj4A==
Date: Wed, 2 Oct 2024 08:31:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: reset: Add reset ID definition for
 Rockchip RK3528
Message-ID: <kg7lh6gafeegmljsygukhfjiztx5wbothngtxrcreccao3itpy@f4bxf4w346ky>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001042401.31903-4-ziyao@disroot.org>

On Tue, Oct 01, 2024 at 04:23:56AM +0000, Yao Zi wrote:
> Similar to previous Rockchip generations, reset IDs for RK3528 SoC
> are register offsets.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../dt-bindings/reset/rockchip,rk3528-cru.h   | 292 ++++++++++++++++++
>  1 file changed, 292 insertions(+)
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h
> 
> diff --git a/include/dt-bindings/reset/rockchip,rk3528-cru.h b/include/dt-bindings/reset/rockchip,rk3528-cru.h
> new file mode 100644
> index 000000000000..1f8c0d38bb88
> --- /dev/null
> +++ b/include/dt-bindings/reset/rockchip,rk3528-cru.h
> @@ -0,0 +1,292 @@
> +/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */


Wrong license, run checkpatch.

Also, as Conor noted, this should eb squashed with device binding.

> +/*
> + * Copyright (c) 2022 Rockchip Electronics Co. Ltd.
> + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> + * Author: Joseph Chen <chenjh@rock-chips.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> +#define _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
> +
> +// CRU_SOFTRST_CON03 (Offset: 0xA0C)
> +#define SRST_CORE0_PO			0x00000030
> +#define SRST_CORE1_PO			0x00000031
> +#define SRST_CORE2_PO			0x00000032
> +#define SRST_CORE3_PO			0x00000033
> +#define SRST_CORE0			0x00000034
> +#define SRST_CORE1			0x00000035
> +#define SRST_CORE2			0x00000036
> +#define SRST_CORE3			0x00000037
> +#define SRST_NL2			0x00000038
> +#define SRST_CORE_BIU			0x00000039
> +#define SRST_CORE_CRYPTO		0x0000003A
> +
> +// CRU_SOFTRST_CON05 (Offset: 0xA14)
> +#define SRST_P_DBG			0x0000005D
> +#define SRST_POT_DBG			0x0000005E
> +#define SRST_NT_DBG			0x0000005F

What are all these? Registers? Not a binding.

Binding constants are numerical values from 0, incremented by one,
serving as abstraction layer between DTS and driver.

None of these here are bindings.

Best regards,
Krzysztof


