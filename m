Return-Path: <linux-kernel+bounces-269524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9A9433CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F67B224EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79321BC097;
	Wed, 31 Jul 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="toXsE+O2"
Received: from mr85p00im-zteg06011501.me.com (mr85p00im-zteg06011501.me.com [17.58.23.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC791BBBFC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441890; cv=none; b=gCLFlQrg14VqCn9m48r9bRM2dqX0ue24hHeq4ryajCa/OHAveAD54h0yrlpVADB2QT7P19F1hbWNwsgaDvX4NwwMg9dEFAsPu83eTyT8VIJwSTrCnlL/JSfghmUXorYeoRGcSx7fztAGhaldoA0IJzwa6ExV71+MEczt3aOxTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441890; c=relaxed/simple;
	bh=2IzSyYtbJrt5C1UeaP4/5ZQWqNuUk885BJergLRe3BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yl9v5r8XA2YufCXI+ByVbBP/LRKweHosp3sfqyH0YTjTc8SP3mZhS9GJEOzJmI88ZHxXlXv2402x0QWUaHsvaW7DtZwS8VoqfwvDsXs1Agk8fHSKP0rXwEn0U3abezBe8//8B6plQOQlFvTPmOjLQXdSwxCbt+oYIhbMpcZg608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=toXsE+O2; arc=none smtp.client-ip=17.58.23.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722441888;
	bh=P14kmEwRCnv82rX3pUE5XFhLQBkIYE1H+XfvhS7TSBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=toXsE+O2fOA1r+XSndKSDBZfA7Wsx8t5URXGY5WJmTjtC3MWRDxBYo03n2PmCrR6a
	 qN5Iz8CiF5NIwnINjfyyh0B5ILMaGnu8R0thbNmizVKGU8KvHY3qiiot2R8DHhbQet
	 vUOulbCOCNlgPgzCKDivjbbBQ7WKXg7kmRgMt1PMxw+esZiKxJ/yriCwQY/ODu1i3H
	 Bim7YZtbGItiKMxlsCJ+WQBUXqLGwFeG/VzQTHQL2hb3sZ/oFo7v6wD3fK5n3reZyX
	 t7jnU+wpTvm0vaaSwpykP+0P69GPPMgS+951pdcdCQRtf7Yu+NqXLqT6EoGiTNmAuq
	 ZJRiUi34v9Nfg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 2849A480543;
	Wed, 31 Jul 2024 16:04:44 +0000 (UTC)
Message-ID: <917359cc-a421-41dd-93f4-d28937fe2325@icloud.com>
Date: Thu, 1 Aug 2024 00:04:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Simplify driver API
 device_find_child_by_name() implementation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com>
 <2024073128-tinfoil-unaligned-8164@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024073128-tinfoil-unaligned-8164@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YlnHkuavhT_gi1bR8qlLA5OPCM4MZ3W9
X-Proofpoint-ORIG-GUID: YlnHkuavhT_gi1bR8qlLA5OPCM4MZ3W9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=983 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2407310113

On 2024/7/31 20:53, Greg Kroah-Hartman wrote:
> On Sat, Jul 20, 2024 at 09:21:50AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Simplify device_find_child_by_name() implementation by using present
>> driver APIs device_find_child() and device_match_name().
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/core.c    | 15 +++------------
>>  include/linux/device.h |  4 ++++
>>  2 files changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 730cae66607c..22ab4b8a2bcd 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4089,18 +4089,9 @@ EXPORT_SYMBOL_GPL(device_find_child);
>>  struct device *device_find_child_by_name(struct device *parent,
>>  					 const char *name)
>>  {
>> -	struct klist_iter i;
>> -	struct device *child;
>> -
>> -	if (!parent)
>> -		return NULL;
>> -
>> -	klist_iter_init(&parent->p->klist_children, &i);
>> -	while ((child = next_device(&i)))
>> -		if (sysfs_streq(dev_name(child), name) && get_device(child))
>> -			break;
>> -	klist_iter_exit(&i);
>> -	return child;
>> +	/* TODO: remove type cast after const device_find_child() prototype */
> 
> I do not understand the TODO here.  Why is it needed?  Why not fix it up
> now?
> 

i have below findings during trying to simplify this API.

there are a type of driver APIs for finding device, for example,
(bus|driver|class)_find_device() which all take below type for
parameter @match:
int (*match)(struct device *, const void *match_data)
but device_find_child() take below type with void * for @match_data:
int (*match)(struct device *, void *match_data).

@match's type of device_find_child() is not good as other finding APIs
since nothing will be touched for finding operations normally.

i want to introduce a dedicate type for device match.
typedef int (*device_match_t)(struct device *dev, const void *data);

advantages:
1) device_match_t is simpler for finding APIs declarations and definitions
2) maybe stop further driver APIs from using bad match type as
device_find_child()

TODO:
1) introduce device_match_t and use it for current present APIs
(bus|driver|class)_find_device()
2) change API device_find_child() to take device_match_t, more jobs to
do since need to touch many drivers
3) correct this change by by remove all TODO inline comments and force cast.

not sure if my ideas is good, what is your opinions?

>> +	return device_find_child(parent, (void *)name,
>> +				 (int (*)(struct device *, void *))device_match_name);
>>  }
>>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>>  
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 34eb20f5966f..685ffd2dc867 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -47,6 +47,9 @@ struct dev_pin_info;
>>  struct dev_iommu;
>>  struct msi_device_data;
>>  
>> +/* TODO: unify device match() parameter of driver APIs to this signature */
> 
> Same here, why have this?  Why not unify them and then fix this up?
> 
>> +typedef int (*device_match_t)(struct device *dev, const void *data);
>> +
>>  /**
>>   * struct subsys_interface - interfaces to device functions
>>   * @name:       name of the device function
>> @@ -1073,6 +1076,7 @@ int device_for_each_child(struct device *dev, void *data,
>>  			  int (*fn)(struct device *dev, void *data));
>>  int device_for_each_child_reverse(struct device *dev, void *data,
>>  				  int (*fn)(struct device *dev, void *data));
>> +/* TODO: change type of @data to const void * and @match to device_match_t */
> 
> Again, why leave this here?
> 
> thanks,
> 
> greg k-h


