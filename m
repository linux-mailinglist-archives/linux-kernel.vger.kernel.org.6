Return-Path: <linux-kernel+bounces-277172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47B949D75
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7704DB235B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48235186E59;
	Wed,  7 Aug 2024 01:46:23 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B41186E2F;
	Wed,  7 Aug 2024 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995182; cv=none; b=Lav3FbKlnrnLUx7PIl1vNsJuSGL9rZyhW43F2q2h9ZmOzZxkOKBkpYiPTFe5nOyYlVzgUJrQGUTwUyC74rVmhZwx3N1Yr+N5RTaduNbUd9Lzb/4FUTh80koBXWBQayTIxO+dW6ZTxycqyXMSbzO/jRd14wCnBJQViLz65UgUUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995182; c=relaxed/simple;
	bh=22qXunkwLMmqX0AzHpjao6I1i0DvEDrHbdB2CFJJtNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hb2jO5tjKwWsqamCLWHcM1ZU0KLenxf/D+7Sq4+T+tvyr+ec0NCWhbG08DV81Z3HZIhU6FHgA0kLZPJmI/G20v2W+sp+N4asXN040aKxf3xDPVF3DMPRNlyjxP+tnmLJDEI/kqOn+Ry9h451dUgkYUNGDl51CTd/nn1F9YL0eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdtKJ3YZkzpT1H;
	Wed,  7 Aug 2024 09:45:08 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A656180101;
	Wed,  7 Aug 2024 09:46:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 09:46:17 +0800
Message-ID: <949db1c5-7c62-cdab-767e-486a75c601c5@huawei.com>
Date: Wed, 7 Aug 2024 09:46:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] arm64/kdump: Update the high memory reserve doc
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <will@kernel.org>, <corbet@lwn.net>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240806113320.2388386-1-ruanjinjie@huawei.com>
 <ZrJWarQnhFiM-e17@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrJWarQnhFiM-e17@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/7 0:59, Catalin Marinas wrote:
> On Tue, Aug 06, 2024 at 07:33:20PM +0800, Jinjie Ruan wrote:
>> Since commit 282c3a66b724 ("crash: Fix riscv64 crash memory reserve dead
>> loop"), if reservation from the high memory failed on ARM64, the kernel
>> will not falls back to searching the low memory, so remove it in the doc.
> 
> This commit doesn't exist in -next. I found it with a different hash but
> don't add it in the commit log here.
> 
>> diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
>> index 56a89f45df28..11b9b84bf422 100644
>> --- a/Documentation/arch/arm64/kdump.rst
>> +++ b/Documentation/arch/arm64/kdump.rst
>> @@ -79,10 +79,6 @@ To reserve memory for crashkernel=size,high, searching is first
>>  attempted from the high memory region. If the reservation succeeds, the
>>  low memory reservation will be done subsequently.
>>  
>> -If reservation from the high memory failed, the kernel falls back to
>> -searching the low memory with the specified size in crashkernel=,high.
>> -If it succeeds, no further reservation for low memory is needed.
> 
> I recall long discussions over a year ago where the conclusion was that
> for sysadmins it's easier to have crashkernel=,high the default with
> fallback to lowmem. No need to worry about how much low or high memory
> there is on a SoC, just specify a preference for high memory.
> 
> Can we not have a different fix for the infinite loop problem while we
> preserve the fallback behaviour?

Of course, thank you!

> 

