Return-Path: <linux-kernel+bounces-548719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85021A54894
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559EA172AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91212205513;
	Thu,  6 Mar 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeYXgZNI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC7204686;
	Thu,  6 Mar 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258776; cv=none; b=ZSXFsqQ9cngUXTRf2ynydbP4eBWgCPka2/PI3hLMj1jA0M0/EJOf18mnofckxaJTZo4asPILhJaxveg/ZQPI4uiuug8bMtz6iceZ+TtbcNW4nj1ds9LqFWCwJ0x3ldQYjGUx5N3rLpmF+asrr8DXZbBxmI1+YU1iRwcB2ZJa3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258776; c=relaxed/simple;
	bh=pn7HsBf7477qOG8Rcf22SNHgAPgmTHb73sR7+rGmUIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+CzVUCIRGrm0jyQX+dEKvuAEcRnWGVSktCmH4KFLzGNnCSsItQDqfT1Ckj0klM9wyZxU3JRvKhW8GuF+aLBwKB8TSwrD9vOjmf9iOdkZcre62FS4oVzzT9PQQbaR+VcCutWBn3uzheSv4aJ2Z43JnoKTRQxZm34+HkDyKDdLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeYXgZNI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741258774; x=1772794774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pn7HsBf7477qOG8Rcf22SNHgAPgmTHb73sR7+rGmUIU=;
  b=aeYXgZNIAQLZFgYHoAg4/0MIBt25RWMksM+DXYQu32TaHn5urjgOzUvX
   9KGGMImjUrTSsCnt68dUV0Y0QbUD5IbKowODuaXpewUMlkEh4JM8o/o4s
   nVrn0YzqqoJyAzr/pLTv/8WASjO6dkCy5fJQSqq/UWDJwJtMgamCDQNkj
   Z+hhwd5Cqm5UE+hu9Roley4tNgRJOrEHskKNx7CsgqkHU84HBwP6wsjzq
   inSPJj+pXSyyQehXaGn8zSA0XnI2NAw1c283mavEnml4CMIAJCzTAT03m
   cwtwxGxIJiUdATrs/HfwQtNt4v3pCbwhu0vTb2xC49IwGYY+brHgyawdI
   A==;
X-CSE-ConnectionGUID: rPjQ6yVmQl+TpHNcfV0xTQ==
X-CSE-MsgGUID: Ugk7auzaSemqar2YrYJbnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52907262"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52907262"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:59:33 -0800
X-CSE-ConnectionGUID: 5HFDfgG9TSK9iDaUKvCqqw==
X-CSE-MsgGUID: SfPtaCZ7R4OLUtDyxqLQ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124199673"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 06 Mar 2025 02:59:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq8wp-000MwI-27;
	Thu, 06 Mar 2025 10:59:27 +0000
Date: Thu, 6 Mar 2025 18:59:18 +0800
From: kernel test robot <lkp@intel.com>
To: Akshay Gupta <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@roeck-us.net,
	gregkh@linuxfoundation.org, arnd@arndb.de, shyam-sundar.s-k@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	naveenkrishna.chatradhi@amd.com,
	Akshay Gupta <akshay.gupta@amd.com>
Subject: Re: [PATCH v5 03/11] misc: amd-sbi: Move hwmon device sensor as
 separate entity
Message-ID: <202503061815.wWrdDMmv-lkp@intel.com>
References: <20250303105902.215009-4-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303105902.215009-4-akshay.gupta@amd.com>

Hi Akshay,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus groeck-staging/hwmon-next soc/for-next linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akshay-Gupta/hwmon-misc-amd-sbi-Move-core-sbrmi-from-hwmon-to-misc/20250303-190830
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20250303105902.215009-4-akshay.gupta%40amd.com
patch subject: [PATCH v5 03/11] misc: amd-sbi: Move hwmon device sensor as separate entity
config: x86_64-randconfig-078-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061815.wWrdDMmv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061815.wWrdDMmv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061815.wWrdDMmv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/misc/amd-sbi/rmi-hwmon.o: in function `create_hwmon_sensor_device':
>> drivers/misc/amd-sbi/rmi-hwmon.c:118: undefined reference to `devm_hwmon_device_register_with_info'


vim +118 drivers/misc/amd-sbi/rmi-hwmon.c

   113	
   114	int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data)
   115	{
   116		struct device *hwmon_dev;
   117	
 > 118		hwmon_dev = devm_hwmon_device_register_with_info(dev, "sbrmi", data,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

