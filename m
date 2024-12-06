Return-Path: <linux-kernel+bounces-434624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21409E6915
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA2218828BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F171DF742;
	Fri,  6 Dec 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOLJOLIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D41DED49
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474192; cv=none; b=r2Qjc0WWU0bo7eK4AhVQ6StH/iV2k1GXvEJM/sFAL2ROu4l5fVDXppkjMvuVG1mdlI4DPnAHPzDXkO5uN6j/h3ODDgxNXpW+ez/GSacr8qs2Yr9JEo2BIC+a0Fmrf5Sqtz7Tuxyh9rSnAhr9fuNTa7as62lmKkKnnrNyjrgoU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474192; c=relaxed/simple;
	bh=+KXs+jrzymKwQ80DAWh/thnKmWYFHshDzqjuxXcUoIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W05suOELNEVwnXTkrI6zMEMRQETVGPYNs9EuNp6uCcg70dsxHqIpAQJJG5zMwxcnmtiAJcboDmsG9GrDhdN+/fLFDbCgDa87IyxQ/LzkB7uW29I3zmuGFzClgNQq1EPgALRndXZIcdFVNjEtjU1PAfgOSvbkza3IL/YXDxX1hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOLJOLIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0347C4CED1;
	Fri,  6 Dec 2024 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733474192;
	bh=+KXs+jrzymKwQ80DAWh/thnKmWYFHshDzqjuxXcUoIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dOLJOLITBkfKRvXZE25SpX29N30hgJy8M/vDFfNaPgDSdXwedOYtR/tmYFtOQydX7
	 WjtK0NySpsfaglCWMi94lKtG7nYF7KmxwksLuK5krQXRHJ2xoXniBDOLQzA/GetTTm
	 5sW4aFWFPfyC6swCyZdKg+/IaFfBsZiyUPOyulAzPv0W2xivHhoJmjEDYMEKkU6WLn
	 CQ3TBf6mp8QVkjnm18P3S96e2X8DbVeQwjIsESlpI8BUzC0fFrOjb/grU2bIjCb7JO
	 Son9JFmWwCwyJPUsHptMxxbj4EWGWIHpmdgrksx2loWRglM9tkbfjhz/QwtT1wnmko
	 lqjStT5lfgeCA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
In-Reply-To: <a3e117ce-abe3-4bd9-aef5-90bbe173828d@ghiti.fr>
References: <20241205-remove_albert-v1-1-17eb850f1540@rivosinc.com>
 <a3e117ce-abe3-4bd9-aef5-90bbe173828d@ghiti.fr>
Date: Fri, 06 Dec 2024 09:36:29 +0100
Message-ID: <87ed2lgqcy.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alex@ghiti.fr> writes:

> Hi Charlie,
>
> On 05/12/2024 23:46, Charlie Jenkins wrote:
>> Albert is not an active maintainer and his inbox rejects all emails.
>> Remove him from the maintainer's list to put an end to everybody who
>> interacts with the riscv linux mailing list from getting spammed with
>> rejection emails.
>>
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1e930c7a58b1..8a5e12355850 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20104,7 +20104,6 @@ F:	include/linux/irqchip/riscv-imsic.h
>>   RISC-V ARCHITECTURE
>>   M:	Paul Walmsley <paul.walmsley@sifive.com>
>>   M:	Palmer Dabbelt <palmer@dabbelt.com>
>> -M:	Albert Ou <aou@eecs.berkeley.edu>
>>   L:	linux-riscv@lists.infradead.org
>>   S:	Supported
>>   Q:	https://patchwork.kernel.org/project/linux-riscv/list/
>>
>> ---
>> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
>> change-id: 20241205-remove_albert-b50c95e19306
>
>
> I totally agree!
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

+1!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

