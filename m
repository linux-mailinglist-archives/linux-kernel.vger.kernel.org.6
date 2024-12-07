Return-Path: <linux-kernel+bounces-435862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85B09E7E0C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746D31885981
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5371AAC4;
	Sat,  7 Dec 2024 02:54:55 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC522C6EB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733540094; cv=none; b=itEzvqieEmpJ5AivGhsw2CcwSQaE1cB0j3qmW1lB0wHIzeWvSXBauNyDLWuDWxJezNlNdNHbwIDRFAei8ZsruB0UDW7lpnRSjRzvubXSYvIuFjYi8XOw+5f5KcQUZo0wHDdHbpXmW8/StsyY7UC54BU096hRxK5C/0RQCBK+pm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733540094; c=relaxed/simple;
	bh=lRpNvy3F6D+u8dxPzbrBWrX6F/f8Kk5CDUEneiVefgI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=StGgF0meg/db4k+KTZOBxueLXqhprlj36SxMER9BPUCYrVcpBBXHWXC5yC7dE+BeqeWOvh0xf+oR0g/VgzJtkt2GaDOyTe3rMxJAVYqqqnbu0W1wYgowlaKjjSdMSuAh88IUGLXUusK1RBT5hGBwrURyotS+avMcrg81oUjJ1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y4t3S3jyCz21mcX;
	Sat,  7 Dec 2024 10:53:08 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id B0B8B1402CA;
	Sat,  7 Dec 2024 10:54:48 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Dec 2024 10:54:48 +0800
Subject: Re: [PATCH] ubifs/lpt_commit: remove return at end of void function
To: Pintu Kumar <quic_pintu@quicinc.com>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>
References: <20241206130511.32592-1-quic_pintu@quicinc.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <abe79e0a-a35f-0b53-bbec-7d642f592fae@huawei.com>
Date: Sat, 7 Dec 2024 10:54:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241206130511.32592-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/6 21:05, Pintu Kumar Ð´µÀ:
> Noticed that there is a useless return statement at the end of void
> function dump_lpt_leb().
> Just removing it.
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> ---
>   fs/ubifs/lpt_commit.c | 1 -
>   1 file changed, 1 deletion(-)

Hi, Pintu. The title of the patch should be something like "ubifs: 
dump_lpt_leb: remove return at end of void function". See 
Documentation/process/submitting-patches.rst. Otherwise,

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> 
> diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
> index aa8837e6247c..f2cb214581fd 100644
> --- a/fs/ubifs/lpt_commit.c
> +++ b/fs/ubifs/lpt_commit.c
> @@ -1932,7 +1932,6 @@ static void dump_lpt_leb(const struct ubifs_info *c, int lnum)
>   	pr_err("(pid %d) finish dumping LEB %d\n", current->pid, lnum);
>   out:
>   	vfree(buf);
> -	return;
>   }
>   
>   /**
> 


