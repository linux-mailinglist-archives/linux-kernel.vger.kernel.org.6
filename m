Return-Path: <linux-kernel+bounces-553648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D8A58CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1443A859E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F921DE3A8;
	Mon, 10 Mar 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XF9FEq7M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F101DE2B7;
	Mon, 10 Mar 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591746; cv=none; b=ATrUD/jkNWPB8oL2Opy1hy7D8JFPDkVcNJpnW2+ZR3K6LEV3FxOPinjtYspYlF5pdf2WoBUMc9QPKcYKg9ngkm4nIZ0ZNuIP/gcTy0ChZO+s62tPBWgU5dT+uHqhwAbdwLp79vDHCPeI8NvbWaKDTfTG+L859o3acIo/tT1GgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591746; c=relaxed/simple;
	bh=ssEg4vPopMVhOA1s0W0lhcWOtIh6Cxqt2KYRDMOOri4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye7JuJdn5VjgKEyKobba0fKYXjota/dHOdkpLqTnq48Oo2eNgzIJJQBTaQcvhQ25woQfCvwMDJWhBaNBeq7M+nKIfqACXlZ/+K3yCNyCEROe6Lt3wewfzviTUaPt1SVdyee+3EK8W6vIrM+8CGrMbZhOjbmo6biuf88Tfy3j4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XF9FEq7M; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741591745; x=1773127745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssEg4vPopMVhOA1s0W0lhcWOtIh6Cxqt2KYRDMOOri4=;
  b=XF9FEq7M64Iu+dE27g8dTv0vy3y1h7pAQvdPquJ5Riht4bWi8+/YTmJa
   CJoHEnlwRgFuI1oTemZqJu7BPQfCs0sgJ8IVOjwTKP35+7V71+yuP3KdW
   pzcSdJwi9EpDNPBfh+6OIe2RFeLaHccCl3BsY/jFQreKTYtc4p4/aadlN
   CAE8+qQSWnCEidm+MMSVEQAJEyWhgdz8QUWGD2203udkQVwVBlQIyF6P8
   hGl/jsomNwqVCTe6O+jvQrg00S3BaRIPq/kBAm6jiYrA8OHN/ii7Td9lN
   uCVuaXFwSOeFl03BoJVDPfa7SDErOUhWPElGXP0WSqR32eKfsihAJFDhC
   Q==;
X-CSE-ConnectionGUID: xGlSFC5BRJS0SwqrHp9pHg==
X-CSE-MsgGUID: g8gDkPZQRUq5LxVmBGosgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65017617"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65017617"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:29:04 -0700
X-CSE-ConnectionGUID: iTIwBm7ARi+jwHUHMJcJjw==
X-CSE-MsgGUID: dq70DRYETUWoDTmHCnfvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119847504"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 10 Mar 2025 00:29:01 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trXZ9-0003wI-0V;
	Mon, 10 Mar 2025 07:28:50 +0000
Date: Mon, 10 Mar 2025 15:26:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Chen <kevin_chen@aspeedtech.com>, lee@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, derek.kiernan@amd.com,
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Re: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Message-ID: <202503101519.AIZNCLz1-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus robh/for-next linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Chen/ARM-dts-aspeed-g6-Add-AST2600-LPC-PCC-support/20250304-194530
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250304104434.481429-4-kevin_chen%40aspeedtech.com
patch subject: [PATCH v2 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
config: s390-randconfig-r112-20250310 (https://download.01.org/0day-ci/archive/20250310/202503101519.AIZNCLz1-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250310/202503101519.AIZNCLz1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503101519.AIZNCLz1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:14,
                    from include/linux/of_address.h:7,
                    from drivers/mfd/syscon.c:18:
   drivers/mfd/syscon.c: In function 'of_syscon_register':
>> arch/s390/include/asm/io.h:31:17: error: implicit declaration of function 'iounmap' [-Wimplicit-function-declaration]
      31 | #define iounmap iounmap
         |                 ^~~~~~~
   drivers/mfd/syscon.c:157:9: note: in expansion of macro 'iounmap'
     157 |         iounmap(base);
         |         ^~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SYSCON
   Depends on [n]: HAS_IOMEM [=n]
   Selected by [y]:
   - ASPEED_LPC_PCC [=y]


vim +/iounmap +31 arch/s390/include/asm/io.h

cd24834130ac65 Jan Glauber 2012-11-29  26  
b43b3fff042d08 Baoquan He  2023-07-06  27  /*
b43b3fff042d08 Baoquan He  2023-07-06  28   * I/O memory mapping functions.
b43b3fff042d08 Baoquan He  2023-07-06  29   */
b43b3fff042d08 Baoquan He  2023-07-06  30  #define ioremap_prot ioremap_prot
b43b3fff042d08 Baoquan He  2023-07-06 @31  #define iounmap iounmap
b43b3fff042d08 Baoquan He  2023-07-06  32  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

