Return-Path: <linux-kernel+bounces-300021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81E695DDA0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBCE1C210B4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591216F851;
	Sat, 24 Aug 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZfbQTpZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382C1547E0;
	Sat, 24 Aug 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724500267; cv=none; b=HbubV9fohn68IUK9AcJm2W76/rZh1PD1ZYhdW26xjjybjl8NWnK0En+H15FymEPvmsAZzgcWrDmvzFr4czIvn9gviZy2S7khIC0rIbo+5+NK0ISu7gg3MV2QModU9/jrhLeUKSVRl7iVwJ2dnSTzvOf7seo2EO7RjzL/DIM2ARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724500267; c=relaxed/simple;
	bh=QtegKuqwk2ZN4NhU1wLwiLOFbVJB01mSXsgiQh9yitE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imsbg//9xP7PgL3Pt7iqarf2qbFzuAtSJ2Ci05kpQ+U3YJe7cGywRWFJpegqh0QgZQ8Vg+KuS5WSgGYgqc6Pa+eU0YHWH6FthoD+Sser5rNT4UFawku88PG1ZgBvuEf1TnIh9aNfozRjQeW7a/FU6Etw1mMuKK0kchYyorjV0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZfbQTpZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724500265; x=1756036265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QtegKuqwk2ZN4NhU1wLwiLOFbVJB01mSXsgiQh9yitE=;
  b=nZfbQTpZoMbbIJE4XvPcQWh68RBO9Yyrs/EJBj2Zj6RmUqyiN37HG3bT
   346zinWHRrDMzrW4URbc5umwfZTj13UT6WGOFkl0l0OMlI6/TiymKv1oG
   BFlOjZaBZ5xl7d6OoLxh+FqPIMZmNr6rtR7l2moKHzdEuUa2zoUFpVTE9
   MK0UJNzuZIEI5Oi9z5b+p+VTmTJLdNWWeLOz9J914vjeFVblQUc8WCMOl
   Pp+UyWZc3wUaP5HTRa/S3dT6CY2ikZKJYVVygV8SWsYgZ1m4yRFUJNDtz
   b/UHtYpPGmwhw6tSPqpeL2+uPkh2jfMs6RcpSRDYAnGhuY2rIHucJYl2F
   w==;
X-CSE-ConnectionGUID: wyJGsP9ARFqPvWIuhCJ99g==
X-CSE-MsgGUID: vSNkqHQ4ToG5u24qtTOW3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="40485498"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="40485498"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 04:51:04 -0700
X-CSE-ConnectionGUID: vfRTiSKURtGdeRsPsygYoQ==
X-CSE-MsgGUID: ERVOj0QSSq+jjutuQj0OBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="62589081"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Aug 2024 04:51:02 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shpIJ-000ES7-2F;
	Sat, 24 Aug 2024 11:50:59 +0000
Date: Sat, 24 Aug 2024 19:50:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <mgross@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Borislav Petkov <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-geode@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
Message-ID: <202408241957.UNeWRRij-lkp@intel.com>
References: <ZsV6MNS_tUPPSffJ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsV6MNS_tUPPSffJ@google.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on linus/master v6.11-rc4 next-20240823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Torokhov/x86-platform-geode-switch-GPIO-buttons-and-LEDs-to-software-properties/20240821-132705
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/ZsV6MNS_tUPPSffJ%40google.com
patch subject: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to software properties
config: i386-randconfig-062-20240824 (https://download.01.org/0day-ci/archive/20240824/202408241957.UNeWRRij-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240824/202408241957.UNeWRRij-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408241957.UNeWRRij-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/platform/geode/geode-common.c:17:28: sparse: sparse: symbol 'geode_gpiochip_node' was not declared. Should it be static?

vim +/geode_gpiochip_node +17 arch/x86/platform/geode/geode-common.c

    16	
  > 17	const struct software_node geode_gpiochip_node = {
    18		.name = "cs5535-gpio",
    19	};
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

