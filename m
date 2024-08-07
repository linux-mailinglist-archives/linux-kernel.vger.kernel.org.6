Return-Path: <linux-kernel+bounces-278293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474394AE62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE991F247C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA8A13AD0F;
	Wed,  7 Aug 2024 16:48:46 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95F82C8E;
	Wed,  7 Aug 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049326; cv=none; b=OqUm2JjhSbGqk7TC7Pdety4UojYJMMSP7L3IxtiwWDK8BMdh7ZHUHsA6mP7p4zvI9o3jlXeURKc1GcQEkgIc03Ln0V3k9W0tyXdmCP24CHo1TkDE8/gXPYivFEfaTvfSCZiqBmnVxA4XipnseIl1xgRZNaQ0rKzTgr7xzYOyuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049326; c=relaxed/simple;
	bh=nVhnXvFpToGDoik+8OyZ2VjT0EjakHNiKOpCLt37pZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP1W4vMvLkuzDrqiilZUIv0tD4DJg9fKI2Em7KJDdPi04b0e8jHEHECLniqaZy1eaoSQuiVpZBlEtSyRiZYFxsuQCb5G9i4yoarOKz7juotIpgbkkdWg4ZhJEMyr5iArgcEf3xk++p4eRoqJ72YvLXeZ8e6NJJyxXhG69abe8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrABXXjpTpbNm+IroAg--.61924S2;
	Thu, 08 Aug 2024 00:48:19 +0800 (CST)
Received: from [192.168.132.127] (unknown [58.19.99.130])
	by gateway (Coremail) with SMTP id _____wCXH3JRpbNmYyjlAA--.33216S2;
	Thu, 08 Aug 2024 00:48:19 +0800 (CST)
Message-ID: <c4ffaae1-59a0-4837-a965-441af4851d2a@hust.edu.cn>
Date: Thu, 8 Aug 2024 00:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240807162720.46588-1-tttturtleruss@hust.edu.cn>
 <d6eec1da-0e79-432f-a5cf-7dc8c59f28c1@hust.edu.cn>
 <87r0b0th7l.fsf@trenco.lwn.net>
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
In-Reply-To: <87r0b0th7l.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrABXXjpTpbNm+IroAg--.61924S2
Authentication-Results: app1; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUOq7k0a2IF6F4UM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0U
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Cr1j6rxdMcIj6x8Erc
	xFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr
	1UJr1l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUjWCJPUUUUU==
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQsCAmay6zI7WwAAsn


在 2024/8/8 0:45, Jonathan Corbet 写道:
> Haoyang Liu <tttturtleruss@hust.edu.cn> writes:
>
>> This is a mistake but I missed it before sending this patch.
>>
>> What should I do to revert or correct this patch?
>>
>> Thanks for your help and patience.
> Send a v6 with the correction made - but wait a while for other reviews
> first.

OK.


Thank you,

Haoyang

>
> Thanks,
>
> jon


