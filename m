Return-Path: <linux-kernel+bounces-241779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C842927F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FE01F256DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B7D27A;
	Fri,  5 Jul 2024 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EujO5cZ4"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20647B65A;
	Fri,  5 Jul 2024 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720141604; cv=none; b=o6aab9jyLuIhA7R5j+sPCF5aINw97CQJ3VmpoPLlvaymsr0i+OLK09vDBhFVZHnmWKI7M7tFxuUPb5jCRvq5rKG/DPRhOBmbOOwmieMklVZCFEvEUV/LRJ/Xr/8otgOH2LKmVFcbfy0Lpoddjb4TBgZDAzhtKxDwZWxPW5i8DrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720141604; c=relaxed/simple;
	bh=TYhAkvtDwkswGAizxiAdL8hwFy8gEaaAvescvij+s7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcpVEfI8DhAqr0AbJ3rFVCLwyio6fJZNrn0EJskRgAczkfVzr5WT87bLdZqyrp5iqsQtJbBKTAti3EZzFG/sy8roRWJjDAAngLuzGJb07N5oe+JJSrZDuQ38qPetxRBY+lrfRms0cMOarQ9HYyg9zQ43gU+cfjVTTWy+4ZwqPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EujO5cZ4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720141592; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4cfuS0iFnw0ne37rW+9HGtwOGkcB1qYjsLKyHH5WycE=;
	b=EujO5cZ4pe4EyEKIPYsENEve2UW9JJEBSlgLCHZxEZyA9VB4yVa7xbBGuHoISjgDjVv4oBaB2uYKIjHfsVNXVAYvj5WkKudpNGRTXr1ZO2MxgST9aVZFpiThsRII92mgi5DDkBg2P4LCsKBEKTn4tK2unysVjxBj1VOMq8cNKKI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W9snGSw_1720141591;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9snGSw_1720141591)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 09:06:32 +0800
Message-ID: <819eac21-9661-4b13-a988-f8f4b736513d@linux.alibaba.com>
Date: Fri, 5 Jul 2024 09:06:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Cleanup Spreadtum/Unisoc ARM64 DT
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1720112081.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1720112081.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/5 01:41, Stanislav Jakubek wrote:
> This series contains various minor cleanups for Spreadtum/Unisoc ARM64
> DeviceTrees.

Thanks. All look good to me. For the whole series:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Stanislav Jakubek (3):
>    arm64: dts: sprd: rename SDHCI nodes to mmc
>    arm64: dts: sprd: reorder clock-names after clocks
>    arm64: dts: sprd: move/add SPDX license to top of the file
> 
>   arch/arm64/boot/dts/sprd/sc2731.dtsi          |  3 +-
>   arch/arm64/boot/dts/sprd/sc9836-openphone.dts |  3 +-
>   arch/arm64/boot/dts/sprd/sc9836.dtsi          |  3 +-
>   arch/arm64/boot/dts/sprd/sc9860.dtsi          |  3 +-
>   arch/arm64/boot/dts/sprd/sc9863a.dtsi         |  8 ++--
>   arch/arm64/boot/dts/sprd/sharkl64.dtsi        |  3 +-
>   arch/arm64/boot/dts/sprd/sp9860g-1h10.dts     |  3 +-
>   arch/arm64/boot/dts/sprd/ums512.dtsi          |  4 +-
>   arch/arm64/boot/dts/sprd/whale2.dtsi          | 43 ++++++++++---------
>   9 files changed, 35 insertions(+), 38 deletions(-)
> 

