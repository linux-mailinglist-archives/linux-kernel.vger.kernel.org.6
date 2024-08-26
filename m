Return-Path: <linux-kernel+bounces-301117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1097E95EC89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC00D281D05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656713DDCC;
	Mon, 26 Aug 2024 08:58:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6D13DBA7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662704; cv=none; b=LQIs6LHreLWnW84vBVUyOSSSIjUOsVcmfzm/6CvD10tPkvrEqtB+J+KxCki5gOVCdweg1Gd1AgTltDeuAz8O1XjVJ6XhzzQG9ct+pvId2c2yfNRVgkVwrl6vHxOPboKjpE5PsDgVBfzl4TxCjLTdK7adNo22ToeWkRdietQpM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662704; c=relaxed/simple;
	bh=58ZpAc9l9/sFRuIEwDfildx04yW5xujHh9QCc60P0gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SyzS69fkxq1F1l1/rkrO9dNMwLYxbzTEdrZbZetCsXMeYQufwdFvMDT4O/WKc99O8m/WPZbWvVrIUT2UglUVVBHwV3zcMo4Aumc9HlB2TV650uLPcGKTW/veZl44DByhEI0+fC8Clxj9Ih5x44vxfUCkYbh5KXHv7gi+0bLUFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wskwl5tGCz69Ll;
	Mon, 26 Aug 2024 16:53:27 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F50818006C;
	Mon, 26 Aug 2024 16:58:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 Aug 2024 16:58:14 +0800
Message-ID: <794f15e7-e15c-a70d-1e72-b5bc570eeab9@huawei.com>
Date: Mon, 26 Aug 2024 16:58:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next 00/12] mfd: Use for_each_child_of_node_scoped()
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <lee@kernel.org>,
	<linux-kernel@vger.kernel.org>, <jic23@kernel.org>
References: <20240826082847.2591036-1-ruanjinjie@huawei.com>
 <33abcd58-8a08-4ca7-812f-3de07cca9c92@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <33abcd58-8a08-4ca7-812f-3de07cca9c92@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/26 16:29, Krzysztof Kozlowski wrote:
> On 26/08/2024 10:28, Jinjie Ruan wrote:
>> Use scoped for_each_available_child_of_node_scoped() when iterating over
>> device nodes to make code a bit simpler.
>>
>> Jinjie Ruan (12):
>>   mfd: max77620: Use for_each_child_of_node_scoped()
>>   mfd: qcom-spmi-pmic: Use for_each_child_of_node_scoped()
>>   mtd: rawnand: arasan: Use for_each_child_of_node_scoped()
> 
> 
> No, you are mixing different subsystems. And even did not care to Cc
> their maintainers.

OK, I'll resend them.

> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> </form letter>

Sorry, the low scrip which wrap the `scripts/get_maintainer.pl` has a bug.

> 
> Best regards,
> Krzysztof
> 

