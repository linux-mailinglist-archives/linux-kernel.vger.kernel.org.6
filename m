Return-Path: <linux-kernel+bounces-390377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FF9B7916
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8426C1C22190
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE619AA6B;
	Thu, 31 Oct 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN9F16lU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D310199FCD;
	Thu, 31 Oct 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371998; cv=none; b=tdKgljBZrTtJSHNGlPNdt8zm1YZ38oum5Gxx4IvNwSW6jFfV0lYlqWv+rGsLGJZEnUvY6KQdTQsMv+cdCiYh+aR8EFhSdDkHOl8IbvVue2ClTIdLiFgk+ijMEz24jJKP3o5cgnGxDOdujj24qgwoLWwT/SuT/QNy1kCkA488TnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371998; c=relaxed/simple;
	bh=mAxfxUq37TjY7+usTzDlC//ggB576dB9RkyHZdE9q7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXqbObRsvFSmFLvHnljgc48QcEj9MvsvnDdNTC1SGn/AzrR25WRBzhZheepxMI7XdWysC12oHp5eQuSFtpvrvG5xg9Aoo+tTc+AlPvLFLTi5ZgxZ78EpfhcZbWCpfPouQkwxR+pTwTqiKOLCV66BTz/pRBIYG9ohkAvR/7NGmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN9F16lU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4A4C4CEDA;
	Thu, 31 Oct 2024 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730371997;
	bh=mAxfxUq37TjY7+usTzDlC//ggB576dB9RkyHZdE9q7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gN9F16lUWheK53dPv9wvKhpDs5otDtps9Ff2NQI+ymvptQfA/heA7p0q+3M2MTOZk
	 luUPbNgcL92RwiWUbrP8fwPWnY2+oFDQobZRTsfPL9CJUzrZzk1XXhWEDGYXaXcbcf
	 Iiz3GoPcUOl+vYRbdt4IPRLtLPTTiA7/Zn6t9YN8IFMUgg6NDD2YP9x44giSWgV795
	 VJOaS1+JQLloROviC7NTvZDgEOizaYKJ0QD+NUPffpzaGYReHuOp7NsgNPHCQY4IRl
	 t3+nRP1MdNMsjS0oS3tZkuhnBvxyLP+R3zhlo8ZKu4eaBEoit3dsp2CDB+gj/WRTZU
	 zj9gGzRR2o0kA==
Message-ID: <1d38d2c7-e1e7-4bc2-a760-a1321cbe0e16@kernel.org>
Date: Thu, 31 Oct 2024 12:53:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add dt overlay to disable
 icssg for Linux
To: MD Danish Anwar <danishanwar@ti.com>, vigneshr@ti.com, nm@ti.com
Cc: conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kristo@kernel.org, srk@ti.com
References: <20241030114458.1358800-1-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241030114458.1358800-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Danish,

On 30/10/2024 13:44, MD Danish Anwar wrote:
> Add k3-am642-evm-icssg1-disable.dtso overlay file that disables
> icssg1-eth from Linux so that icssg peripherals can be used by
> RTOS or some other OS running on R5 core.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  7 +--
>  .../dts/ti/k3-am642-evm-icssg1-disable.dtso   | 49 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6bd06bd76b68..0fd95b7df5a8 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-disable.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-pcie0-ep.dtbo
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
> @@ -235,8 +236,8 @@ k3-am62p5-sk-microtips-mf103hie-lcd2-dtbs := k3-am62p5-sk.dtb \
>  	k3-am62p5-sk-microtips-mf103hie-lcd2.dtbo
>  k3-am642-evm-icssg1-dualemac-dtbs := \
>  	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
> -k3-am642-evm-icssg1-dualemac-mii-dtbs := \
> -	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac-mii.dtbo
> +k3-am642-evm-icssg1-disable-dtbs := \
> +	k3-am642-evm.dtb k3-am642-evm-icssg1-disable.dtbo
>  k3-am642-evm-pcie0-ep-dtbs := \
>  	k3-am642-evm.dtb k3-am642-evm-pcie0-ep.dtbo
>  k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
> @@ -323,7 +324,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>  	k3-am62p5-sk-microtips-mf101hie-panel.dtb \
>  	k3-am62p5-sk-microtips-mf103hie-lcd2.dtb \
>  	k3-am642-evm-icssg1-dualemac.dtb \
> -	k3-am642-evm-icssg1-dualemac-mii.dtb \
> +	k3-am642-evm-icssg1-disable.dtb \
>  	k3-am642-evm-pcie0-ep.dtb \
>  	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>  	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso
> new file mode 100644
> index 000000000000..dc04e2999e97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT overlay for enabling 2nd ICSSG1 port on AM642 EVM
> + *
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&oc_sram {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	r5f0_0_sram: r5f0_0_sram@0 {
> +		reg = <0x0 0x180000>;
> +	};
> +};> +
> +&main_r5fss0_core0 {
> +	sram = <&r5f0_0_sram>;
> +};
> +

You need to mention why this change is done, in the commit log.

> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&icssg0 {
> +	status = "disabled";
> +};

dtso name says icssg1-disabel but you are disabling icssg0 as well?

> +
> +&icssg1 {
> +	status = "disabled";
> +};
> +
> +&ospi0 {
> +	status = "disabled";
> +};

and ospi0?

> +
> +&mdio_mux_1 {
> +	status = "disabled";
> +};
> +
> +&icssg1_eth {
> +	status = "disabled";
> +};

Maybe the dtso is poorly named and should be called something else so that is correctly reflects the use case?
I suppose it has something to do with peripherals reserved for R5 core?

e.g.

k3-am642-evm-r5-reserved.dtso?

How is this dtso applied at boot?

-- 
cheers,
-roger

