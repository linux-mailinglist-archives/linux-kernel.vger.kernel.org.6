Return-Path: <linux-kernel+bounces-329868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812709796D9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42891C20B62
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951A81C6890;
	Sun, 15 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vBCsTFG2"
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4712CDBE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726407504; cv=none; b=UejnOCc3BTRRLWyOnBG4qlPfL8Lik4FkHmMSPo8vgvJSQvRTzt8mkaUteN6n5FSE5juu1lrfv6TkGG7YRAMV5YEsCN3roPr1qws+iP/UZPnjWCF7KNUyLfGtEosizH68Xkli7v39vmdxplClVR76OUcMglXbJwBDUN7tqPM7f/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726407504; c=relaxed/simple;
	bh=b4wbDKeIPkB4R7KB68UTrRBBEPPhkscsgNhWIRPiu4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtOcYLtWysc43CH6sCYjXJyPDwH/JLi4FUMPXiPY+IjCzjyzCSNBxjErwQLEMCOY7jEc+pYoNtIYs8O6OYBZR4delvwpytJrOoCMNa7tqsJKgu7y5TpK+1VsRJ1YrN/wlxmpEQbMpVZg+W1xZkGFFEnealHe6V127SAjjzc+0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vBCsTFG2; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726407502;
	bh=n93yyJ2Q2rBxJC7hwfIjWpftqeNHob55u4X+1khhzLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=vBCsTFG2krSgEfnbnhTUdAoWD82Z3jCYfeMNe8/5WzA3cLFHpNx2aLswTPm3oWPxs
	 zR6Sg5rUzyDEcqNJM47UWOSx7UfHA3+26mKvnn097ZUA6uRGybdc3BjfabuJ9OrtA+
	 aiVncBMFCPkwJvfu6neFBwXgF8HMrSce1sZKITIr211em8Pv41XH9Yyqv8m0M1JHQO
	 0LtJy6tbDVsjjdnBLWVKSoNgaRGZWWcYc2heCIqvurFV62WJz+NlwJdbu8IV4rYf0Y
	 H/Pq1jwqIAXMjmAGwUNx5QHXbe0oYSsRjgQXOe2uJB2ECWJdgJ1cpGZl/8kwgnQ+CQ
	 Lsrm/4nrWejEg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id C3F268057D;
	Sun, 15 Sep 2024 13:38:19 +0000 (UTC)
Message-ID: <8620a8a6-9101-4f53-858f-2e09aa310d16@icloud.com>
Date: Sun, 15 Sep 2024 21:38:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: bus: Mark an impossible error path with
 WARN_ON() in bus_add_driver()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com>
 <2024091530-antacid-magical-8302@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024091530-antacid-magical-8302@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ts05HrP8WDi_7iAB-eBMMbzikXVdp0Ar
X-Proofpoint-GUID: ts05HrP8WDi_7iAB-eBMMbzikXVdp0Ar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_05,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409150104

On 2024/9/15 21:00, Greg Kroah-Hartman wrote:
> On Sun, Sep 15, 2024 at 06:22:05PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> driver_attach() called by bus_add_driver() always returns 0, so its
>> corresponding error path will never happen, hence mark the impossible
>> error path with WARN_ON() to remind readers to disregard it.
> 
> So you just caused the machine to crash and reboot if that happens
> (remember, panic-on-warn is enabled in a few billion Linux systems...)
> 
are there good way to mark a if condition which is always or mostly
evaluated to false currently without any side effect?

i think this is a generic requirement since readers may not want to
care about things which will never or rarely happen, below link
involves such discussion:
https://lore.kernel.org/all/2024090444-earmark-showpiece-b3dc@gregkh/

>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/bus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index 657c93c38b0d..59a48edda267 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -673,7 +673,7 @@ int bus_add_driver(struct device_driver *drv)
>>  	klist_add_tail(&priv->knode_bus, &sp->klist_drivers);
>>  	if (sp->drivers_autoprobe) {
>>  		error = driver_attach(drv);
>> -		if (error)
>> +		if (WARN_ON(error))
> 
> What exactly are you trying to show here?  If this really can never
> fail, then let's just remove the check entirely.
> 
what i want to show is that this error patch will never happen here
currently, so readers can disregard it.

let me try to do it after discussion done.

> thanks,
> 
> greg k-h


