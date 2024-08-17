Return-Path: <linux-kernel+bounces-290578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3719555E3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 08:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069B0282579
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606712BF25;
	Sat, 17 Aug 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HdUbmn1k"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F243152
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723877499; cv=none; b=HC8Y2chMf2XoDaZ2992CUpbbcKCCXZUrm8nv3c+zme2OhV5oVMJkUxO4kORdCy3QfpbJBVGx5fGDXvCkcY6XpsJhDGiYEvd9SYs5udA82GyhD7LhCfhUA3jWnERveuJLNJKEkpNzns5ryywzWVToBD6hY9nQWd12DgpWhuf24W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723877499; c=relaxed/simple;
	bh=gjPfS0o1eSrCiNE+IyL7BL3nfcBNE/eWu+Hgp89atGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQiyGk1ukf28qLF/BnmIjm0q2n3xMOk8d1N5nImh5TbiK7d91TIBSsVW9JVVmeiWAVzce7DvWsReZ2LVng0G8/jipuXaLx4gvYWrnbzCNR2Jzk9XlrNu9RNFOXPMqC5tPPf/P/fsHvpm16BdbWn6tBVo/NVzlM5UXdPmAfQxc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HdUbmn1k; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ca021d4-9cce-4402-8a4e-104df6459bc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723877495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McP28WfNwniewkfzNc6RfLqw1V/Rhkl3Ejq5OhUSXCQ=;
	b=HdUbmn1kPJ0Vx98cmOJHhc0lpi6iHBfwmPksAa48UGrXiA8iXpApfwUQtmkyaBbEQ8XBL3
	CMReN/w+NgzTGZdI9yU2+hSvcPXUbhjZoSYRANaypKBWfT2xgwzFOOFxJaTdB6EzYtCyZO
	Jk+e0LOsETkLD9pGVN2cFjwtJvarTOE=
Date: Sat, 17 Aug 2024 14:51:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Bart Van Assche <bvanassche@acm.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <d698161b-f9f4-490b-98a5-b51d739d4136@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <d698161b-f9f4-490b-98a5-b51d739d4136@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/17 1:09, Bart Van Assche 写道:
> On 8/15/24 10:27 PM, Zhu Yanjun wrote:
>> diff --git a/drivers/infiniband/core/iwcm.c 
>> b/drivers/infiniband/core/iwcm.c
>> index 1a6339f3a63f..7e3a55349e10 100644
>> --- a/drivers/infiniband/core/iwcm.c
>> +++ b/drivers/infiniband/core/iwcm.c
>> @@ -1182,7 +1182,7 @@ static int __init iw_cm_init(void)
>>          if (ret)
>>                  return ret;
>>
>> -       iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", 0);
>> +       iwcm_wq = alloc_ordered_workqueue("iw_cm_wq", WQ_MEM_RECLAIM);
>>          if (!iwcm_wq)
>>                  goto err_alloc;
>
> This change looks good go me. Do you plan to post this as a proper patch?

Hi, Bart

Thanks a lot for your review. I will post the patch ASAP.

Zhu Yanjun


>
> Thanks,
>
> Bart.
>
-- 
Best Regards,
Yanjun.Zhu


