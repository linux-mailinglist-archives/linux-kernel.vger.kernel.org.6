Return-Path: <linux-kernel+bounces-517046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA748A37B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C209D1885B19
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5903018785D;
	Mon, 17 Feb 2025 06:18:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139D31547C9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773133; cv=none; b=lYBJaz5Uad4Yk1JhjkakCl8Ks8sGkTYfqexX+btuEG+5B5lK84i6b79/JnKvg28p1RXdw+Uqgaf4g82AuVFzFlZOnFm/WNeVh09X2BcY/v3ht35/MjAxdRSXZGwOmgZqZdrKPuHgsWgCs5NiITI0jpgNEy3PJYeVJHBGfueVLXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773133; c=relaxed/simple;
	bh=PY7gluqW0Reyq3rYZ0liySpTyTVePKy8CMb8vJhK6KU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=G6ILiubXAjBuIFTITu2F5a8chhHdsyk4KhvjmzVMFkeBvzStNfLjJ9Ctg6tEEBKWLImdsQnBFsp36pF/j/R3dWkVo+ajgcfmDi5HoiZ/FXJ51wjh2k1N66ey8FzPfb96V/lNpEa0gu4kko/P2HQbfW67WkkvlH6VfGFrTliEibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YxC9g5PSjzrYpZ;
	Mon, 17 Feb 2025 14:17:11 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 987CB1401E9;
	Mon, 17 Feb 2025 14:18:45 +0800 (CST)
Received: from [10.174.178.24] (10.174.178.24) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 14:18:44 +0800
Message-ID: <d7069933-903e-9e1e-d7a4-5a6a9fa53064@huawei.com>
Date: Mon, 17 Feb 2025 14:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mpam mpam/snapshot/v6.14-rc1 3/5] arm_mpam: Provide
 conversion method for new closid/rmid pairs
Content-Language: en-US
From: Zeng Heng <zengheng4@huawei.com>
To: <Dave.Martin@arm.com>, <james.morse@arm.com>
CC: <bobo.shaobowang@huawei.com>, <jonathan.cameron@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250217031852.2014939-1-zengheng4@huawei.com>
 <20250217031852.2014939-4-zengheng4@huawei.com>
In-Reply-To: <20250217031852.2014939-4-zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100008.china.huawei.com (7.202.181.222)

Hi Martin,

On 2025/2/17 11:18, Zeng Heng wrote:
> The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs.
> For the new rmid allocation strategy, it will check if there is an
> available rmid of any reqPARTID which belongs to the input closid, not just
> the rmids belonging to the closid.
> 
> For a mixture of MSCs system, for MSCs that do not support narrow-partid,
> we use the PARTIDs exceeding the number of closids as reqPARTIDs for
> expanding the monitoring groups.
> 
> In order to keep the existing resctrl API interface, the rmid contains both
> req_idx and PMG information instead of PMG only under the MPAM driver. The
> req_idx represents the req_idx-th sub-monitoring group under the control
> group. The new rmid would be like:
> 
>      rmid = (req_idx << shift | pmg).
> 

To consider future compatibility with dynamically allocated reqpartid,
should I refactor the rmid?

Instead of defining rmid.req_idx, we could place the entire reqpartid
directly within rmid. In This way, the allocation of reqpartid will no
longer be constrained by the static allocation of closid, facilitating
future compatibility with dynamic allocation mechanisms.

In this case, it needs to refactor the resctrl_arch_rmid_idx_encode()
and resctrl_arch_rmid_idx_decode(), and we can simplify
closid_rmid2reqpartid() to rmid2reqpartid().

What are your thoughts on this idea? Thank you in advance for your
reply.

Best regards,
Zeng Heng


