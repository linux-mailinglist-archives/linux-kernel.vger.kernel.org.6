Return-Path: <linux-kernel+bounces-567256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C510A683D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172277A5EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE3324E010;
	Wed, 19 Mar 2025 03:39:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CE2AD00
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355541; cv=none; b=ZlixVSTBMJiBZbJkvJyxt7JKIKPWJJlCdW7J17l3Wjq60mkhaYwl4X34hBpbaMcX3rsuGTP5sZC51VAgBlmHs6EljcZA0vwGww1sWz8U+qv98/dw8Obv0LrQR/mz1FvCAawWNKR4tInn6hiseSUnUIowE9evdALi/0MeHRrcbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355541; c=relaxed/simple;
	bh=0AhZXZoa8qV5okgsPt9LXCJyG39baDD3bq9XO3mxRCc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KO9eFB2Nxqi5JUGmRldL+/zM4KoVoqhpnYfz4FJZelK9A3fVI5UCt20oszWUiGa/29uqKXQupDQeirh6XqQ+1FLTg/oGHyDcdgRE0r/PT/dllqFaZpIblWrXNYjUT+VDayoeeA0Mt6k4XdUx5honkjckXdsrPjkKR0QrL1w/B30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZHZ815GR5z1g2PT;
	Wed, 19 Mar 2025 11:34:25 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id A9591180044;
	Wed, 19 Mar 2025 11:38:55 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 11:38:55 +0800
Subject: Re: [PATCH] ubifs: Fix grammar in error message
To: Thorsten Blum <thorsten.blum@linux.dev>, Richard Weinberger
	<richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250318162558.100462-2-thorsten.blum@linux.dev>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ae124d6b-6b15-88a9-9f67-be0d17024d94@huawei.com>
Date: Wed, 19 Mar 2025 11:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250318162558.100462-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/19 0:25, Thorsten Blum Ð´µÀ:
> s/much/many/
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   fs/ubifs/journal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Well, the commit message is too simple.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 36ba79fbd2ff..923c0bbff303 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -982,7 +982,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
>   	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
>   
>   	if (kill_xattrs && ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
> -		ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
> +		ubifs_err(c, "Cannot delete inode, it has too many xattrs!");
>   		err = -EPERM;
>   		ubifs_ro_mode(c, err);
>   		return err;
> 


