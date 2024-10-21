Return-Path: <linux-kernel+bounces-374677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624F9A6E72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1441C21F40
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FE01C4623;
	Mon, 21 Oct 2024 15:42:00 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B4131182;
	Mon, 21 Oct 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525319; cv=none; b=cuQ2sb1HFAKrFskxXFOAtP3IgZ3WuaXkda63ERZGAsZnMrgl0O34zoJWFojiz8ANW5reU5O6rdtJTmOPoJRhqqRb0ZiC1X4XiodvWWyzSJqcPiJDX7ljEAP6OiEGdZlTdIPreOZBMidYCzJP3vpyl45lwL4z6Eb/YryXVbv7zxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525319; c=relaxed/simple;
	bh=mvpJ5q6wbG2OGv2ExzGIZ+pg2uE2gGkv1J9IXoMKJ4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx2lsDlPrb/KLlPm5FMQQk1BsN/7JL37CQyVzFLfySebU2lDw1q724/r9jiXbXgn/IfAmMFAYQ56yFCsM2f61G6qif687a0J8mpP58W6/jW5Hs0UPcqU+uDwlPPNyxVk9mgCPQ+Rd8BRyoQnHJH3iRyOHgJBc4S9M7tVHabCFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADHzX0LdhZnXh9PCA--.21720S2;
	Mon, 21 Oct 2024 23:40:59 +0800 (CST)
Received: from [192.168.1.6] (unknown [183.94.68.188])
	by gateway (Coremail) with SMTP id _____wC3sPsJdhZnqLGEAA--.29413S2;
	Mon, 21 Oct 2024 23:40:58 +0800 (CST)
Message-ID: <7a11cfd9-523d-4650-951b-52a128af691d@hust.edu.cn>
Date: Mon, 21 Oct 2024 23:40:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs/zh_CN: add the translations of
 kbuild/reproducible-builds.rst
To: Jonathan Corbet <corbet@lwn.net>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729259177.git.dzm91@hust.edu.cn>
 <dcd09bf28f52ba0461b26f800fdbb145c879a313.1729259177.git.dzm91@hust.edu.cn>
 <87r089tqwi.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87r089tqwi.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrADHzX0LdhZnXh9PCA--.21720S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyrKrWkZr4kGrW8XFWkWFg_yoWDurgEyr
	10v3yakw1UJFn3AaykJrn3Ary09anYgr1Ut3Z8tr97t3yDJr4UXF4qqrn2vFWUWF4akrWx
	CwsYqrn3Wr17ujkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbPAYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0XVy3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/10/21 23:30, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Finish the translation of kbuild/reproducible-builds.rst and move
>> reproducible-builds.rst from TODO to the main body.
>>
>> Update to commit 114ff6fe6cfb ("Documentation: kbuild: Add description
>> of git for reproducible builds")
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   .../translations/zh_CN/kbuild/index.rst       |   2 +-
>>   .../zh_CN/kbuild/reproducible-builds.rst      | 114 ++++++++++++++++++
>>   2 files changed, 115 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/translations/zh_CN/kbuild/reproducible-builds.rst
>>
> I've applied this (patch #1 was already applied).

Thanks Jon. I originally would like to push llvm.rst and 
reproducible-builds.rst as a patchset.

But I incidently cherry-pick the wrong commit and generate an incorrect 
patchset. My apology :/

Since this patch is applied, I will then send the translation of 
llvm.rst as a separate patch.

Dongliang Mu

>
> jon


