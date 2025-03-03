Return-Path: <linux-kernel+bounces-541948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F12FA4C3B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534823A4FB3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9F212D66;
	Mon,  3 Mar 2025 14:43:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F1422098
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013027; cv=none; b=rL3tWpIqmEhNmarmgR21DZlHTg2dJWxBl1XMD1i3TsvhrXy8zzmrqVujWhD0QYr+VYL3WtjmdYDCk65WmAROS1KrZkh0Mu2pD0KcDQ4VDkeM/U0IC/Ml+EdfqRAD+PCjgCoyOIWwHpxXJV7jPcAMPSbRrrA8iIaRBTenJk9IBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013027; c=relaxed/simple;
	bh=UTr20A6HBJqTFjZBJXSh1/c5LnzfbJ+GmEfYuQD5Dsw=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mwvSCyt5K1X1ol6QGUrtgiUNLcgwY1tM5kmguBAaoawVVZk3Bs9ZAbYAtNkEfI/Dn4zDyTczsmqB2+g5XDjnKJ6vTBqIulEpEYjmCxnAvyicoUfmBj64lNX/3wKW0zbbObO0ZcXHfDb5U6bfQ1CvmGN34OzGsdVc01LbNEQKlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z61fk4VT0z2DkjD;
	Mon,  3 Mar 2025 22:39:26 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id E40DA1A0188;
	Mon,  3 Mar 2025 22:43:36 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 22:43:36 +0800
CC: <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <wangyushan12@huawei.com>
Subject: Re: [PATCH 1/9] drivers/perf: hisi: Extend struct hisi_pmu_dev_info
To: Will Deacon <will@kernel.org>
References: <20250218092000.41641-1-yangyicong@huawei.com>
 <20250218092000.41641-2-yangyicong@huawei.com>
 <20250301062343.GA27700@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <e6cfcfd0-5412-20bb-f4b5-cf266884c5d0@huawei.com>
Date: Mon, 3 Mar 2025 22:43:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250301062343.GA27700@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/3/1 14:23, Will Deacon wrote:
> On Tue, Feb 18, 2025 at 05:19:52PM +0800, Yicong Yang wrote:
>> From: Junhao He <hejunhao3@huawei.com>
>>
>> The counter bits and event range may differ from versions of a
>> certain uncore PMU. Make this device specific information into
>> struct hisi_pmu_dev_info. This will help to simplify the
>> initialization process by using a list of struct hisi_pmu_dev_info
>> rather than checking the version.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/perf/hisilicon/hisi_uncore_pmu.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> index f4fed2544877..777675838b80 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> @@ -72,6 +72,8 @@ struct hisi_uncore_ops {
>>  struct hisi_pmu_dev_info {
>>  	const char *name;
>>  	const struct attribute_group **attr_groups;
>> +	u32 counter_bits;
>> +	u32 check_event;
>>  	void *private;
>>  };
> 
> This doesn't really do anything on its own; please just fold it into the
> patch where the new fields are used.
> 

sure, will make this into the following patch.

Thanks.


