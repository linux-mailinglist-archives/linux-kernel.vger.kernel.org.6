Return-Path: <linux-kernel+bounces-576372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92313A70E65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB113BE5D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B81CA81;
	Wed, 26 Mar 2025 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SI9Cp3CL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9533F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952168; cv=none; b=t1lwhV2f0p/PJQl9FCWhVkqW3FdGNPEJEWKbp6NR1P3JIaJZRK65vESC3PyF8V0m5XRLd7NfjjIdLCSOfm9D9fEhnCcGa9wjb0fnjE7f0qRlANJndi0VQIBpfHD62BiQjs0GgaiWALIvV3YJ7IbhTSs1S7N7XVjHIa1gypZlXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952168; c=relaxed/simple;
	bh=EW2WUYnXzEeFiqZb4aNRiXPv+E5nRHDeYMd6+zBYJ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEUt/ycjRa5uN2oKVw0RxBrc+hUNUQb++i4b4NojeqHSgcsqPXS8lgk7cyxaJ6szt6PhoUMuX7Gz2Z7fq6KnT/RNySUQ4csaeMYNNguE3feh5OemxabKASKKlPaoGYm81DJVpkTwVidi8uOmJ/XxM2NQ5Ans+3yXE+b1nCjPHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SI9Cp3CL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742952167; x=1774488167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EW2WUYnXzEeFiqZb4aNRiXPv+E5nRHDeYMd6+zBYJ/E=;
  b=SI9Cp3CLYDpZsG+MsFbUQl2gprTPFiIcf0ZL6+IqDFg/l02VNQG0wmGf
   WsLrgYt7O/Qy34N8ycpjkdzPMy7vDTO0ty0Wl2uRIWE995nKbPldnIUTJ
   Mw24R59ksDOMfft1tT5NiPWNybFG2ocfSaSwhcIWO8Tosp0rdD5fqrPNv
   amtY+JbeKq3bBdktyF+ovSnQARGhKVAC3LyGmVXQbFe/PWZGibjImPJfP
   xxJRqpZp/jziqUSSAJCS8sZZHBqn2r/SLtyD07gjoXWy9QOW0VIV+4fnm
   i914TW9leb73XnkrzPuvipdwyB8zhR6CqcuIc0vgXa+02m4ltX42HL225
   g==;
X-CSE-ConnectionGUID: vraFFsVnQ0OoCtZKd5qTyQ==
X-CSE-MsgGUID: Iz111/E9QV2cF0f+gkTczg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43951824"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="43951824"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 18:22:47 -0700
X-CSE-ConnectionGUID: 5oOBzU7oSCaHqS8SQxa1SA==
X-CSE-MsgGUID: 5n/uCNutQEePq1cdGOjfgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; 
   d="scan'208";a="125350033"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Mar 2025 18:22:43 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txFTd-0005MR-1a;
	Wed, 26 Mar 2025 01:22:41 +0000
Date: Wed, 26 Mar 2025 09:21:53 +0800
From: kernel test robot <lkp@intel.com>
To: Anusha Srivatsa <asrivats@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Anusha Srivatsa <asrivats@redhat.com>
Subject: Re: [PATCH 2/5] drm/panel: Add refcount support
Message-ID: <202503260820.3wTF0Zap-lkp@intel.com>
References: <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d@redhat.com>

Hi Anusha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c8ba07caaecc622a9922cda49f24790821af8a71]

url:    https://github.com/intel-lab-lkp/linux/commits/Anusha-Srivatsa/drm-panel-Add-new-helpers-for-refcounted-panel-allocatons/20250326-012651
base:   c8ba07caaecc622a9922cda49f24790821af8a71
patch link:    https://lore.kernel.org/r/20250325-b4-panel-refcounting-v1-2-4e2bf5d19c5d%40redhat.com
patch subject: [PATCH 2/5] drm/panel: Add refcount support
config: s390-randconfig-002-20250326 (https://download.01.org/0day-ci/archive/20250326/202503260820.3wTF0Zap-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250326/202503260820.3wTF0Zap-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503260820.3wTF0Zap-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_panel.c:408: warning: expecting prototype for drm_bridge_put_void(). Prototype was for drm_panel_put_void() instead


vim +408 drivers/gpu/drm/drm_panel.c

   398	
   399	/**
   400	 * drm_bridge_put_void - wrapper to drm_bridge_put() taking a void pointer
   401	 *
   402	 * @data: pointer to @struct drm_bridge, cast to a void pointer
   403	 *
   404	 * Wrapper of drm_bridge_put() to be used when a function taking a void
   405	 * pointer is needed, for example as a devm action.
   406	 */
   407	static void drm_panel_put_void(void *data)
 > 408	{
   409		struct drm_panel *panel = (struct drm_panel *)data;
   410	
   411		drm_panel_put(panel);
   412	}
   413	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

