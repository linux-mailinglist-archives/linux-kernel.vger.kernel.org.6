Return-Path: <linux-kernel+bounces-537726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4FA48FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BDB3AE2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38D118FDD2;
	Fri, 28 Feb 2025 03:55:19 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4417BA3;
	Fri, 28 Feb 2025 03:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714919; cv=none; b=oJrlnQdy6UnGz8eZABUVqjfn/qsHDTVT9ksW/MAU+B1PX4WgA8VvXqFtJuw0n84OoXYFaHCkd4bJJfuxSkPLLwMOHGugQvJB+Brakww2hwUgCcrwRd9lEuuuqKep4UmLTVWPW6fA8NOuZnWJCSkuKRCijotXTGxmb2+6EyElZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714919; c=relaxed/simple;
	bh=VGRVXS19emRX6O8GPdk4cMmd7Iwtyznx7nZF9BgfBE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdvDpc6US+Yheg+U2u63VndRYZq6/8ec8sc52XJKW9p8zIlKbvXwqTu71sFPhOIjGQKXWaWMjShJO70U9ifP/5TpvQ/rBxmG43f3zMz6x2L2nHJtpAGJn1WNbBYzY/FhFl7URyVJSK6ngLfxwSB0LfUYAtTZkMRAO7mjrK2r4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.55.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2E481342F9A;
	Fri, 28 Feb 2025 03:55:16 +0000 (UTC)
Date: Fri, 28 Feb 2025 03:55:07 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev
Subject: Re: [PATCH] riscv: dts: sophgo: sg2042: Add spi devices
Message-ID: <20250228035507-GYA52348@gentoo>
References: <20250228-sfg-spi-v1-1-b989aed94911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-sfg-spi-v1-1-b989aed94911@gmail.com>

Hi Zixian:

On 10:47 Fri 28 Feb     , Zixian Zeng wrote:
> Add spi devices for the sg2042 soc.
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 0fca16c469cc95aa897b6b57e0a287a687b4d251..d413daa47cf081f23284851db1eeceb3a157e9c0 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -800,5 +800,35 @@ flash@0 {
>  				compatible = "jedec,spi-nor";
>  			};
>  		};
> +
> +		spi0: spi@7040004000 {
> +			compatible = "snps,dw-apb-ssi";
> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			reg = <0x70 0x40004000 0x00 0x1000>;
for consistency, I'd suggest moving 'reg' info above '#address-cells'

> +			interrupt-parent = <&intc>;
> +			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
> +					<&clkgen GATE_CLK_SYSDMA_AXI>;
> +			clock-frequency = <250000000>;
ditto, move clock above interrupt

> +			resets = <&rstgen RST_SPI0>;
> +			num-cs = <0x02>;
> +			status = "okay";
in dtsi file, please make status disabled by default, then enable it at board file

> +		};
> +
> +		spi1: spi@7040005000 {
> +			compatible = "snps,dw-apb-ssi";
> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			reg = <0x70 0x40005000 0x00 0x1000>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
> +					<&clkgen GATE_CLK_SYSDMA_AXI>;
> +			clock-frequency = <250000000>;
> +			resets = <&rstgen RST_SPI1>;
> +			num-cs = <0x02>;
> +			status = "okay";
> +		};
>  	};
>  };
> 
> ---
> base-commit: 9ef5d3235d41a6f5230d3ddf5eb994483853b3e8
> change-id: 20250228-sfg-spi-e3f2aeca09ab
> 
> Best regards,
> -- 
> Zixian Zeng <sycamoremoon376@gmail.com>
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

