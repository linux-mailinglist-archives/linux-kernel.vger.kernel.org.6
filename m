Return-Path: <linux-kernel+bounces-217355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF1790AEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30E72895F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00745198828;
	Mon, 17 Jun 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY4+ffOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87B197A9E;
	Mon, 17 Jun 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629438; cv=none; b=dhf4qEyrZoKFTk9uqM3a/zjefzRMFhmoAL3PsSMfrCH/19pSowMgeTWu+kcD0yN0e5Fo9TjphGJk8hHqVOUg6OD2mNpGDjVVPZAD0p5MCojEtk7TrEQtm4yfE+xKOAcVC0lma8cM41x6ZWg/skZElIguW/Ppe0xYMD0u51P+5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629438; c=relaxed/simple;
	bh=EORJkp/+upucIcV35yM0E99zuj3YYCUH4IYVJVItSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izHKCtShKzzAoq514pO9hJIXlf36SFFSgUlkWiuU/06NL9RNfImOSMiyFz2LePkKDNkdpcftIRMU0aqJHBYVWdish78OUP6IyyvW6jNR8wUr7aJm2QDL14eUS8BJka98jiywhDhVNqcHAQlNAe0vf6a6pwliju0c10LUhyFq0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY4+ffOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DD6C4AF48;
	Mon, 17 Jun 2024 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718629438;
	bh=EORJkp/+upucIcV35yM0E99zuj3YYCUH4IYVJVItSAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pY4+ffOiBZ6YjSdFzRqcd7ZtrV4T0cqz4jDzVshvC+RI5FSmEioLReBkh5ssCWxE5
	 p59aP4C7OXhBosW6Z//aOXGF56fF/rHR8yxFU91W32+ED0AmIIhm9BvlpX373jnxER
	 OLwsafi6NjjDD8MLfJMbeBACrT3KEx6NxAntZD+WPPl1VJ4esDKsSss2azudLk6R6D
	 IjgRCcckPexk641Q+VocpwndKK/KHb2TK1a4FEUW82YTXD5zGJYiUTXvuWE8xW+kLq
	 Qo+Tv3EGF13jMnScABuJ9oJd1HRNaboHRBc39FY2pp/LfDNOz4LlsNGKdhnjWb5B7b
	 T4ytPxer4IyGA==
Date: Mon, 17 Jun 2024 20:49:57 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <ZnAw9QrSD-svYqQ5@xhacker>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>

On Mon, Jun 17, 2024 at 01:20:52AM +0800, Yangyu Chen wrote:
> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> 
> Key features:
> - 4 cores per cluster, 2 clusters on chip
> - UART IP is Intel XScale UART
> 
> Some key considerations:
> - ISA string is inferred from vendor documentation[2]
> - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> - No coherent DMA on this board
>     Inferred by taking vendor ethernet and MMC drivers to the mainline
>     kernel. Without dma-noncoherent in soc node, the driver fails.
> - No cache nodes now
>     The parameters from vendor dts are likely to be wrong. It has 512
>     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
>     When the size of the cache line is 64B, it is a directly mapped
>     cache rather than a set-associative cache, the latter is commonly
>     used. Thus, I didn't use the parameters from vendor dts.
> 
> Currently only support booting into console with only uart, other
> features will be added soon later.

Hi Yangyu,

Per recent practice of cv1800b and th1520 upstream, I think a complete
initial support would include pinctrl, clk and reset, I have received
the complains from the community. So can you please bring the pinctrl
clk  and reset at the same time?

Thanks

> 
> [1] https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet
> [2] https://developer.spacemit.com/#/documentation?token=BWbGwbx7liGW21kq9lucSA6Vnpb
> [3] https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x.dtsi
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 281 +++++++++++++++++++++++++++
>  1 file changed, 281 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/spacemit/k1.dtsi
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> new file mode 100644
> index 000000000000..58f9e143c659
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +/dts-v1/;
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "SpacemiT K1";
> +	compatible = "spacemit,k1";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <10000000>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu_0>;
> +				};
> +				core1 {
> +					cpu = <&cpu_1>;
> +				};
> +				core2 {
> +					cpu = <&cpu_2>;
> +				};
> +				core3 {
> +					cpu = <&cpu_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu_4>;
> +				};
> +				core1 {
> +					cpu = <&cpu_5>;
> +				};
> +				core2 {
> +					cpu = <&cpu_6>;
> +				};
> +				core3 {
> +					cpu = <&cpu_7>;
> +				};
> +			};
> +		};
> +
> +		cpu_0: cpu@0 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_1: cpu@1 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <1>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu1_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_2: cpu@2 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <2>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu2_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_3: cpu@3 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <3>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu3_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_4: cpu@4 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <4>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu4_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_5: cpu@5 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <5>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu5_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_6: cpu@6 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <6>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu6_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +		cpu_7: cpu@7 {
> +			compatible = "spacemit,x60", "riscv";
> +			device_type = "cpu";
> +			reg = <7>;
> +			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
> +					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
> +					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
> +					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
> +					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			riscv,cbop-block-size = <64>;
> +			riscv,cboz-block-size = <64>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu7_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible = "spacemit,k1-plic", "riscv,plic0";
> +			reg = <0x0 0xe0000000 0x0 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 11>, <&cpu4_intc 9>,
> +					      <&cpu5_intc 11>, <&cpu5_intc 9>,
> +					      <&cpu6_intc 11>, <&cpu6_intc 9>,
> +					      <&cpu7_intc 11>, <&cpu7_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			riscv,ndev = <159>;
> +		};
> +
> +		clint: timer@e4000000 {
> +			compatible = "spacemit,k1-clint", "riscv,clint0";
> +			reg = <0x0 0xe4000000 0x0 010000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>,
> +					      <&cpu5_intc 3>, <&cpu5_intc 7>,
> +					      <&cpu6_intc 3>, <&cpu6_intc 7>,
> +					      <&cpu7_intc 3>, <&cpu7_intc 7>;
> +		};
> +
> +		uart0: serial@d4017000 {
> +			compatible = "intel,xscale-uart";
> +			reg = <0x0 0xd4017000 0x0 0x100>;
> +			interrupts = <42>;
> +			clock-frequency = <14000000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +	};
> +};
> -- 
> 2.45.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

