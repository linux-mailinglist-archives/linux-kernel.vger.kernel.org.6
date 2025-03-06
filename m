Return-Path: <linux-kernel+bounces-548203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875DA54194
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B611E7A2D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8834019C540;
	Thu,  6 Mar 2025 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vtkft/1i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB99199238;
	Thu,  6 Mar 2025 04:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234482; cv=none; b=dnhQ79Db5iBfWUU6RXVHXCSSLtSkwQPJcXLwVJfB8OsRSkq8Ir+Hw3DK+qKSi/Qh4JGRjNPPdpeN/cbZzrLiApM35BOmdi7aP0kQDzwxoSmuouItJO6l6Lm0b/jVUSDV3S5aTIuCLQdmS+lIXBgegdwRgylrh0XxAf18c4X188Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234482; c=relaxed/simple;
	bh=b+WNPGk7J2lWZFdjFdJZsxd9df8Adu9P/W/MVBcgvKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm8xEz+yR3CUcDyDUN0lVdDIkMrkSWBAxi+R0D3vKdGvmKIfidpKHmzuRfSFkRTs5ZUseQ0p+zmqqKNE37rYKtXXqRJoQcu8Fe7/9ZCzeBUiHfFzLRR/Jw+LU+PFr3j8vJPdzT8yq76hSj0XENLGp2I5qXUQd7Qzqrlod6adiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vtkft/1i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741234479; x=1772770479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+WNPGk7J2lWZFdjFdJZsxd9df8Adu9P/W/MVBcgvKU=;
  b=Vtkft/1ilessF0qy6oE1D9Koc7pZ9AsHIEkXYK4D0JxYRbQKIYnLd4Ic
   cRRIYCSbevyh1jSfsGhbKmkkAsGScDFJt84StDhTaBfas31XnGBOI4aBI
   y2tjuV8qlCyYEcHswVjV9EB/9kLHzS7gGzsqihKAFUDXReD+eQZjJyUA2
   J7+VNAJEVrs38Ii1kGLogZyib5kuuOwaMQMhZCrmO6RdW7UbmQ0GxxoU4
   VAfF98lOQVGxw0Wr7T7PROEhTEGKv/HZe1EYu9nAjcQrG4jamRiIt1THy
   OZj9syLr6bL5qCXtFzsoDN82V5Y9qXpwawgas1p/HeNYo2arTbWhvuFLa
   A==;
X-CSE-ConnectionGUID: jk1wNkslRKmt69XyG48SgQ==
X-CSE-MsgGUID: PmsasO3ZStuXNQev6l/Ezw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41479199"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41479199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:14:39 -0800
X-CSE-ConnectionGUID: nYDiCb/gSX6tdkOgbp7GIg==
X-CSE-MsgGUID: mg46U7V7QdOhz0Im2OCzfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156115414"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Mar 2025 20:14:36 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq2cz-000MVy-31;
	Thu, 06 Mar 2025 04:14:33 +0000
Date: Thu, 6 Mar 2025 12:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com,
	zhanjun@uniontech.com, Xu Rao <raoxu@uniontech.com>
Subject: Re: [PATCH V3] usb: xhci: Add debugfs support for xHCI port bandwidth
Message-ID: <202503061205.wtVpmjvj-lkp@intel.com>
References: <20250305085118.28826-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305085118.28826-1-raoxu@uniontech.com>

Hi raoxu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/raoxu/usb-xhci-Add-debugfs-support-for-xHCI-port-bandwidth/20250305-165606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250305085118.28826-1-raoxu%40uniontech.com
patch subject: [PATCH V3] usb: xhci: Add debugfs support for xHCI port bandwidth
config: arc-randconfig-002-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061205.wtVpmjvj-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061205.wtVpmjvj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061205.wtVpmjvj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci.c: In function 'xhci_get_port_bandwidth':
>> drivers/usb/host/xhci.c:3094:41: warning: variable 'num_ports' set but not used [-Wunused-but-set-variable]
    3094 |         unsigned int                    num_ports;
         |                                         ^~~~~~~~~


vim +/num_ports +3094 drivers/usb/host/xhci.c

  3090	
  3091	/* Get the available bandwidth of the ports under the xhci roothub */
  3092	int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 dev_speed)
  3093	{
> 3094		unsigned int			num_ports;
  3095		int				ret;
  3096		unsigned long			flags;
  3097		struct xhci_container_ctx	*ctx;
  3098	
  3099		num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
  3100		ctx = xhci->get_bw_command->in_ctx;
  3101	
  3102		/* get xhci hub port bandwidth */
  3103		/* refer to xhci rev1_2 protocol 4.6.15*/
  3104		spin_lock_irqsave(&xhci->lock, flags);
  3105		ret = xhci_queue_get_rh_port_bw(xhci, xhci->get_bw_command, ctx->dma,
  3106						dev_speed, 0, false);
  3107		if (ret < 0) {
  3108			spin_unlock_irqrestore(&xhci->lock, flags);
  3109			return ret;
  3110		}
  3111		xhci_ring_cmd_db(xhci);
  3112		spin_unlock_irqrestore(&xhci->lock, flags);
  3113	
  3114		wait_for_completion(xhci->get_bw_command->completion);
  3115	
  3116		return ret;
  3117	}
  3118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

