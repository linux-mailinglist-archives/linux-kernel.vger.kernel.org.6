Return-Path: <linux-kernel+bounces-545439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DEA4ED2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8058E16C887
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76925F98D;
	Tue,  4 Mar 2025 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5/erAux"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF125E83F;
	Tue,  4 Mar 2025 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116130; cv=none; b=qPlAkG38PhGXsiEQCxVcpxBXABsJzTzdcqNsyrsktYukNFJj1JTB/hPepbwbk2UMxbVk589rVpcb2Iu6jQop9so3C0IjUzeENMaWHLrGXpk3pPlcYuhFhL79aaQVcE+GnqBK8eF0bgvhHyyGbs2oJ4fEjVyIMr17AyELbP5RXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116130; c=relaxed/simple;
	bh=EWww6dka3LvQi0O5gZUXT8FQu5sFnMWxMNRLzJRcR7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHx3OusMpaMqH/eenLJD/kEPg+J6+kw/0YAdpoIHx2tHXokNOrSPfvDVmY7zf9R+hgw+cYdSTEdtXkhSxKmNMItGqiGQzlaCIniAJVy+SMCaGm/C4RZqQQ0Om4n+j9LlaHCosNcLadn5v7XFzjllju+j3Q/bsQn7aGPyk3Qkb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5/erAux; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741116129; x=1772652129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWww6dka3LvQi0O5gZUXT8FQu5sFnMWxMNRLzJRcR7s=;
  b=i5/erAuxqfi0XYSNUJTSlbC2skYIxP0b3Ebq3RYMsFHUYjIupQluoCpl
   FHHDnohT9Ib7ShuSRKXzwM/tjY5eG+TkcvM/zeOwQaZv8uVto5J9R/x4c
   WedwJsCZ/HDq9EGjhGwmfo1Kyruqv02+BoGzmsqjU9JL4Ba1K24dargqA
   K+w3K5By5iV1SgrHAqhEjKGtRjjPTssOFlXkH9e1uuvjILFT7gE7cM8+L
   CX+NHU9ix4BFoqzg+6GySDELo6BA9Hd3WOErVhG09TPfuKTHQavakdrfb
   5qOlTsLDupZMxi8BCATu7VAzj4m1DhIyJTUfNG33If0X+c2aMtBqMZ5JO
   w==;
X-CSE-ConnectionGUID: sdURlcJNQnCCJd0h1oPNnQ==
X-CSE-MsgGUID: ktcqy3X7T72as3MO/tCZRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67424341"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="67424341"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:22:09 -0800
X-CSE-ConnectionGUID: 9+eGOiPxTIGpbUDmXlX+ig==
X-CSE-MsgGUID: CbAXLgcJTLOqszXti+rVHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118614705"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 04 Mar 2025 11:22:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpXq6-000KBC-1z;
	Tue, 04 Mar 2025 19:22:02 +0000
Date: Wed, 5 Mar 2025 03:21:04 +0800
From: kernel test robot <lkp@intel.com>
To: Su Hui <suhui@nfschina.com>, lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Su Hui <suhui@nfschina.com>, ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com, michael.j.ruhl@intel.com,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
Message-ID: <202503050332.hlxQQDQk-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-xe/drm-xe-next]
[also build test ERROR on linus/master v6.14-rc5 next-20250304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Su-Hui/drm-xe-Select-INTEL_VSEC-to-fix-build-dependency/20250227-153437
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20250227073205.1248282-1-suhui%40nfschina.com
patch subject: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250305/202503050332.hlxQQDQk-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050332.hlxQQDQk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503050332.hlxQQDQk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: intel_vsec_register
   >>> referenced by xe_vsec.c
   >>>               drivers/gpu/drm/xe/xe_vsec.o:(xe_vsec_init) in archive vmlinux.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for INTEL_VSEC
   Depends on [n]: X86_PLATFORM_DEVICES [=n] && PCI [=y]
   Selected by [y]:
   - DRM_XE [=y] && HAS_IOMEM [=y] && DRM [=y] && PCI [=y] && MMU [=y] && (m [=m] && MODULES [=y] || KUNIT [=y]=y [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

