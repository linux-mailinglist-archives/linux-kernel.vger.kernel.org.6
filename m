Return-Path: <linux-kernel+bounces-557042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C2A5D2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D23B3B5766
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664EC1DEFDC;
	Tue, 11 Mar 2025 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lj5wpzbV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A95125B9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734054; cv=none; b=ZsfedLllL/Av1L9TT0X97sgh7BZYeDCUOal98/n/NehcNbMGIRkBsJabbvwtSnckGTrPbhgzZBjtNQVXBKitIrvm40OhyZ+eDNdl5YcCfTxabLRWJH9phfgv/UIrsyQsLi8E1JZHuGAtpv8j5dtMnty3TAZ8wvKsWLpsqGc7+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734054; c=relaxed/simple;
	bh=fpP5lJazepeksDoS0wu0HdSV37w5EWa/PsQulq7Kv0k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AWyrVuiStV5PPpqkDN+VqbSDBkC+AZdtortgrlkOIkrDf8nLskW24mfVaGBszCAtD9oUk4hBkTagHsl1STSY32uh08Uu7rQxcxesoVgoLwcLcasK4WsQ+DSojiKC6/++4wlGDC1OF/Ama4jOa14qtnR/qsGy4raMNjmxRhzoouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lj5wpzbV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741734053; x=1773270053;
  h=date:from:to:cc:subject:message-id;
  bh=fpP5lJazepeksDoS0wu0HdSV37w5EWa/PsQulq7Kv0k=;
  b=Lj5wpzbVOpgXVlxMaP3Q4j6U81uANxq4TDSIUT9S44VfDupJWAEzlMNJ
   e+DVNrsSARlnH5ZdHFW3l68BDTib2qpyiclAD5wDzZuUElPygms5yBoNF
   LQ5h7L5KkTjNVKEpyKa+GSaTpZPdMHXRwMFU8fHEG9CoZBDFzIyOQ8qwD
   /5jB0xNAEdNYIhkB6QR5R7y4tbgEHjVuqQ0r7XhgtSh0e006ia03CMn34
   gQBrfygetWFWH0+bfvl2jydXmUY5fmU76Ah5/pNnY3nG9lydxBBtazOD3
   3EQRp+GrWbQLnbo3/s6dDcNjYhIqj2JS2VYVMkFA8j74Bs/4f2ItAUQmO
   A==;
X-CSE-ConnectionGUID: QiEYVXoiTnS/av8ROZNmyQ==
X-CSE-MsgGUID: 2ZwR3JQATHCTRKYvTetxBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53436687"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="53436687"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 16:00:52 -0700
X-CSE-ConnectionGUID: rxGCKTYXRKiVY8XRrr2JfQ==
X-CSE-MsgGUID: IAVQjk2wRgWxDP8OQNdn/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="151420639"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 11 Mar 2025 16:00:51 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts8aE-0007vK-2d;
	Tue, 11 Mar 2025 23:00:30 +0000
Date: Wed, 12 Mar 2025 06:59:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 652262975db421767ada3f05b926854bbb357759
Message-ID: <202503120642.uX1t7sNK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 652262975db421767ada3f05b926854bbb357759  sparc/vdso: Always reject undefined references during linking

elapsed time: 759m

configs tested: 25
configs skipped: 97

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allmodconfig    gcc-12
i386                           allnoconfig    gcc-12
i386                          allyesconfig    gcc-12
i386     buildonly-randconfig-001-20250311    gcc-12
i386     buildonly-randconfig-002-20250311    clang-19
i386     buildonly-randconfig-003-20250311    clang-19
i386     buildonly-randconfig-004-20250311    clang-19
i386     buildonly-randconfig-005-20250311    clang-19
i386     buildonly-randconfig-006-20250311    gcc-11
i386                             defconfig    clang-19
sparc                         allmodconfig    gcc-14.2.0
sparc                          allnoconfig    gcc-14.2.0
sparc              randconfig-001-20250311    gcc-14.2.0
sparc              randconfig-002-20250311    gcc-14.2.0
sparc64            randconfig-001-20250311    gcc-14.2.0
sparc64            randconfig-002-20250311    gcc-14.2.0
x86_64                         allnoconfig    clang-19
x86_64                        allyesconfig    clang-19
x86_64   buildonly-randconfig-001-20250311    gcc-12
x86_64   buildonly-randconfig-002-20250311    gcc-12
x86_64   buildonly-randconfig-003-20250311    clang-19
x86_64   buildonly-randconfig-004-20250311    clang-19
x86_64   buildonly-randconfig-005-20250311    gcc-12
x86_64   buildonly-randconfig-006-20250311    gcc-12
x86_64                           defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

