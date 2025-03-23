Return-Path: <linux-kernel+bounces-572726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39084A6CDD2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE550189FD87
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557351FECB2;
	Sun, 23 Mar 2025 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZI19i6Mq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867EF9C1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742701401; cv=none; b=titY/NeqbJ2+Hnv48Qvyys/uZibVc+XJixs7+YHUpzL5Hu7KXIWoCr7QVSxfNvEJS6uQjfOPKpcYXlfgiJ4bsDYWeH8wwJCrvmsYBwo+pVgosyIAOsrMKNvZWiT9pNl900A1hUu3N820NShWvd25GegcsmPrGyGu7kQcIGcgxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742701401; c=relaxed/simple;
	bh=/JTc9led7vSFjAGqJ5rrIvAPjecmnhmJXbwU3vdzP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dNaTHhpoIprdbNbSYYSTd7RNa+D2etHk06A86zsUsAYg8+6+PRckqIcOcKwtMmgcEb/MjMwJbokiOG8jlTieNCS5VfyYkubLsAXiRE7/0J0dmY9oXHb6cNs7X9TI0OuSKi50hZNjyHG2Z32Tp+NIJDh9gOei0aL3YXJHBGUkLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZI19i6Mq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742701399; x=1774237399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/JTc9led7vSFjAGqJ5rrIvAPjecmnhmJXbwU3vdzP+0=;
  b=ZI19i6MqPINgcQ3/qMtGiebsqPLtIVbAIMz9KHeGJQNyTjsVCImIzRro
   fA3cD2sPDWzAvmMYnaOk4Ye23LRW6bgcFhalSKaP/C3NRR4tbDxswzPs7
   FC4s8wNuJ0oiHcFUvpKjOA5KgeIyJtBmc6l4liwe2au4TwZNxTlktii6V
   6Kr7HEUVEjJ0pCOoU4gt1WWMDLsymGQul3hAgJWIdebTSW8VrfQ/YTJEC
   Z11yFlMVHT762TDNgihfH83/MhzydIOh1aEOIApmW6b6gPxHj6b3qfyWk
   BW3ienDkUvU8PlbLLkNSO6APxlG2sir2ZdWibEERDLmViJUlBXD5M0INo
   A==;
X-CSE-ConnectionGUID: 4hQo5+3XSvqIWvndYSeWWQ==
X-CSE-MsgGUID: /gb1+ZdXSjueTWi8779qlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="43164212"
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="43164212"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 20:43:18 -0700
X-CSE-ConnectionGUID: +vlykdxyROS+HK2H/JSEhA==
X-CSE-MsgGUID: PPvsuTzsTsWjt2pRUXtn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,269,1736841600"; 
   d="scan'208";a="123540752"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Mar 2025 20:43:17 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twCF0-0002ZT-2c;
	Sun, 23 Mar 2025 03:43:14 +0000
Date: Sun, 23 Mar 2025 11:42:40 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: ERROR: modpost: "power_supply_get_drvdata"
 [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!
Message-ID: <202503231159.ga9eWMVO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   183601b78a9b1c3da2b59f2bee915f97ba745c0b
commit: c78dd25138d104f94ddeab5248a5efe4504f205e platform/x86: x86-android-tablets: Add Vexia EDU ATLA 10 EC battery driver
date:   3 months ago
config: i386-randconfig-007-20250323 (https://download.01.org/0day-ci/archive/20250323/202503231159.ga9eWMVO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503231159.ga9eWMVO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503231159.ga9eWMVO-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "power_supply_get_drvdata" [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!
>> ERROR: modpost: "power_supply_changed" [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!
>> ERROR: modpost: "devm_power_supply_register" [drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

