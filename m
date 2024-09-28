Return-Path: <linux-kernel+bounces-342400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFE988E80
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17371C20E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF519EED8;
	Sat, 28 Sep 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL2jg2jy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7271487E2
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727511910; cv=none; b=SgC/yibMAX08e1U1DLs6oaJyKgkVc6knUcoymaqx7oTn7Jyjn9BoaIINulcJemFOi3DOMkb3IdmzNyflku5JcX8iZdi/Il8oJ8syUsdu5ujQk/ns9XM+cOCLXZj/Z3FKVqgs5SVjzeeXkhL9pG6VuRcWoitBgTO+Ok6Myn0uUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727511910; c=relaxed/simple;
	bh=a2LTP0OHS7OT8GJo0mZyCUBskWKgcMbMCiEWDlm4VVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj439nDNuiHXDLEUCpP7ifi7eYHH4RkiX+S7DEVJ/zpt84yOwo2/tZcCSSvYJpMCE8FhTyJi+OODuGwfSm+IvBrNL5L2GD6Lch9r8PitLfIPveu8C4qv4MsGgfre5nqIqXuTI9K7dBBPZ2+iWAK6mlAHvG8PDNBNmiYe0UgKsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL2jg2jy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727511908; x=1759047908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2LTP0OHS7OT8GJo0mZyCUBskWKgcMbMCiEWDlm4VVU=;
  b=mL2jg2jyELw6JcMjL8LqMGk/5cyIc44BjRSFTa6g7cwiW4SKFhWzmC/N
   r8ApoyCBSrXSRKsTaef/av4CRx69YufDn4pbNJ5MxdMHiFynxyWP3Bc8D
   vBQVODGIKY/nwObx6cQ/okigxpR//HVKRhPEcgORoVbQh9qno9w4RJI4i
   A50x0cmvsXIL+FrmqaQpqZSnSHGdkyDcFt6Mbh+2WDZdlXKrx1TRNRelp
   HRrQcGZxsGAun8pysc8c36gUhMe6ESLVicezEE1p2VtR/tZC5E61QywPo
   qnS+C6yUkbQk4bFoSg+3dKchvaSEutGaQypHHsW//pdV9jnshBIQCayc1
   w==;
X-CSE-ConnectionGUID: SPcBMmt2QMSIQRYU9HRXXQ==
X-CSE-MsgGUID: ZzLKD43DQUi1QalmUhTgRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="49180614"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="49180614"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 01:25:07 -0700
X-CSE-ConnectionGUID: RWduUtRiQpSK3JsTflVZ7Q==
X-CSE-MsgGUID: cLQuFNE9RyGahMC47D/2Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="77152201"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Sep 2024 01:25:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suSlC-000N1z-04;
	Sat, 28 Sep 2024 08:25:02 +0000
Date: Sat, 28 Sep 2024 16:24:46 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, kernel@dh-electronics.com,
	Marek Vasut <marex@denx.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Saravana Kannan <saravanak@google.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
Message-ID: <202409281619.4SHXVZe7-lkp@intel.com>
References: <20240925220552.149551-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925220552.149551-1-marex@denx.de>

Hi Marek,

kernel test robot noticed the following build errors:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on soc/for-next linus/master v6.11 next-20240927]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Vasut/soc-imx8m-Probe-the-SoC-driver-as-platform-driver/20240926-060831
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20240925220552.149551-1-marex%40denx.de
patch subject: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240928/202409281619.4SHXVZe7-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240928/202409281619.4SHXVZe7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409281619.4SHXVZe7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/imx/soc-imx8m.c:302:1: error: redefinition of '__inittest'
     302 | device_initcall(imx8_soc_init);
         | ^
   include/linux/module.h:122:30: note: expanded from macro 'device_initcall'
     122 | #define device_initcall(fn)             module_init(fn)
         |                                         ^
   include/linux/module.h:131:42: note: expanded from macro 'module_init'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
   drivers/soc/imx/soc-imx8m.c:292:1: note: previous definition is here
     292 | module_platform_driver(imx8m_soc_driver);
         | ^
   include/linux/platform_device.h:302:2: note: expanded from macro 'module_platform_driver'
     302 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^
>> drivers/soc/imx/soc-imx8m.c:302:1: error: redefinition of 'init_module'
     302 | device_initcall(imx8_soc_init);
         | ^
   include/linux/module.h:122:30: note: expanded from macro 'device_initcall'
     122 | #define device_initcall(fn)             module_init(fn)
         |                                         ^
   include/linux/module.h:133:6: note: expanded from macro 'module_init'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^
   drivers/soc/imx/soc-imx8m.c:292:1: note: previous definition is here
     292 | module_platform_driver(imx8m_soc_driver);
         | ^
   include/linux/platform_device.h:302:2: note: expanded from macro 'module_platform_driver'
     302 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^
   include/linux/device/driver.h:261:3: note: expanded from macro 'module_driver'
     261 | } \
         |   ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^
   2 errors generated.


vim +/__inittest +302 drivers/soc/imx/soc-imx8m.c

d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  293  
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  294  static int __init imx8_soc_init(void)
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  295  {
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  296  	struct platform_device *pdev;
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  297  
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  298  	pdev = platform_device_register_simple("imx8m-soc", -1, NULL, 0);
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  299  
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  300  	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
d817f7a9bde892 drivers/soc/imx/soc-imx8m.c Marek Vasut 2024-09-26  301  }
a7e26f356ca129 drivers/soc/imx/soc-imx8.c  Abel Vesa   2019-03-22 @302  device_initcall(imx8_soc_init);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

