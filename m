Return-Path: <linux-kernel+bounces-216522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675290A084
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD931C20BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4CC6FE07;
	Sun, 16 Jun 2024 22:32:09 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420F9457;
	Sun, 16 Jun 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718577129; cv=none; b=RsSLq+4C8slmYEHWzuWXHNsyCb2GZbp6c4eKNcdGrr8OjJuiq/KYkKsDQowcQLkSOK5A1cHN6LkbJAd5oM65So1LvyzHyY7Dqv96QYmCN9GB87S9rGZOsSaxmHC+gbN1+uy4CVdFTlBSQMOas7a9uEigN5+kDOrCBNBYWzo0isc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718577129; c=relaxed/simple;
	bh=q/pYDRryyAux8mIybOIZ8peVxVmWKVYIzONwSMo9SnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlYoeq98xvvl6TBx/8ztbG+6fhPBp/PRmiy+11TT5cCfLnFfs4IRu0e7EtjG0IoXQgO/bChihlxic7dqN3NzqsTY4iGe8o72unmnsyVZOZTVPOcdYhM1T/2HoU/cyxPQMkH7l8jAihnlEurRjdY8Fx3LScO3rZ7I7zEQPz0ztf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sun, 16 Jun 2024 22:31:49 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 8/9] riscv: dts: spacemit: add Banana Pi BPI-F3 board
 device tree
Message-ID: <20240616223149.GB3983622@ofsar>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_904B1050FBC0B10A172C263924BD518F8F05@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_904B1050FBC0B10A172C263924BD518F8F05@qq.com>

Hi

On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
> Banana Pi BPI-F3 [1] is a industrial grade RISC-V development board, it
> design with SpacemiT K1 8 core RISC-V chip [2].
> 
> Currently only support booting into console with only uart enabled,
> other features will be added soon later.
> 
> [1] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
> [2] https://www.spacemit.com/en/spacemit-key-stone-2/
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/boot/dts/Makefile                 |  1 +
>  arch/riscv/boot/dts/spacemit/Makefile        |  2 ++
>  arch/riscv/boot/dts/spacemit/bananapi-f3.dts | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/spacemit/Makefile
>  create mode 100644 arch/riscv/boot/dts/spacemit/bananapi-f3.dts
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index fdae05bbf556..bff887d38abe 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -5,6 +5,7 @@ subdir-y += microchip
>  subdir-y += renesas
>  subdir-y += sifive
>  subdir-y += sophgo
> +subdir-y += spacemit
>  subdir-y += starfive
>  subdir-y += thead
>  
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> new file mode 100644
> index 000000000000..5c512f4e297d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_SPACEMIT) += bananapi-f3.dtb
Can we have "k1" prefix at least? so k1-bananapi-f3.dtb
it's much clear to let people know the board has k1 SoC,
in case vendor has more chip series..

> diff --git a/arch/riscv/boot/dts/spacemit/bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/bananapi-f3.dts
> new file mode 100644
> index 000000000000..023274189b49
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/bananapi-f3.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k1.dtsi"
> +
> +/ {
> +	model = "Banana Pi BPI-F3";
> +	compatible = "bananapi,bpi-f3", "spacemit,k1";
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> -- 
> 2.45.1
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

