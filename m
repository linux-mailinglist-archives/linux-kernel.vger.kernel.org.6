Return-Path: <linux-kernel+bounces-403231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C09C32D1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183EB2815C1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D06A3A1DA;
	Sun, 10 Nov 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WY8q+w2Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7801D554
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731249013; cv=none; b=QJxhI2QKSjpGd7q8yZOTxtyEgZB/SU3bV0GmKl51wTA5d7UEJRT4g0lIDlioZi/YuHIsicaqZnY//v4axp+gEAtYbn0XRNnqaejZrYIPaV/vYrzF9JeZqekO6aZEay/6x/MxXqkFI6+IfFr6qPp//yAtulBQbt+X/IsBjr/q5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731249013; c=relaxed/simple;
	bh=3+lWuqUzppcJFkR2NtOyXRChOALrQwO8Vx1Jyfs6lEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VlEWhkFlm6mdMZq/0KhCG+Q3eKPExkoSPapZ0paJoivAWqOTXhh+m7OoEHAukvNVhwq5b/ZrINVoXxKzrwkP2x3mYL1PB57DbJu50FldJFibsEG050sI/0Vtj0mc70ptkiz5YooThwn1Sr4ReRPcYtCvjDXOBst9KQCm41iT9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WY8q+w2Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731249011; x=1762785011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3+lWuqUzppcJFkR2NtOyXRChOALrQwO8Vx1Jyfs6lEs=;
  b=WY8q+w2YCTltnX9y+jEfGnKTJUNf460ghBFhX/9e4SbXKc9yD1UyNdA5
   SsvsKpseYlZt9vEg1IGYBjIm9eLRkRHyDDDRqApJWSQpSjf9G1q4SiCLi
   gRz2MpZF38oW7WairHcL2fN3rBYsgLK56DLfmTidcCtkm47O+tRxwVAFq
   EknptpR4ExU0kfRORAwU5GdjPCOyB1iG3dM/u+mUjkgQEEgJbYZs68AAe
   N4oEFpTGH7d/MDUzTWebapPmrbd1Gm3FmtO66zmnVwLf+RSAuvjDwspo5
   +d903XahNHShp2j4u4gcSuw0CD2KBOWl+mqs+bZCb6gZwKsyLw/IuhHg5
   Q==;
X-CSE-ConnectionGUID: dDEpEx3/R2aUgoVABq/GQA==
X-CSE-MsgGUID: phmoyQ40ToODeZGYg2//Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31174231"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; 
   d="scan'208";a="31174231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 06:30:11 -0800
X-CSE-ConnectionGUID: 6ziX+vfdSjSvV63XpB54gQ==
X-CSE-MsgGUID: A88FtPWKTTK1JL4sq0l0jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="91336447"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Nov 2024 06:30:09 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tA8x5-0000Bh-0u;
	Sun, 10 Nov 2024 14:30:07 +0000
Date: Sun, 10 Nov 2024 22:29:44 +0800
From: kernel test robot <lkp@intel.com>
To: Likun Gao <Likun.Gao@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>
Subject: drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1638:5-8:
 Unneeded variable: "ret". Return "0" on line 1642
Message-ID: <202411102210.2NAJRzT2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de2f378f2b771b39594c04695feee86476743a69
commit: 3e55845c3983d92e28517a545e403b5eb9acf95b drm/amd/swsmu: add smu v14_0_2 support
date:   7 months ago
config: x86_64-randconfig-r051-20241110 (https://download.01.org/0day-ci/archive/20241110/202411102210.2NAJRzT2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411102210.2NAJRzT2-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1638:5-8: Unneeded variable: "ret". Return "0" on line 1642
   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1647:5-8: Unneeded variable: "ret". Return "0" on line 1651
   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c:1711:5-8: Unneeded variable: "ret". Return "0" on line 1715

vim +1638 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c

  1635	
  1636	static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
  1637	{
> 1638		int ret = 0;
  1639	
  1640		// TODO
  1641	
> 1642		return ret;
  1643	}
  1644	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

