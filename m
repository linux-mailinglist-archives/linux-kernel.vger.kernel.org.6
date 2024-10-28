Return-Path: <linux-kernel+bounces-384012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECF9B2339
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C822280F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE8188906;
	Mon, 28 Oct 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yiJekmoR"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA318871E;
	Mon, 28 Oct 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083944; cv=none; b=QR1ecjqyWNSG46XAYFrBiz5v9FdHMYgIcXFA2Ial3HO4tb0ldWw37orX9/wf6i9o3D6m2XpSJsJERTJwjRJN/jfscAgS0QJ6EDzOEJK5/XTcm9SqG8AlSnzVP3N7zvdptpEvSwUo7cm0abTJDggZA/f+HXavUg1BxTHvfOgF0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083944; c=relaxed/simple;
	bh=HAVLsqK9UzwLDQUVoiCRHNdhEfmVKcdLiNiMKd+cyk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko8HeIX6OXtKaZkn4DsEtiUP+HowiQqMId7UV7GccyVGK8oI1Gb/cMkJIOGNjB9ODvGcosVckjbuXvnPJdOpcJfMVw/9SThxvdC1A+v6u41/8YmPz3DOf0z4G6Sx+3X/v5MMnZQAzLQHvOQULLe53HoOCHe1GVd/YcReK+hSwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yiJekmoR; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730083932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=b5yQ4YFvkLKgKnnUbCI5wEBIs+r+JY9U+CGgILijEGQ=;
	b=yiJekmoR1ejtIgL9S/jKRrUScXBex0DM5casJsmbiaiExcsC9D5SX1kt6IUuloho5XM4jquF/Du6xuE4ywGAglvSg21C/HtqGNqvf55T5s1HYf9n23Zv3fgLRfVMtlcLUBgBXJcCGpJ7hOrAfdHlaUUA1vA1oiA50VRmqygfPb8=
Received: from 30.221.129.41(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WHzAHht_1730083931 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 10:52:11 +0800
Message-ID: <42fec340-eedc-41b2-9f27-2e41c92d2bba@linux.alibaba.com>
Date: Mon, 28 Oct 2024 10:52:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: cluster: fix a typo
To: Andrew Kreimer <algonell@gmail.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20241027133540.22090-1-algonell@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241027133540.22090-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/24 9:35 PM, Andrew Kreimer wrote:
> Fix a typo: panicing -> panicking.
> 
> Via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/cluster/quorum.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
> index 15d0ed9c13e5..8bf17231d7b7 100644
> --- a/fs/ocfs2/cluster/quorum.c
> +++ b/fs/ocfs2/cluster/quorum.c
> @@ -60,7 +60,7 @@ static void o2quo_fence_self(void)
>  	switch (o2nm_single_cluster->cl_fence_method) {
>  	case O2NM_FENCE_PANIC:
>  		panic("*** ocfs2 is very sorry to be fencing this system by "
> -		      "panicing ***\n");
> +		      "panicking ***\n");
>  		break;
>  	default:
>  		WARN_ON(o2nm_single_cluster->cl_fence_method >=


