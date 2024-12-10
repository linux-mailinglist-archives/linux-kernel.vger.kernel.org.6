Return-Path: <linux-kernel+bounces-438668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC2F9EA41F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CB280D01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812A1EB5B;
	Tue, 10 Dec 2024 01:10:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF841C72
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793047; cv=none; b=MGSF2rpWvDw3uLw1YlR9032US9K6kMChQ0TycS3Zv3Io2cNQ6td9lX+BUuDnrZqLmwe/gGKnIjH8OpbGI/28HlqWUC8xkIH41iKxga3z1tG067LWZPETzWwnSuJFaBg7zq2bldA1VRw7GN0lS4unFPv+N6gyHBytPVUyccqvKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793047; c=relaxed/simple;
	bh=YxaPcvpODXqDnxgTTNijFMbuXVleCtd9cK+F9f5aL4s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tDH6MkmeMnrqIGZ36z+fu8mR2I8tyA5kCqFfhqoqm66IxRSpCMf5KOQKsiZs4xtUEM+kUN/sWQgpzFJrS3dwZwyH+J2yTnOnT/jUm7Wq2NGXiOPV2M0+MkPlet8m6HW95EE8UXSx62ffpwdtoj2zlO8fNzihY1Rr0Q17hxRZ1hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y6gbl64b3z21mGR;
	Tue, 10 Dec 2024 09:08:51 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 3334514010C;
	Tue, 10 Dec 2024 09:10:35 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 09:10:34 +0800
Subject: Re: [PATCH v2] ubifs: ubifs_dump_leb: remove return from end of void
 function
To: Pintu Kumar <quic_pintu@quicinc.com>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>
References: <20241209162104.15331-1-quic_pintu@quicinc.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <17a995ba-5088-7a67-2e84-e0d7633c95f0@huawei.com>
Date: Tue, 10 Dec 2024 09:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209162104.15331-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/10 0:21, Pintu Kumar Ð´µÀ:
> Noticed that there is a useless return statement at the end of void
> function ubifs_dump_leb().
> Just removed it.
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> Changes in V2:
> Change commit title as suggested by Zhihao Cheng.
> V1: https://lore.kernel.org/all/e43da923-0184-d41e-a273-a02848f3b671@huawei.com/
> ---
>   fs/ubifs/debug.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> index 5cc69beaa62e..987eb5b6782a 100644
> --- a/fs/ubifs/debug.c
> +++ b/fs/ubifs/debug.c
> @@ -863,7 +863,6 @@ void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
>   
>   out:
>   	vfree(buf);
> -	return;
>   }
>   
>   void ubifs_dump_znode(const struct ubifs_info *c,
> 


