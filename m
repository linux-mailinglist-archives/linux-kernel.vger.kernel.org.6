Return-Path: <linux-kernel+bounces-209182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE77902E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1171C21BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C393C15ADA4;
	Tue, 11 Jun 2024 02:29:02 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D58C04
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072942; cv=none; b=WD/K8ssbxanIROJg7vIGrSLIU7ILn/DfdpUUh+fshTLH/tgC/2+WqZMd9GJAfvsCrFKmkpHvzcmd05QCATqCOVXH2VmxWtMvPaIK8ahc341VPHCdfZcL6+Om8u9q+K7EgYRxClCd1Hm9vnIfGTIsCZA44UlWOQGFPICaIlBbjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072942; c=relaxed/simple;
	bh=wRRaHIRbGSEyP4emDGB1kR9GyFY+tZkrm2SssqU5Msc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NngeBjQbcDpU0QHMH8lMmAf1yZhRQPOgB8+v1SHVKCJKOJzwK/OUzj3evB2Uozc92Jshv7GoFLblpGff7FrvTGTILnKLp59L+al8NYVxzLTJwRvuTuJYh8V4whhyiGPoeVG+NqQaUek53m9rN42n3Kwnk1c6Hqr2v+jnVQeUbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VysvL4xBnz1SBhH;
	Tue, 11 Jun 2024 10:24:46 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 95C1514041A;
	Tue, 11 Jun 2024 10:28:50 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 10:28:50 +0800
Message-ID: <01e9ccca-c266-face-6854-40b2d6020a16@huawei.com>
Date: Tue, 11 Jun 2024 10:28:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 -next 1/3] mm/hugetlb_cgroup: identify the legacy using
 cgroup_subsys_on_dfl()
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>
CC: <akpm@linux-foundation.org>, <muchun.song@linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240605070133.1941677-1-xiujianfeng@huawei.com>
 <20240605070133.1941677-2-xiujianfeng@huawei.com>
 <ZmaJMqqc4myJNUEm@localhost.localdomain>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZmaJMqqc4myJNUEm@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/10 13:03, Oscar Salvador wrote:
> On Wed, Jun 05, 2024 at 07:01:31AM +0000, Xiu Jianfeng wrote:
>> Currently the numa_stat file encodes 1 into private using the micro
>> MEMFILE_PRIVATE() to identify the legacy. Actually, we can use
>> cgroup_subsys_on_dfl() instead. This is helpful to handle .private
>> in the static array of the comming patch.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Nit below:
> 
>> ---
>>  mm/hugetlb_cgroup.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index e20339a346b9..45f94a869776 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -460,7 +460,7 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
>>  	int nid;
>>  	struct cftype *cft = seq_cft(seq);
>>  	int idx = MEMFILE_IDX(cft->private);
>> -	bool legacy = MEMFILE_ATTR(cft->private);
>> +	bool legacy = !cgroup_subsys_on_dfl(hugetlb_cgrp_subsys);
>>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
>>  	struct cgroup_subsys_state *css;
>>  	unsigned long usage;
>> @@ -839,7 +839,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>>  	/* Add the numa stat file */
>>  	cft = &h->cgroup_files_legacy[8];
>>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, 1);
>> +	cft->private = MEMFILE_PRIVATE(idx, 0);
> 
> Do we still have to set it to '0'?
> Is it not by default?
> 

Hi Oscar,

Thanks for your review.

Not all files care about the value of the second argument of
MEMFILE_PRIVATE(), but all files care about the value of the first
argument 'idx', so the .private must be explicitly set, and passing 0 as
the second argument can be treated as 'not caring what its value is'.

Setting it to 0 or 1 does not affect the functionality, but it makes the
semantics more clear, IMO.

However, you've reminded me that the reassignment of .private in the
second patch is problematic, and I will make a comment on that patch.

