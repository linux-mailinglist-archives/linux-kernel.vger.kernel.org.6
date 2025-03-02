Return-Path: <linux-kernel+bounces-540811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE91A4B543
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A64188FA97
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360981EEA51;
	Sun,  2 Mar 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UALP+DcG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9A1C5D50
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740954275; cv=none; b=LeJEDR7gNAm3C80TAbi+/SVVEQ0Ecb4/TP3V9GsO45OBM7pgF2rHmcCi8F4tZIbYO85kSXdhvCkaAFyQtb9FMg6CoOB9HoL5znNRFIzMQTfoPakVyI3orjzGfhN/ojAtllqmgVXafOS7XaCs7JDP8E+z+STQvVP87JBNCyu2XoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740954275; c=relaxed/simple;
	bh=gWhrY+dgKT08hc4CNnDYn7RoRvEP/QAz6z/9BcCiB4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgtsL8ojx9uJO1hYoOenm1cLbfizDXGTvYfxQI4sz8XGKLNexIykFOclTYXA9Mms8LA01vjhs7LNrK96cRl8bsdAHcZKRoQNd9qdli3mms3WYHLZ4ZhpDphUtGXr2FrJgBk+akoczC5BEbpS12yIuQNybK+60ohHt9VvvUMmVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UALP+DcG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740954273; x=1772490273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gWhrY+dgKT08hc4CNnDYn7RoRvEP/QAz6z/9BcCiB4U=;
  b=UALP+DcGuGEgNCzoipAdZydLxrTMuAlACjJal+Ry8aiNsoifTmWnKXiT
   hIeY7ijN7TXPPZO6NfuX5tTOCiaHzXLAFX6weBlj+kmYwvzuijVT08pZV
   Z5YpuhZQzwvBmWbWK4yZ/5AcD4x6NF1IEGHdfKmUhFs5Jsf14bvUkt41U
   JuyLtmrYMCxTl+99lNgsuXI0NY2qOAElbcUGfL2+4rf0LkuS37ak4VRq9
   WkBJ0LooF9lGZW0aXXel0J59LmQTN9rob4hLk3VwusGlzOFvOs76cf8Q4
   e9DPcXJZbY3Ppb3avotNP+qS7jC2gmR/NGVFJ+R3Vy1+OJNuxWYmX1G3Q
   g==;
X-CSE-ConnectionGUID: KFbD5UQrRPiZIl681A8pBQ==
X-CSE-MsgGUID: 0APUYJkGTiWWveHqpcNWug==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42076489"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="42076489"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 14:24:32 -0800
X-CSE-ConnectionGUID: BptH+XKfT2uJlXj0CNETJA==
X-CSE-MsgGUID: 5Z7VeKH0Q26Jp3TPhr2XcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118378754"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Mar 2025 14:24:30 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1torjX-000Hgw-2S;
	Sun, 02 Mar 2025 22:24:27 +0000
Date: Mon, 3 Mar 2025 06:23:28 +0800
From: kernel test robot <lkp@intel.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, shaggy@kernel.org,
	jfs-discussion@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: Re: [PATCH] jfs: jfs_xtree: replace XT_GETPAGE macro with
 xt_getpage() function
Message-ID: <202503030642.jn4Teav7-lkp@intel.com>
References: <20250302191558.47180-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302191558.47180-1-suchitkarunakaran@gmail.com>

Hi Suchit,

kernel test robot noticed the following build errors:

[auto build test ERROR on kleikamp-shaggy/jfs-next]
[also build test ERROR on linus/master v6.14-rc5 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suchit-Karunakaran/jfs-jfs_xtree-replace-XT_GETPAGE-macro-with-xt_getpage-function/20250303-031811
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20250302191558.47180-1-suchitkarunakaran%40gmail.com
patch subject: [PATCH] jfs: jfs_xtree: replace XT_GETPAGE macro with xt_getpage() function
config: arm-randconfig-001-20250303 (https://download.01.org/0day-ci/archive/20250303/202503030642.jn4Teav7-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250303/202503030642.jn4Teav7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503030642.jn4Teav7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/jfs/jfs_xtree.c:118:13: error: incompatible pointer types passing 'struct inode **' to parameter of type 'struct inode *'; dereference with * [-Werror,-Wincompatible-pointer-types]
           BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
                      ^~
                      *
   fs/jfs/jfs_btree.h:58:35: note: expanded from macro 'BT_GETPAGE'
                   MP = (struct metapage *)&JFS_IP(IP)->bxflag;\
                                                   ^~
   fs/jfs/jfs_incore.h:205:59: note: passing argument to parameter 'inode' here
   static inline struct jfs_inode_info *JFS_IP(struct inode *inode)
                                                             ^
>> fs/jfs/jfs_xtree.c:118:13: error: incompatible pointer types passing 'struct inode **' to parameter of type 'struct inode *'; dereference with * [-Werror,-Wincompatible-pointer-types]
           BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
                      ^~
                      *
   fs/jfs/jfs_btree.h:59:23: note: expanded from macro 'BT_GETPAGE'
                   P = (TYPE *)&JFS_IP(IP)->ROOT;\
                                       ^~
   fs/jfs/jfs_incore.h:205:59: note: passing argument to parameter 'inode' here
   static inline struct jfs_inode_info *JFS_IP(struct inode *inode)
                                                             ^
   fs/jfs/jfs_xtree.c:118:2: error: incompatible pointer types passing 'struct inode **' to parameter of type 'struct inode *'; dereference with * [-Werror,-Wincompatible-pointer-types]
           BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/jfs/jfs_btree.h:64:22: note: expanded from macro 'BT_GETPAGE'
                   MP = read_metapage((IP), BN, SIZE, 1);\
                        ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   fs/jfs/jfs_metapage.h:55:18: note: expanded from macro 'read_metapage'
            __get_metapage(inode, lblock, size, absolute, false)
                           ^~~~~
   fs/jfs/jfs_metapage.h:50:54: note: passing argument to parameter 'inode' here
   extern struct metapage *__get_metapage(struct inode *inode,
                                                        ^
>> fs/jfs/jfs_xtree.c:126:16: error: member reference base type 'struct inode *' is not a structure or union
                           jfs_error(ip->i_sb, "xt_getpage: xtree page corrupt\n");
                                     ~~^ ~~~~
>> fs/jfs/jfs_xtree.c:273:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:828:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, parent->bn, &smp, PSIZE, &sp);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1083:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, nextbn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1438:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1454:20: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                           rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                           ^~
                                           &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1732:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1748:20: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                           rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                           ^~
                                           &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1809:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1885:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:1902:20: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                           rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                           ^~
                                           &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:2289:18: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
           rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                           ^~
                           &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:2527:18: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
           rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                           ^~
                           &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:2812:19: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
                   rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                                   ^~
                                   &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   fs/jfs/jfs_xtree.c:2857:18: error: incompatible pointer types passing 'struct inode *' to parameter of type 'struct inode **'; take the address with & [-Werror,-Wincompatible-pointer-types]
           rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
                           ^~
                           &
   fs/jfs/jfs_xtree.c:113:45: note: passing argument to parameter 'ip' here
   static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
                                               ^
   18 errors generated.


vim +118 fs/jfs/jfs_xtree.c

    79	
    80	
    81	/*
    82	 * forward references
    83	 */
    84	static int xtSearch(struct inode *ip, s64 xoff, s64 *next, int *cmpp,
    85			    struct btstack * btstack, int flag);
    86	
    87	static int xtSplitUp(tid_t tid,
    88			     struct inode *ip,
    89			     struct xtsplit * split, struct btstack * btstack);
    90	
    91	static int xtSplitPage(tid_t tid, struct inode *ip, struct xtsplit * split,
    92			       struct metapage ** rmpp, s64 * rbnp);
    93	
    94	static int xtSplitRoot(tid_t tid, struct inode *ip,
    95			       struct xtsplit * split, struct metapage ** rmpp);
    96	
    97	/*
    98	 *	xt_getpage()
    99	 *
   100	 * function:	get the page buffer for a specified block address.
   101	 *
   102	 * parameters:
   103	 *	ip      - pointer to the inode
   104	 *	bn      - block number (s64) of the xtree page to be retrieved;
   105	 *	mp      - pointer to a metapage pointer where the page buffer is returned;
   106	 *	size    - size parameter to pass to BT_GETPAGE;
   107	 *	p       - pointer to an xtpage_t pointer mapping the page's data.
   108	 *
   109	 * returns:
   110	 *	0 on success, or -EIO if the page is corrupt or an error occurs.
   111	 */
   112	
   113	static inline int xt_getpage(struct inode **ip, s64 bn, struct metapage **mp,
   114				unsigned int size, xtpage_t **p)
   115	{
   116		int rc;
   117	
 > 118		BT_GETPAGE(ip, bn, *mp, xtpage_t, size, *p, rc, i_xtroot);
   119	
   120		if (!rc) {
   121			if ((le16_to_cpu((*p)->header.nextindex) < XTENTRYSTART) ||
   122				(le16_to_cpu((*p)->header.nextindex) >
   123					le16_to_cpu((*p)->header.maxentry)) ||
   124				(le16_to_cpu((*p)->header.maxentry) >
   125					((bn == 0) ? XTROOTMAXSLOT : PSIZE >> L2XTSLOTSIZE))) {
 > 126				jfs_error(ip->i_sb, "xt_getpage: xtree page corrupt\n");
   127				BT_PUTPAGE(*mp);
   128				*mp = NULL;
   129				rc = -EIO;
   130			}
   131		}
   132		return rc;
   133	}
   134	
   135	/*
   136	 *	xtLookup()
   137	 *
   138	 * function: map a single page into a physical extent;
   139	 */
   140	int xtLookup(struct inode *ip, s64 lstart,
   141		     s64 llen, int *pflag, s64 * paddr, s32 * plen, int no_check)
   142	{
   143		int rc = 0;
   144		struct btstack btstack;
   145		int cmp;
   146		s64 bn;
   147		struct metapage *mp;
   148		xtpage_t *p;
   149		int index;
   150		xad_t *xad;
   151		s64 next, size, xoff, xend;
   152		int xlen;
   153		s64 xaddr;
   154	
   155		*paddr = 0;
   156		*plen = llen;
   157	
   158		if (!no_check) {
   159			/* is lookup offset beyond eof ? */
   160			size = ((u64) ip->i_size + (JFS_SBI(ip->i_sb)->bsize - 1)) >>
   161			    JFS_SBI(ip->i_sb)->l2bsize;
   162			if (lstart >= size)
   163				return 0;
   164		}
   165	
   166		/*
   167		 * search for the xad entry covering the logical extent
   168		 */
   169	//search:
   170		if ((rc = xtSearch(ip, lstart, &next, &cmp, &btstack, 0))) {
   171			jfs_err("xtLookup: xtSearch returned %d", rc);
   172			return rc;
   173		}
   174	
   175		/*
   176		 *	compute the physical extent covering logical extent
   177		 *
   178		 * N.B. search may have failed (e.g., hole in sparse file),
   179		 * and returned the index of the next entry.
   180		 */
   181		/* retrieve search result */
   182		XT_GETSEARCH(ip, btstack.top, bn, mp, p, index);
   183	
   184		/* is xad found covering start of logical extent ?
   185		 * lstart is a page start address,
   186		 * i.e., lstart cannot start in a hole;
   187		 */
   188		if (cmp) {
   189			if (next)
   190				*plen = min(next - lstart, llen);
   191			goto out;
   192		}
   193	
   194		/*
   195		 * lxd covered by xad
   196		 */
   197		xad = &p->xad[index];
   198		xoff = offsetXAD(xad);
   199		xlen = lengthXAD(xad);
   200		xend = xoff + xlen;
   201		xaddr = addressXAD(xad);
   202	
   203		/* initialize new pxd */
   204		*pflag = xad->flag;
   205		*paddr = xaddr + (lstart - xoff);
   206		/* a page must be fully covered by an xad */
   207		*plen = min(xend - lstart, llen);
   208	
   209	      out:
   210		XT_PUTPAGE(mp);
   211	
   212		return rc;
   213	}
   214	
   215	/*
   216	 *	xtSearch()
   217	 *
   218	 * function:	search for the xad entry covering specified offset.
   219	 *
   220	 * parameters:
   221	 *	ip	- file object;
   222	 *	xoff	- extent offset;
   223	 *	nextp	- address of next extent (if any) for search miss
   224	 *	cmpp	- comparison result:
   225	 *	btstack - traverse stack;
   226	 *	flag	- search process flag (XT_INSERT);
   227	 *
   228	 * returns:
   229	 *	btstack contains (bn, index) of search path traversed to the entry.
   230	 *	*cmpp is set to result of comparison with the entry returned.
   231	 *	the page containing the entry is pinned at exit.
   232	 */
   233	static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
   234			    int *cmpp, struct btstack * btstack, int flag)
   235	{
   236		struct jfs_inode_info *jfs_ip = JFS_IP(ip);
   237		int rc = 0;
   238		int cmp = 1;		/* init for empty page */
   239		s64 bn;			/* block number */
   240		struct metapage *mp;	/* page buffer */
   241		xtpage_t *p;		/* page */
   242		xad_t *xad;
   243		int base, index, lim, btindex;
   244		struct btframe *btsp;
   245		int nsplit = 0;		/* number of pages to split */
   246		s64 t64;
   247		s64 next = 0;
   248	
   249		INCREMENT(xtStat.search);
   250	
   251		BT_CLR(btstack);
   252	
   253		btstack->nsplit = 0;
   254	
   255		/*
   256		 *	search down tree from root:
   257		 *
   258		 * between two consecutive entries of <Ki, Pi> and <Kj, Pj> of
   259		 * internal page, child page Pi contains entry with k, Ki <= K < Kj.
   260		 *
   261		 * if entry with search key K is not found
   262		 * internal page search find the entry with largest key Ki
   263		 * less than K which point to the child page to search;
   264		 * leaf page search find the entry with smallest key Kj
   265		 * greater than K so that the returned index is the position of
   266		 * the entry to be shifted right for insertion of new entry.
   267		 * for empty tree, search key is greater than any key of the tree.
   268		 *
   269		 * by convention, root bn = 0.
   270		 */
   271		for (bn = 0;;) {
   272			/* get/pin the page to search */
 > 273			rc = xt_getpage(ip, bn, &mp, PSIZE, &p);
   274			if (rc)
   275				return rc;
   276	
   277			/* try sequential access heuristics with the previous
   278			 * access entry in target leaf page:
   279			 * once search narrowed down into the target leaf,
   280			 * key must either match an entry in the leaf or
   281			 * key entry does not exist in the tree;
   282			 */
   283	//fastSearch:
   284			if ((jfs_ip->btorder & BT_SEQUENTIAL) &&
   285			    (p->header.flag & BT_LEAF) &&
   286			    (index = jfs_ip->btindex) <
   287			    le16_to_cpu(p->header.nextindex)) {
   288				xad = &p->xad[index];
   289				t64 = offsetXAD(xad);
   290				if (xoff < t64 + lengthXAD(xad)) {
   291					if (xoff >= t64) {
   292						*cmpp = 0;
   293						goto out;
   294					}
   295	
   296					/* stop sequential access heuristics */
   297					goto binarySearch;
   298				} else {	/* (t64 + lengthXAD(xad)) <= xoff */
   299	
   300					/* try next sequential entry */
   301					index++;
   302					if (index <
   303					    le16_to_cpu(p->header.nextindex)) {
   304						xad++;
   305						t64 = offsetXAD(xad);
   306						if (xoff < t64 + lengthXAD(xad)) {
   307							if (xoff >= t64) {
   308								*cmpp = 0;
   309								goto out;
   310							}
   311	
   312							/* miss: key falls between
   313							 * previous and this entry
   314							 */
   315							*cmpp = 1;
   316							next = t64;
   317							goto out;
   318						}
   319	
   320						/* (xoff >= t64 + lengthXAD(xad));
   321						 * matching entry may be further out:
   322						 * stop heuristic search
   323						 */
   324						/* stop sequential access heuristics */
   325						goto binarySearch;
   326					}
   327	
   328					/* (index == p->header.nextindex);
   329					 * miss: key entry does not exist in
   330					 * the target leaf/tree
   331					 */
   332					*cmpp = 1;
   333					goto out;
   334				}
   335	
   336				/*
   337				 * if hit, return index of the entry found, and
   338				 * if miss, where new entry with search key is
   339				 * to be inserted;
   340				 */
   341			      out:
   342				/* compute number of pages to split */
   343				if (flag & XT_INSERT) {
   344					if (p->header.nextindex ==	/* little-endian */
   345					    p->header.maxentry)
   346						nsplit++;
   347					else
   348						nsplit = 0;
   349					btstack->nsplit = nsplit;
   350				}
   351	
   352				/* save search result */
   353				btsp = btstack->top;
   354				btsp->bn = bn;
   355				btsp->index = index;
   356				btsp->mp = mp;
   357	
   358				/* update sequential access heuristics */
   359				jfs_ip->btindex = index;
   360	
   361				if (nextp)
   362					*nextp = next;
   363	
   364				INCREMENT(xtStat.fastSearch);
   365				return 0;
   366			}
   367	
   368			/* well, ... full search now */
   369		      binarySearch:
   370			lim = le16_to_cpu(p->header.nextindex) - XTENTRYSTART;
   371	
   372			/*
   373			 * binary search with search key K on the current page
   374			 */
   375			for (base = XTENTRYSTART; lim; lim >>= 1) {
   376				index = base + (lim >> 1);
   377	
   378				XT_CMP(cmp, xoff, &p->xad[index], t64);
   379				if (cmp == 0) {
   380					/*
   381					 *	search hit
   382					 */
   383					/* search hit - leaf page:
   384					 * return the entry found
   385					 */
   386					if (p->header.flag & BT_LEAF) {
   387						*cmpp = cmp;
   388	
   389						/* compute number of pages to split */
   390						if (flag & XT_INSERT) {
   391							if (p->header.nextindex ==
   392							    p->header.maxentry)
   393								nsplit++;
   394							else
   395								nsplit = 0;
   396							btstack->nsplit = nsplit;
   397						}
   398	
   399						/* save search result */
   400						btsp = btstack->top;
   401						btsp->bn = bn;
   402						btsp->index = index;
   403						btsp->mp = mp;
   404	
   405						/* init sequential access heuristics */
   406						btindex = jfs_ip->btindex;
   407						if (index == btindex ||
   408						    index == btindex + 1)
   409							jfs_ip->btorder = BT_SEQUENTIAL;
   410						else
   411							jfs_ip->btorder = BT_RANDOM;
   412						jfs_ip->btindex = index;
   413	
   414						return 0;
   415					}
   416					/* search hit - internal page:
   417					 * descend/search its child page
   418					 */
   419					if (index < le16_to_cpu(p->header.nextindex)-1)
   420						next = offsetXAD(&p->xad[index + 1]);
   421					goto next;
   422				}
   423	
   424				if (cmp > 0) {
   425					base = index + 1;
   426					--lim;
   427				}
   428			}
   429	
   430			/*
   431			 *	search miss
   432			 *
   433			 * base is the smallest index with key (Kj) greater than
   434			 * search key (K) and may be zero or maxentry index.
   435			 */
   436			if (base < le16_to_cpu(p->header.nextindex))
   437				next = offsetXAD(&p->xad[base]);
   438			/*
   439			 * search miss - leaf page:
   440			 *
   441			 * return location of entry (base) where new entry with
   442			 * search key K is to be inserted.
   443			 */
   444			if (p->header.flag & BT_LEAF) {
   445				*cmpp = cmp;
   446	
   447				/* compute number of pages to split */
   448				if (flag & XT_INSERT) {
   449					if (p->header.nextindex ==
   450					    p->header.maxentry)
   451						nsplit++;
   452					else
   453						nsplit = 0;
   454					btstack->nsplit = nsplit;
   455				}
   456	
   457				/* save search result */
   458				btsp = btstack->top;
   459				btsp->bn = bn;
   460				btsp->index = base;
   461				btsp->mp = mp;
   462	
   463				/* init sequential access heuristics */
   464				btindex = jfs_ip->btindex;
   465				if (base == btindex || base == btindex + 1)
   466					jfs_ip->btorder = BT_SEQUENTIAL;
   467				else
   468					jfs_ip->btorder = BT_RANDOM;
   469				jfs_ip->btindex = base;
   470	
   471				if (nextp)
   472					*nextp = next;
   473	
   474				return 0;
   475			}
   476	
   477			/*
   478			 * search miss - non-leaf page:
   479			 *
   480			 * if base is non-zero, decrement base by one to get the parent
   481			 * entry of the child page to search.
   482			 */
   483			index = base ? base - 1 : base;
   484	
   485			/*
   486			 * go down to child page
   487			 */
   488		      next:
   489			/* update number of pages to split */
   490			if (p->header.nextindex == p->header.maxentry)
   491				nsplit++;
   492			else
   493				nsplit = 0;
   494	
   495			/* push (bn, index) of the parent page/entry */
   496			if (BT_STACK_FULL(btstack)) {
   497				jfs_error(ip->i_sb, "stack overrun!\n");
   498				XT_PUTPAGE(mp);
   499				return -EIO;
   500			}
   501			BT_PUSH(btstack, bn, index);
   502	
   503			/* get the child page block number */
   504			bn = addressXAD(&p->xad[index]);
   505	
   506			/* unpin the parent page */
   507			XT_PUTPAGE(mp);
   508		}
   509	}
   510	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

