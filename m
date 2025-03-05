Return-Path: <linux-kernel+bounces-547976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6586A53E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A433E7A2FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D312054FB;
	Wed,  5 Mar 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpFIt49j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FCA1EE03B;
	Wed,  5 Mar 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216794; cv=none; b=MCB84EZ0l3uiNudlxHnT1/IOTu5mZItZc2nXq8GKwZBkWYaq7HQpmlAudhgS77eh4pwFCWL8V8+4sZsf1wFLc7Mzzb+UtxfgC9aAzbdPUfKVDIjH9QYUwO1KiYInuR1nIJ43F5tdqXid+vmJqFaGPceeX0/vZXkK1hNWHh4OBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216794; c=relaxed/simple;
	bh=jNjm1cYUFMQZ9mfrDQzo9hhp7ND5yA4DLzm1+XAQYrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/jd07hC7CAQ5QK0UgAuylwsqR9jxnNhnm3/cMwDgNeePS9dMaGqBkI+mI9e0ZuHacwRrU2C6kQ8ueY1OlAtpTXBfgl2fEVAjiQjiH6iDNRvXIcEMEs2GEJ8Xe0ztBEN/f1OU5ehWAswr8VKmlvdmCxWrhdiD73WLkS3iLUvHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpFIt49j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741216793; x=1772752793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jNjm1cYUFMQZ9mfrDQzo9hhp7ND5yA4DLzm1+XAQYrg=;
  b=bpFIt49jOUIkTodpIJ+8xyvw3zA2pvo/dkTboppjK77Jj82bI2cpW6sL
   YenU9g+BNo+z5Tz+CGndqJb8ti2Tl7oVi8mf74OkujKmyXQWSR6ltRRuR
   yWBBcHeN6FPxHXjJntkeolx7haqa0ah1KNNxvxsEcUMs7FonIzr5GZN+i
   irRZPxEVOrhLUvHfJoKQ1mU1gqqvYpwcTJeaLrkMqZR3fnyBcumqW+QRi
   URP/xqMTrIW+R/G9r0gq1vzIgeGOVrzDgh/aeKUQaVISlGIEMb299w74A
   Y1+BODNUdHrCKUz6blJlh+igOYsS4lIspF8SUyQnn1kNJe5/jC90T4LFf
   A==;
X-CSE-ConnectionGUID: kewkCgn4QpaUKNBvo4i/xA==
X-CSE-MsgGUID: Rs9Gv2PbSXWNFwUh4Wt+Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59613105"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="59613105"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:19:52 -0800
X-CSE-ConnectionGUID: HlxSlCs0TSCIaan0QpIjmA==
X-CSE-MsgGUID: jCEax0NNT1Cswvrw3DHVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="149607166"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2025 15:19:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpy1h-000MJ6-2W;
	Wed, 05 Mar 2025 23:19:45 +0000
Date: Thu, 6 Mar 2025 07:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Message-ID: <202503060750.pkwFWR24-lkp@intel.com>
References: <20250304104434.481429-4-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304104434.481429-4-kevin_chen@aspeedtech.com>

Hi Kevin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus lee-leds/for-leds-next lee-mfd/for-mfd-next robh/for-next lee-mfd/for-mfd-fixes linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Chen/ARM-dts-aspeed-g6-Add-AST2600-LPC-PCC-support/20250304-194530
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250304104434.481429-4-kevin_chen%40aspeedtech.com
patch subject: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
config: s390-kismet-CONFIG_MFD_SYSCON-CONFIG_ASPEED_LPC_PCC-0-0 (https://download.01.org/0day-ci/archive/20250306/202503060750.pkwFWR24-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503060750.pkwFWR24-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060750.pkwFWR24-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for MFD_SYSCON when selected by ASPEED_LPC_PCC
   WARNING: unmet direct dependencies detected for MFD_SYSCON
     Depends on [n]: HAS_IOMEM [=n]
     Selected by [y]:
     - ASPEED_LPC_PCC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

