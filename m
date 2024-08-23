Return-Path: <linux-kernel+bounces-298499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D295C821
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05A11C2213B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D4143895;
	Fri, 23 Aug 2024 08:32:09 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB64F88C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401928; cv=none; b=YMVeJaA7R6Tyea0CZsx4T2cGHVvE+wvKttaIjgD46WYhuhtPKuQvVCjZn9aB2A5HN5sbMomnMgmotvJJ3OHWCqKafV2KrTRkeZ3b3oXx42epAmq6whMB7bEUVygCvujloLHvkCVQernutBPdYwHvi5CQWWx/QIr7Vh0qC349gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401928; c=relaxed/simple;
	bh=PmRyCOxj/0S2cjlXWbmaSoLb3NMNYujOEXCUMmjof8U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxX2UObmuYQ/uQvlpvafbrrgfQ+n6DUjIHid6bHxqmY7jPLlZtfedHO1O3PdrYGpzQMhxvI5WJI0iHCtxM/Ud2Fw/6/saGQF0FlRZbZU6rPVRtQAZJW5V/2g2i0uZhHAbZSSYDtNc35TDBJdtAeyqJIwszfM0h+1I9UJw7lv8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqtWw1KHpz6K5V8;
	Fri, 23 Aug 2024 16:29:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 313171400D4;
	Fri, 23 Aug 2024 16:32:04 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 09:32:03 +0100
Date: Fri, 23 Aug 2024 09:32:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huisong Li <lihuisong@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v2 1/6] soc: hisilicon: kunpeng_hccs: Fix a PCC typo
Message-ID: <20240823093203.00000876@Huawei.com>
In-Reply-To: <20240823031059.32579-2-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
	<20240823031059.32579-1-lihuisong@huawei.com>
	<20240823031059.32579-2-lihuisong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 11:10:54 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Fix a PCC typo.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
FWIW.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index e882a61636ec..c4a57328f22a 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -144,7 +144,7 @@ static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>  
>  	pcc_chan = pcc_mbox_request_channel(cl, hdev->chan_id);
>  	if (IS_ERR(pcc_chan)) {
> -		dev_err(dev, "PPC channel request failed.\n");
> +		dev_err(dev, "PCC channel request failed.\n");
>  		rc = -ENODEV;
>  		goto out;
>  	}


