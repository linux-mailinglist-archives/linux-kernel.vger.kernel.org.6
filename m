Return-Path: <linux-kernel+bounces-201798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2018FC354
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC5428715C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A294121C19D;
	Wed,  5 Jun 2024 06:15:27 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222813AA4D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717568127; cv=none; b=RYPWWTIdn+vuouZusNBaR7Uf3zXKmBPko4qPTcSYAbtGeD75rZJn0IBg/HNa04apwgBKRcGMgP87rYkOPkz8IBG2DTJgSipwqaq5tHMGZVTyIbUVNhdB1rCTqo1reWkvkfKyCk3MBFBlPo0vtgRqDm8sVpE561Y+VAaMD7ikxT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717568127; c=relaxed/simple;
	bh=/iJbGKJSbqnXsv1mQbSvBzVkuAfvVdIf4m4RBhK/cS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e3XQzucnwNJd2FDb8V4WkxfSB+sQbxbqMkMmXtLRaJrnPfk4xy4zhJKN/aTbIq8m1HvfIEZ/YSN3rAfoD+mjCNfhn2nqoX3h3UXrQTer8065wV5h09SFb16ecnJMo0mW4hHhTtLE3b2iMpYn+gumWTT5qfH5aaC9HRjpERcuTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VvHCn6NvWz1S63h;
	Wed,  5 Jun 2024 14:11:33 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 74C6C1A0188;
	Wed,  5 Jun 2024 14:15:15 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 14:15:15 +0800
Message-ID: <84a65024-d96c-3fa5-c015-98130ee82ccb@huawei.com>
Date: Wed, 5 Jun 2024 14:15:14 +0800
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
To: Dan Carpenter <dan.carpenter@linaro.org>, <oe-kbuild@lists.linux.dev>,
	<akpm@linux-foundation.org>, <muchun.song@linux.dev>
CC: <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <87bca9ca-0c3e-449a-b121-eee7b84dc2ed@moroto.mountain>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <87bca9ca-0c3e-449a-b121-eee7b84dc2ed@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/5 13:24, Dan Carpenter wrote:
> Hi Xiu,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xiu-Jianfeng/mm-hugetlb_cgroup-identify-the-legacy-using-cgroup_subsys_on_dfl/20240603-201513
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240603120506.1837322-3-xiujianfeng%40huawei.com
> patch subject: [PATCH -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on template
> config: i386-randconfig-r071-20240604 (https://download.01.org/0day-ci/archive/20240605/202406050210.OWthxCFt-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202406050210.OWthxCFt-lkp@intel.com/
> 
> smatch warnings:
> mm/hugetlb_cgroup.c:828 hugetlb_cgroup_cfttypes_init() warn: this array is probably non-NULL. 'tmpl->name'
> 
> vim +828 mm/hugetlb_cgroup.c
> 
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  815  static void __init
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  816  hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  817  			     struct cftype *tmpl, int tmpl_size)
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  818  {
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  819  	char buf[32];
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  820  	int i, idx = hstate_index(h);
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  821  
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  822  	/* format the size */
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  823  	mem_fmt(buf, sizeof(buf), huge_page_size(h));
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  824  
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  825  	for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  826  		*cft = *tmpl;
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  827  		/* rebuild the name */
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03 @828  		if (tmpl->name)
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  829  			snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
> 
> tmpl->name is an array so it's non-NULL.  Just do the snprintf().  No
> need for the if statement.

Hi Dan,

Thanks for you review, will fix in the next version.

> 
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  830  		/* rebuild the private */
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  831  		if (tmpl->private)
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  832  			cft->private = MEMFILE_PRIVATE(idx, tmpl->private);
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  833  		/* rebuild the file_offset */
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  834  		if (tmpl->file_offset) {
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  835  			unsigned int offset = tmpl->file_offset;
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  836  
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  837  			cft->file_offset = MEMFILE_OFFSET0(offset) +
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  838  					   MEMFILE_FIELD_SIZE(offset) * idx;
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  839  		}
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  840  	}
> 66bcc9ace99241 Xiu Jianfeng 2024-06-03  841  }
> 

