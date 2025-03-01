Return-Path: <linux-kernel+bounces-540112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A0FA4ADBC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D0166728
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771511E835D;
	Sat,  1 Mar 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnepYlJR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0E1E3796;
	Sat,  1 Mar 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859810; cv=none; b=X3lpKzdqo9vgrIhITakEPGo+dlbuXABVffS8voLTQ2fSkaT0FIX2CBzmlhePTkkUJ32LwX6Q0JNVc0NsQAeSX6kg2HikVqMI76DzQTSOJzUJY5B6VaYI8Cj39TZd1Q/TPaJlRgj5kD8voPt8PDWx5u9XQibNhE7MJpWzg0+dhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859810; c=relaxed/simple;
	bh=FBynrjpYhkx1HFfcCPVjap8bi0l955UavvMGpYL9ArM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYb1+g4Z+rqjXVrxLCji1ONwyTRSgHqCmgWdjTz4R37b/JnzHZwEoKBqxt70hW9Tya2a6pxt+yU/7AbUCq9NamKHVbW9ByZRuDPgkquKV5wimCuvd7lo4Z+6Th+Rnj6hfr+1iVOTrWit4eL3nwgbQAQ3U6npz5QzpM2KWcWGr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnepYlJR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740859809; x=1772395809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FBynrjpYhkx1HFfcCPVjap8bi0l955UavvMGpYL9ArM=;
  b=WnepYlJRour3igiD5MgngcJoUABG0ykOEY8upEARjdLHtQ9Crhkg7qwl
   x91i/rl/JgNunkpn+4mj4YOHy7K8TtaJQ3+XBzcVp9xCFH+79BYa05nM8
   cd55mmrT4phnr0JMObqCfydYkjveP8k1rWczc/29Hvhm3TdZniXjZRtgp
   zMqmkwEI7yTjoAUzK5Khd1KyCTIebc7+2/TXsb77/ZlFtknj3JaSNInC+
   BbeY1tY1eqCDYUYUEUvIZ+ic+BsB5vnHbH/bWJ4rjV9sTlJEgex1fhZCO
   YvypL03EXoCSQ967RGp/yIAaobe8v7L7M01VYQcgjPtkZL9MkXYVXJYdG
   w==;
X-CSE-ConnectionGUID: WY50oHcPTnaLOIye7boRAg==
X-CSE-MsgGUID: XGofDEzXSiixmzHisN3r1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41959948"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41959948"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 12:10:08 -0800
X-CSE-ConnectionGUID: gzFfgN1jRIuUQbHQm7LDzA==
X-CSE-MsgGUID: cDEiiL2+Q7q6mvz25U0Awg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="117626677"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Mar 2025 12:10:04 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toT9u-000Gem-1E;
	Sat, 01 Mar 2025 20:10:02 +0000
Date: Sun, 2 Mar 2025 04:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: Su Hui <suhui@nfschina.com>, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Su Hui <suhui@nfschina.com>,
	ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
	michael.j.ruhl@intel.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
Message-ID: <202503020347.z00djbJE-lkp@intel.com>
References: <20250227073205.1248282-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227073205.1248282-1-suhui@nfschina.com>

Hi Su,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Su-Hui/drm-xe-Select-INTEL_VSEC-to-fix-build-dependency/20250227-153437
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20250227073205.1248282-1-suhui%40nfschina.com
patch subject: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
config: x86_64-kismet-CONFIG_INTEL_VSEC-CONFIG_DRM_XE-0-0 (https://download.01.org/0day-ci/archive/20250302/202503020347.z00djbJE-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250302/202503020347.z00djbJE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020347.z00djbJE-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for INTEL_VSEC when selected by DRM_XE
   WARNING: unmet direct dependencies detected for INTEL_VSEC
     Depends on [n]: X86_PLATFORM_DEVICES [=n] && PCI [=y]
     Selected by [y]:
     - DRM_XE [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && MMU [=y] && (m [=m] && MODULES [=y] || KUNIT [=y]=y [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

