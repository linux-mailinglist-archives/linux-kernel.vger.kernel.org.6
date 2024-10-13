Return-Path: <linux-kernel+bounces-362721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED799B8AB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD15B21B52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740EA13211F;
	Sun, 13 Oct 2024 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyFnMcaY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC4433B0
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802721; cv=none; b=TAAI1aWB4OULCGBr+Twwt4qI2CeI662xz7gYhEtJXjNsBV82eQw80DV+TBJ0X9JyscUYteT4FuWh1UUnuX3jGLAuBSX33MRzmiPo77cn0b1zUcknPYgOaZeLD/m6Bd6kPcLfvDAPNLr7B3SZbCY10onnRlCTYyP9kkWRvK20BdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802721; c=relaxed/simple;
	bh=kzKgqGl+8k5EVwHPhD0pMcimWB9DroUSYjZZsLaYGOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WYbqGuZn5qxdek+ma0RD5TLFEDojeAv7mqjKrNFhZax83OdN2mheosUBnkdPKKYvQmXYl+mpmBb9NbmLPCp0ub4jK9g3CH5ehA3Aj3leb9RteQu1msKzc7MnbTS+dWp1NB+H3vTVcqXW79LeSuX/ky3sMbr7UV6+rcrtG8kvQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyFnMcaY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728802721; x=1760338721;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kzKgqGl+8k5EVwHPhD0pMcimWB9DroUSYjZZsLaYGOE=;
  b=OyFnMcaYm0jsyfRoB25zf2pyWnZl2FImmr6d6b+NjhqcgujkTay9Y5kr
   9T0sQE2km7N56Iun8SJuzRbFPwVFHUG+B+zDOKzL7j8LhzxSm4EeaXYx0
   sIr2WukLvQD/64U8SlXuvcl5As0Uup/BAQkFk3BhNILL5oGimMSqGFgxt
   gXsRN4E/dAvp0XUZG/+DlX0iQkQY5eqLZEwM+2SwizeWSs+WSycpea4z7
   uinChJgC9aOzNNCP7VDIOyum1O9r2taDU6ux19IX03KW8gzFrVLP8rTyM
   mWyldBRFQ19wNz7j5JNhqadQxsjSpkw2IYxie+9g3SxPgsOBiPCAtwGWt
   Q==;
X-CSE-ConnectionGUID: IMjYdCudQBqiQs2npxD+gw==
X-CSE-MsgGUID: stQRWR+3Qz+OaSY6ARHqsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28253315"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="28253315"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 23:58:40 -0700
X-CSE-ConnectionGUID: wv7FFXLVSpOhPjV5u7QfQQ==
X-CSE-MsgGUID: wEHL3Ts1R76uVTyJ2D98Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="82290888"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Oct 2024 23:58:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szsYm-000EA6-1q;
	Sun, 13 Oct 2024 06:58:36 +0000
Date: Sun, 13 Oct 2024 14:58:04 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/token.c:50:6-27: WARNING: atomic_dec_and_test variation
 before object free at line 54.
Message-ID: <202410131412.5csjqw8L-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   36c254515dc6592c44db77b84908358979dd6b50
commit: 35f96de04127d332a5c5e8a155d31f452f88c76d bpf: Introduce BPF token object
date:   9 months ago
config: alpha-randconfig-r054-20241012 (https://download.01.org/0day-ci/archive/20241013/202410131412.5csjqw8L-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131412.5csjqw8L-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> kernel/bpf/token.c:50:6-27: WARNING: atomic_dec_and_test variation before object free at line 54.

vim +50 kernel/bpf/token.c

    44	
    45	void bpf_token_put(struct bpf_token *token)
    46	{
    47		if (!token)
    48			return;
    49	
  > 50		if (!atomic64_dec_and_test(&token->refcnt))
    51			return;
    52	
    53		INIT_WORK(&token->work, bpf_token_put_deferred);
  > 54		schedule_work(&token->work);
    55	}
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

