Return-Path: <linux-kernel+bounces-437783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B989E9892
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFE7282F02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10491A2397;
	Mon,  9 Dec 2024 14:17:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8B1798F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753821; cv=none; b=mmlv5rD0oLEOIHUplrLU+6ff8RwBkKD8d8cMXf1anjiwCHw0RMk/5CcratcQW9hWTUDXKQ+U1crSgZYRpuEugvXcTYQPygvtDerkITylwx5EPdV7jmfm3q8ZcPj6oFstc6S7MXNnxK1wQjrFoS8zG/vnWFXjiknOOKedx7BbHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753821; c=relaxed/simple;
	bh=Lg8V3q7O0ZK1PwZj9SOcYfskU+QqeTmcFmwFz48gPtE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VOOVPQyS5jwh+fhSK1i53i8Xwz3pPqTMT0Pkyn2iaz42ACZ82ahiLqLJHbK+FyTg2VXcfqgvirjOvkNO65xDHNf1zPRgRuUnfokRT23bEKSpCQJVPOQo4YybgWoD5PmG/0/PLcUh+zr4UalTdSpqkR87VBoWGeRzNMXGOtcv/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y6P4m0YyKz2Dh7m;
	Mon,  9 Dec 2024 22:14:32 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CE4D1A016C;
	Mon,  9 Dec 2024 22:16:55 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 22:16:54 +0800
Subject: Re: [PATCH v2] ubifs: dump_lpt_leb: remove return at end of void
 function
To: Pintu Kumar <quic_pintu@quicinc.com>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>
References: <20241209135936.13229-1-quic_pintu@quicinc.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c5f85328-04d4-0653-4202-c3b3d7f92bfe@huawei.com>
Date: Mon, 9 Dec 2024 22:16:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209135936.13229-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/12/9 21:59, Pintu Kumar Ð´µÀ:
> Noticed that there is a useless return statement at the end of void
> function dump_lpt_leb().
> Just removing it.
> 
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> Changes in V2:
> Change commit title as suggested by Zhihao Cheng.
> V1: https://lore.kernel.org/all/abe79e0a-a35f-0b53-bbec-7d642f592fae@huawei.com/
> ---
>   fs/ubifs/lpt_commit.c | 1 -
>   1 file changed, 1 deletion(-)
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


