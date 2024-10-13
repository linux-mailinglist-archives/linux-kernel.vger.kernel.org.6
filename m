Return-Path: <linux-kernel+bounces-362865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF67E99BA4C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB241F218DF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1DA1465AE;
	Sun, 13 Oct 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="d9k+MylM"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C3231CB0
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836019; cv=none; b=dCLZHpAjoAX7DYLCEXFKahePdmUiE6ltMA3XCRtU3qk8w4+EzM219Pm9q03RVkvGxsPxzSjywXOnhfUQY7eE0EHjVlL/0b/Z8RRIFhIm2lHbilh3c6vF9FhyWfwt7vFyRG52khq7+xcLkqVUhQHfTX9WHyDNAzKWp6hb1Lv6CJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836019; c=relaxed/simple;
	bh=Si3SRf3BHO3r6eygHyO4/9etXZ5+qbzIUndjJZK6qpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2TLThRSTKNciL1oF8uf1XOps2kF8s27s9RU9nJbNQljGk1Qg6iI3Mo8zQnNNh1dEMJj9Pzt0XYWP8iWSjYBdILMMMHU4AQfm14dZKWpexE4UWbSGvKNV6KFNnQ0j2ZX+7VEijoAgZ78QhTu2zZShGE4b8+jJ9ahGkW722Ci7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=d9k+MylM; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728836018;
	bh=Mo4WligMal5Ff7C76u8LLfr8LyrzxXB7aUAHYy6oDkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=d9k+MylM5gyubSGrmwP/6FEZpO9SF1sunBkJIYBDLI+quhSyXmUzg1ZWNy0twhcER
	 CuunMzvxJlRp/DnOxWAsdj5WNOelvnZc+CfUDod5hrLuVhI7mfgk/WbDd/4sq2VP9V
	 iicTwoXnpMjK4mF/vAyJKBpRFVUU83AWB4VPxRs+RyKRLWR3IH0BplPRkRxHt171eN
	 e14tvKHNqioYScwopHlZD/Ikj9S/D/3CCLF1kn8p3eCTHxD/arN/EX+M/vgY5y6R6g
	 vhw6rpfwelF/DFQv5FTIDj+KE5QZwSogNiNsFBEI9JKEkc3hvjmDT8qO+ATcvWMmkM
	 C9Uvyvpn/Q0fw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 533D7D00278;
	Sun, 13 Oct 2024 16:13:34 +0000 (UTC)
Message-ID: <fa08e89d-40d0-41b9-8542-f37f1f716b56@icloud.com>
Date: Mon, 14 Oct 2024 00:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: bus: Remove an impossible error handling
 path in bus_add_driver()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240917-bus_add_driver_fix-v2-1-a94026443444@quicinc.com>
 <420b202e-e094-4e82-bf77-dd1c62119aa7@icloud.com>
 <2024101316-designing-renegade-6f00@gregkh>
 <c155f97e-b466-4740-ae8e-ce56bcdddf65@icloud.com>
 <2024101333-unrented-bobsled-3ec6@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024101333-unrented-bobsled-3ec6@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KzxHKn8aJz9xqQQKqL36ZzK1mvD6Y0v6
X-Proofpoint-GUID: KzxHKn8aJz9xqQQKqL36ZzK1mvD6Y0v6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_11,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410130122

On 2024/10/14 00:00, Greg Kroah-Hartman wrote:
> On Sun, Oct 13, 2024 at 11:46:46PM +0800, Zijun Hu wrote:
>> On 2024/10/13 23:02, Greg Kroah-Hartman wrote:
>>> On Tue, Sep 17, 2024 at 02:53:32PM +0800, Zijun Hu wrote:
>>>> On 2024/9/17 14:49, Zijun Hu wrote:
>>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>
>>>>> For the following function call chain:
>>>>> API driver_register() -> bus_add_driver() -> driver_attach()
>>>>>
>>>>> There is an error handling path for driver_attach() returning non-zero
>>>>> or failure in bus_add_driver(), remove it with below reasons:
>>>>>
>>>>> - It is impossible for driver_attach() to have failure in bus_add_driver()
>>>>>   For int driver_attach(const struct device_driver *drv), the only factor
>>>>>   which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
>>>>>   the factor has been excluded by bus_add_driver() before calling it.
>>>>>
>>>>> - driver_attach() is irrelevant with driver_register(), so the former's
>>>>>   result should not also have an impact on the later.
>>>>>
>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Remove the error handling path instead of WARN_ON() it.
>>>>> - Correct title and commit message
>>>>> - Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
>>>>> ---
>>>>>  drivers/base/bus.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>>>>> index 657c93c38b0d..54ff92aece92 100644
>>>>> --- a/drivers/base/bus.c
>>>>> +++ b/drivers/base/bus.c
>>>>> @@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
>>>>>  	if (sp->drivers_autoprobe) {
>>>>>  		error = driver_attach(drv);
>>>>>  		if (error)
>>>>> -			goto out_del_list;
>>>>> +			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
>>>>> +				__func__, drv->name, sp->bus->name);
>>>>
>>>> driver_attach() has __must_check attribute and this error may be
>>>> inconsequential for driver_register(), so give pr_warn() here
>>>
>>> Yes, but you  now ignore the error, so someone will come back and add
>>> that error handling in.  I'd just leave it as-is.
>>>
>>
>> driver API driver_attach() may ONLY have below error -EINVAL.
>> is it worthy of a __must_check attribute ?
> 
> Yes.
> 
>> i agree with you to leave it as-is if your answer is "YES".
>> otherwise, i would like to also simply remove __must_check attribute.
> 
> Please don't.  If you do that, then callers will end up not checking the
> results, and we do not want that.
> 
okay.

but as 2nd reason of commit message explained:
driver_attach() failure should NOT cause driver_register() failure, so
should ignore driver_attach() failure here. but driver_attach() has
__must_check attribute, it will has build error if ignore the failure,
so this solution is worked out: if (error) pr_warn().

does this solution meet __must_check attribute ?

> thanks,
> 
> greg k-h


