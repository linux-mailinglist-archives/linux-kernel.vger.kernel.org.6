Return-Path: <linux-kernel+bounces-539586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3ADA4A61D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABEB189C514
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CE1DED69;
	Fri, 28 Feb 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQcKQZh2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716781D61B1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782582; cv=none; b=GnM+Way9jTXjNoT0+SzquuwaEPE0BqbTgB0KMDjoBnaKR6x6HyHa98TdCpVq71L4G7fsq+8a+nl66dRT8LV95DW2DChOvrtnUATacnbQofA6BDf4ijHnlUZWIHg33IIxblBOAuBOZbs9UNNztJ9LeL6j5tLZNiIC0StL0uUqTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782582; c=relaxed/simple;
	bh=NYq9GU89dfTFUegDYYygPmHsdUwHcUkS2ntkv8n+GlU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mfagvx4DL0qrljA+iyu8O7d/X4ukr50KESxEowWROjMGK4iQReC+dcdg4fseMyosg25EEbALXkLfwMHMAjt2TUHnC1Edg2RQ0TxmVQDjiRLJqhBA9vXqLHLc1B8iLC6Nc2IpHVdIP9EDouQyXsXOBw8pL210NYkNOhzc+KnyItw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQcKQZh2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740782580; x=1772318580;
  h=date:from:to:cc:subject:message-id;
  bh=NYq9GU89dfTFUegDYYygPmHsdUwHcUkS2ntkv8n+GlU=;
  b=XQcKQZh2BVa7Mtx4NfFe1mHCiwDo7ndgW1yOEp8chdYT0hPClL+qG/nw
   C8Iz37qgqr7XkYhqfmGmdBuLkjUB4Q/jUAAzActB3L+wWfbWZEHwAYdRu
   n8bsEQFM04rqh+OH6zz5ZMg/o7pTtGBCVM3BJuXnVrcJGvIPkR26gT945
   gUG+j63JW9gqqqxzvzw0uT2hhbZoSA6f457DNsIDjzR6NU4rwic0qgC8b
   9jssk06IJr0Osbk3DaszvhGok90lXqcOcK/g8lCqDPpd0bFu4gYavx1uK
   1IKmNYDY+jAFyAwK/9eP/gGAQAHoNhiVjL18AbmbQYlQZ4XL5454JVN2z
   A==;
X-CSE-ConnectionGUID: rC9hRK6VSYaRj2eImqhFaA==
X-CSE-MsgGUID: hXszwjcHTGKR+py8BbNaXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41844305"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41844305"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 14:42:59 -0800
X-CSE-ConnectionGUID: ocKfCLhYQQePCjOT9GiQug==
X-CSE-MsgGUID: ghx61IPmRoueGpe3p992Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117651797"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Feb 2025 14:42:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to94K-000Fb4-2q;
	Fri, 28 Feb 2025 22:42:56 +0000
Date: Sat, 01 Mar 2025 06:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 72dafb567760320f2de7447cd6e979bf9d4e5d17
Message-ID: <202503010649.CJvsKpmU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 72dafb567760320f2de7447cd6e979bf9d4e5d17  x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()

elapsed time: 1457m

configs tested: 14
configs skipped: 126

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250228    clang-19
i386    buildonly-randconfig-002-20250228    clang-19
i386    buildonly-randconfig-003-20250228    gcc-12
i386    buildonly-randconfig-004-20250228    clang-19
i386    buildonly-randconfig-005-20250228    clang-19
i386    buildonly-randconfig-006-20250228    clang-19
x86_64                        allnoconfig    clang-19
x86_64  buildonly-randconfig-001-20250228    clang-19
x86_64  buildonly-randconfig-002-20250228    clang-19
x86_64  buildonly-randconfig-003-20250228    gcc-12
x86_64  buildonly-randconfig-004-20250228    clang-19
x86_64  buildonly-randconfig-005-20250228    gcc-12
x86_64  buildonly-randconfig-006-20250228    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

