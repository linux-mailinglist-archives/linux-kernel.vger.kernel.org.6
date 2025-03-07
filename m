Return-Path: <linux-kernel+bounces-550340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD9EA55E21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB4F7A36CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7F18CBFB;
	Fri,  7 Mar 2025 03:16:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88729408;
	Fri,  7 Mar 2025 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317403; cv=none; b=j5VOOMW5StWbFxfq+27EXKlhZVIJ07IJn9P4G9pdD/C8QSNq0qmxI+sUIF9ItK8gdF164TFyF0fxkyYAPwrti+HYM83QPzBZS3edU4aLfD3IEb6vbCOLhI5Xq2mF5KnpT7q9cEkwE7Z0WJEU1GwXNLfKkIfNZQQKerb5cihLkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317403; c=relaxed/simple;
	bh=zUvXikN8bxMHia3xeJ7XhbVG/7tEYVBGwGZ5hGrnaBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IRAloSfIuVp8mo0nJQ5vJwN368sEfVEBQOhMtswyqd1OEniYuWJRwzIozuBV9XbQl7eHnSCT4hzTPRQ/LG70J6dwJse3byTeNNlSL0/vLWBH0KswEI6mXgfJ04OQQNxB9mokG6mhoIgJy9gbSBsx1qdErSOMGLVcT+l7kEpB5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z8BFF4VjWz9wPj;
	Fri,  7 Mar 2025 11:13:21 +0800 (CST)
Received: from kwepemd100020.china.huawei.com (unknown [7.221.188.213])
	by mail.maildlp.com (Postfix) with ESMTPS id 54C111400CF;
	Fri,  7 Mar 2025 11:16:30 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by kwepemd100020.china.huawei.com
 (7.221.188.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Mar
 2025 11:16:29 +0800
Message-ID: <0bea64d3-34bd-4c4f-8386-ce29acaf5f6c@huawei.com>
Date: Fri, 7 Mar 2025 11:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2022-49623: powerpc/xive/spapr: correct bitmap allocation
 size
To: Greg KH <gregkh@linuxfoundation.org>, <nathanl@linux.ibm.com>,
	<mpe@ellerman.id.au>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "youbowen (A)" <youbowen2@huawei.com>
References: <0af1c796-aa08-4284-ae6b-470fa75799b5@huawei.com>
 <2025030618-opal-chomp-5731@gregkh>
From: "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <2025030618-opal-chomp-5731@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100020.china.huawei.com (7.221.188.213)

Yes, there is still some confusion about this bugfix patch. Hope Nathan 
and Michael can explain and give more details.

在 2025/3/6 21:58, Greg KH 写道:
> On Thu, Mar 06, 2025 at 09:41:41PM +0800, zhangjianhua (E) wrote:
>> Hi Greg，
>>
>> The commit message of this patch show that it occurs out-of-bounds of
>> xibm->bitmap，the reason is that the allocated object can be smaller than
>> sizeof(long) while bits is small.
>>
>> However, it is incorrect.  The kzalloc interface allocates memory in the
>> unit of byte while bitmap_zalloc does based on the number of bits after
>> rounded up, the space allocated by the kzalloc is not less than that
>> allocated by the bitmap_zalloc. Therefore, replacing the kzalloc with the
>> bitmap_zalloc does not solve the problem. In fact, the problem of
>> out-of-bounds access does not exist. For instance the xibm->count is
>> 3，kzalloc and bitmap_zalloc both return 8 bytes，it's enough for all
>> bitmap. Although using the kzalloc wastes some memory, it does not create
>> any real problems.
>>
>> Maybe this CVE should be rejected?
> We will be glad to reject this if you think this does not actually fix
> anything at all.  If so, just let us know.
>
> thanks,
>
> greg k-h
>
>

