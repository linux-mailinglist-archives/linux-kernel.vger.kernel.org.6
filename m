Return-Path: <linux-kernel+bounces-543638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2242A4D7D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C109163343
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666E1F4CA6;
	Tue,  4 Mar 2025 09:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FE1CAA7B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080006; cv=none; b=O+KcXttEr++S0dedAnrFfXHCMt0cIjbt6gZkjZfXD1h7jUdhn3NYbDeszpr7j9PcncLiJkSj55Ay4+ENeICb9lXW59eaBjsUQ4eH4InHN9DZfvPMEWL6eAFyEhRZkNda2cOM4005lh2PL5bd+Hl1imUWKpA4KVF4oiWaL+o3D/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080006; c=relaxed/simple;
	bh=nQIIE3rsVADulU/3dXy0ss0MFmzZdDBZpy8CCyBBFeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sZ9fsFJmg40iAW25kPQu6KzKCm8KNVD2V+Cv/G4Be9SwtQxjqoHQA2DB3hLqe4iEUrXaOJNl8v5Kj66Z8sVnrbXsCosrhokcOzcgQJIVwALP7PwAPVFr11gShjsGXgwogsJm595Lz67m/7EKIcUgORvqwj5LQ1E3dgbKSD+GrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z6V031gHbz9stG;
	Tue,  4 Mar 2025 09:56:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3I1rDI2lQlkt; Tue,  4 Mar 2025 09:56:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z6V030r5lz9st4;
	Tue,  4 Mar 2025 09:56:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A34E8B770;
	Tue,  4 Mar 2025 09:56:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5F1iC3gbFidx; Tue,  4 Mar 2025 09:56:02 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A1D238B763;
	Tue,  4 Mar 2025 09:56:02 +0100 (CET)
Message-ID: <8ba544e7-cf2a-4807-a056-683115805721@csgroup.eu>
Date: Tue, 4 Mar 2025 09:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build Warnings at arch/powerpc/
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
 <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/03/2025 à 07:13, Madhavan Srinivasan a écrit :
> 
> 
> On 3/4/25 10:42 AM, Venkat Rao Bagalkote wrote:
>> Greetings!!
>>
>>
>> Observing build warnings with linux-next and powerpc repo's. Issue is currently not seen on mainline yet.
>>
>> PPC Repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpowerpc%2Flinux.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8e0f8501f09c48dbb43608dd5ae3c9bf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638766656585342184%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=e5BrJzcrtlITkLF31KltGExQ5Qe8fDVTMV6VfR4w9o8%3D&reserved=0 merge branch
>>
>> PPC Kernel Version: 6.14.0-rc4-g1304f486dbf1
>> next Repo: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git&data=05%7C02%7Cchristophe.leroy2%40cs-soprasteria.com%7C8e0f8501f09c48dbb43608dd5ae3c9bf%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638766656585355246%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=meQyZfB75HhJFCL6AX93slsyVwnogGPYFabDXl%2FLzDA%3D&reserved=0 master branch
>>
>> next Kernel Version: 6.14.0-rc5-next-20250303
>>
>>
>> On linux-next kernel issue got introduced b/w next-20250227 and next-20250303
>>
>>
>> Build Warnings:
>>
>> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
>> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call
>> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
>>
>>
> 
> Can you please specific the compiler and compiler version you found this issue with
> 

Can you also tell which defconfig you are using or provide your .config

It might also be helpfull if you can provide a disassembly of the three 
file.o around the warned address.

Christophe

