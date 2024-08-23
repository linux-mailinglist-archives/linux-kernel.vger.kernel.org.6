Return-Path: <linux-kernel+bounces-298552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40CB95C8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DEE2895D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AFE149C50;
	Fri, 23 Aug 2024 09:02:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39900149C4C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403736; cv=none; b=FHKdmZshkjAapcucNXdKe+LgD+oYUnGm+IMXfUoGBrr6otxBxTdbR9Tjb8GskMT+4wFnuqeZ2Ul4myvY0EQbULs8kyyLmK2Iad8780bd8/OtiJOZHtZrHjTb7Z50wzS4AKhgUlQ2jWTou1Wp4ktDJsDG3GozXhTDlKYkxi9Vm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403736; c=relaxed/simple;
	bh=bPxieNCa4dUjIVLBQUu7xlwQySuRO9qbE9gGdXXgB8o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjsmpxxYfeWAhj4HjC18C26BSg65anZegKFoNfa5E1VosWREjYtw8lldSoyIlPJceetqLqIslUr+Bskfo6fM7T9PWZOzSA9Twc5VN7eaVgBKOBFl8W1ZxCMErV4k6SJPYCzHK7TN7nmpSSODtz3aAj72tkyOUjQ4+QojchFDp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wqv9v5MG3z6FH3P;
	Fri, 23 Aug 2024 16:58:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 561FB140594;
	Fri, 23 Aug 2024 17:02:12 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 10:02:11 +0100
Date: Fri, 23 Aug 2024 10:02:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huisong Li <lihuisong@huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH v2 0/6] Add some features and bugfix for kunpeng_hccs
Message-ID: <20240823100211.00002b9d@Huawei.com>
In-Reply-To: <20240823031059.32579-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
	<20240823031059.32579-1-lihuisong@huawei.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 11:10:53 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> This series are intended to support the low power feature for specified
> HCCS and add used HCCS types sysfs. In addition, fix some bugfix and
> enhance some codes.

Quick process thing.  Don't send a v2 like this in reply to v1
(for most kernel subsystems anyway, maybe there are some that request
this?).

Most people still review in email clients and they often start at latest
and work back until they run out of time.  Thus a reply to an earlier
thread is not read!

Jonathan

> 
> ---
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
>  drivers/soc/hisilicon/kunpeng_hccs.c          | 516 +++++++++++++++++-
>  drivers/soc/hisilicon/kunpeng_hccs.h          |  33 +-
>  4 files changed, 582 insertions(+), 19 deletions(-)
> 


