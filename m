Return-Path: <linux-kernel+bounces-436537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738F9E8740
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 19:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E473A188219F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9331891B2;
	Sun,  8 Dec 2024 18:18:24 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3914601C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681903; cv=none; b=rd/yNZ1A7zqn8PanhwU7P47reLO3y6Wr7uiZpTq/MA8uRKbvyUeOjv3s71ibtbtS1Dkl13ykAoaQwcVxSokE+G5qgvc04h9X9rJvHa8YjL6LHlpZUzX3y92HpWo8CtiEF/ntSuxphQIWPdG8TNYxbODGRbzAG4MDz69tPOGxTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681903; c=relaxed/simple;
	bh=M579xWeA72oll3fun8BbRa9/VJeR+JooWy7HSCLgug4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pki6uIBCVTKwgcaZ3jU/MGZrs8h2cbqHMWufAvR1vcuXhvXkPqzmj9J599FpLq2mecMMsm9HDEITULwi0EEZlQkXWoD5+e35L8i1ccgnI++3JzHB+7EJJOyikEVcRHs7vUYnBD3Lj3e6ecdeNBaxLTYtHguMUl6KPPUUDbd10gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2E3220004;
	Sun,  8 Dec 2024 18:18:09 +0000 (UTC)
Message-ID: <8b4a7f3d-0c3c-472f-914f-7e3971697d7c@ghiti.fr>
Date: Sun, 8 Dec 2024 19:18:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
 <Z1PihReuTF3Gx5K6@archie.me>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Z1PihReuTF3Gx5K6@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Bagas,

On 07/12/2024 06:52, Bagas Sanjaya wrote:
> On Thu, Dec 05, 2024 at 02:46:19PM -0800, Charlie Jenkins wrote:
>> Albert is not an active maintainer and his inbox rejects all emails.
>> Remove him from the maintainer's list to put an end to everybody who
>> interacts with the riscv linux mailing list from getting spammed with
>> rejection emails.
> I didn't get bounce message on my spam folder when sending to Albert,
> though.
>
> BTW, have you contact him off-band, confirming that he no longer wants
> to maintain?


I have been working on the riscv kernel for more than 6 years and I have 
never seen Albert posting on the mailing list or sending a patch.

I don't mean to be disrespectful but it's not his choice anymore, being 
a maintainer is a full time job and we need that.

Thanks,

Alex


>
> Thanks.
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

