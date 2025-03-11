Return-Path: <linux-kernel+bounces-557058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A630A5D315
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8ED3B56E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD92356A4;
	Tue, 11 Mar 2025 23:20:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D92233731
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735207; cv=none; b=e0cuMYLm6ksdWaKBfK3z80BsLfN76DdLibcBXpvhra81rGPdvtuKLGTSyWIjpTaBQmsMZsNaH0GSbXWHBeQqcqKZNZrlzQ8qrFp0fa3LLcm2EBm1bXhvCVgEj2B935BxFwU/SDnfPmPT0sHh9iqtNq5T7cDWZVSi26EUq3F3t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735207; c=relaxed/simple;
	bh=DOPZBItvv7cZ8D7nHTK1lwyFm6BI41wibAesQHpf95M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eitZtoHqHYXaY0PcY6/fM+Y9SdFBoZ/p8AJurhD3oa/OF9E5M46GXsCvK534v6q/rgIJ+RS0Xl67+KiyIIq+g5ttNc67U6DQ4fBhR06lzZnPEDt6entjIt2DqmfKtSUSGi+i2yWP5x5CLIiZNvaFEZT/1Kxa6pYMS7nNRDUbHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZC8B51Q6yz9sgG;
	Tue, 11 Mar 2025 23:50:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkhevmocnkFM; Tue, 11 Mar 2025 23:50:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZC8B50bc1z9sVp;
	Tue, 11 Mar 2025 23:50:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ED0958B768;
	Tue, 11 Mar 2025 23:50:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id qokX83PjF9Q0; Tue, 11 Mar 2025 23:50:52 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8814A8B763;
	Tue, 11 Mar 2025 23:50:52 +0100 (CET)
Message-ID: <5ab103b4-70f0-454e-bca6-0bfc66d143f5@csgroup.eu>
Date: Tue, 11 Mar 2025 23:50:51 +0100
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <70ba4e80-53c4-4583-82f3-2851e0829aa6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/03/2025 à 13:38, Venkat Rao Bagalkote a écrit :
> Greetings!!,
> 
> I see linux-next-20250307 fails to build on IBM Power9 and Power10 servers.
> 
> 
> Errors:
> 
> In file included from ^[[01m^[[K<command-line>^[[m^[[K:
> ^[[01m^[[K./usr/include/cxl/features.h:11:10:^[[m^[[K ^[[01;31m^[[Kfatal 
> error: ^[[m^[[Kuuid/uuid.h: No such file or directory
>     11 | #include ^[[01;31m^[[K<uuid/uuid.h>^[[m^[[K
>        |          ^[[01;31m^[[K^~~~~~~~~~~~~^[[m^[[K

This is unreadable. Please avoid fancy colors that add escapes to logs. 
You can unset LANG environment var before building in order to get 
pastable stuff.

By the way I don't think it is a kernel issue because nowhere in the 
kernel you have uuid/uuid.h

But can you provide your .config (the actual one, not an old one from 
kernel 6.0.0-rc3 like last time) and tell which version of GCC you are 
using.

Thanks
Christophe

