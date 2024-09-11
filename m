Return-Path: <linux-kernel+bounces-324932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A37D9752E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E493DB215AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2718EFC6;
	Wed, 11 Sep 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rNa/G4zY"
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D89186E24
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059058; cv=none; b=NBWUeKu5d0vCzFP4h5gOigGGYouOX2iqRyvqqgRa3R/kA5RymtxfhK1MQLr+ECuEfYa63eyiv0HhBNN5FFm+zw/otBBV+/M+ckYGiSCtWRDLKvI+/pXCxopzd5+/oCNHXrHHG4VaUXhwMv8LxprgIRTu4dqbZF6XQDwDEPtNtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059058; c=relaxed/simple;
	bh=rUlk53nCs8wQTy1Jnv68tMjamj2WRFiaO88QhPgjPwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8WHDNHCun3DV2AZSklqYry3K0OLdjEmg6fBg8FbpHR/dSCCoL7rrVzPwnr81yT6RSpdZ6rs6r/G7RBJoVMfssd7ZD4mZwiNxX1+m97W69+325rPspFM0eKwZLsKXyj+9p7/aaVep63gsXyzDyXqrBHTnpF22881NZc0Q2ch4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rNa/G4zY; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726059056;
	bh=dIxIGAOzGqO3/gRpEdeu9pBJ0+fcxciA86JJF6+iX1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=rNa/G4zYuUnuikWDaXiO2ZgPdNUi4eXgYqY/fZHBBCOfdpt0EbQxGlAvD54TEYGHG
	 FxTC0EDclR/WZ6airbMvmfBwM4AdPQE+7xx4Vnf8+RdquV317X+Pk7vGnxAjaMyK1C
	 bbh/zj6zEvZlVDEQEmMrJIUBEUvvfJ5BWRfBhmTDLAiguN2NBMXx+msNnJ9YcqXXKI
	 4StSUsc4lryJc6qILSb5yt0LNRyh2iwhbL2uThQB3EjsoIKa8sVF3nAJ0bFZuCY2U5
	 Dp/g2CbJfJ1gyZX0rHxhqSrKn70rgBtvz/UwDfRWOcxWYPEXnY056vlQDLmoHgDWSp
	 zGnjYkHoNp8+Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 24FB21802DB;
	Wed, 11 Sep 2024 12:50:52 +0000 (UTC)
Message-ID: <343ef9ea-12ab-4ca6-bd9a-fc01bbf9962b@icloud.com>
Date: Wed, 11 Sep 2024 20:50:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
To: Saravana Kannan <saravanak@google.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
 <CAGETcx9X0m3=8PPtVsHp=AAjyCoUZ0-53H5RzVd4HCDtWRS0Fw@mail.gmail.com>
 <a4cf15fb-bbaa-4ed0-a1d5-c362b7a5c6e2@icloud.com>
 <CAGETcx_YMUXRLye3OUOQ9O4Cw9nqLcVOts0hTMgORuLmQ7tAZw@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <CAGETcx_YMUXRLye3OUOQ9O4Cw9nqLcVOts0hTMgORuLmQ7tAZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y3vEPo04vj16E46xNRPXHIMaxQB7tuM4
X-Proofpoint-GUID: Y3vEPo04vj16E46xNRPXHIMaxQB7tuM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409110096

On 2024/9/11 00:27, Saravana Kannan wrote:
> On Tue, Sep 10, 2024 at 5:17 AM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> On 2024/9/9 15:24, Saravana Kannan wrote:
>>> On Sun, Sep 8, 2024 at 4:38 PM Zijun Hu <zijun_hu@icloud.com> wrote:
>>>>
>>>> This patch series is to make amba_match(), as bus_type @amba_bustype's
>>>> match(), also follow below ideal rule:
>>>>
>>> Also, patch 3/3 is not at all easy to understand and seems to be doing
>>> way more than what the commit message is trying to do.
>>>
>>
>> thanks for your code review.
>>
>> let me explain the issue here firstly to go on with discussion, will
>> correct it by next revision.
>>
>> amba_match(), as bus_type @amba_bustype's match(), operate hardware to
>> read id, may return -EPROBE_DEFER consequently.
>>
>> this design is not very good and has several disadvantages shown below:
>>
>> 1) it is not good time to operate hardware in a bus_type's match().
>>    hardware is not ready to operate normally in a bus_type's match()
>>    as driver_probe_device() shown, there are still many preparations
>>    to make hardware to operate after a bus_type's match(), for example,
>>    resuming device and its ancestors, ensuring all its suppliers have
>>    drivers bound, activating its power domain, ...
>>
.....

>> 5) amba_match() is the only bus_type's match which breaks below ideal
>> rule in current kernel tree:
>>    bus_type's match() should only return bool type compatible integer 0
>> or 1 ideally since its main operations are lookup and comparison normally.
> 
> All of this used to happen even if the bus match wasn't doing what
> it's doing today. You don't seem to have full context on how amba
> devices are added and probed. What you see now is a clean
> up/simplification of how things used to work.
> 
> Please go read this patch history and git log history for these files
> to get more context.
> 
> Nack for the entire series. It'll never go in.
> 

sorry, not agree with you.

IMO, it is easy to make amba_match() return bool type as shown below:

make amba_match() always match with AMBA device with INvalid periphid
and move reading id operation into amba_dma_configure().

Above solution can have the same logical as current one but it looks ugly.

so i make below optimizations to get this patch series:

1) only make AMBA device with INvalid periphid match with existing empty
   amba_proxy_drv to reduce unnecessary reading id operation.

2) moving reading id operation to amba_probe() looks more graceful.


Look at below 3 consecutive history commits:

git log --pretty='%h (\"%s\")' 656b8035b0ee -3
Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
bus_type.match()")
Commit: 17f29d36e473 ("ARM: 8523/1: sa1111: ensure no negative value
gets returned on positive match")
Commit: 82ec2ba2b181 ("ARM: 8522/1: drivers: nvdimm: ensure no negative
value gets returned on positive match")

the first AMBA related commit breaks that a bus_type's match() have bool
type return value.
the remaining two commits at the same time really do not like negative
return value for a bus_type's match().

thanks
> -Saravana
> 
>>
>>
>> Our purpose is to solve this issue then enforce the ideal rule mentioned
>> in 5).
>>
>> so we send this patch series to start a topic about how to solve this
>> issue (^^).
>>
>>> -Saravana
>>>
>>
>>


