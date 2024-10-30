Return-Path: <linux-kernel+bounces-389349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549719B6BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779DB1C22FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D511C3F00;
	Wed, 30 Oct 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ZAoN+FMv"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A91C3308
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311753; cv=none; b=raiYDmypO42372qSEsizYp/RHjDLgX8H+k/ZbzB+kGhi89119ZVo5FcGe9Krtltph1fXgyU1jCFbzJ+lo0NyGrkR/WgwfttvuqF1zGfW1w5UxC7clqBoxg09/xjI6gVcGwrfLFIU69oiDqTsf0NB2nd/i39R66vdDPkVZ9AK6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311753; c=relaxed/simple;
	bh=t4J85PGwIbsckyeJ/2v7+1bhmSEkPmZJWIdQ3AZkcfo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=QRx9THdbBmX5ptPe6VwNIbw79wVlo5XNuAUNmvkoMhsXlzGJKD59OKIIbdYenQAiO3VKeMIPj028S13VeEyclT6RMFGJ3TvAJ2iZz5UnoYy1IyixwjCmXtg55BoEd48n8IwW5U+qQPlTGbnYk2MQ075tXKOKSOp64GhoXBHiuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ZAoN+FMv; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B93CUXoskoQFA/PtjXNUa7hgVgDMs9cfiRi5u906n5Y=;
  b=ZAoN+FMvGQjEPTVLK4R8h3dlejwhNidDBIiTqUhlxpqwxTDR1CXN0s21
   g0EOOV0r/HtiymF26SGxT/p4GlMUT4Gs4tpXzDD1Q8gi/F8RlFRLdWJpa
   5fiUw4OF7Es4QT+AWyjRaDzmToFksT4x4n/Mmq9YlFYIm9aDsgMjrwoke
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,245,1725314400"; 
   d="scan'208";a="191501813"
Received: from unknown (HELO hadrien) ([79.140.208.1])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 19:09:06 +0100
Date: Wed, 30 Oct 2024 18:09:05 +0000 (GMT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jinjie Ruan <ruanjinjie@huawei.com>
cc: Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, 
    linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR:
 invalid reference to the index variable of the iterator on line 665 (fwd)
Message-ID: <6e8d67a9-2b7-37e6-dea3-68ddd0aadcdb@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please see line 663 and line 678.

On line 665, entry will always be initialized, even if the list is empty.
So the assignment entry = NULL is useless on line 663.  And likewise entry
will not be NULL on line 678.  If the list is empty, it will be pointing
out into space at an offset from the initial list head.

julia

---------- Forwarded message ----------
Date: Thu, 31 Oct 2024 01:16:33 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR: invalid
     reference to the index variable of the iterator on line 665

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Jinjie Ruan <ruanjinjie@huawei.com>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Jacob Keller <jacob.e.keller@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Simon Horman <horms@kernel.org>

Hi Jinjie,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1e939a21eb111a6d6067b38e8e04b8809b64c4e
commit: c1fec890458ad101ddbbc52cdd29f7bba6aa2b10 ethernet/intel: Use list_for_each_entry() helper
date:   1 year, 1 month ago
:::::: branch date: 15 hours ago
:::::: commit date: 1 year, 1 month ago
config: xtensa-randconfig-r054-20241030 (https://download.01.org/0day-ci/archive/20241031/202410310150.GAApd4GK-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202410310150.GAApd4GK-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR: invalid reference to the index variable of the iterator on line 665
   drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:16-21: ERROR: invalid reference to the index variable of the iterator on line 665

vim +678 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c

4c7f35f679f592 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Alexander Duyck 2015-11-02  637
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  638  static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  639  				int vf, int index, unsigned char *mac_addr)
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  640  {
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  641  	struct vf_macvlans *entry;
0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  642  	int retval = 0;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  643
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  644  	if (index <= 1) {
c1fec890458ad1 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jinjie Ruan     2023-09-19  645  		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  646  			if (entry->vf == vf) {
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  647  				entry->vf = -1;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  648  				entry->free = true;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  649  				entry->is_macvlan = false;
5d7daa35b9eb14 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jacob Keller    2014-03-29  650  				ixgbe_del_mac_filter(adapter,
5d7daa35b9eb14 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jacob Keller    2014-03-29  651  						     entry->vf_macvlan, vf);
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  652  			}
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  653  		}
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  654  	}
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  655
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  656  	/*
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  657  	 * If index was zero then we were asked to clear the uc list
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  658  	 * for the VF.  We're done.
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  659  	 */
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  660  	if (!index)
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  661  		return 0;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  662
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  663  	entry = NULL;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  664
c1fec890458ad1 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jinjie Ruan     2023-09-19 @665  	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  666  		if (entry->free)
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  667  			break;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  668  	}
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  669
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  670  	/*
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  671  	 * If we traversed the entire list and didn't find a free entry
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  672  	 * then we're out of space on the RAR table.  Also entry may
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  673  	 * be NULL because the original memory allocation for the list
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  674  	 * failed, which is not fatal but does mean we can't support
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  675  	 * VF requests for MACVLAN because we couldn't allocate
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  676  	 * memory for the list management required.
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  677  	 */
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13 @678  	if (!entry || !entry->free)
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  679  		return -ENOSPC;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  680
0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  681  	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  682  	if (retval < 0)
0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  683  		return retval;
0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  684
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  685  	entry->free = false;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  686  	entry->is_macvlan = true;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  687  	entry->vf = vf;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  688  	memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  689
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  690  	return 0;
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  691  }
a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  692

:::::: The code at line 678 was first introduced by commit
:::::: a1cbb15c13971bd5d41626e9e5ced9f9de132c47 ixgbe: Add macvlan support for VF

:::::: TO: Greg Rose <gregory.v.rose@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

