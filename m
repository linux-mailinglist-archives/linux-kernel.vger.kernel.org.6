Return-Path: <linux-kernel+bounces-435863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C55799E7E0D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88ECD1885AC2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D3200A0;
	Sat,  7 Dec 2024 02:55:46 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541F8BE8
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733540146; cv=none; b=Mg9xPoR0QD0n3R6CRGfUKJNpDXjOHmDqExRGOtq8GJkBeKcnSL6TPyVADmLbsk0fVKllmwK2ISL4aKBli06dQeiPrbBD1jZ1BrHv5JZTGgcMQ+7N2oNZ0f2lizOg9kas2cnt89K1auRY0C+FkHL+Cf/IbSECjzAtJfQOl8CpjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733540146; c=relaxed/simple;
	bh=MRcCbHQUBhmS00nVrTauRhvP/NK0uyMvcsma6GHdeO0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DXMbKOrMqvzgauxYRxQKdZh1b4oOgzm7DinbjztmPrHCpVQIS8qz4nF9NXy3CUGgi5w6X4TYHs19YekeFl0wTUFOTrU/MT4PDirTaj4I3eeOynKBkehNAUDv0ZBR+mYGm2Exwuinp53RJ2B/tviTHRX9DUaJcLT5DB0V3Kr3X3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Y4t2v6lQPz11M1T;
	Sat,  7 Dec 2024 10:52:39 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 36F6E1800FD;
	Sat,  7 Dec 2024 10:55:40 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 7 Dec 2024 10:55:39 +0800
Subject: Re: [PATCH] ubifs/debug: remove return from end of void function
To: Pintu Kumar <quic_pintu@quicinc.com>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>
References: <20241206125258.9212-1-quic_pintu@quicinc.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e43da923-0184-d41e-a273-a02848f3b671@huawei.com>
Date: Sat, 7 Dec 2024 10:55:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241206125258.9212-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/6 20:52, Pintu Kumar Ð´µÀ:
> Noticed that there is a useless return statement at the end of void
> function ubifs_dump_leb().
> Just removed it.
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> ---
>   fs/ubifs/debug.c | 1 -
>   1 file changed, 1 deletion(-)

Hi, Pintu. The title of the patch should be something like "ubifs: 
ubifs_dump_leb: remove return at end of void function". See 
Documentation/process/submitting-patches.rst. Otherwise,

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

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


