Return-Path: <linux-kernel+bounces-350833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08897990A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DBB1C21F58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7CF1D9A78;
	Fri,  4 Oct 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtfN1OIo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392271D9A5E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063454; cv=none; b=o+EvZvG/HMSju6rwRNS66RYM9d41pTwAdLjM3P09uv8FppkwsMHunmzZYz+03Y1l48pFSkWJx6dxV8VTgejOby9wCkqgQP7aMAyZ94eeC9qeCLMIbtM8gtflElJOrZqqTEv7XRVN50r4qC99tmDbP1hKJraEhNXEYme6ck0S9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063454; c=relaxed/simple;
	bh=iZFWLSoPxAd/cwpSGTpHg2V73KoZMyPRMN4xeGb1Tb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q6nWqa3I60KWoxKotu/fWhnhhSZmAkfKLxg8gukrKDT31W4Vnb6cd0qR5F1CSukTTgMR/beuayIBnBJXJ0eRUS6wY3aPZSZIpIt4JM6mW0eulJ3ePmfkz7qz7yns/HVFhyCGEWiaeR0Tums+yBtD+hdnPN/ACFwtBLGz1Qg4/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtfN1OIo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728063452; x=1759599452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iZFWLSoPxAd/cwpSGTpHg2V73KoZMyPRMN4xeGb1Tb4=;
  b=XtfN1OIoGa0BqA2eGRSiLNk2Dy5e/45IYZ1J5fCMhsQq7zbQWn3ECwtL
   myX3Tq7POSb1zD5JCxG29MTGFLwHQwpVC68LUbFwWV7BYYlGHjkyjcTcs
   UvjctBVLGkcvXGYyeXvlySfiIt9V1YjcCbPY7I0n8WDqMG3P8lTrBdTUN
   bLR1wcG9UX8AoxMGQFi1hATDfgiR67WX1j8Q8YxnOV4ReD/X94Jki0uU1
   +PR/WnNqSOtGGT4j4/zS4lORJvoy8mHkuFCedh+Sn7ZdmLAI+K7ThYolO
   aB2bs2oe0IAI9HdOh69JpWpd7M4Yd7/cvrRQCFHfg3sTzEp7Je3vG34TV
   A==;
X-CSE-ConnectionGUID: wz4PmfeVQj+ZqRlxqsshsg==
X-CSE-MsgGUID: DAKcZ/mNRqq6bwElabv/pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="30178586"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="30178586"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 10:37:32 -0700
X-CSE-ConnectionGUID: MQ8R+xm+S7Srm39Pz1j2vQ==
X-CSE-MsgGUID: eKuvOb3DTbmWjo7PlRHDJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74598750"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Oct 2024 10:37:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swmF6-0001yK-10;
	Fri, 04 Oct 2024 17:37:28 +0000
Date: Sat, 5 Oct 2024 01:37:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241003 14/14]
 kernel/bpf/core.c:2505:29: warning: comparison of distinct pointer types
 lacks a cast
Message-ID: <202410050156.QDVz2Sit-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241003
head:   ec64acf2dce7577a42c01241e78b24afebc26e96
commit: ec64acf2dce7577a42c01241e78b24afebc26e96 [14/14] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241005/202410050156.QDVz2Sit-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050156.QDVz2Sit-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050156.QDVz2Sit-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'bpf_prog_array_free_sleepable':
>> kernel/bpf/core.c:2505:29: warning: comparison of distinct pointer types lacks a cast
    2505 |         if (!progs || progs == &bpf_empty_prog_array.hdr)
         |                             ^~


vim +2505 kernel/bpf/core.c

8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2502  
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2503  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2504  {
8c7dcb84e3b744 Delyan Kratunov 2022-06-14 @2505  	if (!progs || progs == &bpf_empty_prog_array.hdr)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2506  		return;
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2507  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2508  }
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2509  

:::::: The code at line 2505 was first introduced by commit
:::::: 8c7dcb84e3b744b2b70baa7a44a9b1881c33a9c9 bpf: implement sleepable uprobes by chaining gps

:::::: TO: Delyan Kratunov <delyank@fb.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

