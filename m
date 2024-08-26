Return-Path: <linux-kernel+bounces-300625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F61295E635
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CEA1C208EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9263524C;
	Mon, 26 Aug 2024 01:17:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5933D5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635069; cv=none; b=W6MuA6orfFZI6hu+p7SUWRzP2LOVuK3UPU2YcbI8tkTVk1ZB6kjNrUcBO1479r7Lg4zkmZdhIXLYJvJ86dy2ugpfPrZE6mPNCmnhU7W4OFkqBdrArZRyVQLN1zFMICi/VSZU3+z1CyVFZfnmyGiMS4X2cA1CjtD+5aZpTxfFgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635069; c=relaxed/simple;
	bh=WGXREo+pSglzNAmtzH6t1B7+ZyGVSAsDCYsmLWxmDhE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NYwDHdEwv7wP+eyXtqpX+Np/TwdyfQgw703yCtGnEmIKKhA8QCdJWBrSr7SAWE+XbZ4XYh6vSWA/W7h33McLPebWHIzIRtM+iRwxHCSdCY5kIPfsK6T7anzNXNG2qrP8iZdslfcScN0DhLDtWSSEp0J1ELDy/g65xFLjXNrJVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WsXn201RKzpSwx;
	Mon, 26 Aug 2024 09:16:05 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DA7E1800A5;
	Mon, 26 Aug 2024 09:17:44 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 09:17:43 +0800
Subject: Re: [PATCH] mtd: ubi: remove unused parameter 'pnum' from
 add_volume()
To: Wang Zhaolong <wangzhaolong1@huawei.com>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
References: <20240825083515.4074081-1-wangzhaolong1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7ef4f6c2-feae-e98b-cc85-a9f92eadaa67@huawei.com>
Date: Mon, 26 Aug 2024 09:17:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240825083515.4074081-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

ÔÚ 2024/8/25 16:35, Wang Zhaolong Ð´µÀ:
> The parameter 'pnum' in the function add_volume() is not used inside the
> function body. This patch removes this unused parameter to clean up the
> code and improve readability.
> 
> This change does not affect the functionality of add_volume() or any other
> part of the UBI subsystem, as the removed parameter is not utilized.
> 
> Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/attach.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
> index ae5abe492b52..fe9784c90ea4 100644
> --- a/drivers/mtd/ubi/attach.c
> +++ b/drivers/mtd/ubi/attach.c
> @@ -393,8 +393,7 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
>    * to the allocated "av" object in case of success and a negative error code in
>    * case of failure.
>    */
> -static struct ubi_ainf_volume *add_volume(struct ubi_attach_info *ai,
> -					  int vol_id, int pnum,
> +static struct ubi_ainf_volume *add_volume(struct ubi_attach_info *ai, int vol_id,
>   					  const struct ubi_vid_hdr *vid_hdr)
>   {
>   	struct ubi_ainf_volume *av;
> @@ -576,7 +575,7 @@ int ubi_add_to_av(struct ubi_device *ubi, struct ubi_attach_info *ai, int pnum,
>   	dbg_bld("PEB %d, LEB %d:%d, EC %d, sqnum %llu, bitflips %d",
>   		pnum, vol_id, lnum, ec, sqnum, bitflips);
>   
> -	av = add_volume(ai, vol_id, pnum, vid_hdr);
> +	av = add_volume(ai, vol_id, vid_hdr);
>   	if (IS_ERR(av))
>   		return PTR_ERR(av);
>   
> 


