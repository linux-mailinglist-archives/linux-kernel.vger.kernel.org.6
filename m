Return-Path: <linux-kernel+bounces-169256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C18BC5C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32E32812A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE35940847;
	Mon,  6 May 2024 02:29:13 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE413D966
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962553; cv=none; b=pnPkE3s7mu5X7ToIDJiFOwmF8Riok9axA7ZMKLDAfH3q0kH7OotUBNm1LrH/8TGbXmbw8Gi99difzYOvI74s+rNxjk5JGhc3dxd+pFOpqwoUWRSkdJOUKzAQGlOH/QqHYC3wVXhJxeYNsvJPTXbRRTR5bqYaJOPGtDkUHQiw8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962553; c=relaxed/simple;
	bh=BiXbc1aIRlL+2+nMpyqZw2TtlPtUUBy/7U6HwAqoeVk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WP/7TZyUHK2o85/lPH8n0lrU9Rtg7SXbyVk561lkAlzjLx3ndft9itlibM0UeOiOT/lnWH+EYkm0ckrjRgoBtdQy/8BDYaaJJtwKRBkI4/vE+Aw6ZBUEpy/yBYcfdC4Q66p9D7j6rV3Ao9mM2JkICGLerNIapAhwJ0bNqTBs5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VXlHr0jrCz1xmcT;
	Mon,  6 May 2024 10:10:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D21971A016C;
	Mon,  6 May 2024 10:11:54 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:11:54 +0800
Subject: Re: [PATCH] ubifs: fix kernel-doc warnings
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Richard Weinberger
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240502-ubifs-kdoc-v1-1-59c35a325141@quicinc.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c94ba482-0b3a-e8c0-0990-dcb5507148c6@huawei.com>
Date: Mon, 6 May 2024 10:11:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240502-ubifs-kdoc-v1-1-59c35a325141@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/5/3 4:16, Jeff Johnson 写道:
> make C=1 reports the following kernel-doc warnings:
> 
> fs/ubifs/compress.c:103: warning: Function parameter or struct member 'c' not described in 'ubifs_compress'
> fs/ubifs/compress.c:155: warning: Function parameter or struct member 'c' not described in 'ubifs_decompress'
> fs/ubifs/find.c:353: warning: Excess function parameter 'data' description in 'scan_for_free_cb'
> fs/ubifs/find.c:353: warning: Function parameter or struct member 'arg' not described in 'scan_for_free_cb'
> fs/ubifs/find.c:594: warning: Excess function parameter 'data' description in 'scan_for_idx_cb'
> fs/ubifs/find.c:594: warning: Function parameter or struct member 'arg' not described in 'scan_for_idx_cb'
> fs/ubifs/find.c:786: warning: Excess function parameter 'data' description in 'scan_dirty_idx_cb'
> fs/ubifs/find.c:786: warning: Function parameter or struct member 'arg' not described in 'scan_dirty_idx_cb'
> fs/ubifs/find.c:86: warning: Excess function parameter 'data' description in 'scan_for_dirty_cb'
> fs/ubifs/find.c:86: warning: Function parameter or struct member 'arg' not described in 'scan_for_dirty_cb'
> fs/ubifs/journal.c:369: warning: expecting prototype for wake_up_reservation(). Prototype was for add_or_start_queue() instead
> fs/ubifs/lprops.c:1018: warning: Excess function parameter 'lst' description in 'scan_check_cb'
> fs/ubifs/lprops.c:1018: warning: Function parameter or struct member 'arg' not described in 'scan_check_cb'
> fs/ubifs/lpt.c:1938: warning: Function parameter or struct member 'ptr' not described in 'lpt_scan_node'
> fs/ubifs/replay.c:60: warning: Function parameter or struct member 'hash' not described in 'replay_entry'
> 
> Fix them.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Note ubifs still has C=1 warnings from smatch that are not addressed:

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
[...]
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 74aee92433d7..f997a85bcdce 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -359,7 +359,7 @@ static void wake_up_reservation(struct ubifs_info *c)
>   }
>   
>   /**
> - * wake_up_reservation - add current task in queue or start queuing.
> + * add_or_start_queue - add current task in queue or start queuing.
>    * @c: UBIFS file-system description object
>    *
>    * This function starts queuing if queuing is not started, otherwise adds

This period of code was modified in previous patch 
https://patchwork.ozlabs.org/project/linux-mtd/patch/20240227024204.1080739-1-chengzhihao1@huawei.com/ 
, I'm okay to drop the old patch and apply this one.


