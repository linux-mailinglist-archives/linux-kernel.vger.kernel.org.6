Return-Path: <linux-kernel+bounces-375445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C63B9A9602
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB21D1C22004
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3C131182;
	Tue, 22 Oct 2024 02:09:42 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496412B176;
	Tue, 22 Oct 2024 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562981; cv=none; b=Dy8IzPjrqZIyO9w7L8uGaypYJXY1GyRxFPfn3kwwCywacIX0znZpz+3tO/EqI0ueWPksPTQDUYutSw3UBXInc5FlW/tXt6VJw4se0ckhiLD+3p0n2h0uaJM98Z68PhHgmKapuPUxKguETEhDb0dkVksErbp04AATxwqtkAyvleU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562981; c=relaxed/simple;
	bh=NXjtOr7rEpuwAUsPyFpTo+ZqsgtYz7tXOkFvQJhW0RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S12skFQ/MlVpqJc8ClZnuGssPXafU1e7Wz62BXixONWou2dWEofkCrzXjE9eLRYcbS5LT+RIztIA9tEjGDJkEwiJloPLjkyUVIFvPIzyrly7AYjrziNCC5zHxVTtVvKSNS8exsqKv+dVV0WVsj/MDRMko2AVvsudul2TE+GFtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrABHTgIfCRdnDvwfAQ--.12540S2;
	Tue, 22 Oct 2024 10:08:32 +0800 (CST)
Received: from [10.11.71.182] (unknown [10.11.71.182])
	by gateway (Coremail) with SMTP id _____wD3uw0dCRdnhy+JAA--.31386S2;
	Tue, 22 Oct 2024 10:08:30 +0800 (CST)
Message-ID: <d81ba896-9883-4112-8b9e-79be20a27494@hust.edu.cn>
Date: Tue, 22 Oct 2024 10:08:29 +0800
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
 <bae3c59c-39a5-4daa-b37e-bbf077d57643@hust.edu.cn>
 <87wmi1s99g.fsf@trenco.lwn.net>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87wmi1s99g.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HwEQrABHTgIfCRdnDvwfAQ--.12540S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1UAr48ur1DJF1xJw18Zrb_yoW8uFyfpF
	yjqFy7Ca1rAF15C3yjqr4Fqr45tan7J3yqqr17X3WFyw4qkr97XrWftFs3u34UZryxAayU
	X3yUGF9aqr45AaDanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	1q6r43M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUDMUqUUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 2024/10/22 00:36, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> On 2024/10/21 23:38, Jonathan Corbet wrote:
>>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>>
>>>> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
>>>> programming language section")
>>>>
>>>> scripts/checktransupdate.py reports:
>>>>
>>>> Documentation/translations/zh_CN/process/programming-language.rst
>>>> commit 0b02076f9953 ("docs: programming-language: add Rust programming
>>>> language section")
>>>> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
>>>> Intel compiler")
>>>> 2 commits needs resolving in total
>>>>
>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>> ---
>>>> v1->v2: revise the script name
>>>>    .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>>>>    1 file changed, 30 insertions(+), 48 deletions(-)
>>> This one adds some new build warnings:
>>>
>>> Documentation/translations/zh_CN/process/programming-language.rst:44: WARNING: duplicate citation gcc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
>>> Documentation/translations/zh_CN/process/programming-language.rst:51: WARNING: duplicate citation rustc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
>>>
>>> *Please* be sure to do a docs build before submitting your patches.
>> I am sorry. I am not sure why I miss this warning. I should strictly
>> follow the rule - make htmldocs and checkpatch do no trigger any errors
>> or warns.
>>
>> A simple question: if you miss the warning in one `make htmldocs`
>> building``, you rerun `make htmldocs` and still trigger the warning or
>> just the warnnings do not appear until `make cleandocs` is done?
> Sphinx only rebuilds what it has to, so a warning may not repeat if you
> do not build from a clean tree.

I see where my problem is. I will modify my workflow with an additional 
rule: always do a clean build before sending a patch.

Thanks, Jon

Dongliang Mu

>
> jon


