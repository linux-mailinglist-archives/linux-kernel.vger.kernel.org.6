Return-Path: <linux-kernel+bounces-403473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DE9C3634
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623DE1F22D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3B34CDD;
	Mon, 11 Nov 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JPRpQQ0H"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641711F94A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289114; cv=none; b=QkcD32AMSqEO1g8z/jCvHf+ON01soowr9dVKpVfbK0FkJwkK+7M2BvFQ3+cmfd/2//jKinzE6NdncQAIX0hM3HcwHRCm8fAlST+kpt148FgJj50BDAI82wo0uyzPDk5edbTvvvaj6FzXqrg1ngv/9iApSvXx7wxJuIxYsqVRn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289114; c=relaxed/simple;
	bh=YlAhbnm1I5k+kU1PvnjADRjTwfieELE3uO4yvcd449A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=j+8s7qgdqTAZQqiJPgWwOIc4M6rVq1MoPOVaJCWC2mNMVwTgbPsQIOBgS7eDZdvikTfdXERte9tzZxFN0/F0C6sLU3ZM2RfeRPjgOUl88NVJce7APlfoI/4CZnuUK+NcI4NQFt1Fd0dGqCIuQAJZdjaUW1qBcurJU3Ysc2WjBSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JPRpQQ0H; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731289108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OOO5xPN3ZUpfGW6Ti+5DdkzIsYWm8WcDbrIu5y57poI=;
	b=JPRpQQ0H9+HJhk8RKeVeaHEUzOncu2dx2vCYJHOkexHNGgtm9pyLWJbH/kxZ1tez4r5OnhXykLSEPVTQdqTLFSXHMsdS7TOiV4z1rMOSOq8yOq4yBtDU3zqws9OfXYmedzXcyNbg1JS9/AXJSRuHXtURuMiZWEtRE7388Yk/xlw=
Received: from 30.221.129.158(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJ3xLg5_1731289107 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 09:38:28 +0800
Message-ID: <614f6304-f096-41f7-b0a4-05127904e601@linux.alibaba.com>
Date: Mon, 11 Nov 2024 09:38:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: update seq_file index in ocfs2_dlm_seq_next
To: Wengang Wang <wen.gang.wang@oracle.com>, ocfs2-devel@lists.linux.dev
References: <20241108192829.58813-1-wen.gang.wang@oracle.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20241108192829.58813-1-wen.gang.wang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/24 3:28 AM, Wengang Wang wrote:
> The following INFO level message was seen:
> 
> seq_file: buggy .next function ocfs2_dlm_seq_next [ocfs2] did not
> update position index
> 
> Fix:
> Updata m->index to make seq_read_iter happy though the index its self makes
> no sense to ocfs2_dlm_seq_next.
> 
> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
> ---
>  fs/ocfs2/dlmglue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 60df52e4c1f8..349d131369cf 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3120,6 +3120,7 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
>  	}
>  	spin_unlock(&ocfs2_dlm_tracking_lock);
>  
> +	m->index++;

We can directly use '(*pos)++' instead.

Thanks,
Joseph

>  	return iter;
>  }
>  


