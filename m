Return-Path: <linux-kernel+bounces-354390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55246993CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2722866B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673642AB9;
	Tue,  8 Oct 2024 02:33:05 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9D40849
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354785; cv=none; b=KRn5RRTRHjcoej0hkpl5eireRpC8zVDAOjFVqfovwsGUOeGRPj7If3JDlcUBMIldxUthG23nRHAeoL9UKLmQTQEAR7mVIjWdLX5zEDpF6fmjO/0ovM/G1S6N+4HUJwtfY+pczh6gjPf8gtL7BGExWbgOBYRClQSXPjE2pkPF4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354785; c=relaxed/simple;
	bh=avnkZ210ASOhoeBbB8MnCxKZD40/XE4J/XZpVSzpuhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dga3uM4lcVNsJzCeUu7Mt6oi//fx0z1SXprJ//+1V76MrsDu/UeMt96FlHnYsxRdwqy/h7t9rWEouUmGuraNLjnR0cwxpIoaeL+2SNHPOJsGb1tMltLEaqgGcg/S26BHEcBmyPqM6kRWZObC/lzUpvcO+RO/A552gZc5FODPB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XN0S04dSvz1ympL;
	Tue,  8 Oct 2024 10:33:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 734191401F1;
	Tue,  8 Oct 2024 10:33:00 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Oct 2024 10:32:59 +0800
Message-ID: <a192a264-e7d8-3a3b-7bcc-60975102fcc6@huawei.com>
Date: Tue, 8 Oct 2024 10:32:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] i3c: master: svc: Fix pm_runtime_set_suspended() with
 runtime pm enabled
To: <miquel.raynal@bootlin.com>, <conor.culhane@silvaco.com>,
	<alexandre.belloni@bootlin.com>, <xiaoning.wang@nxp.com>, <jun.li@nxp.com>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240930091913.2545510-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240930091913.2545510-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Ping.

On 2024/9/30 17:19, Jinjie Ruan wrote:
> It is not valid to call pm_runtime_set_suspended() for devices
> with runtime PM enabled because it returns -EAGAIN if it is enabled
> already and working. So, call pm_runtime_disable() before to fix it.
> 
> Cc: stable@vger.kernel.org # v5.17
> Fixes: 05be23ef78f7 ("i3c: master: svc: add runtime pm support")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add Reviewed-by.
> - Add stable tag as Miquel suggested.
> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index a7bfc678153e..130cec4ee307 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1827,8 +1827,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
>  rpm_disable:
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
>  
>  err_disable_clks:
>  	svc_i3c_master_unprepare_clks(master);

