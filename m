Return-Path: <linux-kernel+bounces-270028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D45A943A52
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6DAB24FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE2140E5F;
	Thu,  1 Aug 2024 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Dy+Wn1IP"
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E8130A7C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470922; cv=none; b=ok1pkSDBkkd1PGz5a0Jp7Bzzam1dXcZ0wZ7M3jRRW1kCWkbv4eVAOMK9/Ox9ZY2d01Ke7GY/wQPiYRNjhme1iXYGcR6/FetkOnHNugdgOFVDfJVPBPOqd2BNFoVQ2OGkpDuRUjNpU98EbJDigaQArCmLq5F/lLxdRzdVI7bMEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470922; c=relaxed/simple;
	bh=TQ5F02pgzaKhx2W+byz6nQtmJsKli2V2+Ojs79PYTsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5JZqU552QHCw0pRb0Wd88XVFPjACUwuxqDtaFEWCpdz4RyAJSnNa/9kTOIVnhOU4DJzWgonMn1f8jS7ZVJenx4emVdGx2rTKs42uQ/ga/1slGY+dHpjyG7092426WNpfZsY5kJp0VYD77GgUi5j05URlltPHu+XqWKro5xlURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Dy+Wn1IP; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722470919;
	bh=Kd57aboH9LpqrAUa930J8jmTFRDDcdRa8xOJ7y45jpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Dy+Wn1IPiY0KxDBc3K9A+74ZiDQG4f/LnB+oJXv2frDFkZMirgyat9inwm6DZhILJ
	 szgoxDy2SY23v/XVdHgk/1/Bef5eNTqjfVS6CeJPrl0/LT65inf3TtIzziFUPYn66T
	 OWJwwfJzkXcNinaB/PSq/4FpaCIZol1ThHF8YNYD202BhyO6wUARdhBUzEVr2wZ0b7
	 kXjeBHKGnMO2V88lHLyHSakLR5UGBcR+scaoX/0KulfFsB7BTC9hYJ0GBVSWA1FNE6
	 +DjY6A7kTAVKBlHJ46bSEF2IWaEb0zm6jV9ERlZhztLfCM1yWqK+GvF7t8VqecdIRU
	 wPV4SS9IEh78Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id 0E9D53A0159;
	Thu,  1 Aug 2024 00:08:36 +0000 (UTC)
Message-ID: <b6dcf753-c262-46d9-bbf6-53b25d0e2bff@icloud.com>
Date: Thu, 1 Aug 2024 08:08:30 +0800
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
 <917359cc-a421-41dd-93f4-d28937fe2325@icloud.com>
 <2024073119-mortally-ashes-80f0@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024073119-mortally-ashes-80f0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NDrRTp5ovitdIFCkpDOrxu-CEYpngSU7
X-Proofpoint-ORIG-GUID: NDrRTp5ovitdIFCkpDOrxu-CEYpngSU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=961 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407310168

On 2024/8/1 00:21, Greg Kroah-Hartman wrote:
> On Thu, Aug 01, 2024 at 12:04:40AM +0800, Zijun Hu wrote:
>> On 2024/7/31 20:53, Greg Kroah-Hartman wrote:
>>> On Sat, Jul 20, 2024 at 09:21:50AM +0800, Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> Simplify device_find_child_by_name() implementation by using present
>>>> driver APIs device_find_child() and device_match_name().
>>>>
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/base/core.c    | 15 +++------------
>>>>  include/linux/device.h |  4 ++++
>>>>  2 files changed, 7 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 730cae66607c..22ab4b8a2bcd 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -4089,18 +4089,9 @@ EXPORT_SYMBOL_GPL(device_find_child);
>>>>  struct device *device_find_child_by_name(struct device *parent,
>>>>  					 const char *name)
>>>>  {
>>>> -	struct klist_iter i;
>>>> -	struct device *child;
>>>> -
>>>> -	if (!parent)
>>>> -		return NULL;
>>>> -
>>>> -	klist_iter_init(&parent->p->klist_children, &i);
>>>> -	while ((child = next_device(&i)))
>>>> -		if (sysfs_streq(dev_name(child), name) && get_device(child))
>>>> -			break;
>>>> -	klist_iter_exit(&i);
>>>> -	return child;
>>>> +	/* TODO: remove type cast after const device_find_child() prototype */
>>>
>>> I do not understand the TODO here.  Why is it needed?  Why not fix it up
>>> now?
>>>
>>
>> i have below findings during trying to simplify this API.
>>
>> there are a type of driver APIs for finding device, for example,
>> (bus|driver|class)_find_device() which all take below type for
>> parameter @match:
>> int (*match)(struct device *, const void *match_data)
>> but device_find_child() take below type with void * for @match_data:
>> int (*match)(struct device *, void *match_data).
>>
>> @match's type of device_find_child() is not good as other finding APIs
>> since nothing will be touched for finding operations normally.
>>
>> i want to introduce a dedicate type for device match.
>> typedef int (*device_match_t)(struct device *dev, const void *data);
> 
> Yes, that would be good.
> 
>> advantages:
>> 1) device_match_t is simpler for finding APIs declarations and definitions
>> 2) maybe stop further driver APIs from using bad match type as
>> device_find_child()
>>
>> TODO:
>> 1) introduce device_match_t and use it for current present APIs
>> (bus|driver|class)_find_device()
>> 2) change API device_find_child() to take device_match_t, more jobs to
>> do since need to touch many drivers
>> 3) correct this change by by remove all TODO inline comments and force cast.
>>
>> not sure if my ideas is good, what is your opinions?
> 
> That's great, but evolve it properly, don't add TODO lines here, there's
> no real need for that.  Should end up with a lot of good cleanup
> changes, and might not be all that bad overall.
> 

okay, thanks for these good suggestions.

let me mark this patch as abandoned now since i would like to do it by
another better way.

> thanks,
> 
> greg k-h


