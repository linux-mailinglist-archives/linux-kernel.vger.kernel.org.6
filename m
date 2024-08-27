Return-Path: <linux-kernel+bounces-303150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E34960820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C4BB2145C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EA19DF77;
	Tue, 27 Aug 2024 11:05:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6561B674
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756702; cv=none; b=WvhgX5eU4xFRpbLWjBzdNpccO7vFiszbHOBFmXjNtLDvnjxbXbI0tkYad/YNhsnNGuybqheVypVwiPd2LW7RiiNMVErfVA5PNqO3mZAQAWv6lJyDtgjAgVINB4+iGZPutITJimacwrj+kzsaskCppZN+XMfkmeEU4DzG0DZkXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756702; c=relaxed/simple;
	bh=EkO41esWrahqVLQDgAHkhpO5Wu6cVLlWqb4iOcHwmYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JqOcOvNJXK9s8yAj1uBXx7SCUYUi+VsYJHUycaSl/cE03EX5Ud2j7rFDd02+amppPx7lohctw2lLPQkKl7eDToif0O7cukKfMsNJM7mvfPPuSKpxrlzU/lTgFUphaR5sHOu+KipMjPUF3kfu0yzUcnU14iZoTGvTEf7jJsGq/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WtPnn64hYz2CnnC;
	Tue, 27 Aug 2024 19:04:45 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id DC2931A0188;
	Tue, 27 Aug 2024 19:04:55 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 19:04:55 +0800
Message-ID: <858c23e1-2ff9-34fd-80b4-405ebd54d287@huawei.com>
Date: Tue, 27 Aug 2024 19:04:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/6] soc: hisilicon: kunpeng_hccs: Return failure on
 having not die or port information
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <xuwei5@hisilicon.com>, <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
 <20240823031059.32579-1-lihuisong@huawei.com>
 <20240823031059.32579-3-lihuisong@huawei.com>
 <20240823093345.000024f2@Huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20240823093345.000024f2@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/23 16:33, Jonathan Cameron 写道:
> On Fri, 23 Aug 2024 11:10:55 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
>> Driver is unavailable if all die number or all port number obtained from
>> firmware are zero. So return failure in this case.
> Perhaps should include a little info on whether there are firmware's out
> there that do this or not?  I.e. Fix, or hardening?
Ack
just hardening code.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Otherwise, this lgtm.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> ---
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> index c4a57328f22a..6e88f597f267 100644
>> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -451,6 +451,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
>>   	struct device *dev = hdev->dev;
>>   	struct hccs_chip_info *chip;
>>   	struct hccs_die_info *die;
>> +	bool has_die_info = false;
>>   	u8 i, j;
>>   	int ret;
>>   
>> @@ -459,6 +460,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
>>   		if (!chip->die_num)
>>   			continue;
>>   
>> +		has_die_info = true;
>>   		chip->dies = devm_kzalloc(hdev->dev,
>>   				chip->die_num * sizeof(struct hccs_die_info),
>>   				GFP_KERNEL);
>> @@ -480,7 +482,7 @@ static int hccs_query_all_die_info_on_platform(struct hccs_dev *hdev)
>>   		}
>>   	}
>>   
>> -	return 0;
>> +	return has_die_info ? 0 : -EINVAL;
>>   }
>>   
>>   static int hccs_get_bd_info(struct hccs_dev *hdev, u8 opcode,
>> @@ -601,6 +603,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>>   	struct device *dev = hdev->dev;
>>   	struct hccs_chip_info *chip;
>>   	struct hccs_die_info *die;
>> +	bool has_port_info = false;
>>   	u8 i, j;
>>   	int ret;
>>   
>> @@ -611,6 +614,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>>   			if (!die->port_num)
>>   				continue;
>>   
>> +			has_port_info = true;
>>   			die->ports = devm_kzalloc(dev,
>>   				die->port_num * sizeof(struct hccs_port_info),
>>   				GFP_KERNEL);
>> @@ -629,7 +633,7 @@ static int hccs_query_all_port_info_on_platform(struct hccs_dev *hdev)
>>   		}
>>   	}
>>   
>> -	return 0;
>> +	return has_port_info ? 0 : -EINVAL;
>>   }
>>   
>>   static int hccs_get_hw_info(struct hccs_dev *hdev)
> .

