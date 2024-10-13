Return-Path: <linux-kernel+bounces-362869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DF99BA6E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC542819F1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C961442F2;
	Sun, 13 Oct 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hFAYmPWv"
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87F84A31
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728837360; cv=none; b=FPvm+Wr+Npzo9ZB7ZTgZUjliJvUwO6X+2+m5R6Sh3TdQT3x08rgdWCMQSKFDKUa+3KGHMloOrLbmeJWKGuOHiVZjfeXpn25LEsiaOHnYf+g+HkbmeFK2qWyAhpbJFQC/uW+anfoiCpuJFP02fVDp7my7oIsQXzACAFnnOMU2S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728837360; c=relaxed/simple;
	bh=lY/51Z+aDby2zKYg3ctv52dOLY5gprfICO5H8K1p1r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftr9kK3DSR5xVwSSCuIHXjDal6g6zJofjgNlRwAzR6dUZpc0oWZR0d4Hs3A/QVngojUSpFJHox1xNnJK1HUmMY1iUQygsMzCyvplp/JDXfYbcrxO7OzFS2tFSKc26tcSrjKb9eeyAjzqaUF56BRLXtv3QFb9VWHMkMOnLXWBKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hFAYmPWv; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728837358;
	bh=nHJCwx/aqZaPVRNS9p99M58B+80c+JmT9Gim40ReXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=hFAYmPWvu9UOF8n4YjAr4lwGEOYw2Bb353t+iKEVU0HAJ+XhC3Gfl3rpMwzRybgjW
	 VydIpgVlg0wVQNqph9ifVPgmJyu/KOPFsHv9nzxy3U+nSrIFkfWbTabAUiW4O9+8wV
	 wLjxBKYUw5dTalIrDvPMxUIQ/qqYHb9mglEqg5cWknOE0UE7KmXWNDiAyNqoEYqqrj
	 AYRQ5AKJ/yQOP783zvqfFY2xiUKhzfpTjl+rJoDFaGbJf3+TL7w9GIsopYJXhVF3YG
	 NihZtdmN043IbBD74Co/LmB8WtRY7Z+1IT1ZRFFKCX6lD6iMGupRcLNrqoxdsZ0yAb
	 GEKSlchDxy6Gw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 6FFB52C03ED;
	Sun, 13 Oct 2024 16:35:54 +0000 (UTC)
Message-ID: <a9a011fb-31d0-4ecb-ad8d-540d9761e28d@icloud.com>
Date: Mon, 14 Oct 2024 00:35:51 +0800
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
 <fa08e89d-40d0-41b9-8542-f37f1f716b56@icloud.com>
 <2024101349-handpick-cozy-f19e@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024101349-handpick-cozy-f19e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: M2yavd3OmWBpfPrl4pJc-h9TlvKwNyjs
X-Proofpoint-GUID: M2yavd3OmWBpfPrl4pJc-h9TlvKwNyjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_11,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410130125

On 2024/10/14 00:24, Greg Kroah-Hartman wrote:
> On Mon, Oct 14, 2024 at 12:13:30AM +0800, Zijun Hu wrote:
>> On 2024/10/14 00:00, Greg Kroah-Hartman wrote:
>>> On Sun, Oct 13, 2024 at 11:46:46PM +0800, Zijun Hu wrote:
>>>> On 2024/10/13 23:02, Greg Kroah-Hartman wrote:
>>>>> On Tue, Sep 17, 2024 at 02:53:32PM +0800, Zijun Hu wrote:
>>>>>> On 2024/9/17 14:49, Zijun Hu wrote:
>>>>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>>
>>>>>>> For the following function call chain:
>>>>>>> API driver_register() -> bus_add_driver() -> driver_attach()
>>>>>>>
>>>>>>> There is an error handling path for driver_attach() returning non-zero
>>>>>>> or failure in bus_add_driver(), remove it with below reasons:
>>>>>>>
>>>>>>> - It is impossible for driver_attach() to have failure in bus_add_driver()
>>>>>>>   For int driver_attach(const struct device_driver *drv), the only factor
>>>>>>>   which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
>>>>>>>   the factor has been excluded by bus_add_driver() before calling it.
>>>>>>>
>>>>>>> - driver_attach() is irrelevant with driver_register(), so the former's
>>>>>>>   result should not also have an impact on the later.
>>>>>>>
>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>> ---
>>>>>>> Changes in v2:
>>>>>>> - Remove the error handling path instead of WARN_ON() it.
>>>>>>> - Correct title and commit message
>>>>>>> - Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
>>>>>>> ---
>>>>>>>  drivers/base/bus.c | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>>>>>>> index 657c93c38b0d..54ff92aece92 100644
>>>>>>> --- a/drivers/base/bus.c
>>>>>>> +++ b/drivers/base/bus.c
>>>>>>> @@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
>>>>>>>  	if (sp->drivers_autoprobe) {
>>>>>>>  		error = driver_attach(drv);
>>>>>>>  		if (error)
>>>>>>> -			goto out_del_list;
>>>>>>> +			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
>>>>>>> +				__func__, drv->name, sp->bus->name);
>>>>>>
>>>>>> driver_attach() has __must_check attribute and this error may be
>>>>>> inconsequential for driver_register(), so give pr_warn() here
>>>>>
>>>>> Yes, but you  now ignore the error, so someone will come back and add
>>>>> that error handling in.  I'd just leave it as-is.
>>>>>
>>>>
>>>> driver API driver_attach() may ONLY have below error -EINVAL.
>>>> is it worthy of a __must_check attribute ?
>>>
>>> Yes.
>>>
>>>> i agree with you to leave it as-is if your answer is "YES".
>>>> otherwise, i would like to also simply remove __must_check attribute.
>>>
>>> Please don't.  If you do that, then callers will end up not checking the
>>> results, and we do not want that.
>>>
>> okay.
>>
>> but as 2nd reason of commit message explained:
>> driver_attach() failure should NOT cause driver_register() failure, so
>> should ignore driver_attach() failure here.
> 
> How could driver_attach() fail and it still be ok to continue?
> 
sorry, i am wrong, agree with you to leave it as-is.

driver_attach() failure means driver itself error not attaching it with
devices error. so should cause driver_register() failure even if the
error is impossible here.

thanks.

> thanks,
> 
> greg k-h


