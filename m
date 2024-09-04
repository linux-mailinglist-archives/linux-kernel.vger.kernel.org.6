Return-Path: <linux-kernel+bounces-315442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C596796C2C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFD61F2109C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388BE1DEFF3;
	Wed,  4 Sep 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="CDff8AMx"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9310A12
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464737; cv=none; b=NUcxDHywrVz/AGTeEdH1eoqqM6H8heFnIqpkUKps/e85viVUSACr/kMDG+8JI/+2Yl2lW/VEubmcaGNL6kVKotiHS5kGu7x7tdqO+mzXEuwzhWXG1qyKzDbs9kz1aWlO+2tI/FMXplL/YA7+IM1dTe7Za+f8FCBuOOvZdVcEx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464737; c=relaxed/simple;
	bh=oQfKByoW6TItWmfIS8lcDktw2x2H/L6mS7fxYgGENwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puyfwLrJ2jTJvZVfZXKFpFOoI5iGRHhD+iX2++XVoEEGIMw7B2CPBm7CCHzGDrG4MFnK9qeLU6MpNI9L5vaP7MYkfGXfox4Mkq6QDhg1H60kiKl3cgWx+ZrCZWD3DfN/EbiyoHo4l82S+VK2iom/YjRucO0B8mm30ACfwO1ohW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=CDff8AMx; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725464735;
	bh=umCPpsx3HtqQD+UtRTYVLDcMrB2HE6x81lqyYPTPDvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=CDff8AMxGDLTzDLQpO9M412J7ekuh5mMEMPZ7D0NTKYB9tUIrLXQLldewgmLSSVZ4
	 yFuFYfmdzhX8jCBTXk8xux+BlZVmNJ0ynJQjMp+u1sRN5kIEhz2nqHVNJ3fTaAI0Z8
	 ep1/NwCCzGKYeOnEWOQI29XydmQWN4oy6/a4ZiTYadZNs5cMpqTGSRg6bk6tAAx8H2
	 cMFZrEszki4UdUUh4y+P8WpXMU2zPWlQnd6aR6EtH2aUnzSkHjqOeCp1w3ByWuJhXq
	 mI1Y31s0K1VH8oEwogesqsBwIieeoqekaCSMDpPJRW3at9KgGvO0Pjs9mbzFoEiZSw
	 RINViD4Gt9Qpg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 256FB134A0A6;
	Wed,  4 Sep 2024 15:45:33 +0000 (UTC)
Message-ID: <5a1191d5-beaa-4bf6-9f68-4322cab96edf@icloud.com>
Date: Wed, 4 Sep 2024 23:45:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: Mark impossible return values of
 bus_type's match() with unlikely()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
 <20240904-bus_match_unlikely-v1-1-122318285261@quicinc.com>
 <2024090444-earmark-showpiece-b3dc@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024090444-earmark-showpiece-b3dc@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GeFyMAeg0fk97gYqIDh7Cph8FZX3X1TS
X-Proofpoint-GUID: GeFyMAeg0fk97gYqIDh7Cph8FZX3X1TS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409040119

On 2024/9/4 21:53, Greg Kroah-Hartman wrote:
> On Wed, Sep 04, 2024 at 08:56:42PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Bus_type's match() should return bool type compatible integer 0 or 1
>> ideally since its main operations are lookup and comparison normally
>> actually, this rule is followed by ALL bus_types but @amba_bustype within
>> current v6.10 kernel tree, for @amba_bustype, ONLY extra -EPROBE_DEFER
>> may be returned, so mark those impossible or rare return values with
>> unlikely() to help readers understand device and driver binding logic.
> 
> unlikely() and likely() should ONLY be used when you can measure the
> performance impact.  And any "scan all devices in the bus" function is
> NOT performance critical at all.  So this is not the place for that,
> sorry.
> 

make sense
thank you for these explanation.

>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/dd.c          | 16 ++++++++++++----
>>  include/linux/device/bus.h |  9 ++++-----
>>  2 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 9b745ba54de1..288e19c9854b 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -928,7 +928,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>>  	if (ret == 0) {
>>  		/* no match */
>>  		return 0;
>> -	} else if (ret == -EPROBE_DEFER) {
>> +	} else if (unlikely(ret == -EPROBE_DEFER)) {
>> +		/*
>> +		 * Only match() of @amba_bustype may return this error
>> +		 * in current v6.10 tree, so also give unlikely() here.
> 
> version numbers in the kernel source mean nothing, and they age
> horribly. This is not going to work out at all.
> 
> let's fix up the one user that is doing this wrong and then we don't
> have to worry about it, right?  We have the source for everything, let's
> use it :)
> 
yes, you are right.

my original motivation is to see if it is possible change bus_type's
match() return value type to bool type based on below reasons:

(1)
it is not good time for bus_type's match() to operate device such as
I/O since device may be not ready to operate at that time.

(2)
match() is called without holding device lock firstly by driver_attach().

(3)
all bus_type's match() only do lookup and comparison and return bool
type but @amba_bustype which operate device and maybe return extra
-EPROBE_DEFER

> thanks,
> 
> greg k-h


