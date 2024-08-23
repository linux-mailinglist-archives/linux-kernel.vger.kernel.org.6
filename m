Return-Path: <linux-kernel+bounces-299661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A495D851
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD391F2289B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA21C7B97;
	Fri, 23 Aug 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="aWa+ppi6"
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12D1953BA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447534; cv=none; b=BgtSR6ZYVadpUevPhecWqRxoM5Gxmqz1en2nJka+O3NJB1ZRFp+mqJx+BOQ8wNEqYbu/PVrMZdR4X3kOjSNC+yy67mf6P59fgV7FzpuCGz+8vrgMbdXAIV45HpIPaUu0jAuGu4VnFA0STaJQ9AIhodP6lC1bx7rB58V7DpD7+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447534; c=relaxed/simple;
	bh=EpAGpeq/cxRnxGHLxCPSegH6tgHoYbyAJTWf1ec6bqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bikZLO//SyKjoc+cEODMCtpddSwnWI8HBPxwyG64sDnGencoGVTfzFghhY1ySqEnsTeyWuuaSPulLQInyGy7F2+Yl9ZSA+9A5g69pkBbKj0m/vj3Y6n0PvmquO2SHnut2bXIwMUi/v4NAbUS1ae96LNlTmng76fo3FFsEMMeM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=aWa+ppi6; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724447532;
	bh=RM1/5wwL/1lyKRUBcoYwRdzQVvNlFSouwKdlsl8krSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=aWa+ppi6TeGqzUyK/yUqAyux0SvHO2qDaAT1cPXTKUWe7HOpJOIVMl+WqqUF6/kPg
	 JlyUdSETFHFSRxIW28KCL0DkgmJfZfeKFwRKITtqSCFWzTJLcpbz+CDUvfjEC+8PAQ
	 dVfdnaYE4bPNJ+OvD4hZlGrhxxfSm6+Mh4gHN6t0Tm48xVWISY8Dp6u06bCUcaWWDR
	 Kn1oOfYXYIavbZ3Yek2TJbweOdJUwbRr43BN4N2y2Cut6mkhacKXs/Xa+ak+sTnsij
	 s+H8r+jStwtGhkbJc0VPX/HB+je/3CVPr4kt7xACB3TQevdlHxq/rjYJ9Mtkpfpwan
	 uY6sXhrgpocmw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id B8F7E800269;
	Fri, 23 Aug 2024 21:12:08 +0000 (UTC)
Message-ID: <7a464c15-d42e-408f-9b7e-55263299f1e1@icloud.com>
Date: Sat, 24 Aug 2024 05:12:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] driver core: Explicitly initialize struct member
 @data.have_async in __device_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240823-fix_have_async-v2-1-ed1039527365@quicinc.com>
 <Zsiw_cUgoXEcY7io@google.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Zsiw_cUgoXEcY7io@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hCI8pP6eih6PnDTo8ZKyVUqmtdIj_pZM
X-Proofpoint-GUID: hCI8pP6eih6PnDTo8ZKyVUqmtdIj_pZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=958 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408230157

On 2024/8/23 23:55, Dmitry Torokhov wrote:
> On Fri, Aug 23, 2024 at 08:00:14PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> __device_attach() relies on compiler to implicitly initialize struct
>> member @data.have_async to avoid the member is used before initialization
>> but readers may not understand that, solved by explicitly initializing
>> @data.have_async as well as existing @data.want_async.
> 
> I do not believe this is needed. We require kernel developers be
> familiar with the language of choice for the kernel.
> 
> We have a ton of partial or empty structure initializers in the kernel.
> If we count only empty non-static ones I see:
> 
> dtor@dtor-ws:~/kernel/work $ git grep '= \?{ \?};' | grep -v static | wc -l
> 5707
> 
> Rough count of partial initializers is (might be over eager and some
> of them could be full ones, on the other hand it does not count
> initializers that span multiple lines and start with opening brace
> only):
> 
> dtor@dtor-ws:~/kernel/work $ git grep '= \?{ \..* };' | grep -v static | wc -l
> 1150
> 
> Are you planning to go through all of them and add complete
> initializers? And keep adjusting them when structures will get extended?
> For what gain?
> 
actually, many partial initializers is proper, for example, we don't use
these fields that are implicitly initialized, for example, another usage
of the same same in the file drivers/base/dd.c.

no, let me take time to check if there are other usages in kernel tree
similar the one we discuss.

> There was no readers confusion, you wrote a tool for C static analysis
> that did not follow C standard and gave you a false warning. Please fix
> your tool instead.
> 
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Changes in v2:
>> - Remove both fix and stable tag
>> - Correct both title and commit messages
>> - Link to v1: https://lore.kernel.org/r/20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com
>> ---
>>  drivers/base/dd.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 9b745ba54de1..b0c44b0846aa 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -1021,6 +1021,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>>  			.dev = dev,
>>  			.check_async = allow_async,
>>  			.want_async = false,
>> +			.have_async = false,
>>  		};
>>  
>>  		if (dev->parent)
>>
>> ---
>> base-commit: 87ee9981d1f86ee9b1623a46c7f9e4ac24461fe4
>> change-id: 20240823-fix_have_async-3a135618d91b
>>
>> Best regards,
>> -- 
>> Zijun Hu <quic_zijuhu@quicinc.com>
>>
> 
> Thanks.
> 


