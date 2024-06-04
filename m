Return-Path: <linux-kernel+bounces-199898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B088FA76B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21761C23468
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9087A8F6A;
	Tue,  4 Jun 2024 01:16:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E58472
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717463794; cv=none; b=jjgxa01CIP1cBkrFwt/cGu494h929wxwcf97vj+hHF5Ok6QvrLK+ePJVQbrdXOGRFmsh1XKYVcGB9MDOtlBrYqrgIFLZPj4vq1shnBpRQLYWll6h/SEzzQfKlxX/sfM4tbHTi5PTiGLWfBqTzxi3eDhZk0wxTQg1iLPO9cVvIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717463794; c=relaxed/simple;
	bh=Eqh/AtuHMdxOjBiZKaHZvSpUFcM+NAehA9EHqDldqTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k6LgHsqQe/gSfNjs6UXrSBR5IMu9gQw60xOjfTqHVGsSe2LfAejvQbdK/Nq0A5Tn69kqEnOeWndBKHf6U8k6NQ/+JCw+Ag46c4vDQ8PFXOcZdfFBhCgtKE6h0a9f2Al//lKaFWHlaEfB9usiR81y0wK+ctmylmrZT/kT3cf1mAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VtXdD3dyczxPxC;
	Tue,  4 Jun 2024 09:12:32 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id BBEE9140109;
	Tue,  4 Jun 2024 09:16:27 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 09:16:27 +0800
Message-ID: <3b030437-4571-7a87-55e0-5fc3f5711a6e@huawei.com>
Date: Tue, 4 Jun 2024 09:16:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on
 template
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, <akpm@linux-foundation.org>,
	<muchun.song@linux.dev>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240603120506.1837322-3-xiujianfeng@huawei.com>
 <202406040437.z2Iel9db-lkp@intel.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <202406040437.z2Iel9db-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/4 5:25, kernel test robot wrote:
> Hi Xiu,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xiu-Jianfeng/mm-hugetlb_cgroup-identify-the-legacy-using-cgroup_subsys_on_dfl/20240603-201513
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240603120506.1837322-3-xiujianfeng%40huawei.com
> patch subject: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on template
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240604/202406040437.z2Iel9db-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040437.z2Iel9db-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406040437.z2Iel9db-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    mm/hugetlb_cgroup.c: In function 'hugetlb_cgroup_cfttypes_init':
>>> mm/hugetlb_cgroup.c:828:21: warning: the comparison will always evaluate as 'true' for the address of 'name' will never be NULL [-Waddress]
>      828 |                 if (tmpl->name)
>          |                     ^~~~
>    In file included from include/linux/cgroup.h:27,
>                     from mm/hugetlb_cgroup.c:20:
>    include/linux/cgroup-defs.h:605:14: note: 'name' declared here
>      605 |         char name[MAX_CFTYPE_NAME];
>          |              ^~~~
> 

Thanks, will fix in the next version.

> 
> vim +828 mm/hugetlb_cgroup.c
> 
>    814	
>    815	static void __init
>    816	hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>    817				     struct cftype *tmpl, int tmpl_size)
>    818	{
>    819		char buf[32];
>    820		int i, idx = hstate_index(h);
>    821	
>    822		/* format the size */
>    823		mem_fmt(buf, sizeof(buf), huge_page_size(h));
>    824	
>    825		for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
>    826			*cft = *tmpl;
>    827			/* rebuild the name */
>  > 828			if (tmpl->name)
>    829				snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
>    830			/* rebuild the private */
>    831			if (tmpl->private)
>    832				cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
>    833			/* rebuild the file_offset */
>    834			if (tmpl->file_offset) {
>    835				unsigned int offset = tmpl->file_offset;
>    836	
>    837				cft->file_offset = MEMFILE_OFFSET0(offset) +
>    838						   MEMFILE_FIELD_SIZE(offset) * idx;
>    839			}
>    840		}
>    841	}
>    842	
> 

