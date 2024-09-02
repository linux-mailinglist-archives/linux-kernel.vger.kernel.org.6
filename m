Return-Path: <linux-kernel+bounces-310762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423CA9680F0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F5CB210D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC3B1714DD;
	Mon,  2 Sep 2024 07:51:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96213C00
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263490; cv=none; b=B7VsRKwl4SdWZND1wK63xf/iOBW7pra6CBBZzTut4avEyU6XuFlRelB6iaqQug1axcK7kGDejML01LVUQAEEehbp6ShxkzxxyD9CgnWNJopB/kj68KlRPsFxRQz+fZLD6LjE0gFiNFIFuS0i6okSVwcS0wwQTL8eSRNnptmiqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263490; c=relaxed/simple;
	bh=1GKTTkMJBbcXUCW66Wm6PVSWzFRleBHFoXeOj8/2460=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=fkRdnHakjGsllOLE8lYFbAou1khGy+Ff6R4viqWZBOgzlgF0aZkABejMC1bFZm9h9lGYnJqXOcfUGyRkoU8eEBtSC5RdDFDAAJ9c0mkveFTYHT8EzP4PtIxg4OUtQ7dUleMKrQ9PtjDhfgydJn47hFmV1xbUtIoMmV5vqPTJ1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wy1CD5W8nzyRM5;
	Mon,  2 Sep 2024 15:50:48 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 7880018010A;
	Mon,  2 Sep 2024 15:51:24 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 2 Sep
 2024 15:51:23 +0800
Message-ID: <66D56E7B.9040502@hisilicon.com>
Date: Mon, 2 Sep 2024 15:51:23 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Huisong Li <lihuisong@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<Jonathan.Cameron@Huawei.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH v3 0/6] Add some features and bugfix for kunpeng_hccs
References: <20240828104956.20214-1-lihuisong@huawei.com>
In-Reply-To: <20240828104956.20214-1-lihuisong@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Huisong,

On 2024/8/28 18:49, Huisong Li wrote:
> This series is aimed to support the low power feature and add used
> HCCS types sysfs. And fix some bugfix to harden codes by the way.
> 
> ---
>  v3:
>   - add Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>.
>   - drop 'none' string print according to Jonathan's suggestion.
>   - early return in hccs_wait_serdes_adapt_completed.
>   - fix commit log in patch[2/6], patch[3/6] and patch[5/6]
> 
>  v2:
>   - remove "this patch" words in commit log suggested by Krzyszto.
>   - use for_each_set_bit to replace the cycle scanning all HCCS IP.
>   - add a patch to rename the 'lane_mode' to 'max_lane_num' to make it
>     easy to see.
>   - add doc description into the code patch.
>   - rename the name of the low power interface.
>   - adjust the increasing and decreasing lane interface description.
>   - do not create available_inc_dec_lane_types when no HCCS type support
>     low power.
> ---
> 
> Huisong Li (6):
>   soc: hisilicon: kunpeng_hccs: Fix a PCC typo
>   soc: hisilicon: kunpeng_hccs: Return failure on having not die or port
>     information
>   soc: hisilicon: kunpeng_hccs: Add the check for base address and size
>     of shared memory
>   soc: hisilicon: kunpeng_hccs: Fix the 'lane_mode' field name in port
>     info structure to 'max_lane_num'
>   soc: hisilicon: kunpeng_hccs: Add used HCCS types sysfs
>   soc: hisilicon: kunpeng_hccs: Support low power feature for the
>     specified HCCS type
> 
>  .../sysfs-devices-platform-kunpeng_hccs       |  45 ++
>  drivers/soc/hisilicon/Kconfig                 |   7 +-
>  drivers/soc/hisilicon/kunpeng_hccs.c          | 514 +++++++++++++++++-
>  drivers/soc/hisilicon/kunpeng_hccs.h          |  33 +-
>  4 files changed, 580 insertions(+), 19 deletions(-)
> 

Thanks!
Series applied to the Hisilicon driver tree.
But it is already rc6, maybe I will send the PR in the next cycle if no conflict.

Best Regards,
Wei

