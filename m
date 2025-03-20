Return-Path: <linux-kernel+bounces-569139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB0A69EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC87B463F91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02421DD9D1;
	Thu, 20 Mar 2025 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jct7BLI7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0AA926
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444333; cv=none; b=Hr8S/Ot4vk9QRZO5NmW4iCdLxYqq6t00/mptQza5J/f1taIAL+40j2RLiEgIZCaiADcqf+gKXsJOhtDw+JmjhhGB5f/HtmXiD5s6PQlkVSPuO3gE/I16Qx4uBPzy5rH2CENZd+azNThMAz5JgLHZAN/aegra97JCPpCCQOKks58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444333; c=relaxed/simple;
	bh=bDg/TFsSsAergY8F8yNJGYdHaRnohAoosdRef+WJbFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z+i65GKAFzQGas73YAbvXvgo9l8KvRWTN5LTbCfiIjqiyaiOtbDbnfw5vFGYga3YLkJ+X5eMNInZCucYwPi4uXTaLcShtatS+wOCOsW7nN7xGi0ZKJ3lgmr2YLBXWbJgEc3s9PpjDXNDSWZZzIRD2J8qhFkPvDbAdMtXWLjnrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jct7BLI7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742444332; x=1773980332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bDg/TFsSsAergY8F8yNJGYdHaRnohAoosdRef+WJbFg=;
  b=Jct7BLI71oKQUVtvpvveUmLmwJZ7flOZdWErtGlCHC39BByDX3YfllAl
   l+AZTlBsoFfmUuVG3lMzhfXypgfqgpRmL5F/tTI4SOxXw4ySR8EZdI8Ky
   QtEUJamIoB1/ob0bghDpS8kcx8XrvhPMhIwnqXtrTPpoHA11Fv81cW7Bi
   kitAsVrXWUhg7P0bLhHdhEuOy0iZtxO9f1WTRPrHjLT7GxOm16e4hnALX
   VOpYGosO6MMxrQgF6ZdBBtV/woPUCDFnOn5Fw/vIx7DZ2UJ7Ya3PDdSbH
   s7zF4S9Zg+O9DaqHYFhljzvXYgwQ46wQNUrmrTkMfpkNT3gEYQ0FT9rdG
   Q==;
X-CSE-ConnectionGUID: Qs9aBRTERDm+0x3oxSsrQQ==
X-CSE-MsgGUID: r/XWrgC7TKy3tNRaDrDx9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43547934"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="43547934"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 21:18:51 -0700
X-CSE-ConnectionGUID: C9joRENzQP647RLxm5+5jA==
X-CSE-MsgGUID: iSI/6MiYR2mON2nFJzAi2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="160143874"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Mar 2025 21:18:49 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv7MN-0000C9-2Z;
	Thu, 20 Mar 2025 04:18:25 +0000
Date: Thu, 20 Mar 2025 12:16:57 +0800
From: kernel test robot <lkp@intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: include/linux/minmax.h:93:30: warning: large integer implicitly
 truncated to unsigned type
Message-ID: <202503201231.VrUIFcq2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
commit: 99185c10d5d9214d0d0c8b7866660203e344ee3b resource, kunit: add test case for region_intersects()
date:   6 months ago
config: arm-randconfig-r063-20250320 (https://download.01.org/0day-ci/archive/20250320/202503201231.VrUIFcq2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503201231.VrUIFcq2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503201231.VrUIFcq2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/ioport.h:15:0,
                    from kernel/resource.c:15:
   kernel/resource.c: In function 'gfr_start':
>> include/linux/minmax.h:93:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
                                 ^
   include/linux/minmax.h:96:2: note: in expansion of macro '__cmp_once_unique'
     __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
     ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
    #define min_t(type, x, y) __cmp_once(min, type, x, y)
                              ^~~~~~~~~~
   kernel/resource.c:1838:9: note: in expansion of macro 'min_t'
      end = min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
            ^~~~~
   kernel/resource.c: In function 'gfr_continue':
>> include/linux/minmax.h:93:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
                                 ^
   include/linux/minmax.h:96:2: note: in expansion of macro '__cmp_once_unique'
     __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
     ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
    #define min_t(type, x, y) __cmp_once(min, type, x, y)
                              ^~~~~~~~~~
   kernel/resource.c:1855:11: note: in expansion of macro 'min_t'
      addr <= min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
              ^~~~~


vim +93 include/linux/minmax.h

d03eba99f5bf7c David Laight   2023-09-18  91  
017fa3e8918784 Linus Torvalds 2024-07-28  92  #define __cmp_once_unique(op, type, x, y, ux, uy) \
017fa3e8918784 Linus Torvalds 2024-07-28 @93  	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
017fa3e8918784 Linus Torvalds 2024-07-28  94  

:::::: The code at line 93 was first introduced by commit
:::::: 017fa3e89187848fd056af757769c9e66ac3e93d minmax: simplify and clarify min_t()/max_t() implementation

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

