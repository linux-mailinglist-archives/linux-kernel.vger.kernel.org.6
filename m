Return-Path: <linux-kernel+bounces-419106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B319C9D6994
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2462B1616FA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2D1BC49;
	Sat, 23 Nov 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Av6XCo+M"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A8BA42
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374788; cv=none; b=leeSPAEOjvY3jX99y5pXdEHyKuWJesqkG/1IYUH0o1kTLFWHZmGoA6P1W4e8P3N6wJjbvnaMu2zxiqPAOSHnKy7FF/ScmgeFyDmTYF0eFNvn4aK7+/lGEwwPe7k9qTYgQKMZPREFk++x8yQRrHCKm23uugX0aW4WQJ4mtINGMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374788; c=relaxed/simple;
	bh=wLb79zeSqhwXnFvGdrpJW0IFs8FVOlDv9YZHGSZotHo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=H8/uFE64NsQ0BMf9H1aYNLLh3iJSYm5u875uyjXEqr4wWwPq0l1zEQF1q51nSZiP0pgi9TLz38Oteb6U1lzU/T1zJKnxljYefvuAWo45aiRl5Yo+nH00aT/2OxGKH0+C88ghWT4zOW5LVTaTUa+c0vR6FBc361avZfRN6NB9lH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Av6XCo+M; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bIMOKm7OsN1C2/NxXtSFefauVRh9CdSZ4YM11qJ8RZA=;
  b=Av6XCo+MeKKLK24WKOI1SgmtlzZIFvjBFHeLopB5vgnvFPJKDXIxTYXU
   sIOFF8SnlLFWvu/FYvhHFOqlI38hTHarzFs6X+lyefEUkttR14BjtZD4y
   Ih/NErsHzN2pIjFH+zjltC63VLHES8Sr4nPMZmnO3yeC+t0W7fhvRU3c6
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,179,1728943200"; 
   d="scan'208";a="102451876"
Received: from unknown (HELO hadrien) ([137.54.125.254])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 16:11:52 +0100
Date: Sat, 23 Nov 2024 10:11:50 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jinjie Ruan <ruanjinjie@huawei.com>
cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>
Subject: drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR:
 invalid reference to the index variable of the iterator on line 665 (fwd)
Message-ID: <27f489a5-1758-c0a2-f977-bd17a26d6dbf@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please see lines 663-679.  Setting entry to NULL is useless.  The
list_for_each_entry will overwrite it, even if the list is empty.  The
!empty test on line 678 is likewise useless, and the !entry->free est on
the same line may return a meaningless value if the list is empty.
Consider adding a flag variable to record whether the break was taken.

julia

---------- Forwarded message ----------
Date: Fri, 22 Nov 2024 14:07:03 +0800
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
head:   28eb75e178d389d325f1666e422bc13bbbb9804c
commit: c1fec890458ad101ddbbc52cdd29f7bba6aa2b10 ethernet/intel: Use list_for_each_entry() helper
date:   1 year, 2 months ago
:::::: branch date: 7 hours ago
:::::: commit date: 1 year, 2 months ago
config: riscv-randconfig-r051-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221358.yZAZKbuI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202411221358.yZAZKbuI-lkp@intel.com/

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

