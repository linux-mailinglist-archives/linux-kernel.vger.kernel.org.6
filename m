Return-Path: <linux-kernel+bounces-382852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DF9B1401
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C7FB21990
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D706135A69;
	Sat, 26 Oct 2024 01:28:22 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC57DA6C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906102; cv=none; b=iXW7qrjGb+GDeIxki5tzG16jqBL7g8yKYVoHBdi/YfqMddrYsjLc1ql5bKbnKrYDuJxutow0KFC1pUdRU1UriKEzlHxQ+ERTeuORFuFicivyPhtD3eAVEbs7PlH1MJFu/uhF68hcXOLYt7STqtS3r9LakvATKzSuAH0ygOTzl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906102; c=relaxed/simple;
	bh=6umi1eNi/TB8oXAflEPdCVfVLErE42WN5r7P5SCBpuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cx9YGG3YFY4u7GjJOxz8SyFZ2INF2SuYxaCdXUGS2hXObJiyDFFVbdJpD9JEh2FN9DBM4KSAbIKxUdidY4n45Be3DsoA/L6BPOo9rMLv9Eqxz+jJSVyNSpaV4DSEFbV8rQXvv+fVGXVSC/Z7PzGI5Vl9YytQKhxM7l2xIrYD/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xb2725YNlzyTkj;
	Sat, 26 Oct 2024 09:26:38 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 20B801401F4;
	Sat, 26 Oct 2024 09:28:13 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemf100008.china.huawei.com (7.202.181.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 09:28:12 +0800
Message-ID: <42b52500-9243-432e-1359-086012a60e81@huawei.com>
Date: Sat, 26 Oct 2024 09:28:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] goldfish: Fix unused const variable
 'goldfish_pipe_acpi_match'
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@baylibre.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <jia-cheng.hu@intel.com>, <gregkh@linuxfoundation.org>,
	<quic_jjohnson@quicinc.com>, <jinqian@android.com>, <alan@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
References: <20241025074129.1920707-1-zengheng4@huawei.com>
 <ttlc5ppgljd3plbk6kw4ndi47pqafivtxk2sosdhlw3zeda273@dn74s3eluxqp>
Content-Language: en-US
From: Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <ttlc5ppgljd3plbk6kw4ndi47pqafivtxk2sosdhlw3zeda273@dn74s3eluxqp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100008.china.huawei.com (7.202.181.222)


On 2024/10/25 22:27, Uwe Kleine-König wrote:
> Hello,
>
> [Cc += Andy]

I would loop in the next version.


>
> On Fri, Oct 25, 2024 at 03:41:29PM +0800, Zeng Heng wrote:
>> Fix the following compilation warning:
>>
>> drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
>> ‘goldfish_pipe_acpi_match’ defined but not used
>> [-Wunused-const-variable=]
>>    925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
>>
>> Only define the const variable when the CONFIG_ACPI is enabled.
> Note you also need CONFIG_MODULE=n to reproduce.
>
>> Fixes: d62f324b0ac8 ("goldfish: Enable ACPI-based enumeration for android pipe")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/platform/goldfish/goldfish_pipe.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
>> index c2aab0cfab33..aeabacba3760 100644
>> --- a/drivers/platform/goldfish/goldfish_pipe.c
>> +++ b/drivers/platform/goldfish/goldfish_pipe.c
>> @@ -922,11 +922,13 @@ static void goldfish_pipe_remove(struct platform_device *pdev)
>>   	goldfish_pipe_device_deinit(pdev, dev);
>>   }
>>   
>> +#ifdef CONFIG_ACPI
>>   static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
>>   	{ "GFSH0003", 0 },
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
>> +#endif
>>   
>>   static const struct of_device_id goldfish_pipe_of_match[] = {
>>   	{ .compatible = "google,android-pipe", },
> Looking at changes like
> https://lore.kernel.org/all/20241024130424.3818291-11-andriy.shevchenko@linux.intel.com/
> I suggest to drop the use of ACPI_PTR() instead.

Right, got it.


Best regards,

Zeng Heng




