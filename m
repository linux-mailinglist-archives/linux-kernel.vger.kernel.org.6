Return-Path: <linux-kernel+bounces-362856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D21499BA2B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B61C20C16
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CC13C9A6;
	Sun, 13 Oct 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Y/JbKa79"
Received: from mr85p00im-zteg06011501.me.com (mr85p00im-zteg06011501.me.com [17.58.23.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0202233B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834417; cv=none; b=fp4sc8Sn22SkxmPaGSzKoBJEuTdphLCFwIPl7nxB39gsSsN86f1opZGR8WfQvnNbcnPPb7bf623vu5CxwAQnMgJ9IMQJnTp4B/t/J6TWzxcN/LpDTipzLuL20uaNqtqaKRC2eGyGMIuftUxtqknsz5Us5MobW//B3rKmIbFmzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834417; c=relaxed/simple;
	bh=+9OeE6f/aPK3/5caHauVZFn8lu7gOH3dzlHxW1e8lww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhfyQiH7dTboNTz9M4zVtvaNpmPTsPkcxH5zkpho1LuvsmEoVkL/qD2kErS9JZRz0XvmwLqlwww8SlMtCnSVjcrN6ncOf+K/a5k16of24Gq4ZsvAQFkUJCsxBbnle3A8FKIWE9FvolwHwnJZt3F/KaI+Cb6KhooopJSpg4/wM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Y/JbKa79; arc=none smtp.client-ip=17.58.23.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728834413;
	bh=/eOxJOkSQVlYDJKTQZRHYVtb2T9CgganruDMB01VLVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Y/JbKa79I3HQYyDcHfm4zvqm3ZxJMmDzdM+6PQvo/V/b2HvQO2n+d9YnHldRqCzql
	 UQKi3dMHuUfD9O62EuhWVkxKdcBHrxIo6nys+WxpfCWwqu+jx2o04f4V0u+dIJrJfc
	 K6XsNqN2ddaBuxCb1ayKXr/GT/2FSJei4cnXBFOBnCBh1v6gaeWdD8SJjqx/uj4cq4
	 Ux3ZAa8vWQCECXnxKKxfgTaa8viZ+dMLIjtbpdIqqWH6swW6bT088uEZ5aJqbpXPDq
	 vculJt+QoWi8WpS1kyZnkSDKf7Gc+U/mmXWTO8rBW4paocDDEtj8mN+Mn7bGKvbxOh
	 cOky8uV91NvqA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 1C873480341;
	Sun, 13 Oct 2024 15:46:50 +0000 (UTC)
Message-ID: <c155f97e-b466-4740-ae8e-ce56bcdddf65@icloud.com>
Date: Sun, 13 Oct 2024 23:46:46 +0800
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2024101316-designing-renegade-6f00@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: X3vZgfzQjifDI7bc3KnwqgKt6xzQ6eAk
X-Proofpoint-ORIG-GUID: X3vZgfzQjifDI7bc3KnwqgKt6xzQ6eAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-13_11,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410130119

On 2024/10/13 23:02, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2024 at 02:53:32PM +0800, Zijun Hu wrote:
>> On 2024/9/17 14:49, Zijun Hu wrote:
>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>
>>> For the following function call chain:
>>> API driver_register() -> bus_add_driver() -> driver_attach()
>>>
>>> There is an error handling path for driver_attach() returning non-zero
>>> or failure in bus_add_driver(), remove it with below reasons:
>>>
>>> - It is impossible for driver_attach() to have failure in bus_add_driver()
>>>   For int driver_attach(const struct device_driver *drv), the only factor
>>>   which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
>>>   the factor has been excluded by bus_add_driver() before calling it.
>>>
>>> - driver_attach() is irrelevant with driver_register(), so the former's
>>>   result should not also have an impact on the later.
>>>
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> ---
>>> Changes in v2:
>>> - Remove the error handling path instead of WARN_ON() it.
>>> - Correct title and commit message
>>> - Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
>>> ---
>>>  drivers/base/bus.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>>> index 657c93c38b0d..54ff92aece92 100644
>>> --- a/drivers/base/bus.c
>>> +++ b/drivers/base/bus.c
>>> @@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
>>>  	if (sp->drivers_autoprobe) {
>>>  		error = driver_attach(drv);
>>>  		if (error)
>>> -			goto out_del_list;
>>> +			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
>>> +				__func__, drv->name, sp->bus->name);
>>
>> driver_attach() has __must_check attribute and this error may be
>> inconsequential for driver_register(), so give pr_warn() here
> 
> Yes, but you  now ignore the error, so someone will come back and add
> that error handling in.  I'd just leave it as-is.
> 

driver API driver_attach() may ONLY have below error -EINVAL.
is it worthy of a __must_check attribute ?

i agree with you to leave it as-is if your answer is "YES".
otherwise, i would like to also simply remove __must_check attribute.

int driver_attach(const struct device_driver *drv)
{
  return bus_for_each_dev(drv->bus, NULL, (void *)drv, __driver_attach);
}

int bus_for_each_dev(const struct bus_type *bus, struct device *start,
		     void *data, int (*fn)(struct device *, void *))
{
	struct subsys_private *sp = bus_to_subsys(bus);
	...
	int error = 0;

	if (!sp)
		return -EINVAL;  // this is the only error for the API.
	...
}

> thanks,
> 
> greg k-h


