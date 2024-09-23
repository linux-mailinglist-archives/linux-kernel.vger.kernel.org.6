Return-Path: <linux-kernel+bounces-335420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA697E583
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC311C21088
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD748EAF1;
	Mon, 23 Sep 2024 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKGSY40w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECB1C3D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727067218; cv=none; b=Kp/vC4hrJ9klQuxLmvpiYmvtLjhx31ccLHeLgly2XxkHKYJFTivL9DY7CS0VztD2coNHJkDzL/3jxFBNQdezSS2gCIOnv5UqH96hk4jyTPInekT5n4yFH1IdC1Lf0b0UdWxf/vZBhMjzUgRCPyq3a6/X3PTJcT0Ody1W98RMFoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727067218; c=relaxed/simple;
	bh=u71Qf2SkDRLp4O4wF7193daelVI1zw1JCVVZqTIzMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jdut/jxYXunNBbhNyhD/7i3CbCrm9iUJ5qSXXll3LgfQMUDIyuIyUBkSJLSZkqxV4nFzOS7m8x/DezB5ElgQr4krfflIWaTlZH1As78TVkEH+Bir+4+pwlg9WBsSOcPMEofdMzw7G+ZwaSbIsgD+xTbMyNklbQU2wB8qJsQ0xFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKGSY40w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727067217; x=1758603217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=u71Qf2SkDRLp4O4wF7193daelVI1zw1JCVVZqTIzMDQ=;
  b=QKGSY40wGOBFNdZ1FovvpXkXBFkdTayJLHMGqEL7Q/9I8NIG2wnEkx/8
   sKwwe+YsBxI82huhXUE7uK0CVywqnJNYV+oPl4hM+OWqNZS0pfw2/O0CJ
   84+qofcacYRqfHMFZHUnquKUeJyId0vheVtss3heNjkEK49t/roTcdBpa
   JH7/G2IiVn8jotAZw8kmDx9mtdNpXAZBKPHVBoKgRSzTiBpvhPNIRZqbo
   s6P346EuvAXkqmbfR16Z92/H4U+wTz/tI8pGUp0Dlz3iuCvgEv82ev3es
   I4g2VKj1T/EN9oWrOgo9Gf7p3ZrDLNTd799wJZRWkM4Re83KQ9x3bkg00
   g==;
X-CSE-ConnectionGUID: zlqHg1nZSP60s6wul7gcmQ==
X-CSE-MsgGUID: jv1XtlXNTEKaMSPRYCIl2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43514508"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="43514508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 21:53:36 -0700
X-CSE-ConnectionGUID: pTvhCv6aTWWC+NZrcU9cWA==
X-CSE-MsgGUID: gYaKa9FaQASbWtkmtYnZNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="108380474"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Sep 2024 21:53:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssb4m-000Gue-2H;
	Mon, 23 Sep 2024 04:53:32 +0000
Date: Mon, 23 Sep 2024 12:53:23 +0800
From: kernel test robot <lkp@intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: drivers/soc/fsl/qe/qmc.c:2002:30: warning: unused variable
 'qmc_data_qe'
Message-ID: <202409231229.EFlvN9m0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
commit: eb680d563089e55b20cb7730ed881638fe4425b7 soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation
date:   3 weeks ago
config: powerpc-randconfig-r054-20240923 (https://download.01.org/0day-ci/archive/20240923/202409231229.EFlvN9m0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409231229.EFlvN9m0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409231229.EFlvN9m0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/soc/fsl/qe/qmc.c:12:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/soc/fsl/qe/qmc.c:2002:30: warning: unused variable 'qmc_data_qe' [-Wunused-const-variable]
    2002 | static const struct qmc_data qmc_data_qe = {
         |                              ^~~~~~~~~~~
   2 warnings generated.


vim +/qmc_data_qe +2002 drivers/soc/fsl/qe/qmc.c

  2001	
> 2002	static const struct qmc_data qmc_data_qe = {
  2003		.version = QMC_QE,
  2004		.tstate = 0x30000000,
  2005		.rstate = 0x30000000,
  2006		.zistate = 0x00000200,
  2007		.zdstate_hdlc = 0x80FFFFE0,
  2008		.zdstate_transp = 0x003FFFE2,
  2009		.rpack = 0x80000000,
  2010	};
  2011	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

