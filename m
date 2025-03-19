Return-Path: <linux-kernel+bounces-567112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C49A68162
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369A2189215C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0028EA;
	Wed, 19 Mar 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0wHjKXb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB029A0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343598; cv=none; b=ZB7SdRRfUDk6X1gqHUb7L+wbc63DUPqQcc5R+XpSqDjs3vJK0TxGjBHRZvAe6kr2Vu8IUC9gNeoXCeMpSm/nKXAS3R8SDLiWuZbQNb7DPYNXyNLpM6bJSJqet7j/svOo6cx/V2fHWWJPlUxfvhY9mt//QIVrLIVR/GjJ182gD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343598; c=relaxed/simple;
	bh=BIO7MY+HOlyWKCmMvbDyXosSy0zFIyzmCa0FDTg5HtY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qSrMfxyM273j+rEDi4odsQodiaip+whFz4SN8oFhai1byHczyYyyH/d5eEJbw+zTU30oWbCKB1vLLAVxa2rYiJg0AD1alOSrP6V4F4nCidvl50WS23Wo6+tNXIC2SvQYnUkqYxDTZciVBINkHXOJyb2JWZgLmmDkv8nRMOEzTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0wHjKXb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742343597; x=1773879597;
  h=date:from:to:cc:subject:message-id;
  bh=BIO7MY+HOlyWKCmMvbDyXosSy0zFIyzmCa0FDTg5HtY=;
  b=T0wHjKXbtERUbwWByca6MZnHY34z9W63Jb9kFDrpBsLoObH+KNsIoNBE
   RDgP3VISAbJtZ8cUoUR9KjhfrSmsJ4ZKEzeY6zzAdBMqDzrbloEaag6qs
   R/CXpusbZ+XO3Iq/hq/gMgA3y4ztE8b4BoUji/mKyR7ZfPg3jA92k7Fjr
   R++NfuDI0Uscu5qEQbbEgd5U7wdQ8hw+MtyBKeVcTsFFUcjGJYzk3bi+v
   FVTMfy6qYFnxJaGwd6ZN3pWwFaKOjDLBxZqumuYJltb9ZAfMrCJs+wZuA
   /gH/pNxb0LotX9eOP56I5rWB7s+ktidRIsWaIfowBis3itC6HW6B8T4Yv
   g==;
X-CSE-ConnectionGUID: 3+qBxeR4Q2im4GKL9HCX7w==
X-CSE-MsgGUID: kOux+WKVThuqOQeA/I2jow==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43246177"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43246177"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 17:19:56 -0700
X-CSE-ConnectionGUID: Twu3gGGERTyp98WFqe1+9Q==
X-CSE-MsgGUID: d+LITORIT92QnyGgdnEI4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="122891906"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 Mar 2025 17:19:55 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuhA0-000EFi-2O;
	Wed, 19 Mar 2025 00:19:52 +0000
Date: Wed, 19 Mar 2025 08:19:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 dda366083e5ff307a4a728757db874bbfe7550be
Message-ID: <202503190852.r6gd0Be3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: dda366083e5ff307a4a728757db874bbfe7550be  x86/fpu/xstate: Fix inconsistencies in guest FPU xfeatures

elapsed time: 1453m

configs tested: 19
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250318    clang-20
i386    buildonly-randconfig-002-20250318    clang-20
i386    buildonly-randconfig-003-20250318    clang-20
i386    buildonly-randconfig-004-20250318    clang-20
i386    buildonly-randconfig-005-20250318    clang-20
i386    buildonly-randconfig-006-20250318    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250318    clang-20
x86_64  buildonly-randconfig-002-20250318    clang-20
x86_64  buildonly-randconfig-003-20250318    clang-20
x86_64  buildonly-randconfig-004-20250318    clang-20
x86_64  buildonly-randconfig-005-20250318    gcc-12
x86_64  buildonly-randconfig-006-20250318    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

