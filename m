Return-Path: <linux-kernel+bounces-548895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C84A54A98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DF3A4EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5C1C7017;
	Thu,  6 Mar 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXDjOQrr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3D20B7FC;
	Thu,  6 Mar 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263852; cv=none; b=uhPK5wHHuRcSensXLQxqLJSAD9BQVwUpd7bKvAau0PPuWkzXMu8NH6Zfcu6+/00Ik3g3am2HP8vLmliHyjOPXYofziAdY0/d5pfulQt+BysGTIQH32jb/IjczSj8+wEc9i5BD4shLypXjpXywv71TFvYISUU+vc/T/zCmKotFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263852; c=relaxed/simple;
	bh=qzLIfj24eCaV6FZdSTktCdO7Ubv8artGxsJKxm1jD60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXxqNY/fFvt+uWzUrFQKIJedkAYXElx0AX5WUV93i8F5bQpcO13xzMKxvruMIqZlfQLsg+TLI0kpSt+rGxdkAlBDa/GGRGi2vkGRtoBxkh3bGSYcIuPZC4sMJ/bzZjAs5FpmVQc7IBkH5r4NpkIX1b2MJBA4vJ9vv7NdsON4tQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXDjOQrr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741263851; x=1772799851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzLIfj24eCaV6FZdSTktCdO7Ubv8artGxsJKxm1jD60=;
  b=nXDjOQrr8ffQdfaSbTr64OA0M9DrLpuPR/AOqs6rjHv3eph4yhPjNxX7
   5TmtBbvT5f5lDvCRFls/jdn7s2aHoj/Dj9KnXS1A3OYBaMrwZBkjcbEZi
   o08hNNB+MQu863uB+y4FzuiBlsCebrejyDltVcqea+hJ3MizjFufuOmG/
   qBhGLymD5POVbaC71uBH1qrdn3k8t+ZNQ5fmnmBBZKwh7W2aYMZ2tsyPK
   xAxIVUZYLTxl42SwUGwjA+q8cetKGuIBFTgUKsEjULmi2NakFnaRmz7KW
   sSAlnrLtdx1LFMNtLVLryV0KcV2BMqpMqYSc+m41lqymhqQ0vwdq/Atd7
   w==;
X-CSE-ConnectionGUID: h9Hy6g4ATQiWD8b6vthQUg==
X-CSE-MsgGUID: FIOMyiOmRZqGUYhDA4PE5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42406463"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42406463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 04:24:10 -0800
X-CSE-ConnectionGUID: zrIc1M9QTtCL4OxlUvWRQw==
X-CSE-MsgGUID: THaLNgaaRem9bfibAxoorw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="118739220"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 06 Mar 2025 04:24:07 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqAGi-000N3C-2a;
	Thu, 06 Mar 2025 12:24:04 +0000
Date: Thu, 6 Mar 2025 20:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Akshay Gupta <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@roeck-us.net,
	gregkh@linuxfoundation.org, arnd@arndb.de, shyam-sundar.s-k@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	Akshay Gupta <akshay.gupta@amd.com>
Subject: Re: [PATCH v5 02/11] misc: amd-sbi: Move protocol functionality to
 core file
Message-ID: <202503062020.pOZSz5ye-lkp@intel.com>
References: <20250303105902.215009-3-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303105902.215009-3-akshay.gupta@amd.com>

Hi Akshay,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus groeck-staging/hwmon-next soc/for-next linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akshay-Gupta/hwmon-misc-amd-sbi-Move-core-sbrmi-from-hwmon-to-misc/20250303-190830
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250303105902.215009-3-akshay.gupta%40amd.com
patch subject: [PATCH v5 02/11] misc: amd-sbi: Move protocol functionality to core file
config: i386-randconfig-004-20250306 (https://download.01.org/0day-ci/archive/20250306/202503062020.pOZSz5ye-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503062020.pOZSz5ye-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503062020.pOZSz5ye-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
>> ERROR: modpost: "devm_hwmon_device_register_with_info" [drivers/misc/amd-sbi/sbrmi-i2c.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

