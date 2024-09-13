Return-Path: <linux-kernel+bounces-328866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9341978A22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A60285592
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1614B97E;
	Fri, 13 Sep 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nMKOMQgi"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE61465A4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260251; cv=none; b=Wdfn27BAVQtlZAmn/2ReKDZ0C0oh4+COldnYToPTo9Fv08X3NH3dmjiBMtJzWYlQvsj9F7Vf5iyq1mBlI3+P8bgumq52L5XsoAVk3xtcCOidanwGaYz36QaYPGJj8neknJxAsfwmkvFXTbIdwvBPJjJHNellLoW2hWhNcoMJt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260251; c=relaxed/simple;
	bh=H4vWfCLYluyPcc16zgufsSJ4XZrgR6TJoZE6xbO6Sc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWP+JK+q38geUaz2/nJTtAJRYcOGz15WsArl6M5S3Z6VdLsMzjUNRI+p5abEGzHw8M+P7oBQJwrb72clrOzyJBAEtDl/QzDVWgPh9pim3tBNti3vKDJ3VFeudm1Wa719fXlNF3V0WOoYJlEf4MF9Ip3vi1/B54pyoFc5ImUae3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nMKOMQgi; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726260249;
	bh=/5mvMNhP2NPf26rTLxEYfkHPz1uSgDItfvATSNuxyyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=nMKOMQgiBR4J9L68WUkE9rgO7INLuJcBHPhHcDctjWIyXWH7/O+wTlcSN9Dozr4KY
	 6zKeNBtXfr5UWvvqTHQRPZDmCpNwks+ZFG/YArtSNVFQ8udr/KDsnReRgTv9hpci3m
	 p3CcoGBhML7Ye34bigtqnAEGYKPtErMd1DK7CZI4jgVCBiNC5YNgM3T+NXN6BpFadl
	 izCFOuUbY4zjQCPYmaXSUEJ3gLuDMGmp0bZ0kb4mZcoutYVkbtEtIUSjX09GJfXQda
	 PoEw3X581rHOSVcUHvoOG5IaKKhavafu7kQ3piIRVmQTSenvPLAL79Fl5fBjFm5img
	 3nkqFXnFblpFw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 877676808C5;
	Fri, 13 Sep 2024 20:44:06 +0000 (UTC)
Message-ID: <692e27c4-a370-4920-819c-588f09892a3a@icloud.com>
Date: Sat, 14 Sep 2024 04:44:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] driver core: Explicitly initialize struct member
 @data.have_async in __device_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240913-fix_have_async-v3-1-793707cfc0d1@quicinc.com>
 <ZuR4w5l7kLkwSAQS@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <ZuR4w5l7kLkwSAQS@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KqdZkWRyQWQyGdKudIYSS--WBpOsb7rc
X-Proofpoint-ORIG-GUID: KqdZkWRyQWQyGdKudIYSS--WBpOsb7rc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409130147

On 2024/9/14 01:39, Dmitry Torokhov wrote:
> Hi,
> 
> On Fri, Sep 13, 2024 at 10:05:38PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> __device_attach() defines struct device_attach_data @data as auto
>> variable and needs to use both @data.want_async and @data.have_async
>> but it explicitly initializes the former and leaves compiler implicitly
>> initialize the later, that does not have an elegant look, solved by
>> explicitly initializing the later member as well that also makes @data
>> have full initialization.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> IMO, this change still has a little bit of value as explained below:
>>
>> - Looks at below similar commit:
>> Commit: 8f45f5071ad2 ("gpu: host1x: Explicitly initialize host1x_info structures")
>>
>> - This change's initialization way is obvious better than
>>
>> struct device_attach_data data = {
>> 	.dev = dev,
>> 	.check_async = allow_async,
>> };
>>
>> which is better than current
>>
>> struct device_attach_data data = {
>> 	.dev = dev,
>> 	.check_async = allow_async,
>> 	.want_async = false,
>> };
> 
> Unlike host1x_info structure from commit 8f45f5071ad2 that you
> referenced, which sole purpose is to describe hardware, this is an
> internal structure in drivers/base/dd.c that mixes together scan
> parameters and internal state/result. The scan parameters are
> initialized explicitly to convey the exact request (i.e.  for given
> device we want to try to attach a driver synchronously, but also we
> might be interested in knowing if there is a matching driver that
> supports asynchronous probe), the state is not mentioned not to draw
> attention from the particulars of the request.
> 
> I'll leave this to Greg to decide if we wants to apply this change (I
> would not), but if you are doing this you need to make similar change
> for the 2nd instance of struct device_attach_data.

sorry, not follow you here

the 2nd instance in __device_attach_async_helper() is good as explained
below:
	struct device_attach_data data = {
		.dev		= dev,
		.check_async	= true,
		.want_async	= true,
	};

1) it is a normal usage to ONLY explicitly initialize these fields that
can't be implicitly initialized by compiler.

2) user does not care about @data.have_async, namely, it is NOT used
later to decide later logic for 2nd instance.

> 
> Thanks.
> 


