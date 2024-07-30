Return-Path: <linux-kernel+bounces-267215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BD940E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7EB1F24746
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9604197A9D;
	Tue, 30 Jul 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6YIVf9j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B926196C9B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333579; cv=none; b=JbVIsss7y6LzER/4wsQi2rL/Uh/eCqO5BkSWPsoWZ0a5wbHZJYvilgk5H5oIbFwbwEcJAdJsCusa9UdUaDh4i4C7SXtTQPembBig4MYahjtMJMBgwdOCJqMxQZ8PY6hnlmctxmpZ/iJ5fmjd7PYk0/KqMguRP/itVOOuQkG6iIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333579; c=relaxed/simple;
	bh=P2IN5rpmwUqedEttveeycf9C6gDuAqWf3TQ64sYrffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQVElnEptawgQjzDTceOZQpbtWirhgtepDhnZVE9906ndnNZkUjV7UIIVZ3y5mPrMNmD3gqSsrwVCwbd0Jz9vrDaQUKSWMYQu1628zF1P1JemEb4O3ROCKW7STpbJXtz6MJSQwp3axOq4vmhYES2lFUvOaBR4W/p6oLU/7WtW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6YIVf9j; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722333577; x=1753869577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P2IN5rpmwUqedEttveeycf9C6gDuAqWf3TQ64sYrffE=;
  b=O6YIVf9jGpVVSUMYlO+Jc2YGUHsvvPyw31EaiWOH+7eAplSFwKRRpRds
   Zvu1/+1Gs3ztntvayaI53P03N7XapDD/eNvRSd0lIvJi+tdtnUcgwTSDd
   /PS9UJuMNEkgaWNop993taVXvWTHVezTOmRKBC4q15phGDSQvIeQg68kH
   lQFHYrhgGzJnfEKdqnox60zUb1TDgzB1L82vw6FetgZzSwfDxSazS5UVN
   fb1nyCd6jVHj2Wlf3+aq9DXyBTft3n3l+mWtdqx614Tj0L650nssqFFA2
   DWJeOdooXw9+sfRvqAyIaMag4r7azUXx8ht9rRXGGKZY4kX3UeSvF/P+y
   A==;
X-CSE-ConnectionGUID: ic63BlcPQhK0LdnGpCcD4w==
X-CSE-MsgGUID: JrQz0Y2ZQXm3Bs9xFcN6bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19940336"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="19940336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:59:36 -0700
X-CSE-ConnectionGUID: yEQdJkDYT6ey/of9Y9lvgw==
X-CSE-MsgGUID: 2fpdTJBrSW6a1MTYJRqDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="54259706"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 30 Jul 2024 02:59:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYjdi-000sk4-2O;
	Tue, 30 Jul 2024 09:59:30 +0000
Date: Tue, 30 Jul 2024 17:59:23 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 9/9] mm: Consolidate common checks in
 hugetlb_mmap_check_and_align
Message-ID: <202407301708.tn4PRNvn-lkp@intel.com>
References: <20240729091018.2152-10-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729091018.2152-10-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on s390/features]
[also build test WARNING on akpm-mm/mm-everything deller-parisc/for-next linus/master v6.11-rc1 next-20240730]
[cannot apply to powerpc/next powerpc/fixes arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20240729-171449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240729091018.2152-10-osalvador%40suse.de
patch subject: [PATCH v2 9/9] mm: Consolidate common checks in hugetlb_mmap_check_and_align
config: mips-randconfig-r062-20240729 (https://download.01.org/0day-ci/archive/20240730/202407301708.tn4PRNvn-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301708.tn4PRNvn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301708.tn4PRNvn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/hugetlb.h:792,
                    from kernel/fork.c:53:
   arch/mips/include/asm/hugetlb.h: In function 'prepare_hugepage_range':
>> arch/mips/include/asm/hugetlb.h:20:24: warning: unused variable 'h' [-Wunused-variable]
      20 |         struct hstate *h = hstate_file(file);
         |                        ^


vim +/h +20 arch/mips/include/asm/hugetlb.h

50a41ff292fafe David Daney     2009-05-27  13  
78d6e4e8ea8700 Alexandre Ghiti 2018-10-26  14  #define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
50a41ff292fafe David Daney     2009-05-27  15  static inline int prepare_hugepage_range(struct file *file,
50a41ff292fafe David Daney     2009-05-27  16  					 unsigned long addr,
50a41ff292fafe David Daney     2009-05-27  17  					 unsigned long len)
50a41ff292fafe David Daney     2009-05-27  18  {
50a41ff292fafe David Daney     2009-05-27  19  	unsigned long task_size = STACK_TOP;
50a41ff292fafe David Daney     2009-05-27 @20  	struct hstate *h = hstate_file(file);
50a41ff292fafe David Daney     2009-05-27  21  
50a41ff292fafe David Daney     2009-05-27  22  	if (len > task_size)
50a41ff292fafe David Daney     2009-05-27  23  		return -ENOMEM;
50a41ff292fafe David Daney     2009-05-27  24  	if (task_size - len < addr)
50a41ff292fafe David Daney     2009-05-27  25  		return -EINVAL;
50a41ff292fafe David Daney     2009-05-27  26  	return 0;
50a41ff292fafe David Daney     2009-05-27  27  }
50a41ff292fafe David Daney     2009-05-27  28  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

