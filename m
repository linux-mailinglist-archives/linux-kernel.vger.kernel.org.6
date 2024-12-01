Return-Path: <linux-kernel+bounces-426729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A09DF70F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4981627BB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406751D8DF9;
	Sun,  1 Dec 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYEqAMSE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF21D86DC;
	Sun,  1 Dec 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733083947; cv=none; b=i5bW5QN8fX513PpCe+95BfUZjLGXh/ZMv1GtqOZMCRIxv+BGzK1YBtmk8jZ+fXCRtOTY2hJ49zEHb0jdZPgufDcCXWlfVa+DvvqU8q9WZNJP5qJLYrJlmj/om6tyQTg8+bfscs19w6nejlyg5xwlV5yEv1EaqPWwbMULq9C+hRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733083947; c=relaxed/simple;
	bh=DO98wTZSoedT3RNKFgu/Mtl3yj+E/QB5/wWgWa2iINQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kb3hrKxGv5gYNh9hIqUZ3Hker7zEa1FqH55tOEi8NcJ2fP/EkZKBzDE+74LgCFE89bwBjHGr0h8SNhUOajAtyZrEOsVzRhVR0n3WvDTwxqdAnbefexDivCFdZLXQ3RcM2n/w4nbYBOk1CMWXKzFUBs+l4WXKJKIJKKjVyMQ+gGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYEqAMSE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733083944; x=1764619944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DO98wTZSoedT3RNKFgu/Mtl3yj+E/QB5/wWgWa2iINQ=;
  b=EYEqAMSEkP1pMf8sw8wq1m17nz7lY0BUDz1ggimytj6LydbBQdy1c3CO
   NSBw4iIozfrpRfI9dJboy1k3eR1ejm4nGI8ZRgaUNStta+iHndCUrRudS
   CS5lS1nXyGiQURTRE6F0JNALLi3eoHrQpsS6t9ch4Q9qpBam9+pO5jmxa
   Eo8FnVDo1oeItht1uKdkJaNsDWk2tOnc4UUHQdHr4lxOytOB8Yh62P9NB
   icZ4hHf2jSgCEdl/HgP8SDxRkfrxAGYXcnfcJE6KckbQ2iMqEAdLWE6KO
   xrKUkj6Bq1i2/OZtMKsQRrBqouFRp+KEXwWsScm8fQNKhghEz8Oz+qiVl
   Q==;
X-CSE-ConnectionGUID: IDffGgZ4S9KkiwLHI7XUAw==
X-CSE-MsgGUID: hfS25cmOQbutnFCtmdpbLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="36109567"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="36109567"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 12:12:23 -0800
X-CSE-ConnectionGUID: De9xxm3zRNC6Wb6b6jmFHQ==
X-CSE-MsgGUID: /pNG//6TRiefYh+podYKyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="116187337"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Dec 2024 12:12:18 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHqIh-0001oz-2W;
	Sun, 01 Dec 2024 20:12:15 +0000
Date: Mon, 2 Dec 2024 04:12:02 +0800
From: kernel test robot <lkp@intel.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 02/18] clk: imx8mp: rename video_pll1 to video_pll
Message-ID: <202412020312.z4UEdjd3-lkp@intel.com>
References: <20241201174639.742000-3-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201174639.742000-3-dario.binacchi@amarulasolutions.com>

Hi Dario,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on shawnguo/for-next clk/clk-next linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dario-Binacchi/clk-imx8mm-rename-video_pll1-to-video_pll/20241202-015316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/20241201174639.742000-3-dario.binacchi%40amarulasolutions.com
patch subject: [PATCH v4 02/18] clk: imx8mp: rename video_pll1 to video_pll
config: arm64-randconfig-002-20241202 (https://download.01.org/0day-ci/archive/20241202/202412020312.z4UEdjd3-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412020312.z4UEdjd3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412020312.z4UEdjd3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8mp.c: In function 'imx8mp_clocks_probe':
>> drivers/clk/imx/clk-imx8mp.c:465:13: error: 'IMX8MP_VIDEO_PLL_BYPASS' undeclared (first use in this function); did you mean 'IMX8MP_VIDEO_PLL1_BYPASS'?
     465 |         hws[IMX8MP_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", anatop_base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
         |             ^~~~~~~~~~~~~~~~~~~~~~~
         |             IMX8MP_VIDEO_PLL1_BYPASS
   drivers/clk/imx/clk-imx8mp.c:465:13: note: each undeclared identifier is reported only once for each function it appears in


vim +465 drivers/clk/imx/clk-imx8mp.c

   407	
   408	static int imx8mp_clocks_probe(struct platform_device *pdev)
   409	{
   410		struct device *dev = &pdev->dev;
   411		struct device_node *np;
   412		void __iomem *anatop_base, *ccm_base;
   413		int err;
   414	
   415		np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
   416		anatop_base = devm_of_iomap(dev, np, 0, NULL);
   417		of_node_put(np);
   418		if (WARN_ON(IS_ERR(anatop_base)))
   419			return PTR_ERR(anatop_base);
   420	
   421		np = dev->of_node;
   422		ccm_base = devm_platform_ioremap_resource(pdev, 0);
   423		if (WARN_ON(IS_ERR(ccm_base)))
   424			return PTR_ERR(ccm_base);
   425	
   426		clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
   427		if (WARN_ON(!clk_hw_data))
   428			return -ENOMEM;
   429	
   430		clk_hw_data->num = IMX8MP_CLK_END;
   431		hws = clk_hw_data->hws;
   432	
   433		hws[IMX8MP_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
   434		hws[IMX8MP_CLK_24M] = imx_get_clk_hw_by_name(np, "osc_24m");
   435		hws[IMX8MP_CLK_32K] = imx_get_clk_hw_by_name(np, "osc_32k");
   436		hws[IMX8MP_CLK_EXT1] = imx_get_clk_hw_by_name(np, "clk_ext1");
   437		hws[IMX8MP_CLK_EXT2] = imx_get_clk_hw_by_name(np, "clk_ext2");
   438		hws[IMX8MP_CLK_EXT3] = imx_get_clk_hw_by_name(np, "clk_ext3");
   439		hws[IMX8MP_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
   440	
   441		hws[IMX8MP_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", anatop_base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   442		hws[IMX8MP_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", anatop_base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   443		hws[IMX8MP_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel", anatop_base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   444		hws[IMX8MP_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", anatop_base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   445		hws[IMX8MP_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", anatop_base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   446		hws[IMX8MP_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", anatop_base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   447		hws[IMX8MP_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", anatop_base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   448		hws[IMX8MP_SYS_PLL1_REF_SEL] = imx_clk_hw_mux("sys_pll1_ref_sel", anatop_base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   449		hws[IMX8MP_SYS_PLL2_REF_SEL] = imx_clk_hw_mux("sys_pll2_ref_sel", anatop_base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   450		hws[IMX8MP_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", anatop_base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
   451	
   452		hws[IMX8MP_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll);
   453		hws[IMX8MP_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll);
   454		hws[IMX8MP_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", anatop_base + 0x28, &imx_1443x_pll);
   455		hws[IMX8MP_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll);
   456		hws[IMX8MP_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", anatop_base + 0x64, &imx_1416x_pll);
   457		hws[IMX8MP_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", anatop_base + 0x74, &imx_1416x_pll);
   458		hws[IMX8MP_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", anatop_base + 0x84, &imx_1416x_pll);
   459		hws[IMX8MP_SYS_PLL1] = imx_clk_hw_pll14xx("sys_pll1", "sys_pll1_ref_sel", anatop_base + 0x94, &imx_1416x_pll);
   460		hws[IMX8MP_SYS_PLL2] = imx_clk_hw_pll14xx("sys_pll2", "sys_pll2_ref_sel", anatop_base + 0x104, &imx_1416x_pll);
   461		hws[IMX8MP_SYS_PLL3] = imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_sel", anatop_base + 0x114, &imx_1416x_pll);
   462	
   463		hws[IMX8MP_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", anatop_base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
   464		hws[IMX8MP_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", anatop_base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
 > 465		hws[IMX8MP_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", anatop_base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
   466		hws[IMX8MP_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", anatop_base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
   467		hws[IMX8MP_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", anatop_base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
   468		hws[IMX8MP_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", anatop_base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
   469		hws[IMX8MP_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", anatop_base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
   470		hws[IMX8MP_SYS_PLL1_BYPASS] = imx_clk_hw_mux_flags("sys_pll1_bypass", anatop_base + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK_SET_RATE_PARENT);
   471		hws[IMX8MP_SYS_PLL2_BYPASS] = imx_clk_hw_mux_flags("sys_pll2_bypass", anatop_base + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT);
   472		hws[IMX8MP_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", anatop_base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
   473	
   474		hws[IMX8MP_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", anatop_base, 13);
   475		hws[IMX8MP_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", anatop_base + 0x14, 13);
   476		hws[IMX8MP_VIDEO_PLL_OUT] = imx_clk_hw_gate("video_pll_out", "video_pll_bypass", anatop_base + 0x28, 13);
   477		hws[IMX8MP_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", anatop_base + 0x50, 13);
   478		hws[IMX8MP_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", anatop_base + 0x64, 11);
   479		hws[IMX8MP_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", anatop_base + 0x74, 11);
   480		hws[IMX8MP_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", anatop_base + 0x84, 11);
   481		hws[IMX8MP_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", anatop_base + 0x114, 11);
   482	
   483		hws[IMX8MP_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1_bypass", anatop_base + 0x94, 11);
   484	
   485		hws[IMX8MP_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
   486		hws[IMX8MP_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
   487		hws[IMX8MP_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
   488		hws[IMX8MP_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
   489		hws[IMX8MP_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
   490		hws[IMX8MP_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
   491		hws[IMX8MP_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
   492		hws[IMX8MP_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
   493		hws[IMX8MP_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
   494	
   495		hws[IMX8MP_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2_bypass", anatop_base + 0x104, 11);
   496	
   497		hws[IMX8MP_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
   498		hws[IMX8MP_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
   499		hws[IMX8MP_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
   500		hws[IMX8MP_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
   501		hws[IMX8MP_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
   502		hws[IMX8MP_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
   503		hws[IMX8MP_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
   504		hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
   505		hws[IMX8MP_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
   506	
   507		hws[IMX8MP_CLK_CLKOUT1_SEL] = imx_clk_hw_mux2("clkout1_sel", anatop_base + 0x128, 4, 4,
   508							      imx8mp_clkout_sels, ARRAY_SIZE(imx8mp_clkout_sels));
   509		hws[IMX8MP_CLK_CLKOUT1_DIV] = imx_clk_hw_divider("clkout1_div", "clkout1_sel", anatop_base + 0x128, 0, 4);
   510		hws[IMX8MP_CLK_CLKOUT1] = imx_clk_hw_gate("clkout1", "clkout1_div", anatop_base + 0x128, 8);
   511		hws[IMX8MP_CLK_CLKOUT2_SEL] = imx_clk_hw_mux2("clkout2_sel", anatop_base + 0x128, 20, 4,
   512							      imx8mp_clkout_sels, ARRAY_SIZE(imx8mp_clkout_sels));
   513		hws[IMX8MP_CLK_CLKOUT2_DIV] = imx_clk_hw_divider("clkout2_div", "clkout2_sel", anatop_base + 0x128, 16, 4);
   514		hws[IMX8MP_CLK_CLKOUT2] = imx_clk_hw_gate("clkout2", "clkout2_div", anatop_base + 0x128, 24);
   515	
   516		hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
   517		hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
   518		hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
   519		hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
   520		hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
   521		hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
   522		hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
   523		hws[IMX8MP_CLK_GPU2D_CORE] = imx8m_clk_hw_composite("gpu2d_core", imx8mp_gpu2d_sels, ccm_base + 0x8280);
   524		hws[IMX8MP_CLK_AUDIO_AXI] = imx8m_clk_hw_composite("audio_axi", imx8mp_audio_axi_sels, ccm_base + 0x8300);
   525		hws[IMX8MP_CLK_AUDIO_AXI_SRC] = hws[IMX8MP_CLK_AUDIO_AXI];
   526		hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, ccm_base + 0x8380);
   527		hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, ccm_base + 0x8400);
   528	
   529		/* CORE SEL */
   530		hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
   531	
   532		hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
   533		hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
   534		hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
   535		hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
   536		hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
   537		hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
   538		hws[IMX8MP_CLK_HDMI_APB] = imx8m_clk_hw_composite_bus("hdmi_apb", imx8mp_media_apb_sels, ccm_base + 0x8b00);
   539		hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite_bus("hdmi_axi", imx8mp_media_axi_sels, ccm_base + 0x8b80);
   540		hws[IMX8MP_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mp_gpu_axi_sels, ccm_base + 0x8c00);
   541		hws[IMX8MP_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mp_gpu_ahb_sels, ccm_base + 0x8c80);
   542		hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mp_noc_sels, ccm_base + 0x8d00);
   543		hws[IMX8MP_CLK_NOC_IO] = imx8m_clk_hw_composite_bus_critical("noc_io", imx8mp_noc_io_sels, ccm_base + 0x8d80);
   544		hws[IMX8MP_CLK_ML_AXI] = imx8m_clk_hw_composite_bus("ml_axi", imx8mp_ml_axi_sels, ccm_base + 0x8e00);
   545		hws[IMX8MP_CLK_ML_AHB] = imx8m_clk_hw_composite_bus("ml_ahb", imx8mp_ml_ahb_sels, ccm_base + 0x8e80);
   546	
   547		hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
   548		hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
   549		hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
   550		hws[IMX8MP_CLK_MEDIA_DISP2_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp2_pix", imx8mp_media_disp_pix_sels, ccm_base + 0x9300, CLK_SET_RATE_PARENT);
   551	
   552		hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
   553	
   554		hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
   555		hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
   556		hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
   557		hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
   558		hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
   559		hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
   560		hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
   561		hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
   562		hws[IMX8MP_CLK_I2C6] = imx8m_clk_hw_composite("i2c6", imx8mp_i2c6_sels, ccm_base + 0xa500);
   563		hws[IMX8MP_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mp_sai1_sels, ccm_base + 0xa580);
   564		hws[IMX8MP_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mp_sai2_sels, ccm_base + 0xa600);
   565		hws[IMX8MP_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mp_sai3_sels, ccm_base + 0xa680);
   566		hws[IMX8MP_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mp_sai5_sels, ccm_base + 0xa780);
   567		hws[IMX8MP_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mp_sai6_sels, ccm_base + 0xa800);
   568		hws[IMX8MP_CLK_ENET_QOS] = imx8m_clk_hw_composite("enet_qos", imx8mp_enet_qos_sels, ccm_base + 0xa880);
   569		hws[IMX8MP_CLK_ENET_QOS_TIMER] = imx8m_clk_hw_composite("enet_qos_timer", imx8mp_enet_qos_timer_sels, ccm_base + 0xa900);
   570		hws[IMX8MP_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mp_enet_ref_sels, ccm_base + 0xa980);
   571		hws[IMX8MP_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mp_enet_timer_sels, ccm_base + 0xaa00);
   572		hws[IMX8MP_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy_ref", imx8mp_enet_phy_ref_sels, ccm_base + 0xaa80);
   573		hws[IMX8MP_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mp_nand_sels, ccm_base + 0xab00);
   574		hws[IMX8MP_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mp_qspi_sels, ccm_base + 0xab80);
   575		hws[IMX8MP_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mp_usdhc1_sels, ccm_base + 0xac00);
   576		hws[IMX8MP_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mp_usdhc2_sels, ccm_base + 0xac80);
   577		hws[IMX8MP_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mp_i2c1_sels, ccm_base + 0xad00);
   578		hws[IMX8MP_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mp_i2c2_sels, ccm_base + 0xad80);
   579		hws[IMX8MP_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mp_i2c3_sels, ccm_base + 0xae00);
   580		hws[IMX8MP_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mp_i2c4_sels, ccm_base + 0xae80);
   581	
   582		hws[IMX8MP_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mp_uart1_sels, ccm_base + 0xaf00);
   583		hws[IMX8MP_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mp_uart2_sels, ccm_base + 0xaf80);
   584		hws[IMX8MP_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mp_uart3_sels, ccm_base + 0xb000);
   585		hws[IMX8MP_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mp_uart4_sels, ccm_base + 0xb080);
   586		hws[IMX8MP_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mp_usb_core_ref_sels, ccm_base + 0xb100);
   587		hws[IMX8MP_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mp_usb_phy_ref_sels, ccm_base + 0xb180);
   588		hws[IMX8MP_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mp_gic_sels, ccm_base + 0xb200);
   589		hws[IMX8MP_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mp_ecspi1_sels, ccm_base + 0xb280);
   590		hws[IMX8MP_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mp_ecspi2_sels, ccm_base + 0xb300);
   591		hws[IMX8MP_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mp_pwm1_sels, ccm_base + 0xb380);
   592		hws[IMX8MP_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mp_pwm2_sels, ccm_base + 0xb400);
   593		hws[IMX8MP_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mp_pwm3_sels, ccm_base + 0xb480);
   594		hws[IMX8MP_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mp_pwm4_sels, ccm_base + 0xb500);
   595	
   596		hws[IMX8MP_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mp_gpt1_sels, ccm_base + 0xb580);
   597		hws[IMX8MP_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mp_gpt2_sels, ccm_base + 0xb600);
   598		hws[IMX8MP_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mp_gpt3_sels, ccm_base + 0xb680);
   599		hws[IMX8MP_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mp_gpt4_sels, ccm_base + 0xb700);
   600		hws[IMX8MP_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mp_gpt5_sels, ccm_base + 0xb780);
   601		hws[IMX8MP_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mp_gpt6_sels, ccm_base + 0xb800);
   602		hws[IMX8MP_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mp_wdog_sels, ccm_base + 0xb900);
   603		hws[IMX8MP_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mp_wrclk_sels, ccm_base + 0xb980);
   604		hws[IMX8MP_CLK_IPP_DO_CLKO1] = imx8m_clk_hw_composite("ipp_do_clko1", imx8mp_ipp_do_clko1_sels, ccm_base + 0xba00);
   605		hws[IMX8MP_CLK_IPP_DO_CLKO2] = imx8m_clk_hw_composite("ipp_do_clko2", imx8mp_ipp_do_clko2_sels, ccm_base + 0xba80);
   606		hws[IMX8MP_CLK_HDMI_FDCC_TST] = imx8m_clk_hw_composite("hdmi_fdcc_tst", imx8mp_hdmi_fdcc_tst_sels, ccm_base + 0xbb00);
   607		hws[IMX8MP_CLK_HDMI_24M] = imx8m_clk_hw_composite("hdmi_24m", imx8mp_hdmi_24m_sels, ccm_base + 0xbb80);
   608		hws[IMX8MP_CLK_HDMI_REF_266M] = imx8m_clk_hw_composite("hdmi_ref_266m", imx8mp_hdmi_ref_266m_sels, ccm_base + 0xbc00);
   609		hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, ccm_base + 0xbc80);
   610		hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, ccm_base + 0xbd00);
   611		hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, ccm_base + 0xbd80);
   612		hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite_bus_flags("media_disp1_pix", imx8mp_media_disp_pix_sels, ccm_base + 0xbe00, CLK_SET_RATE_PARENT);
   613		hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
   614		hws[IMX8MP_CLK_MEDIA_LDB] = imx8m_clk_hw_composite("media_ldb", imx8mp_media_ldb_sels, ccm_base + 0xbf00);
   615		hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite_critical("mem_repair", imx8mp_memrepair_sels, ccm_base + 0xbf80);
   616		hws[IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE] = imx8m_clk_hw_composite("media_mipi_test_byte", imx8mp_media_mipi_test_byte_sels, ccm_base + 0xc100);
   617		hws[IMX8MP_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mp_ecspi3_sels, ccm_base + 0xc180);
   618		hws[IMX8MP_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mp_pdm_sels, ccm_base + 0xc200);
   619		hws[IMX8MP_CLK_VPU_VC8000E] = imx8m_clk_hw_composite("vpu_vc8000e", imx8mp_vpu_vc8000e_sels, ccm_base + 0xc280);
   620		hws[IMX8MP_CLK_SAI7] = imx8m_clk_hw_composite("sai7", imx8mp_sai7_sels, ccm_base + 0xc300);
   621	
   622		hws[IMX8MP_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
   623		hws[IMX8MP_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", ccm_base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL);
   624	
   625		hws[IMX8MP_CLK_DRAM1_ROOT] = imx_clk_hw_gate4_flags("dram1_root_clk", "dram_core_clk", ccm_base + 0x4050, 0, CLK_IS_CRITICAL);
   626		hws[IMX8MP_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", ccm_base + 0x4070, 0);
   627		hws[IMX8MP_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", ccm_base + 0x4080, 0);
   628		hws[IMX8MP_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", ccm_base + 0x4090, 0);
   629		hws[IMX8MP_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", ccm_base + 0x40a0, 0);
   630		hws[IMX8MP_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", ccm_base + 0x40b0, 0);
   631		hws[IMX8MP_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", ccm_base + 0x40c0, 0);
   632		hws[IMX8MP_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", ccm_base + 0x40d0, 0);
   633		hws[IMX8MP_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", ccm_base + 0x40e0, 0);
   634		hws[IMX8MP_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", ccm_base + 0x40f0, 0);
   635		hws[IMX8MP_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", ccm_base + 0x4100, 0);
   636		hws[IMX8MP_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", ccm_base + 0x4110, 0);
   637		hws[IMX8MP_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", ccm_base + 0x4120, 0);
   638		hws[IMX8MP_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", ccm_base + 0x4130, 0);
   639		hws[IMX8MP_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", ccm_base + 0x4140, 0);
   640		hws[IMX8MP_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", ccm_base + 0x4150, 0);
   641		hws[IMX8MP_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", ccm_base + 0x4170, 0);
   642		hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", ccm_base + 0x4180, 0);
   643		hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", ccm_base + 0x4190, 0);
   644		hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", ccm_base + 0x41a0, 0);
   645		hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", ccm_base + 0x4210, 0);
   646		hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", ccm_base + 0x4220, 0);
   647		hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", ccm_base + 0x4250, 0);
   648		hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", ccm_base + 0x4280, 0);
   649		hws[IMX8MP_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", ccm_base + 0x4290, 0);
   650		hws[IMX8MP_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", ccm_base + 0x42a0, 0);
   651		hws[IMX8MP_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", ccm_base + 0x42b0, 0);
   652		hws[IMX8MP_CLK_QOS_ROOT] = imx_clk_hw_gate4("qos_root_clk", "ipg_root", ccm_base + 0x42c0, 0);
   653		hws[IMX8MP_CLK_QOS_ENET_ROOT] = imx_clk_hw_gate4("qos_enet_root_clk", "ipg_root", ccm_base + 0x42e0, 0);
   654		hws[IMX8MP_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", ccm_base + 0x42f0, 0);
   655		hws[IMX8MP_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", ccm_base + 0x4300, 0, &share_count_nand);
   656		hws[IMX8MP_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", ccm_base + 0x4300, 0, &share_count_nand);
   657		hws[IMX8MP_CLK_I2C5_ROOT] = imx_clk_hw_gate2("i2c5_root_clk", "i2c5", ccm_base + 0x4330, 0);
   658		hws[IMX8MP_CLK_I2C6_ROOT] = imx_clk_hw_gate2("i2c6_root_clk", "i2c6", ccm_base + 0x4340, 0);
   659		hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
   660		hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
   661		hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
   662		hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
   663		hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
   664		hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
   665		hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
   666		hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", ccm_base + 0x4490, 0);
   667		hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
   668		hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", ccm_base + 0x44b0, 0);
   669		hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", ccm_base + 0x44c0, 0);
   670		hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate2_shared2("usb_root_clk", "hsio_axi", ccm_base + 0x44d0, 0, &share_count_usb);
   671		hws[IMX8MP_CLK_USB_SUSP] = imx_clk_hw_gate2_shared2("usb_suspend_clk", "osc_32k", ccm_base + 0x44d0, 0, &share_count_usb);
   672		hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", ccm_base + 0x44f0, 0);
   673		hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", ccm_base + 0x4510, 0);
   674		hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", ccm_base + 0x4520, 0);
   675		hws[IMX8MP_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", ccm_base + 0x4530, 0);
   676		hws[IMX8MP_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", ccm_base + 0x4540, 0);
   677		hws[IMX8MP_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", ccm_base + 0x4550, 0);
   678		hws[IMX8MP_CLK_VPU_G1_ROOT] = imx_clk_hw_gate4("vpu_g1_root_clk", "vpu_g1", ccm_base + 0x4560, 0);
   679		hws[IMX8MP_CLK_GPU_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", ccm_base + 0x4570, 0);
   680		hws[IMX8MP_CLK_VPU_VC8KE_ROOT] = imx_clk_hw_gate4("vpu_vc8ke_root_clk", "vpu_vc8000e", ccm_base + 0x4590, 0);
   681		hws[IMX8MP_CLK_VPU_G2_ROOT] = imx_clk_hw_gate4("vpu_g2_root_clk", "vpu_g2", ccm_base + 0x45a0, 0);
   682		hws[IMX8MP_CLK_NPU_ROOT] = imx_clk_hw_gate4("npu_root_clk", "ml_core", ccm_base + 0x45b0, 0);
   683		hws[IMX8MP_CLK_HSIO_ROOT] = imx_clk_hw_gate4("hsio_root_clk", "ipg_root", ccm_base + 0x45c0, 0);
   684		hws[IMX8MP_CLK_MEDIA_APB_ROOT] = imx_clk_hw_gate2_shared2("media_apb_root_clk", "media_apb", ccm_base + 0x45d0, 0, &share_count_media);
   685		hws[IMX8MP_CLK_MEDIA_AXI_ROOT] = imx_clk_hw_gate2_shared2("media_axi_root_clk", "media_axi", ccm_base + 0x45d0, 0, &share_count_media);
   686		hws[IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam1_pix_root_clk", "media_cam1_pix", ccm_base + 0x45d0, 0, &share_count_media);
   687		hws[IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam2_pix_root_clk", "media_cam2_pix", ccm_base + 0x45d0, 0, &share_count_media);
   688		hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", ccm_base + 0x45d0, 0, &share_count_media);
   689		hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", ccm_base + 0x45d0, 0, &share_count_media);
   690		hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF_ROOT] = imx_clk_hw_gate2_shared2("media_mipi_phy1_ref_root", "media_mipi_phy1_ref", ccm_base + 0x45d0, 0, &share_count_media);
   691		hws[IMX8MP_CLK_MEDIA_LDB_ROOT] = imx_clk_hw_gate2_shared2("media_ldb_root_clk", "media_ldb", ccm_base + 0x45d0, 0, &share_count_media);
   692		hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", ccm_base + 0x45d0, 0, &share_count_media);
   693	
   694		hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", ccm_base + 0x45e0, 0);
   695		hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
   696		hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
   697		hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
   698	
   699		hws[IMX8MP_CLK_AUDIO_AHB_ROOT] = imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", ccm_base + 0x4650, 0, &share_count_audio);
   700		hws[IMX8MP_CLK_AUDIO_AXI_ROOT] = imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", ccm_base + 0x4650, 0, &share_count_audio);
   701		hws[IMX8MP_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root", "sai1", ccm_base + 0x4650, 0, &share_count_audio);
   702		hws[IMX8MP_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root", "sai2", ccm_base + 0x4650, 0, &share_count_audio);
   703		hws[IMX8MP_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root", "sai3", ccm_base + 0x4650, 0, &share_count_audio);
   704		hws[IMX8MP_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root", "sai5", ccm_base + 0x4650, 0, &share_count_audio);
   705		hws[IMX8MP_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root", "sai6", ccm_base + 0x4650, 0, &share_count_audio);
   706		hws[IMX8MP_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root", "sai7", ccm_base + 0x4650, 0, &share_count_audio);
   707		hws[IMX8MP_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root", "pdm", ccm_base + 0x4650, 0, &share_count_audio);
   708	
   709		hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
   710						     hws[IMX8MP_CLK_A53_CORE]->clk,
   711						     hws[IMX8MP_CLK_A53_CORE]->clk,
   712						     hws[IMX8MP_ARM_PLL_OUT]->clk,
   713						     hws[IMX8MP_CLK_A53_DIV]->clk);
   714	
   715		imx_check_clk_hws(hws, IMX8MP_CLK_END);
   716	
   717		err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
   718		if (err < 0) {
   719			dev_err(dev, "failed to register hws for i.MX8MP\n");
   720			imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
   721			return err;
   722		}
   723	
   724		imx_register_uart_clocks();
   725	
   726		return 0;
   727	}
   728	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

