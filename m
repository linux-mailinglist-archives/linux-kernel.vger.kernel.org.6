Return-Path: <linux-kernel+bounces-536633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3AA48201
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8377B3A5B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39725D1ED;
	Thu, 27 Feb 2025 14:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6F5232379
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667804; cv=none; b=eAQU3Va+vELAfUkb8FanAe2ofZcY6ul4l9PCNAWXPcJUhL7EUa7kuFR+7xPP0XcxmIorET9Ycgau4xtVHxSE8y0WS4EjCAAQfUGah2SbKAb/k10zJw55blW6KXK8SkZW+wovtkndHLXKO8uTXiBjcxN8LtYYqmm5bPTq5CtaNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667804; c=relaxed/simple;
	bh=neRENxf1Lo7oNnqEmZF/Bu+fkuNcBaQkyltD/4I912w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gU9k5lFlPGkgqFylZzR7WWNXMVoWrywkVzYK5AbwwrMNjldBIjFWh+iTBSWqT00CO1rxAOfYRvxrKUt4rmuqcQO8ICdBxBB603Ej39mSlNX4stCPfl3Hvy0o0/Se98bTZe8FMD2+dvgWNP2MG5g52fH2+lhYYdXje5AASojCRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z3YK96mwzz9sTK;
	Thu, 27 Feb 2025 15:15:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdWIFlqYCtlL; Thu, 27 Feb 2025 15:15:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z3YK36WdMz9sSr;
	Thu, 27 Feb 2025 15:15:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CC23B8B78B;
	Thu, 27 Feb 2025 15:15:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id MJ5KskemWaxm; Thu, 27 Feb 2025 15:15:35 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 72F768B77C;
	Thu, 27 Feb 2025 15:15:35 +0100 (CET)
Message-ID: <c68287f7-ad00-46fc-a92e-06e0c9074139@csgroup.eu>
Date: Thu, 27 Feb 2025 15:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20250226]Build Failure
To: Michael Kelley <mhklinux@outlook.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kees Cook <kees@kernel.org>
References: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
 <20250227123804.5dd71cef@canb.auug.org.au>
 <14193c98-fb30-4ee8-a19a-fe85d1230d74@csgroup.eu>
 <SN6PR02MB4157A0C1B4F85D8A289E5CE9D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <SN6PR02MB4157A0C1B4F85D8A289E5CE9D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/02/2025 à 15:05, Michael Kelley a écrit :
> From: Christophe Leroy <christophe.leroy@csgroup.eu> Sent: Thursday, February 27, 2025 2:43 AM
>>
>> Le 27/02/2025 à 02:38, Stephen Rothwell a écrit :
>>> Hi Venkat,
>>>
>>> CC Kees Cook for advice.  This is a result of the tests added in commit
>>>
>>>     bbeb38b8487a ("string.h: Validate memtostr*()/strtomem*() arguments more carefully")
>>>
>>> from the kspp tree.
>>>
>>> I note that the comment about memtostr() says "Copy a possibly
>>> non-NUL-term string".
>>
>> Can you tell more about your config and your environment ?
>>
>> I just tested with ppc64_defconfig and ppc64le_defconfig, with gcc 12.4,
>> gcc 13.2 and gcc 14.2 and didn't get that build error.
>>
>> Christophe
> 
> FWIW, I see the same build failures related to __must_be_noncstr()
> when building natively on x86 and on arm64. In both cases, it's an
> Ubuntu 20.04 installation with gcc 9.4.0 and binutils 2.34.
> 

Looks like I get that problem only with GCC 8.5 and GCC 9.5.

I don't get it with gcc 10.3 nor 11.3 nor 12.4 nor 13.2 nor 14.2
I don't get it either with gcc 5.5 or 7.5

Christophe


