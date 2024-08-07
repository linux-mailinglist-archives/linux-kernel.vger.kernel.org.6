Return-Path: <linux-kernel+bounces-278581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BE94B225
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2611C21207
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015014A62A;
	Wed,  7 Aug 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzwr8WW1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627C13E409
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066142; cv=none; b=vDivEivRhzCPhN6K7gcQm4rjKpatZSQHp4kZ44iIVhoafdskAO8+hHsh9q4Jxoi990aFw2+YX6H+oPt+4TsdbJZXFteqaBQ1c1wh4lIuwApLTHay0I1ijxm8/aCkm8exIgprWAG/u899npwv5UErtPFDzmzZZgzlWUoPfbK3i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066142; c=relaxed/simple;
	bh=ZUX9+fCy+0B7oLMMSZ5tfzYOYda/SvhNBtJufwVTXRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJk1PAjFJs+E4ZIHkXbMFb+C/gRQgSLBMrm4wafBZKMuFbuIBeSEWsTL8Bmu8GFW5AdhtJh6rjAZmoAi0sOYNTJNmVEgtAIMhGTEVaqfO+Ih0rrZXPmNPbm5K7riEgEsfKfQwqOUq0a54bWw0+MPjyPnNKD8kK6reOuQdpEAqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tzwr8WW1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723066140; x=1754602140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZUX9+fCy+0B7oLMMSZ5tfzYOYda/SvhNBtJufwVTXRA=;
  b=Tzwr8WW1c9vGTtwFKXwNVyOk9wSdkF4KhLW4weWhB9qxvth9ZvAY7uKB
   hMPnwjWzuYevJexFCS9/E3DPMoWqVW2Wo1behFrCpA3v4uifq7fRtV5m3
   ataP69mZLC5SWL9u35Q3j9oj2UMTNB3GGOoUu5f9vzCCG3R14edHaiPdK
   5g5WQHBIKUM5rWUdAhlMxKqksr3DE8i+b1mZaaaPVwUZJMWTPQZNwlL2H
   DwGeseGe736lkfvQU+iQgUMdy/XXz5G8wpk5sfeLUvuwYJBbn5QFo9UqQ
   GyJfBTd1SQkuCjO99LNpGWGUuvwsFKZnPem5qefs829hudhRilz8i1ri/
   Q==;
X-CSE-ConnectionGUID: fUyCfh15SJGxDoY/CFzbVw==
X-CSE-MsgGUID: QCIXlGKVQ4i7b+v2HBhkiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21286244"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21286244"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 14:29:00 -0700
X-CSE-ConnectionGUID: EQqxYnucTvukEsTBxWCF1A==
X-CSE-MsgGUID: vQFOEMQBR8y6JhP2VHcKeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56947503"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2024 14:28:57 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sboDB-0005jQ-2h;
	Wed, 07 Aug 2024 21:28:51 +0000
Date: Thu, 8 Aug 2024 05:27:45 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>, martin.petersen@oracle.com,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, leit@meta.com,
	"open list:LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)" <MPT-FusionLinux.pdl@broadcom.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: message: fusion: Remove unused variable
Message-ID: <202408080515.uSFIs9Q0-lkp@intel.com>
References: <20240807094000.398857-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807094000.398857-1-leitao@debian.org>

Hi Breno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on linus/master v6.11-rc2 next-20240807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/scsi-message-fusion-Remove-unused-variable/20240807-174402
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20240807094000.398857-1-leitao%40debian.org
patch subject: [PATCH] scsi: message: fusion: Remove unused variable
config: i386-buildonly-randconfig-001-20240808 (https://download.01.org/0day-ci/archive/20240808/202408080515.uSFIs9Q0-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080515.uSFIs9Q0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080515.uSFIs9Q0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/message/fusion/mptsas.c:4235:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
    4235 |         scsi_device_reprobe(sdev);
         |         ^~~~~~~~~~~~~~~~~~~ ~~~~
   1 warning generated.


vim +/warn_unused_result +4235 drivers/message/fusion/mptsas.c

  4230	
  4231	static void
  4232	mptsas_reprobe_lun(struct scsi_device *sdev, void *data)
  4233	{
  4234		sdev->no_uld_attach = data ? 1 : 0;
> 4235		scsi_device_reprobe(sdev);
  4236	}
  4237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

