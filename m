Return-Path: <linux-kernel+bounces-558640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255FFA5E8F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ABB18946AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849BE79FE;
	Thu, 13 Mar 2025 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDSvSjIo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF54A2D;
	Thu, 13 Mar 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825171; cv=none; b=rhMQexG5s1JwFsE+Qwu8A1K+4oMUyjGBAQ858HooAEnswrU/tuBPYWd69A1DcF22JgNE4jtMCW5J7EFWjTHdjiv3atQWaG2hSt6AGUZfb9v/ACBx2rQTw3rxpIrlFx2Ofn3xzyM3PNe2LvSpqhqehq9B3KOp3eSJMWYRBSu4srs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825171; c=relaxed/simple;
	bh=OC2kJdO0bX1Vrlgy1KVz18BJpr1zZxwC8vQSJOOX8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSzq1Hlg4H2LiuuQSbhgs/6ajiXVQB8m6J5nfN7nt2Dkt8pnw6SrKjncRh7N+JDBoXPtzHXPH9NE8Dx4Q8u/7kcliRTn7NNvXixuqdx2/7A/3pBFxHV4MWBN9Xkc/S7SbVNDLr7Mh/meHeWwLFT+gUz/NiS+Ze9RdJ6gCg008bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDSvSjIo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741825170; x=1773361170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OC2kJdO0bX1Vrlgy1KVz18BJpr1zZxwC8vQSJOOX8ws=;
  b=aDSvSjIoJXB5I6161vAeXjdHxa/FK9dmvWjFUbps21OvuJF/ik1n2hJk
   x7Ss3tfQFO6UipiaE4NAddaqza1I4tkijHkDJk0D9ijgb1mIhWOcZnQyF
   6CpTFyOxoWHrWBwyvivTBMJWrVG7Aic7IlofkRyeHdkQ+NCfNVvcHUHzU
   di3sJBYa/fnLrsPj5GlMdRZHYv3Oer44NyelJ2p8gAPypjU2mQAG0sL/z
   Bh16yZuK6fS/ES/a8lznWOzU4B2G6OrCJNITQCkDrHxD1zNpfDxvBf5fk
   kjNfCg6CyKO2Ues6jr/U4es+WyUB7HhacNXPnxMZKqDyK9RoUbcySBs4F
   A==;
X-CSE-ConnectionGUID: Hsb3R31kQ+mbhx346WVS3w==
X-CSE-MsgGUID: Me6u2/y6Tm2CWblJW5J6nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42654588"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="42654588"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 17:19:30 -0700
X-CSE-ConnectionGUID: s3sqfxtzSe6SU3Vj1W6z7Q==
X-CSE-MsgGUID: nwNajwp9RgyA/BRF2hWX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="125870236"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 12 Mar 2025 17:19:25 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsWIE-000908-2X;
	Thu, 13 Mar 2025 00:19:22 +0000
Date: Thu, 13 Mar 2025 08:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 3/4] clk: meson: a1: add the audio clock controller
 driver
Message-ID: <202503131003.x6L69hJL-lkp@intel.com>
References: <20250309180940.1322531-4-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309180940.1322531-4-jan.dakinevich@salutedevices.com>

Hi Jan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next krzk/for-next krzk-dt/for-next linus/master v6.14-rc6 next-20250312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Dakinevich/clk-meson-axg-share-the-set-of-audio-helper-macros/20250310-022012
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250309180940.1322531-4-jan.dakinevich%40salutedevices.com
patch subject: [PATCH v6 3/4] clk: meson: a1: add the audio clock controller driver
config: arm64-randconfig-r131-20250312 (https://download.01.org/0day-ci/archive/20250313/202503131003.x6L69hJL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250313/202503131003.x6L69hJL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503131003.x6L69hJL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/meson/a1-audio.c: In function 'a1_audio_clkc_probe':
>> drivers/clk/meson/a1-audio.c:807:18: error: implicit declaration of function '__devm_auxiliary_device_create'; did you mean '__auxiliary_device_add'? [-Wimplicit-function-declaration]
     807 |         auxdev = __devm_auxiliary_device_create(dev, dev->driver->name,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                  __auxiliary_device_add
>> drivers/clk/meson/a1-audio.c:807:16: error: assignment to 'struct auxiliary_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     807 |         auxdev = __devm_auxiliary_device_create(dev, dev->driver->name,
         |                ^


vim +807 drivers/clk/meson/a1-audio.c

   748	
   749	static int a1_audio_clkc_probe(struct platform_device *pdev)
   750	{
   751		struct device *dev = &pdev->dev;
   752		const struct a1_audio_data *data;
   753		struct auxiliary_device *auxdev;
   754		struct regmap *map;
   755		void __iomem *base;
   756		struct clk *clk;
   757		unsigned int i;
   758		int ret;
   759	
   760		data = device_get_match_data(dev);
   761		if (!data)
   762			return -EINVAL;
   763	
   764		clk = devm_clk_get_enabled(dev, "pclk");
   765		if (IS_ERR(clk))
   766			return PTR_ERR(clk);
   767	
   768		base = devm_platform_ioremap_resource(pdev, 0);
   769		if (IS_ERR(base))
   770			return PTR_ERR(base);
   771	
   772		map = devm_regmap_init_mmio(dev, base, &a1_audio_regmap_cfg);
   773		if (IS_ERR(map))
   774			return PTR_ERR(map);
   775	
   776		ret = device_reset(dev);
   777		if (ret)
   778			return ret;
   779	
   780		for (i = 0; i < data->hw_clks.num; i++) {
   781			struct clk_hw *hw = data->hw_clks.hws[i];
   782			struct clk_regmap *clk_regmap = to_clk_regmap(hw);
   783	
   784			if (!hw)
   785				continue;
   786	
   787			clk_regmap->map = map;
   788		}
   789	
   790		for (i = 0; i < data->hw_clks.num; i++) {
   791			struct clk_hw *hw;
   792	
   793			hw = data->hw_clks.hws[i];
   794			if (!hw)
   795				continue;
   796	
   797			ret = devm_clk_hw_register(dev, hw);
   798			if (ret)
   799				return ret;
   800		}
   801	
   802		ret = devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
   803						  (void *)&data->hw_clks);
   804		if (ret)
   805			return ret;
   806	
 > 807		auxdev = __devm_auxiliary_device_create(dev, dev->driver->name,
   808							data->rst_drvname, NULL, 0);
   809		if (!auxdev)
   810			return -ENODEV;
   811	
   812		return 0;
   813	}
   814	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

