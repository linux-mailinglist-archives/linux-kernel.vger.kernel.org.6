Return-Path: <linux-kernel+bounces-209630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5059038A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06C21C236D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D9C17838E;
	Tue, 11 Jun 2024 10:16:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC7514F109;
	Tue, 11 Jun 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101005; cv=none; b=k1j9BQ/Yx3kjSNKaiISgByTiNi6vINw8DTpgySlvSHgfOWo3lwsqG0FwIkke37i6F7yZ/8fHKhGWQviW0HzAbiWfpRC8ZDrOVViBMAOjYoWMT5MnqrcHqlpvfcIEphvOhxBf3yi+a/Tgp3pr7IuWgbG+fp74KdhUEQxjso1dXxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101005; c=relaxed/simple;
	bh=h+k2rER/h3tpIRHo81rNO5HpHNpTKoFhhrcxfBCglf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XV5KHpPvxXZW1ypNhTvpC05nx6DuaVkusXq+s531D5Q1ofIt4uCeyhZ/EPnAVUIinuIpQLaChWlydSYMc0XSPNMj9Mh7eZ9n8vJPPxtAM5e5Zp2KdfE2vNxXJpt+d7+OawJn3aN8lLpgxV0anFTZUiuUWieiXAYMUesGytS8Ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B35771424;
	Tue, 11 Jun 2024 03:17:06 -0700 (PDT)
Received: from [10.162.41.16] (e116581.arm.com [10.162.41.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CDAD3F5A1;
	Tue, 11 Jun 2024 03:16:38 -0700 (PDT)
Message-ID: <13fd02ce-ed18-4499-9b55-367ea69cbe31@arm.com>
Date: Tue, 11 Jun 2024 15:46:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Add ARM64 for reserving ZONE_MOVABLE
To: Ryan Roberts <ryan.roberts@arm.com>,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 suzuki.poulose@arm.com, broonie@kernel.org, James.Morse@arm.com,
 Anshuman.Khandual@arm.com
References: <20240604052856.546183-1-dev.jain@arm.com>
 <8c3db3d5-8ddc-427c-8db2-980b14afb258@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8c3db3d5-8ddc-427c-8db2-980b14afb258@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/7/24 17:04, Ryan Roberts wrote:
> On 04/06/2024 06:28, Dev Jain wrote:
>> kernelcore and movablecore kernel command line works for ARM64. Update
>> the Documentation to reflect the same.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b600df82669d..7282d6057e32 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2544,7 +2544,7 @@
>>   
>>   	keepinitrd	[HW,ARM] See retain_initrd.
>>   
>> -	kernelcore=	[KNL,X86,IA-64,PPC,EARLY]
>> +	kernelcore=	[KNL,X86,IA-64,PPC,ARM64,EARLY]
> Given these are both arch-agnostic parameters, wouldn't the correct change be to
> remove all the arch-specific labels, i.e. [KNL,EARLY]? In fact, wasn't IA-64
> removed from the kernel?


Indeed, the handling of these parameters completely resides in

generic mm; I'll send a separate patch and CC Andrew. And yes,

IA-64 was removed, but still has some mentions remaining

throughout the tree :)

>
>>   			Format: nn[KMGTPE] | nn% | "mirror"
>>   			This parameter specifies the amount of memory usable by
>>   			the kernel for non-movable allocations.  The requested
>> @@ -3612,7 +3612,7 @@
>>   	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
>>   			reporting absolute coordinates, such as tablets
>>   
>> -	movablecore=	[KNL,X86,IA-64,PPC,EARLY]
>> +	movablecore=	[KNL,X86,IA-64,PPC,ARM64,EARLY]
>>   			Format: nn[KMGTPE] | nn%
>>   			This parameter is the complement to kernelcore=, it
>>   			specifies the amount of memory used for migratable

