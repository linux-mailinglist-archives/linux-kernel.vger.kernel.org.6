Return-Path: <linux-kernel+bounces-295306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A7959987
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E630B281510
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C61C4EC8;
	Wed, 21 Aug 2024 10:02:50 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7520C006
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234570; cv=none; b=Yus3EM/gKQHHq4kBF3elpXOT30/22QDgTkEkzDF0aB5VH68uSL3S4/DDAlBXWbnHCh8YdVpOXJ/ZaczEMqjehlOf3cCp375FnqaV3fUll9p/pBvHsGq1vdcNqsxR2IYPbYb5S0wQ5zT1nhnI2Ej0ZLXP5/DYRQteSs+JuL1bWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234570; c=relaxed/simple;
	bh=UcPIGUJVxX0AOWoPINDChDdlbo7L9cxJse2F6TmX6Ec=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i3i9G+RXve462x4gF+gUjNklm9wTGXpUFwK0gDFHvIqkPkIIqXPlH86VXCBB4/1vuAjIdwwr5CqLWMzK4pCjDzp0+lqjUp3IkKrgGmyaG38l08ncNN7vGqL4MKzN0nBEhYdEYpUg37ON1uayzZqgx3ZMhiDqN8IqZAie/4mzSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8BxHJtEu8VmYw8bAA--.21638S3;
	Wed, 21 Aug 2024 18:02:44 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMDxkeFBu8Vm_IAcAA--.60587S3;
	Wed, 21 Aug 2024 18:02:43 +0800 (CST)
Subject: Re: [PATCH v1 1/2] LoongArch: Define barrier_before_unreachable() as
 empty
To: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
 <20240820123731.31568-2-yangtiezhu@loongson.cn>
 <CAAhV-H6Mh3didzHnKJiEsMP4yVgggnBBuDS1U6yDzEvdVEbGRg@mail.gmail.com>
 <dab9357bd21d257f66a9f6a145570d0de61c4595.camel@xry111.site>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <53b0ed80-4bbe-490d-1e3b-f2dac1aaacc9@loongson.cn>
Date: Wed, 21 Aug 2024 18:02:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dab9357bd21d257f66a9f6a145570d0de61c4595.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxkeFBu8Vm_IAcAA--.60587S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4xCFyUur4xtFW3uF1fXwc_yoW5Ar18pF
	W3JF1kKFWDXFn29r18Kw17CFnxAwn7GrWUKryIgw1qkrya9F9IqaykKry0vFy7Cws8uFWU
	Za13tws29FWkXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

On 2024-08-21 15:52, Xi Ruoyao wrote:

> On Wed, 2024-08-21 at 15:37 +0800, Huacai Chen wrote:
>>> I am not sure whether the GCC bug has been fixed, I can not find the
>>> fixup in the link https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
>>> and in the GCC repo. So I am not sure whether it is time and proper
>>> to remove this workaround in the common header totally, just remove
>>> it in the arch specified header when compiling kernel with a newer
>>> GCC version (for example GCC 12.1 or higher on LoongArch) at least.
>> What's your opinion? From my point of view, this GCC bug hasn't been
>> fixed. So there may still be potential problems.
> I'm pretty sure it isn't fixed.  Using the test case from the bug
> report:
>
> struct i2c_board_info {
>          char type[20];
>          char pad[100];
> };
>
> #ifdef NONORETURN
> void fortify_panic();
> #else
> void fortify_panic() __attribute__((noreturn));
> #endif
>
>
> int f(int a)
> {
>    if (a)
>      fortify_panic();
> }
>
>
> void i2c_new_device(struct i2c_board_info *);
> int em28xx_dvb_init(int model, int a, int b, int c, int d)
> {
>          switch (model) {
>          case 1:{
>                          struct i2c_board_info info = {};
>                          f(a);
>                          i2c_new_device(&info);
>                          break;
>                  }
>          case 2:{
>                          struct i2c_board_info info = {};
>                          f(b);
>                          i2c_new_device(&info);
>                          break;
>                  }
>          case 3:{
>                          struct i2c_board_info info = { };
>                          f(c);
>                          i2c_new_device(&info);
>                          break;
>                  }
>          case 4:{
>                          struct i2c_board_info info = { };
>                          f(d);
>                          i2c_new_device(&info);
>                          break;
>                  }
>          }
>          return 0;
> }
>
> $ cc -v
> Using built-in specs.
> COLLECT_GCC=cc
> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/loongarch64-unknown-linux-gnu/14.2.0/lto-wrapper
> Target: loongarch64-unknown-linux-gnu
> Configured with: ../configure --prefix=/usr LD=ld --enable-languages=c,c++ --enable-default-pie --enable-default-ssp --disable-multilib --with-build-config=bootstrap-lto --disable-fixincludes --with-system-zlib --enable-host-pie
> Thread model: posix
> Supported LTO compression algorithms: zlib zstd
> gcc version 14.2.0 (GCC)
> $ cc t.c -S -Wframe-larger-than=1 -DNONORETURN -O2
> t.c: In function 'em28xx_dvb_init':
> t.c:50:1: warning: the frame size of 144 bytes is larger than 1 bytes [-Wframe-larger-than=]
>     50 | }
>        | ^
> $ cc t.c -S -Wframe-larger-than=1 -O2
> t.c: In function 'em28xx_dvb_init':
> t.c:50:1: warning: the frame size of 512 bytes is larger than 1 bytes [-Wframe-larger-than=]
>     50 | }
>        | ^
>
> And I'm puzzled why "unreachable instruction" is not a problem on x86?
>
Hi, Ruoyao,

I looked the gcc:machine_kexec.c:rtl:jump2+:kexec_reboot, it seems
the gcc thought the block `asm volatile ("")` is same. So for -Os,
if 2+ these blocks appears, it create "b" to the same block.

I tried "-fno-crossjumping" to disable the jump2 pass, it works.
Could we change this block different to solve this? (e.g. by __COUNTER__).
But it seems break the original trick. :-(

Jinyang


