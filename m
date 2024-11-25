Return-Path: <linux-kernel+bounces-420524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA19D7BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D29282483
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F09E15F41F;
	Mon, 25 Nov 2024 07:27:09 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2964D1426C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519628; cv=none; b=TzPP/Wj5nM5ROi5Zq8LpbIjmjtCH2FHRq/bcirXT/0UdIChR6P4mGF1ERS7iayWGBH91xq9unVat4OXV4M9qMFJUr7sO799RlC2Jd8rhGod5vv+qLMwnPNELi9ji9CbNDeVVq9Nwq18E1axOZx8BCxNVfSLk14DB0RiK0jDS+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519628; c=relaxed/simple;
	bh=IT6/56c8jGaFNw6Kc1j6ndCo/AcawZifLTc2v5qGJpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBRapvgD9XxZgZ508WrLQXMoOjTNIFtnMEZH74DHk5oTg6FuNKx+WCj70PfK3Gg5/Ll00RtfwmGPXybV21pQ3vMM5OCm2ouRPgc3vdypVms2KF0BOIPoGVTx84dkQefouWT10HhHdOXbTjlycJXKDZb/ZmOz91nRw5wn6O526mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xxchz27g4z9sPd;
	Mon, 25 Nov 2024 08:26:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPPde6qatPkl; Mon, 25 Nov 2024 08:26:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xxchz1Mcqz9rvV;
	Mon, 25 Nov 2024 08:26:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EB568B764;
	Mon, 25 Nov 2024 08:26:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OlEhmccigwwc; Mon, 25 Nov 2024 08:26:59 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DBF518B763;
	Mon, 25 Nov 2024 08:26:58 +0100 (CET)
Message-ID: <563bccb3-d9eb-4001-8c3e-6021c507f636@csgroup.eu>
Date: Mon, 25 Nov 2024 08:26:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] powerpc/machdep: Remove duplicated include in svm.c
To: Michael Ellerman <mpe@ellerman.id.au>,
 Yang Li <yang.lee@linux.alibaba.com>, npiggin@gmail.com, naveen@kernel.org,
 maddy@linux.ibm.com, Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
 <87msibcmeb.fsf@mpe.ellerman.id.au>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87msibcmeb.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/11/2024 à 12:29, Michael Ellerman a écrit :
> Yang Li <yang.lee@linux.alibaba.com> writes:
>> The header files linux/mem_encrypt.h is included twice in svm.c,
>> so one inclusion of each can be removed.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11750
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>> ---
>>   arch/powerpc/platforms/pseries/svm.c | 1 -
>>   1 file changed, 1 deletion(-)
> 
> The two includes only appear in linux-next, and they both come from
> different trees. They are required in each tree to avoid breaking the
> build.
> 
> So no one can merge this patch until the two trees are merged into mainline.
> 

That's in linus tree now

Christophe

