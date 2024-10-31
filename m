Return-Path: <linux-kernel+bounces-390650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9B9B7CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178D0282337
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB7A1A08AB;
	Thu, 31 Oct 2024 14:26:05 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D2042AA5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384764; cv=none; b=VX+w+3/1f902g6nwxTsV9xkgub18IiTSflLfXW6bQJEsUxd9zauh38BqxeNeuk1R4vACk0O9QluXKM3SFWipJ+wxpNYSEek8NI1auqZwzfEcQB0zNkOaY+YZ46Fd3ucAsVj61VAq/8nxer/z5kfMmITTmgt22LZ2SV+9wcA05Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384764; c=relaxed/simple;
	bh=WiQlX9SFlkfxtyAgJeEDBYXW9jz8q4uNA2aWfNGql1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b0WoLiWoIxGOEg5SOlf5kPt1xGCKheB0WRT4tigNRKYPimCCeXP2MBLdIuDPRRKun6k73waOJEuQSRgF6f6vHN+WDkof2K10E+T1GD1VUXYpP5InW1snugt4QJWaO58fm0/oxQ/hdbNAahuZbzpZwBTrpm1M9I+DTRCGSxy5TZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XfR4m2zlHz1HLpY;
	Thu, 31 Oct 2024 22:21:28 +0800 (CST)
Received: from kwepemd500013.china.huawei.com (unknown [7.221.188.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F88614022F;
	Thu, 31 Oct 2024 22:25:58 +0800 (CST)
Received: from [10.159.166.136] (10.159.166.136) by
 kwepemd500013.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 22:25:56 +0800
Message-ID: <40a6c61d-b5db-40a0-8e2a-cbcd950c382f@huawei.com>
Date: Thu, 31 Oct 2024 22:25:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 drm-dp 1/4] drm/hisilicon/hibmc: add dp aux in hibmc
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <liangjian010@huawei.com>,
	<chenjianmin@huawei.com>, <lidongming5@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241022124148.1952761-1-shiyongbang@huawei.com>
 <20241022124148.1952761-2-shiyongbang@huawei.com>
 <wu2kwdqce7jovidzxhublmpgdhzq4uby65quo7ks44tfjhtgd2@qtfogva3exyg>
 <c418e93a-7305-4ca6-85c1-42bd458f4e7b@huawei.com>
 <CAA8EJppvnAcj5ESHe3t2QBvTGZTpiUUS3K+tJ+4_3Pkuijga0g@mail.gmail.com>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <CAA8EJppvnAcj5ESHe3t2QBvTGZTpiUUS3K+tJ+4_3Pkuijga0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500013.china.huawei.com (7.221.188.12)

> On Tue, 29 Oct 2024 at 16:15, Yongbang Shi <shiyongbang@huawei.com> wrote:
>>> On Tue, Oct 22, 2024 at 08:41:45PM +0800, Yongbang Shi wrote:
>>>> From: baihan li <libaihan@huawei.com>
>>>> +}
>>>> +
>>>> +enum dpcd_revision {
>>>> +    DPCD_REVISION_10 = 0x10,
>>>> +    DPCD_REVISION_11,
>>>> +    DPCD_REVISION_12,
>>>> +    DPCD_REVISION_13,
>>>> +    DPCD_REVISION_14,
>>> Any reason for ignoring defines in drm_dp.h?
>> Hi Dmitry,
>> I tried it but still can't find it, if you know, can you tell me which macro I can use?
> # define DP_DPCD_REV_10                     0x10
> # define DP_DPCD_REV_11                     0x11
> etc

Thanks, I got it.

Baihan.


>> Thanks,
>> Baihan
>

