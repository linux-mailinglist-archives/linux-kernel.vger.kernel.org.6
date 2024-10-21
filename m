Return-Path: <linux-kernel+bounces-374700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DDF9A6EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FEE2813A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648941CBEAC;
	Mon, 21 Oct 2024 15:52:00 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA641A264A;
	Mon, 21 Oct 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525920; cv=none; b=EmVvYu3n9bGZ48MeHxJiAie/dkMlWQotBiCl0vD3EIWW3iuxfIbzyyKn3hvZEw5e8uaD+ewkhE7Uwgw1f6ksAWDUnMS3btNBZq0tCoi2TL/nB/bcAd/wfcPxwehxuqkhP7rBaTzu6mL4G9vD6+6TZ4sM8J8TC5Q+2rKrnik7Z+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525920; c=relaxed/simple;
	bh=NtU/4AB1lTAZ+pQ9nINBRSms9NiVC6gYsoyQPRpM65M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDAiefQycaOd8v9BiLIQGs479xv397eK0s1j4/VU2iq/mCmKGBWEJYn2iZn9w3lUmAofqcNNeTWS/EB757BEKiGZUtgiFMvlu4RqPsCfn+p31wHfBH0eoPXas5ObkDaUWP45vSLWx4SVPqafSrO61+dbUhHY/LdjaFaJjF6XRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrADnR21yeBZnfEBPCA--.38942S2;
	Mon, 21 Oct 2024 23:51:14 +0800 (CST)
Received: from [192.168.1.6] (unknown [183.94.68.188])
	by gateway (Coremail) with SMTP id _____wB3cA9weBZn1MqEAA--.29580S2;
	Mon, 21 Oct 2024 23:51:14 +0800 (CST)
Message-ID: <bae3c59c-39a5-4daa-b37e-bbf077d57643@hust.edu.cn>
Date: Mon, 21 Oct 2024 23:51:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/programming-language.rst
To: Jonathan Corbet <corbet@lwn.net>, si.yanteng@linux.dev,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241018015226.3786020-1-dzm91@hust.edu.cn>
 <87ed49tqia.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87ed49tqia.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrADnR21yeBZnfEBPCA--.38942S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7WF18XF1rWryDZr1DAw47Jwb_yoW8AryDpF
	yUtFy7Ga1rAFn8C3yUtrWrWr1rJFs7GayDtr12q3Z5tws0k3s7XrWfKFs3u34UZry8Aa1U
	XayUKF9Ygr4YvaDanT9S1TB71UUUU1UqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQFb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jw
	0_GFylnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw2
	8IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWrXVW3AwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b1db8UUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/10/21 23:38, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
>> programming language section")
>>
>> scripts/checktransupdate.py reports:
>>
>> Documentation/translations/zh_CN/process/programming-language.rst
>> commit 0b02076f9953 ("docs: programming-language: add Rust programming
>> language section")
>> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
>> Intel compiler")
>> 2 commits needs resolving in total
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> v1->v2: revise the script name
>>   .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>>   1 file changed, 30 insertions(+), 48 deletions(-)
> This one adds some new build warnings:
>
> Documentation/translations/zh_CN/process/programming-language.rst:44: WARNING: duplicate citation gcc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
> Documentation/translations/zh_CN/process/programming-language.rst:51: WARNING: duplicate citation rustc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
>
> *Please* be sure to do a docs build before submitting your patches.

I am sorry. I am not sure why I miss this warning. I should strictly 
follow the rule - make htmldocs and checkpatch do no trigger any errors 
or warns.

A simple question: if you miss the warning in one `make htmldocs` 
building``, you rerun `make htmldocs` and still trigger the warning or 
just the warnnings do not appear until `make cleandocs` is done?

Dongliang Mu

>
> jon


