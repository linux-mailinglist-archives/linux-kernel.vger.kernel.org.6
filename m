Return-Path: <linux-kernel+bounces-381643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26219B01EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E532836C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4A202F80;
	Fri, 25 Oct 2024 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grndIlir"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5A2022DA;
	Fri, 25 Oct 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858212; cv=none; b=sIrREFiWmpSRV/uu2CFJD+998MOMCF+D3Pp3KDD0nMLYlGuTmmz+f2vdHCKi9YC+Oh8Yu2EhErHwGYa9u+7TcqkZjjv12uoSawuYSxlESn7+ahjhz+wZlDTkLB2UNTmidxSU4dG2nvL71sfwJJBmCgGDWAOmygjPWXyYS0/JwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858212; c=relaxed/simple;
	bh=a0NkGOWfPXvuC0pRrY2V1xNhHthWDgHcKYifaYQcMuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAISP3deAT0U/QTgCCf2vlkC+dZKe47kf68+hCAc253VYT54fakcpDuGvb8BZigPNPAsoOGUCk2y4H97eomWTmwg+4xFGmMbWmc7S70AZChJEiOecAtqA3HT+lBFHcIipCY+MRjz9PhYcFsIpM+SebCwHyPig8/ZmFD4QkEAaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grndIlir; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729858211; x=1761394211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0NkGOWfPXvuC0pRrY2V1xNhHthWDgHcKYifaYQcMuI=;
  b=grndIlirvwmJWQAfbj0CBCEvDKEt2cRMzFOmud3jEV+/q3q6JNn3tedq
   YAUT+KvT4A80W6gqhuJ1+sPOj4u44TKBL8eMV1QrjUq7ipz4IKzEiJzFK
   2Xbp9miwo1fprcOd8tllz0202o+r6DBoy5jcNERIs3yXOYo2W50y1eXGM
   1hM5RwysnEzDj99nt/gw40PhO7JLp2zHuRy2jFowL5LQo6NamvtXr2C1G
   JsZ/a32s4nERx/6npfu3lUBW9lEmSBHelAeit0YKvBnihrQphf0sYNVyl
   wIH3xXHdMLQLnyQq3fHc/FluqnzI9CRj/zAuuRAMiI4yWtHrMAWL9Nprm
   g==;
X-CSE-ConnectionGUID: sTIWyVf7TqmmY6G6KXSezQ==
X-CSE-MsgGUID: m+DIviJpTi+/nLhudoIzHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29692403"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29692403"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 05:10:10 -0700
X-CSE-ConnectionGUID: UO8b6M5ER5iqox+HpdnRPg==
X-CSE-MsgGUID: g74Ybz18R9a361uG3aHnZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111711060"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Oct 2024 05:10:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4J8j-000YD2-0w;
	Fri, 25 Oct 2024 12:10:01 +0000
Date: Fri, 25 Oct 2024 20:09:47 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 22/37] drm/vc4: txp: Add BCM2712 MOPLET support
Message-ID: <202410251938.rnvcIesU-lkp@intel.com>
References: <20241023-drm-vc4-2712-support-v1-22-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-22-1cc2d5594907@raspberrypi.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 91e21479c81dd4e9e22a78d7446f92f6b96a7284]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Stevenson/drm-vc4-Limit-max_bpc-to-8-on-Pi0-3/20241024-005239
base:   91e21479c81dd4e9e22a78d7446f92f6b96a7284
patch link:    https://lore.kernel.org/r/20241023-drm-vc4-2712-support-v1-22-1cc2d5594907%40raspberrypi.com
patch subject: [PATCH 22/37] drm/vc4: txp: Add BCM2712 MOPLET support
config: arc-randconfig-r111-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251938.rnvcIesU-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241025/202410251938.rnvcIesU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251938.rnvcIesU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/vc4/vc4_txp.c:513:27: sparse: sparse: symbol 'bcm2712_mop_data' was not declared. Should it be static?
>> drivers/gpu/drm/vc4/vc4_txp.c:527:27: sparse: sparse: symbol 'bcm2712_moplet_data' was not declared. Should it be static?

vim +/bcm2712_moplet_data +527 drivers/gpu/drm/vc4/vc4_txp.c

   526	
 > 527	const struct vc4_txp_data bcm2712_moplet_data = {
   528		.base = {
   529			.name = "moplet",
   530			.debugfs_name = "moplet_regs",
   531			.hvs_available_channels = BIT(1),
   532			.hvs_output = 4,
   533		},
   534		.encoder_type = VC4_ENCODER_TYPE_TXP1,
   535		.high_addr_ptr_reg = TXP_DST_PTR_HIGH_MOPLET,
   536		.size_minus_one = true,
   537		.supports_40bit_addresses = true,
   538	};
   539	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

