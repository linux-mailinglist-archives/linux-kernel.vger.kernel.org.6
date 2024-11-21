Return-Path: <linux-kernel+bounces-416839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE209D4AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21DEB21D63
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433651CDFCF;
	Thu, 21 Nov 2024 10:36:42 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AF1BD501
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185401; cv=none; b=AQDjii9p33kfS0eFzfErH47/5N0teQQVST0DVX4dIC9Q20MoA3yDVCkoZbxoLo0gztIXjAwmacuJdrxhrXaLvPjqeNkobd1LahzP+GeDKihD9v3OueYQupaosnXcavdS+Xz7M23DbDkhpkGkyX8zmQ0ynvxZq1yfzVjNi9HWm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185401; c=relaxed/simple;
	bh=ZctgL/SmjCHPTqomYOIiiSK+YYOMgthj/lMKAmIjv3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muIPlN7+L7Lvea0roAqsHJ1Y+gW9gwwLtrfDa1cq1re7hWlrIHYII9Plm6tTVX4o17MeLwsbBQhqmxRliwM9hjypXtQG4Ejg284Dj5S6oGqNeQY1dmbW/pSLFYi3QyY+xjiEOjG52g978b31JZ4h3lHtvaknA7GvMrBZVCoTD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B388820016;
	Thu, 21 Nov 2024 10:36:34 +0000 (UTC)
Message-ID: <0456b6b4-1453-444d-8cd8-38715dc9f845@ghiti.fr>
Date: Thu, 21 Nov 2024 11:36:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Call secondary mmu notifier when flushing the
 tlb
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240328073838.8776-1-alexghiti@rivosinc.com>
 <20241121-e97820f8c09de9bcedfe885d@orel>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241121-e97820f8c09de9bcedfe885d@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andrew,

On 21/11/2024 10:32, Andrew Jones wrote:
> On Thu, Mar 28, 2024 at 08:38:38AM +0100, Alexandre Ghiti wrote:
>> This is required to allow the IOMMU driver to correctly flush its own
>> TLB.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>
>> Changes in v2:
>> - Rebase on top of 6.9-rc1
>>
>>   arch/riscv/mm/tlbflush.c | 39 +++++++++++++++++++++++----------------
>>   1 file changed, 23 insertions(+), 16 deletions(-)
>>
> Hi Alex,
>
> Is this patch still something we need?
>
> Thanks,
> drew


Yes I think so, hopefully it gets merged.

Thanks,

Alex

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

