Return-Path: <linux-kernel+bounces-364360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F999D3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BDEB2BE64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A91AE863;
	Mon, 14 Oct 2024 15:40:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1771AAE23
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920457; cv=none; b=rv1k30SC3ZDfWWILWsAMZtLRmhGLDcJaqIUbIXxlzuWhO6LZuGiN+B31h96b57qlTyGjYHGv97xnNJSlUb4jPt0WD6DIxq4qFHKw5otU9+mOgL3sFQeCqaZiq6IMaRDq1D4VpY2FjSwTGvSAGU+5jo8D5qvHJLqZieGuqih74X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920457; c=relaxed/simple;
	bh=p1Vg17F35a1DEGWtU5hHwKxhHXUlMzvJhVOjq/pbIz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/8zyNiQV62XIMC+jfPINRCDf8YFYZzL2ayvpEm1fX/VC20mJzvNNULHX94nrXHwvnrQWVIZ+K0IApCadKqQgmpbzcS3EePk47/sdTkbg++IYC9JVPU2oxhb5rTJi9NMoZlYPrDUC0ixfy4UGbC2YpjGzx1AjWUZOaO1l+CkYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 518851007;
	Mon, 14 Oct 2024 08:41:24 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 149033F51B;
	Mon, 14 Oct 2024 08:40:53 -0700 (PDT)
Message-ID: <24019386-6ecc-4715-9486-503ccc828113@arm.com>
Date: Mon, 14 Oct 2024 16:40:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm-ccn: remove unused macros
To: Mark Rutland <mark.rutland@arm.com>, Ba Jing <bajing@cmss.chinamobile.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241012091629.2369-1-bajing@cmss.chinamobile.com>
 <ZwziGzex9RmVlcNa@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZwziGzex9RmVlcNa@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 10:19 am, Mark Rutland wrote:
> On Sat, Oct 12, 2024 at 05:16:29PM +0800, Ba Jing wrote:
>> By reading the code, I found these marcos are never
>> referenced in the code. Just remove them.
>>
>> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> 
> These are control bit values, so I don't see a strong reason to delete
> them unless we're certain we're not going to use them in future.
> 
> Anyhow, Robin Murphy wrote this driver, so its up to him. Please Cc him
> for any changes to this driver in future.

Er, this is CCN - FWIW I didn't claim this one, nor CCI, as supported in 
my maintainers entry largely because active development on them has long 
finished, but also because I *didn't* write them, so wouldn't claim to 
understand them much better than you or Will do ;)

However, I'd agree that there doesn't seem to be any significant benefit 
to removing these (certainly showing at a glance that ALL_ERRORS_DISABLE 
is composed equivalently to PMU_EVENTS_DISABLE seems like no bad thing.)

Thanks,
Robin.

> 
> Mark.
> 
>> ---
>>   drivers/perf/arm-ccn.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
>> index 5c66b9278862..ea878b025d32 100644
>> --- a/drivers/perf/arm-ccn.c
>> +++ b/drivers/perf/arm-ccn.c
>> @@ -28,12 +28,7 @@
>>   
>>   #define CCN_MN_ERRINT_STATUS		0x0008
>>   #define CCN_MN_ERRINT_STATUS__INTREQ__DESSERT		0x11
>> -#define CCN_MN_ERRINT_STATUS__ALL_ERRORS__ENABLE	0x02
>> -#define CCN_MN_ERRINT_STATUS__ALL_ERRORS__DISABLED	0x20
>>   #define CCN_MN_ERRINT_STATUS__ALL_ERRORS__DISABLE	0x22
>> -#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_ENABLE	0x04
>> -#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_DISABLED	0x40
>> -#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_DISABLE	0x44
>>   #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__ENABLE	0x08
>>   #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLED	0x80
>>   #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLE	0x88
>> -- 
>> 2.33.0
>>
>>
>>

