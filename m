Return-Path: <linux-kernel+bounces-289243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE5954390
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7339E1C2293F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A181AD7;
	Fri, 16 Aug 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="yw7SDA5P"
Received: from out187-14.us.a.mail.aliyun.com (out187-14.us.a.mail.aliyun.com [47.90.187.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578112C474
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795113; cv=none; b=eoiickM5FQOTnz9cy6FeGyTbOFnXH/AS1jHHDcUEyF+dHJbl5a5EX6GVkDLrIYnPIcbMZAwrUEp+4shbN2Pg6/8Ea4AL5Yt+GLEFXzLgTv8ue+xmbXTDI0LpYoAL+gCwPW6dCdRWP7Lp0TulkX0qoDKFdmop///gJg+fytDkKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795113; c=relaxed/simple;
	bh=JPrziY53lmIaRZNj3oni7Sa9qL5xtqYp4oJ7Z9QfGoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed3Ld3q3Q3VMdNIJvjHyxZfZJv07JGsaSol3LtJhWlZlMy2zgwh8v0D8M5NjHowbpa6DtnyWwIW8nL7hFoYxwVlK0BoLOZIu7z9BTbsIKg0CJDA9ss/YPLCYsoGs/R9qp5deGe321MjFVsYLduDNPSs8kVLK7K0L5lmRFa/RLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=yw7SDA5P; arc=none smtp.client-ip=47.90.187.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723795097; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LExdO87mry8HyL7SOp36JtNIHE4EzuqTMVIvTdhoH/s=;
	b=yw7SDA5PqZ8MZnkEFDluBTYptkTHUvMzcsjUZCKFwc8nrwEv+LvHb9Hw1jO1KZc6GzC3uMSxG5mVfYF7Zov8lFq3mfC4WjG4pYAZgUQ5Hi4rIz6C8OzECW4ZEojMpFsPHV1Zneaemcj6nWUQUBP0jwgKY1pwrEC7QdSKVkzwnIs=
Received: from 30.236.48.76(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Ytc8sKJ_1723795088)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 15:58:16 +0800
Message-ID: <8caaf7d5-a0a0-4888-b467-d8fc84830f8a@antgroup.com>
Date: Fri, 16 Aug 2024 15:58:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] um: Remove unused mm_fd field from mm_id
To: Benjamin Berg <benjamin@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
 <20240816015447.320394-5-tiwei.btw@antgroup.com>
 <3be8448cfb2aeb39e0e73856a701101dc8a0f04f.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <3be8448cfb2aeb39e0e73856a701101dc8a0f04f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Benjamin,

On 2024/8/16 13:59, Benjamin Berg wrote:
> Hi Tiwei,
> 
> On Fri, 2024-08-16 at 09:54 +0800, Tiwei Bie wrote:
>> It's no longer used since the removal of the SKAS3/4 support.
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>>  arch/um/include/shared/skas/mm_id.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/um/include/shared/skas/mm_id.h
>> b/arch/um/include/shared/skas/mm_id.h
>> index 1e76ba40feba..b3571a8afec9 100644
>> --- a/arch/um/include/shared/skas/mm_id.h
>> +++ b/arch/um/include/shared/skas/mm_id.h
>> @@ -8,7 +8,6 @@
>>  
>>  struct mm_id {
>>  	union {
>> -		int mm_fd;
>>  		int pid;
>>  	} u;
>>  	unsigned long stack;
> 
> Maybe we should also remove the union here while at it? It is pretty
> pointless after all.

That makes sense. Will do. Thanks!

Regards,
Tiwei

> 
> Benjamin


