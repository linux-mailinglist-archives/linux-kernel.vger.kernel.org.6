Return-Path: <linux-kernel+bounces-298503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC595C82B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6211C214BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EA143C7B;
	Fri, 23 Aug 2024 08:33:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A036AEC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402031; cv=none; b=nPgwjZg+xzulIPs/Ee3JFuWcKRR1UbAnuIi4/6m5IIj/E+C5yXvjS+oD8uHYzzqz7Hrx4dXpf67PZgTXrnnbhu431aUn6nAG87HeG4hP8734wGQ2PxuJFcs4xCZTDmA7CrgDxM2qRr88aoTrEQpEl36qM5xVlQALWui2tSuxDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402031; c=relaxed/simple;
	bh=IrByBlXZIbr5E4dZ52UqOkc2uwoNEPohFcklm+VoinQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESFIOaVb2HObzRbslQUkwHiHtvGdlxTZHdXTswvTCU8auWfl4aTLT9k9BFFoCpjKU3t6SrGO9OlJrJcx8+0U3LlqusWu9gvhS7Dbu0vuyzUvRUH4NPlu/ldi0ytF5awCM/+c2LOhnb+DIH4hqPcICUDT1mBafUnj8eOxjQhYCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqtY6297Nz6FGd5;
	Fri, 23 Aug 2024 16:30:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CF26A14065B;
	Fri, 23 Aug 2024 16:33:46 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 09:33:46 +0100
Date: Fri, 23 Aug 2024 09:33:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huisong Li <lihuisong@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v2 2/6] soc: hisilicon: kunpeng_hccs: Return failure on
 having not die or port information
Message-ID: <20240823093345.000024f2@Huawei.com>
In-Reply-To: <20240823031059.32579-3-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
	<20240823031059.32579-1-lihuisong@huawei.com>
	<20240823031059.32579-3-lihuisong@huawei.com>
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

On Fri, 23 Aug 2024 11:10:55 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> Driver is unavailable if all die number or all port number obtained from
> firmware are zero. So return failure in this case.

Perhaps should include a little info on whether there are firmware's out
there that do this or not?  I.e. Fix, or hardening?

> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
Otherwise, this lgtm.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/soc/hisilicon/kunpeng_hccs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index c4a57328f22a..6e88f597f267 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -451,6 +451,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
>  	struct device *dev = hdev->dev;
>  	struct hccs_chip_info *chip;
>  	struct hccs_die_info *die;
> +	bool has_die_info = false;
>  	u8 i, j;
>  	int ret;
>  
> @@ -459,6 +460,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
>  		if (!chip->die_num)
>  			continue;
>  
> +		has_die_info = true;
>  		chip->dies = devm_kzalloc(hdev->dev,
>  				chip->die_num * sizeof(struct hccs_die_info),
>  				GFP_KERNEL);
> @@ -480,7 +482,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
>  		}
>  	}
>  
> -	return 0;
> +	return has_die_info ? 0 : -EINVAL;
>  }
>  
>  static int hccs_get_bd_info(struct hccs_dev *hdev, u8 opcode,
> @@ -601,6 +603,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>  	struct device *dev = hdev->dev;
>  	struct hccs_chip_info *chip;
>  	struct hccs_die_info *die;
> +	bool has_port_info = false;
>  	u8 i, j;
>  	int ret;
>  
> @@ -611,6 +614,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>  			if (!die->port_num)
>  				continue;
>  
> +			has_port_info = true;
>  			die->ports = devm_kzalloc(dev,
>  				die->port_num * sizeof(struct hccs_port_info),
>  				GFP_KERNEL);
> @@ -629,7 +633,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>  		}
>  	}
>  
> -	return 0;
> +	return has_port_info ? 0 : -EINVAL;
>  }
>  
>  static int hccs_get_hw_info(struct hccs_dev *hdev)


