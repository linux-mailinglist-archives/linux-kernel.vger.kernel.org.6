Return-Path: <linux-kernel+bounces-276194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CA948FC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EBC1F23309
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB001C6891;
	Tue,  6 Aug 2024 12:56:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753601C578D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949017; cv=none; b=k3Ec+ma/UWqDVTkctQmVIRAWS5Leppq+rlUU/Ti6ipNuDCowWHyekZkMq2RyLbP1m0LKJ0yLh4W5Lo3vqi7/mjdotfC7XTbJ7ViqLFE2dKkvDDyqXuxoL4nvfq+g5PwiWMCBS5njm14Lf+xqzLB7b7l1SzuDC4WsFvCrM0oQH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949017; c=relaxed/simple;
	bh=FNLkamIh+O8lfw9ET0UoohqpCcD8zI/XkDhxGy4zyMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IiW+gaQZy5rWQNbs+eUKO2awhMEgxa2Bf37KwrjJk8AQN5U5r8/YZ9K0E3kpVpzISTpqFOOxBLfojiwIWqVS6zFKxbDIh0RUAnMXyQkXx6/uYcHT3z0Y5sFnJ3uv07fDS+bqxazck/bhhd55LqgE6nd61cK1+65ne9pU13+pyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WdY9l24F4zQnYT;
	Tue,  6 Aug 2024 20:52:27 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id F1CDD18009B;
	Tue,  6 Aug 2024 20:56:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 20:56:52 +0800
Message-ID: <fa26e911-adb1-8410-5e7c-1ca5a1302e77@huawei.com>
Date: Tue, 6 Aug 2024 20:56:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] powerpc: Fix a config comment typo in asm/percpu.h
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>, <dennis@kernel.org>,
	<tj@kernel.org>, <cl@linux.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<naveen@kernel.org>, <linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20240806112345.2387969-1-ruanjinjie@huawei.com>
 <135289c2-78bc-4a14-ad43-6d45750af293@csgroup.eu>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <135289c2-78bc-4a14-ad43-6d45750af293@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/6 20:50, Christophe Leroy wrote:
> 
> 
> Le 06/08/2024 à 13:23, Jinjie Ruan a écrit :
>> [Vous ne recevez pas souvent de courriers de ruanjinjie@huawei.com.
>> Découvrez pourquoi ceci est important à
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> commit 0db880fc865f ("powerpc: Avoid nmi_enter/nmi_exit in real mode
>> interrupt.") has a config comment typo, fix it.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   arch/powerpc/include/asm/percpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/percpu.h
>> b/arch/powerpc/include/asm/percpu.h
>> index 634970ce13c6..c836b16ce30d 100644
>> --- a/arch/powerpc/include/asm/percpu.h
>> +++ b/arch/powerpc/include/asm/percpu.h
>> @@ -23,7 +23,7 @@
>> DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
>>                  (static_key_enabled(&__percpu_first_chunk_is_paged.key))
>>   #else
>>   #define percpu_first_chunk_is_paged    false
>> -#endif /* CONFIG_PPC64 && CONFIG_SMP */
>> +#endif /* CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK && CONFIG_SMP */
> 
> The #if/#else/#endif section is small and doesn't nest additional
> #ifdefs so the comment is useless and should be removed completely.

OK, I'll send v2 to remove it, thank you!

> 
> Christophe
> 

