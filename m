Return-Path: <linux-kernel+bounces-281809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5F94DB94
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E652813F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D514C5B5;
	Sat, 10 Aug 2024 08:46:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE814A4F3;
	Sat, 10 Aug 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279593; cv=none; b=EMmtdVcCA/pdC78ELDaWsRX7C/3X4Lvv7cqMibcgjOTqcJwjUDVs7yTohR9kTTFJgryTACvur06PYKf7a0AghnzaDGcadTchTUACemPaQKcR5FyN9+Z6UKBng/R/wq6I7rylx6hy2VEwZdQDq80+yNpMqqF9o6qk5WTaNmwxvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279593; c=relaxed/simple;
	bh=tpqFHf0QIbN/O8DLROx1XHLRwAw5pEui3Bz2WpLB65E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cYfIC2NSTrehzrkzzwlxVHEyHDzYxJ6xRCnMJlIqmPK4uZL3/q5f/f+HzcD2hnRJD/ebrB/bLkVSJ7Ak5G+vUqMzxt54ksA13DG4dudm735sUQ2wOofod+5GOhvDphJQH/zy/wBb9PR0uroRXWWofcpuqlklEToluJHlWTrHLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WgvWZ2x6WzyP7L;
	Sat, 10 Aug 2024 16:46:02 +0800 (CST)
Received: from kwepemf500010.china.huawei.com (unknown [7.202.181.248])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FB281800FF;
	Sat, 10 Aug 2024 16:46:27 +0800 (CST)
Received: from [10.174.177.238] (10.174.177.238) by
 kwepemf500010.china.huawei.com (7.202.181.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 10 Aug 2024 16:46:26 +0800
Message-ID: <40a701a9-8c96-7fca-b043-6ca27847e151@huawei.com>
Date: Sat, 10 Aug 2024 16:46:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Documentation: dontdiff: remove 'utf8data.h'
To: Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <guoxuenan@huaweicloud.com>,
	<jack.qiu@huawei.com>, <ganjie5@huawei.com>
References: <20240808085707.3235019-1-guoxuenan@huawei.com>
 <87sevfp30w.fsf@trenco.lwn.net>
Content-Language: en-US
From: Guo Xuenan <guoxuenan@huawei.com>
In-Reply-To: <87sevfp30w.fsf@trenco.lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500010.china.huawei.com (7.202.181.248)

Hi Jon,
On 2024/8/8 21:17, Jonathan Corbet wrote:
> Guo Xuenan <guoxuenan@huawei.com> writes:
>
>> From: ganjie <ganjie5@huawei.com>
>>
>> Commit 2b3d04787012 ("unicode: Add utf8-data module") changed the
>> database file from 'utf8data.h' to 'utf8data.c' to build separate
>> module, but it seems forgot to update Documentation/dontdiff. Remove
>> 'utf8data.h' and add 'utf8data.c'.
>>
>> Signed-off-by: ganjie <ganjie5@huawei.com>
>> ---
>>   Documentation/dontdiff | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
>> index 3c399f132e2d..94b3492dc301 100644
>> --- a/Documentation/dontdiff
>> +++ b/Documentation/dontdiff
>> @@ -262,7 +262,7 @@ vsyscall_32.lds
>>   wanxlfw.inc
>>   uImage
>>   unifdef
>> -utf8data.h
>> +utf8data.c
>>   wakeup.bin
>>   wakeup.elf
>>   wakeup.lds
> I'll apply this, but does anybody actually use the dontdiff file
> anymore?  I think it's old and, if being used, actively harmful; for
> example, it masks changes to "parse.c", an instance of which was added
> to git in January.
>
> Is there a reason to not just remove this file?
Completely agree，It seems fs/unicode module missing to update `dontdiff`
I've actually never used it, seems that developers likely using .gitignore.
eg. 98f2345773f（"unicode: fix .gitignore for generated utfdata file")

Thanks
Xuenan
> Thanks,
>
> jon

-- 
Guo Xuenan [OS Kernel Lab]
-----------------------------
Email: guoxuenan@huawei.com


