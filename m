Return-Path: <linux-kernel+bounces-536195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B6CA47C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9336E16E71F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CD22A4D1;
	Thu, 27 Feb 2025 11:53:30 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6686FB0;
	Thu, 27 Feb 2025 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657209; cv=none; b=lqnYCtZ2qphA3c3pOLhoUgW8PkLAZmeUDayV30LXBKn9xK0thUfCwH27bKVyenmqRbZ8q4UOXhkIEpDzoIfKXRfNXL0nFwa1DP2F6A0ZGeRSkiIBLfZcWwymwnpEZQFKbXeQkIKmYTKEntr+0anMZ1/DELVRzen4205ZfKbWqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657209; c=relaxed/simple;
	bh=BLKdMETV/SInTthomDJ1NH2Qh7Bpvfh6khpGKs35JvM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mGyX4m3FXJjrp2mq4jTUkLGREfw8/YYmeHr3psRR+CRWXrovaCA4rQg3lbnm5QkoWWRc6OtQTMeSf52rCQ9HJlQqufz9DKZup99D+5R615X0urPo8g2P4WP1UXqw6RMnfWOfI65UznHHd6GWKD33g+24UTC9BBvRPIaK1Ofbues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z3V5Q5vf7z9w7y;
	Thu, 27 Feb 2025 19:50:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 264A1180113;
	Thu, 27 Feb 2025 19:53:24 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Feb 2025 19:53:23 +0800
Message-ID: <3e477135-981f-49bd-8e54-0c3ecdcc8a19@huawei.com>
Date: Thu, 27 Feb 2025 19:53:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Netdev <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR
 annotation
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Jian Shen
	<shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20250225163341.4168238-1-arnd@kernel.org>
 <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
 <c0a3d083-d6ae-491e-804d-28e4c37949d7@app.fastmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <c0a3d083-d6ae-491e-804d-28e4c37949d7@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/26 14:49, Arnd Bergmann wrote:
> On Wed, Feb 26, 2025, at 04:21, Jijie Shao wrote:
>> on 2025/2/26 0:33, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Building with W=1 shows a warning about hns_mdio_acpi_match being unused when
>>> CONFIG_ACPI is disabled:
>>>
>>> drivers/net/ethernet/hisilicon/hns_mdio.c:631:36: error: unused variable 'hns_mdio_acpi_match' [-Werror,-Wunused-const-variable]
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>    drivers/net/ethernet/hisilicon/hns_mdio.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
>>> index a1aa6c1f966e..6812be8dc64f 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns_mdio.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
>>> @@ -640,7 +640,7 @@ static struct platform_driver hns_mdio_driver = {
>>>    	.driver = {
>>>    		   .name = MDIO_DRV_NAME,
>>>    		   .of_match_table = hns_mdio_match,
>>> -		   .acpi_match_table = ACPI_PTR(hns_mdio_acpi_match),
>>> +		   .acpi_match_table = hns_mdio_acpi_match,
>>>    		   },
>>>    };
>>
>> But I think it can be changed to:
>>
>> + #ifdef CONFIG_ACPI
>> static const struct acpi_device_id hns_mdio_acpi_match[] = {
>> 	{ "HISI0141", 0 },
>> 	{ },
>> };
>> MODULE_DEVICE_TABLE(acpi, hns_mdio_acpi_match);
>> + #endif
>>
> That would of course avoid the build warning, but otherwise
> would be worse: the only reason ACPI_PTR()/of_match_ptr() exist
> is to work around drivers that have to put their device ID
> table inside of an #ifdef for some other reason. Adding the
> #ifdef to work around an incorrect ACPI_PTR() makes no sense.
>
>       Arnd

if CONFIG_ACPI is disabled, ACPI_PTR() will return NULL, so
hns_mdio_acpi_match is unused variable.


So use #ifdef is possible and has no side effects, and many drivers do so.



Of course, it also seems possible to remove ACPI_PTR(),
But I'm not sure if it's okay to set a value to acpi_match_table if CONFIG_ACPI is disabled.
It need maintainer to look at this.

Thanks,
Jijie Shao



