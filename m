Return-Path: <linux-kernel+bounces-209183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807B902E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BC81F21B58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA315ADA4;
	Tue, 11 Jun 2024 02:29:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977E8C04
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072982; cv=none; b=Pb4NfqPznLdjmxaWCZbMpEQY0hHkSFjyLMP9F6xy0wn1MKTQC3rcXxLZy6ys8q/G58QbOE+1mTtVpoIPrOjJ0k78ghsWSpXfZ4pHNP3cNlryhzOvEDr0nVoY9+JsycnVClO0tX1549Jzhf3eXbwhPMpbXResuuAra7WrH1/1S4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072982; c=relaxed/simple;
	bh=dZ6nyUr+BGvstEqi7iOz/SBB23f8mi6bA92iIq2tSww=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=FaJDJeDh+1MpqfE/nzLIbq2wu/jovmNR5v1ObktU4Hrsw0E/JNmM1jDNuXZC4YhDQjaDyBzVrVRERczdlCXX5xi54eaCdejaGgQoqfjIfEtkMtJjpgmx5fM6plYVD/VHhkYe8kyFuMK69KEwr1sZ7HGG1VoHHwkzT+gg872uHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VysvP5Rx8zmZ06;
	Tue, 11 Jun 2024 10:24:49 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 89E6118007C;
	Tue, 11 Jun 2024 10:29:31 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 10:29:29 +0800
Message-ID: <ff7f7d2d-d5fc-2839-cbdb-9bab767bc00f@huawei.com>
Date: Tue, 11 Jun 2024 10:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 -next 2/3] mm/hugetlb_cgroup: prepare cftypes based on
 template
Content-Language: en-US
From: xiujianfeng <xiujianfeng@huawei.com>
To: <akpm@linux-foundation.org>, <muchun.song@linux.dev>, Oscar Salvador
	<osalvador@suse.de>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240605070133.1941677-1-xiujianfeng@huawei.com>
 <20240605070133.1941677-3-xiujianfeng@huawei.com>
In-Reply-To: <20240605070133.1941677-3-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/5 15:01, Xiu Jianfeng wrote:
> Unlike other cgroup subsystems, the hugetlb cgroup does not provide
> a static array of cftype that explicitly displays the properties,
> handling functions, etc., of each file. Instead, it dynamically creates
> the attribute of cftypes based on the hstate during the startup
> procedure. This reduces the readability of the code.
> 
> To fix this issue, introduce two templates of cftypes, and rebuild the
> attributes according to the hstate to make it ready to be added to
> cgroup framework.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  mm/hugetlb_cgroup.c | 155 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 45f94a869776..56876b61027d 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -27,7 +27,16 @@
>  #define MEMFILE_IDX(val)	(((val) >> 16) & 0xffff)
>  #define MEMFILE_ATTR(val)	((val) & 0xffff)
>  
> +#define MEMFILE_OFFSET(t, m)	(((offsetof(t, m) << 16) | sizeof_field(t, m)))
> +#define MEMFILE_OFFSET0(val)	(((val) >> 16) & 0xffff)
> +#define MEMFILE_FIELD_SIZE(val)	((val) & 0xffff)
> +
> +#define DFL_TMPL_SIZE		ARRAY_SIZE(hugetlb_dfl_tmpl)
> +#define LEGACY_TMPL_SIZE	ARRAY_SIZE(hugetlb_legacy_tmpl)
> +
>  static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
> +static struct cftype *dfl_files;
> +static struct cftype *legacy_files;
>  
>  static inline struct page_counter *
>  __hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
> @@ -702,12 +711,142 @@ static int hugetlb_events_local_show(struct seq_file *seq, void *v)
>  	return __hugetlb_events_show(seq, true);
>  }
>  
> +static struct cftype hugetlb_dfl_tmpl[] = {
> +	{
> +		.name = "max",
> +		.private = RES_LIMIT,
> +		.seq_show = hugetlb_cgroup_read_u64_max,
> +		.write = hugetlb_cgroup_write_dfl,
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	{
> +		.name = "rsvd.max",
> +		.private = RES_RSVD_LIMIT,
> +		.seq_show = hugetlb_cgroup_read_u64_max,
> +		.write = hugetlb_cgroup_write_dfl,
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	{
> +		.name = "current",
> +		.private = RES_USAGE,
> +		.seq_show = hugetlb_cgroup_read_u64_max,
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	{
> +		.name = "rsvd.current",
> +		.private = RES_RSVD_USAGE,
> +		.seq_show = hugetlb_cgroup_read_u64_max,
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	{
> +		.name = "events",
> +		.seq_show = hugetlb_events_show,
> +		.file_offset = MEMFILE_OFFSET(struct hugetlb_cgroup, events_file[0]),
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	{
> +		.name = "events.local",
> +		.seq_show = hugetlb_events_local_show,
> +		.file_offset = MEMFILE_OFFSET(struct hugetlb_cgroup, events_local_file[0]),
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	{
> +		.name = "numa_stat",
> +		.seq_show = hugetlb_cgroup_read_numa_stat,
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +	},
> +	/* don't need terminator here */
> +};
> +
> +static struct cftype hugetlb_legacy_tmpl[] = {
> +	{
> +		.name = "limit_in_bytes",
> +		.private = RES_LIMIT,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +		.write = hugetlb_cgroup_write_legacy,
> +	},
> +	{
> +		.name = "rsvd.limit_in_bytes",
> +		.private = RES_RSVD_LIMIT,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +		.write = hugetlb_cgroup_write_legacy,
> +	},
> +	{
> +		.name = "usage_in_bytes",
> +		.private = RES_USAGE,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +	},
> +	{
> +		.name = "rsvd.usage_in_bytes",
> +		.private = RES_RSVD_USAGE,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +	},
> +	{
> +		.name = "max_usage_in_bytes",
> +		.private = RES_MAX_USAGE,
> +		.write = hugetlb_cgroup_reset,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +	},
> +	{
> +		.name = "rsvd.max_usage_in_bytes",
> +		.private = RES_RSVD_MAX_USAGE,
> +		.write = hugetlb_cgroup_reset,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +	},
> +	{
> +		.name = "failcnt",
> +		.private = RES_FAILCNT,
> +		.write = hugetlb_cgroup_reset,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +	},
> +	{
> +		.name = "rsvd.failcnt",
> +		.private = RES_RSVD_FAILCNT,
> +		.write = hugetlb_cgroup_reset,
> +		.read_u64 = hugetlb_cgroup_read_u64,
> +	},
> +	{
> +		.name = "numa_stat",
> +		.seq_show = hugetlb_cgroup_read_numa_stat,
> +	},
> +	/* don't need terminator here */
> +};
> +
> +static void __init
> +hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
> +			     struct cftype *tmpl, int tmpl_size)
> +{
> +	char buf[32];
> +	int i, idx = hstate_index(h);
> +
> +	/* format the size */
> +	mem_fmt(buf, sizeof(buf), huge_page_size(h));
> +
> +	for (i = 0; i < tmpl_size; cft++, tmpl++, i++) {
> +		*cft = *tmpl;
> +		/* rebuild the name */
> +		snprintf(cft->name, MAX_CFTYPE_NAME, "%s.%s", buf, tmpl->name);
> +		/* rebuild the private */
> +		if (tmpl->private)
> +			cft->private = MEMFILE_PRIVATE(idx, tmpl->private);

I found there is a problem here, the if (tmpl->private) statment should
be dropped, and the cft->private should be reassigned unconditionally
according to the idx of the hstate, because the .private in the
templates only represents the second argument of the MEMFILE_PRIVATE().

But cft->file_offset is a bit different; it does not need to be assigned
unless it is required, its usage is as follows:

int cgroup_add_file(...)
{
...
if (cft->file_offset) {
    struct cgroup_file *cfile = (void *)css + cft->file_offset;
    ...
}
...
}

I will fix it in the next version.

> +		/* rebuild the file_offset */
> +		if (tmpl->file_offset) {
> +			unsigned int offset = tmpl->file_offset;
> +			cft->file_offset = MEMFILE_OFFSET0(offset) +
> +					   MEMFILE_FIELD_SIZE(offset) * idx;
> +		}
> +	}
> +}
> +
>  static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  {
>  	char buf[32];
>  	struct cftype *cft;
>  	struct hstate *h = &hstates[idx];
>  
> +	hugetlb_cgroup_cfttypes_init(h, dfl_files + idx * DFL_TMPL_SIZE,
> +				     hugetlb_dfl_tmpl, DFL_TMPL_SIZE);
> +
>  	/* format the size */
>  	mem_fmt(buf, sizeof(buf), huge_page_size(h));
>  
> @@ -779,6 +918,9 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>  	struct cftype *cft;
>  	struct hstate *h = &hstates[idx];
>  
> +	hugetlb_cgroup_cfttypes_init(h, legacy_files + idx * LEGACY_TMPL_SIZE,
> +				     hugetlb_legacy_tmpl, LEGACY_TMPL_SIZE);
> +
>  	/* format the size */
>  	mem_fmt(buf, sizeof(buf), huge_page_size(h));
>  
> @@ -856,10 +998,23 @@ static void __init __hugetlb_cgroup_file_init(int idx)
>  	__hugetlb_cgroup_file_legacy_init(idx);
>  }
>  
> +static void __init __hugetlb_cgroup_file_pre_init(void)
> +{
> +	int cft_count;
> +
> +	cft_count = hugetlb_max_hstate * DFL_TMPL_SIZE + 1; /* add terminator */
> +	dfl_files = kcalloc(cft_count, sizeof(struct cftype), GFP_KERNEL);
> +	BUG_ON(!dfl_files);
> +	cft_count = hugetlb_max_hstate * LEGACY_TMPL_SIZE + 1; /* add terminator */
> +	legacy_files = kcalloc(cft_count, sizeof(struct cftype), GFP_KERNEL);
> +	BUG_ON(!legacy_files);
> +}
> +
>  void __init hugetlb_cgroup_file_init(void)
>  {
>  	struct hstate *h;
>  
> +	__hugetlb_cgroup_file_pre_init();
>  	for_each_hstate(h)
>  		__hugetlb_cgroup_file_init(hstate_index(h));
>  }

