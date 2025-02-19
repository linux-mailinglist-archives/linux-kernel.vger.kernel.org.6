Return-Path: <linux-kernel+bounces-520726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58075A3AE41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EAE16636B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB619DF8D;
	Wed, 19 Feb 2025 00:53:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D719D8A7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926401; cv=none; b=I7Xf1TYKV5C8p41S867Soe1uo/W+nwaDFDN8UCDB4bhGoZGpUzvvydOqiVxjPKDbf5FHbfeJ/4qzBT8PrTKvLtnbFBOk4Hzjq3M3SuGffN0d+mTG27FPUnXVg7HFZ7PxI7lAksoyz+P1QSu7CbuaVfdHPXU3hH4GlXvafAcdp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926401; c=relaxed/simple;
	bh=5mM228tnSgpXIyj+6Dr1xL9d9OSe8vvjBUkQjBBzh9k=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pjECepoywlixhG18wtQXfXniDiO5jK6jObobXLFnA6hh7Yeq57kUDfvj3voUqQd1BeI5kYXVvbXqHLNyTKxaRHg4YRyprGOjFeqSbf6x0sp1XU6kudybl64Ty93QumNpPYHXxmZ+0hgvXrNFMJcSMuO2fZbcW4sP4SIV/oWhsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxbeJ5K7VnE2J6AA--.41995S3;
	Wed, 19 Feb 2025 08:53:13 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxPsd4K7Vn5TcbAA--.39110S3;
	Wed, 19 Feb 2025 08:53:13 +0800 (CST)
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>
References: <20250218092538.1903204-2-ardb+git@google.com>
 <CAMj1kXGyhYHS3WpC2oowWOnJiQVrbHOw57ULYuSx5Rip=Lt9oA@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a8cb74a7-358b-9c03-a37a-672e212d3571@loongson.cn>
Date: Wed, 19 Feb 2025 08:53:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGyhYHS3WpC2oowWOnJiQVrbHOw57ULYuSx5Rip=Lt9oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxPsd4K7Vn5TcbAA--.39110S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw4ktryxXF4xXw4DGryDArc_yoWxAwc_WF
	W0y3WkGrs8urW5Cw1qv3WfWF9FqFyfJr4UA3s7WF47J345tFyFyr1kG3srurWSqrs7Jrsr
	Aa1qvF9IywnFgosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU
	=

On 02/18/2025 05:29 PM, Ard Biesheuvel wrote:
> On Tue, 18 Feb 2025 at 10:26, Ard Biesheuvel <ardb+git@google.com> wrote:
>>
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> When running in PIE mode, the compiler will emit const global objects
>> into .data.rel.ro rather than into .rodata if those objects contain
>> statically initialized fields carrying addresses that are subject to
>> runtime relocation (e.g., function pointers).

...

> I'll send a fixed v2 once the LoongArch folks confirm that this works for them.

This change works well with GCC and Clang on LoongArch.

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn> # on LoongArch


