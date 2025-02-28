Return-Path: <linux-kernel+bounces-538029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8BAA493BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9DE189246F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6132512C1;
	Fri, 28 Feb 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVoZJbzN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C0250C04
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732003; cv=none; b=bh91VW5CnhAH1ko2spChe67hOwPutaCWlbeBNFMDQcuobPX7H/KlqBR8alD5zmUAq3uWd996ttfd3UZ/fK2nrIQNztNkNnG0a4Ms4lz3PvBlgc/ZWVOnAM7kCuil1pqDCfXp4xkfbvoCbqr4ehzSqZvDS41lbHujbQ5fHPo/fxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732003; c=relaxed/simple;
	bh=6nLlEJR+1HRqZHpNFMxHE62+fk85zp8gkyvfjgnlWPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1a7XLyhhT/stz9LnOf74n9eNYtQABeYCvk0untDOsko8Twa812nFKLcFojj8nfv8qQY73dRwBoO9h0Nu/VPgr1jwLbQnVndVC5dmFKfK8HiSlkcFGb4ITpwFw9CJSJR/E+HdYYu9QDpEpW2EygHmmGdz2EOCDhzJpt1qUoe9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVoZJbzN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740732000; x=1772268000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6nLlEJR+1HRqZHpNFMxHE62+fk85zp8gkyvfjgnlWPs=;
  b=lVoZJbzNos8hNXw2nKPuKxV4eiCsFWeYQPMFjBOGSreXKiDu1QEpbm76
   cBRes40xFDt1Xr3u9dwRI4EUmqz8eZA/+UWxVFKhxpRnVN9MyYXwPKkzR
   vGQM/7H5OxfZvK9FV6baWfC05PENUT2L3qU6k9CNTpOMH/IO6Y9BrHMw6
   mebw62djrAADMBz2u5vyONYfWyW+fwXdhXM2Z4ho2ZvdE+odudhRX7JQE
   aPf2LV/qQ2DKFXcLL2eaZh/z4AgN3wtZziJm8XbhVLjEpf717Efs7AxC3
   VjVEOzCupPM7AXa+e/5Ew8xv3AKGJKFb1xmeBq0mEO2IjdrO4dMzPA5cx
   g==;
X-CSE-ConnectionGUID: qgVolWVmQmmxwx6Ip4eHRw==
X-CSE-MsgGUID: iJwmvH/DT4SCj8RhP/He4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41905670"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41905670"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 00:39:59 -0800
X-CSE-ConnectionGUID: Ng7e4B6tRsSRZ7rZzz/aZQ==
X-CSE-MsgGUID: fgjmtdnfSxiJ/VZEuJieeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122510082"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 28 Feb 2025 00:39:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnvu4-000Eck-0q;
	Fri, 28 Feb 2025 08:39:36 +0000
Date: Fri, 28 Feb 2025 16:38:13 +0800
From: kernel test robot <lkp@intel.com>
To: zihan zhou <15645113830zzh@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH V1 2/4] sched: Do predict load
Message-ID: <202502281647.5vhdZuZE-lkp@intel.com>
References: <20250221085051.32468-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221085051.32468-1-15645113830zzh@gmail.com>

Hi zihan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on akpm-mm/mm-nonmm-unstable brauner-vfs/vfs.all peterz-queue/sched/core linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zihan-zhou/sched-Add-kconfig-of-predict-load/20250221-165850
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250221085051.32468-1-15645113830zzh%40gmail.com
patch subject: [PATCH V1 2/4] sched: Do predict load
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250228/202502281647.5vhdZuZE-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502281647.5vhdZuZE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502281647.5vhdZuZE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/fair.c:4755:17: warning: variable 'load' is uninitialized when used here [-Wuninitialized]
    4755 |         load = div_u64(load * weight, PREDICT_LOAD_MAX);
         |                        ^~~~
   kernel/sched/fair.c:4749:20: note: initialize the variable 'load' to silence this warning
    4749 |         unsigned long load;
         |                           ^
         |                            = 0
   1 warning generated.


vim +/load +4755 kernel/sched/fair.c

  4746	
  4747	static unsigned long restore_normalized_load(unsigned long normalized_load, unsigned long weight)
  4748	{
  4749		unsigned long load;
  4750	
  4751		//Prevent arithmetic overflow
  4752		WARN_ON_ONCE(normalized_load > 4000000);
  4753		if (weight == PREDICT_LOAD_MAX)
  4754			return normalized_load;
> 4755		load = div_u64(load * weight, PREDICT_LOAD_MAX);
  4756		return load;
  4757	}
  4758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

