Return-Path: <linux-kernel+bounces-265029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A221C93EB97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23661C20935
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62797F460;
	Mon, 29 Jul 2024 02:46:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD373768EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221209; cv=none; b=Tw7mZeaQyUj38aMr5C0lADzc/8O+yggrKZc9KT8gOx45VpHdGKpfeGHcj9fAML+f31KWfw4pBsq09jlF5w1cccxwnI3aZ6jStKNsPJ4tB2MEdQGG4XpzYlHS8jB8KuRGiR9pqQcIesi0UnFkwOLRBliERfwR+PdyEmQamc8+p60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221209; c=relaxed/simple;
	bh=1lRbEWi+OMlsICnvkK7z1NxUuNrlu0eka29HhIf8Mnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIQFxSiBBQkkeoxMOpZOSjNJpjnMjwWLGj8zz8xTnoJEQdzZhjex/8GgqN2MQn+Bp7yULyBnR6MNgY41BiwKJs1CJasAG0xD2aeIWoxWtR+zSla36mYD8J7zcUeJ56ZHYRxaHoH9MI3Ez774YJ6Qnbtxc75VVfDkiVgw6aQaBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D498FEC;
	Sun, 28 Jul 2024 19:38:26 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BECAF3F64C;
	Sun, 28 Jul 2024 19:37:58 -0700 (PDT)
Message-ID: <575911ec-aa33-4c5b-877b-8a2bdac08844@arm.com>
Date: Mon, 29 Jul 2024 08:07:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for
 compressed kernel image
To: Will Deacon <will@kernel.org>, Sedat Dilek <sedat.dilek@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240726201014.18484-1-sedat.dilek@gmail.com>
 <20240727195752.GA30914@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240727195752.GA30914@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/24 01:27, Will Deacon wrote:
> On Fri, Jul 26, 2024 at 10:09:30PM +0200, Sedat Dilek wrote:
>> The COMPRESSED_INSTALL kconfig does not sound very meaningful.
>>
>> Rename from COMPRESSED_INSTALL kconfig to KERNEL_IMAGE_COMPRESSED_INSTALL.
>>
>> Fixes: commit 4c7be57f2 ("arm64: allow installing compressed image by default")

"Fixes:" tag should only be used for patches that fix real functional
problems in the code.

>> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
>> ---
>>  arch/arm64/Kconfig  | 6 +++---
>>  arch/arm64/Makefile | 6 +++---
>>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> Hmm, I'm not sure I see the point of this tbh. I think the code is fine
> as it is.

Agreed, only thing this patch does is to add "kernel image" prefix
in the config as well in related descriptions which in itself does
not make this any better. As Will mentioned, it is better to leave
this unchanged.

