Return-Path: <linux-kernel+bounces-557565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF1AA5DADC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBB18956BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623223C8AC;
	Wed, 12 Mar 2025 10:50:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156F233D85
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776606; cv=none; b=QGkq2SgzOnHZwFFbod3rJk4TUGvIwY2XWRnO19ulYUJWoIxxYTaM3uo8ugf+bVDXtujpmV4LQ2h6GK7n51EnZD04NNMMb0KMTBE/OM//UvHZkJA8aHLGcvZHeoXig7piby0UvVSGmpl4hxEkzUqkahaaRT4Y1wnuACR56ERbSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776606; c=relaxed/simple;
	bh=Y45kkFaeGvu203KwL1jnYyfb4Gk/FkGEhZTM1WBbCRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r7DjX5M8G5ny55EQfiGHwL89SEduxPsaUZi9PoPKJBnPBX5uSzecdRuuuTOb7LMsrb7vGSB593gbznXV0FUrOF5S7rUIxLLNf10P2826y7Vqo1P81Wy65wSD4lWWCvsem1qKnewyxiIsoQ+n2qHOZny6oVG0lNSgnr9Y+lwibsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZCRPX36Yhz9sgW;
	Wed, 12 Mar 2025 11:16:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sWOjLZKmmSMT; Wed, 12 Mar 2025 11:16:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZCRPX25Rsz9sgS;
	Wed, 12 Mar 2025 11:16:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 34E478B768;
	Wed, 12 Mar 2025 11:16:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id GVHOBlTWoH6b; Wed, 12 Mar 2025 11:16:48 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DEF2F8B763;
	Wed, 12 Mar 2025 11:16:47 +0100 (CET)
Message-ID: <e5a67a3a-f2ca-45b7-b227-267477c62ccb@csgroup.eu>
Date: Wed, 12 Mar 2025 11:16:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250307] Build Failure
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
References: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
 <5ab103b4-70f0-454e-bca6-0bfc66d143f5@csgroup.eu>
 <c0a716d0-6811-4b1b-b008-d4e97900cb0e@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <c0a716d0-6811-4b1b-b008-d4e97900cb0e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/03/2025 à 11:11, Venkat Rao Bagalkote a écrit :
> 
> On 12/03/25 4:20 am, Christophe Leroy wrote:
>>
>>
>> Le 09/03/2025 à 13:38, Venkat Rao Bagalkote a écrit :
>>> Greetings!!,
>>>
>>> I see linux-next-20250307 fails to build on IBM Power9 and Power10 
>>> servers.
>>>
>>>
>>> Errors:
>>>
>>> In file included from ^[[01m^[[K<command-line>^[[m^[[K:
>>> ^[[01m^[[K./usr/include/cxl/features.h:11:10:^[[m^[[K 
>>> ^[[01;31m^[[Kfatal error: ^[[m^[[Kuuid/uuid.h: No such file or directory
>>>     11 | #include ^[[01;31m^[[K<uuid/uuid.h>^[[m^[[K
>>>        |          ^[[01;31m^[[K^~~~~~~~~~~~~^[[m^[[K
>>
>> This is unreadable. Please avoid fancy colors that add escapes to 
>> logs. You can unset LANG environment var before building in order to 
>> get pastable stuff.
>>
>> By the way I don't think it is a kernel issue because nowhere in the 
>> kernel you have uuid/uuid.h
>>
>> But can you provide your .config (the actual one, not an old one from 
>> kernel 6.0.0-rc3 like last time) and tell which version of GCC you are 
>> using.
>>
> Attached are the two config files on both CI nodes build failures were 
> reported.
> 
> On both the CI nodes gcc version is 11.5.0.
> 
> Below data are from the failure nodes.
> 
> commit-time: 2025-03-07 20:31:46 +1100
> commit-id: 0a2f889128969dab41861b6e40111aa03dc57014
> version: 6.14.0-rc5-next-20250307-auto
> 

Sorry I'm still puzzled with your config files.


The one named p10_build_failure contains:

# Linux/powerpc 6.3.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1)"


The one named p10_kdump_config_build_failure contains:

# Linux/powerpc 6.3.0 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18)"


You are talking about CI nodes, do you have an online link to the full 
report ?

Christophe

