Return-Path: <linux-kernel+bounces-527695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD5A40E3C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB50B3B429C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D5204686;
	Sun, 23 Feb 2025 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cleppnlp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40332AF04
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308659; cv=none; b=dsBvzmNHvnoKP/V6ks5QR+qMsNRv/Kf/CVpJBQ+VKzN/lrgKwJv9Rom0RCB+JMwLCE9YGsRlwc5igBZ/+OHBQYUgq53ZFmZffJXWSWtwpHU4QlRspqJ/la9d0iNxQNSoJBXD5j0SF5q0zoL1/LXR/HSCIAat+wC4lElPNqyeNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308659; c=relaxed/simple;
	bh=ZWw3/0fW6948IUXvYI199/4dSrzTfv19+qbKidcVqrg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FUL2TT8cHPdZq9IPehu4O/AWCtqH7/dyQmy6cbXykOSjrENsDqLmhdkYa/lSn3wjv7npkJbTixWbps9uwPv5KL10Ip0mn/s9xc4SDDkKOHj6e60ZIifIqjEhYX5WKj+9uW6Ld4SZcs0gsbvEEJXSe6eKK1c+WCyqdKI2BaCBOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cleppnlp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740308656; x=1771844656;
  h=date:from:to:cc:subject:message-id;
  bh=ZWw3/0fW6948IUXvYI199/4dSrzTfv19+qbKidcVqrg=;
  b=Cleppnlpwbvpts8TZUp+hu07GUz8BLoh8oimLyTot+k82BtAmXlnSCds
   2cZ7XUBdMuuYKO4INnyt5hlm5Cvqb0yAD/dN9NBaCAULBAEhLh8iGf4nL
   kWXzwtJt2zsO1sI4IxVhfqhnc8epizD7j0JET8VLKb1vloPdhpCoSz7dT
   J8u+kByWf+QvJVfqCGcE4hqzfriiNz/vYadB8Z3o6QTIgY+7FGfl322Cj
   Q4RJwipu4/cBhxHJtogqVZ7aNMNZ73AN/uiBXUybVxVw7mGDd4d2TxVwc
   SmyBk9aRso3gJ20IkC2wB7c2U3nwrqOZLWnT2Dy12A9M3od7BZkO8p8OI
   g==;
X-CSE-ConnectionGUID: 3zb2g0vYR7O5ORhuXO5kqw==
X-CSE-MsgGUID: 2D6D+dFuQq26y0QQq/UuSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40923791"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40923791"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 03:04:16 -0800
X-CSE-ConnectionGUID: YOVOB03VSF6dDyiz8QpU1w==
X-CSE-MsgGUID: k9WbzoA6Sl2TFMpJf3eaHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115832745"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Feb 2025 03:04:14 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm9mO-0007HT-1N;
	Sun, 23 Feb 2025 11:04:12 +0000
Date: Sun, 23 Feb 2025 19:03:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 43bb700cff6bc2f0d337006b864192227fb05dc1
Message-ID: <202502231930.pLDqxUzX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 43bb700cff6bc2f0d337006b864192227fb05dc1  x86/cpu: Update Intel Family comments

elapsed time: 1320m

configs tested: 19
configs skipped: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250222    clang-19
i386    buildonly-randconfig-002-20250222    gcc-12
i386    buildonly-randconfig-003-20250222    gcc-12
i386    buildonly-randconfig-004-20250222    clang-19
i386    buildonly-randconfig-005-20250222    gcc-12
i386    buildonly-randconfig-006-20250222    clang-19
i386                            defconfig    clang-19
x86_64                        allnoconfig    clang-19
x86_64                       allyesconfig    clang-19
x86_64  buildonly-randconfig-001-20250222    clang-19
x86_64  buildonly-randconfig-002-20250222    gcc-12
x86_64  buildonly-randconfig-003-20250222    gcc-12
x86_64  buildonly-randconfig-004-20250222    clang-19
x86_64  buildonly-randconfig-005-20250222    clang-19
x86_64  buildonly-randconfig-006-20250222    gcc-12
x86_64                          defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

