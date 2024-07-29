Return-Path: <linux-kernel+bounces-266541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3559940165
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D591B21CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092B18FC69;
	Mon, 29 Jul 2024 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dut9vJj3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CD18D4CA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293530; cv=none; b=YoxUCXXpovbqr2Iy+rvwRAUJN9OBMgMDz/1ZheXTx6n90Ej3qNlTP457JmOgLR9HYWkeH9knA7244kWrTNLM8yM5s44ZKFBLMSqIB72G1Rsil9qdmyNmI7bNuO29qOlWfJXEV/zmYSAMlWFiYFJ6Abb03FzfZEaIhAQq9F0gsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293530; c=relaxed/simple;
	bh=ancUfdbymKu5ygqur2XdPXpMNAsblcqDSvNTOQNnBeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQxFu0qpJqsB/AF9max4ZvhmqQ8ai9Rh5LCjKWABZeC5wFtPfzAW+dFoqBxMgEL2gll4xA1Z4rAbXAYjEzvfFZv9T21Xh4B4n3rZrHg71qqLC4yyIm4gEuDtamBL3JsqerWgtJMBOTU5C9PyFJHtqrcQm3cxaHCU5u+N3+94XXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dut9vJj3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722293529; x=1753829529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ancUfdbymKu5ygqur2XdPXpMNAsblcqDSvNTOQNnBeE=;
  b=Dut9vJj3wzHW8g84ArgKLfmvkeSGNgBsKjBG3fDid22xIhj3BEuK+Sxi
   VJmO4OxmYLOVMsVcaVcBEIOfAGh8lsCOwqXUIOpmFSFa9vZ8CjcZ08+Qa
   UmTmNK/sbXBsejdbfwPJLqg/83JIdF1/CaZuD00R/RLnWd3wEkeE17/ZP
   P9Tqq2BkVtw66V2fAcNMkc0/5yPRvbjvi03zEZmh4zMtr71qs0BkYwYDu
   HhNNXZSZUsk1iBs1KfAMbHmBNzfSN/Zv6eEkmHdEuSRfRjG59KkV1liiC
   os3QZB8GfCUK2DhwB9POe5QBQkTdVFA454jpXs4ea4roulW31d9E7B8Fe
   w==;
X-CSE-ConnectionGUID: 33/sJFSnQS2KyA9GEzgvAg==
X-CSE-MsgGUID: zoCnIctNQNewt0DqZaYdZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20228991"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20228991"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:52:08 -0700
X-CSE-ConnectionGUID: FPzRSpk3Ssur722Q8WBs3Q==
X-CSE-MsgGUID: j/maIhMDQ6CnZJZm4LxmBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54925186"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 29 Jul 2024 15:52:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYZDn-000s9i-2I;
	Mon, 29 Jul 2024 22:52:03 +0000
Date: Tue, 30 Jul 2024 06:51:56 +0800
From: kernel test robot <lkp@intel.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 23/30] drivers/irqchip/irq-armada-370-xp.c:263:37:
 error: use of undeclared identifier 'd'
Message-ID: <202407300645.8EAO5dys-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marek,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   e626fcbaa9b67e4488ea437e0e8a5657e707d5f8
commit: f72976cd7f0e16639f29398d5fe5ab1b03789b42 [23/30] irqchip/armada-370-xp: Use consistent name for struct irq_data variables
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240730/202407300645.8EAO5dys-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300645.8EAO5dys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300645.8EAO5dys-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-armada-370-xp.c:263:37: error: use of undeclared identifier 'd'
           irq_data_update_effective_affinity(d, cpumask_of(cpu));
                                              ^
   1 error generated.


vim +/d +263 drivers/irqchip/irq-armada-370-xp.c

   250	
   251	static int mpic_msi_set_affinity(struct irq_data *irq_data, const struct cpumask *mask, bool force)
   252	{
   253		unsigned int cpu;
   254	
   255		if (!force)
   256			cpu = cpumask_any_and(mask, cpu_online_mask);
   257		else
   258			cpu = cpumask_first(mask);
   259	
   260		if (cpu >= nr_cpu_ids)
   261			return -EINVAL;
   262	
 > 263		irq_data_update_effective_affinity(d, cpumask_of(cpu));
   264	
   265		return IRQ_SET_MASK_OK;
   266	}
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

