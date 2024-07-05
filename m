Return-Path: <linux-kernel+bounces-242361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC492871A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47BC1F22441
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD60147C9A;
	Fri,  5 Jul 2024 10:52:10 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F0148305
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176730; cv=none; b=VTmud9Rpk5Qs2gzogrbxZxJ+rxsUHxTTOj0bIHY5rUWII/R8jI56w1y/Ml5ww6DNbaDanpcXL1x3r6608BFfa8bkBW+cXVXct+aMAwdNK3/rtlKg3SXd+VoeCzCDDt1gB2KvYe31vPiGmLRGzZC0FngksXQnHFXfXSTeA7gOBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176730; c=relaxed/simple;
	bh=0ASd1o9/NZq6ldORUb2BtU9p/ymbr/DIBYi2nQZdLDI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvnbBj1lsDecA5YZWnNqnUC5CoKs9B+kufbECeDP19SmYQOBwn/Y0Pp1zojiR/T6vHpU+WwKoX2NU3h5m0YNkvje0FUzWnivWquQk1nLqjXQLz87BwzYgiyZKVOOEuaEFD5m3tGUaA4dlIbqKZbm3JhikpwwtJ9eU39tbMl5tNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFqzQ5Yg1z6K96m;
	Fri,  5 Jul 2024 18:50:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AF76140B33;
	Fri,  5 Jul 2024 18:52:06 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 11:52:06 +0100
Date: Fri, 5 Jul 2024 11:52:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
CC: Julia Lawall <julia.lawall@inria.fr>, Nishanth Menon <nm@ti.com>, Santosh
 Shilimkar <ssantosh@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, "Javier Carrasco"
	<javier.carrasco.cruz@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] soc: ti: knav_qmss_queue: do device_node auto
 cleanup
Message-ID: <20240705115205.00006363@Huawei.com>
In-Reply-To: <20240703065710.13786-3-five231003@gmail.com>
References: <20240703065710.13786-1-five231003@gmail.com>
	<20240703065710.13786-3-five231003@gmail.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  3 Jul 2024 12:25:27 +0530
Kousik Sanagavarapu <five231003@gmail.com> wrote:

> Use scope based cleanup, instead of manual of_node_put() calls, which
> automatically free()s "struct device_node".
> 
> While at it, refactor the code from knav_queue_probe() into the seperate
> functions to make auto cleanup look more neat.
> 
> Doing the cleanup this way has the advantage of reducing the chance of
> memory leaks in case we need to read from new OF nodes in the future
> when we probe.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>

One trivial thing inline
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> @@ -1668,6 +1686,25 @@ static int knav_queue_start_pdsps(struct knav_device *kdev)
>  	return 0;
>  }
>  
> +static int knav_queue_setup_pdsps(struct knav_device *kdev,
> +				  struct device_node *node)
> +{
> +	struct device_node *pdsps __free(device_node) =
> +			of_get_child_by_name(node, "pdsps");
> +
> +	if (pdsps) {
> +		int ret;
> +
> +		ret = knav_queue_init_pdsps(kdev, pdsps);
> +		if (ret)
> +			return ret;
As per original style, readability slightly helped by
a blank line here.

> +		ret = knav_queue_start_pdsps(kdev);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}



