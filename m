Return-Path: <linux-kernel+bounces-319597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21096FF08
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000D51F2383F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB362DDA0;
	Sat,  7 Sep 2024 01:44:53 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132F1171C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673493; cv=none; b=oXghaAkqdwUp9U5wT1V4mXE50YxWkdQHvaFxkmTKcIbNmxh1bUTKwOMKs0Cugf5ZtzSZ7Onc28Y4EoIqc58zYq9gT7tMR6veOZW+Vy2BFldBM5Iw7vmySU1mIY2Y8N63zolTsEWDIw7cNU0mC/tKH2MrHDkscyvSRuna83isOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673493; c=relaxed/simple;
	bh=pylA5tagj09nDI87yFBxwRhwPG7LLyAmv1xsfsc/61A=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RQlUsxKdOpKQ3X6HP0MGRlPx51+Ta+hWxUXdCrJ8vhWznHpW13vYndd7gJu7naIQkIZy0lrDBMSgBDkqA7VTJO1AMxrP+2dJ9mfl/p6QdsvEGgztXAR8le6VhT4l8+SZOB/1UWLixT7e3CsDQzcEYs7fSbTK63kcVpCsaf/jn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxPusKsNtmM90AAA--.3083S3;
	Sat, 07 Sep 2024 09:44:42 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front2 (Coremail) with SMTP id qciowMCxSsYHsNtm0sMAAA--.3804S3;
	Sat, 07 Sep 2024 09:44:41 +0800 (CST)
Subject: Re: LoongArch without CONFIG_ACPI and CONFIG_EFI
To: Huacai Chen <chenhuacai@kernel.org>
References: <ZtsX_tcEuOjktUl9@zx2c4.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
 xry111@xry111.site, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <84a8ee9c-7781-c474-c394-d1498dc00050@loongson.cn>
Date: Sat, 7 Sep 2024 09:44:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtsX_tcEuOjktUl9@zx2c4.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxSsYHsNtm0sMAAA--.3804S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

Add huacai who is maintainer of Loongarch Linux kernel.

On 2024/9/6 下午10:55, Jason A. Donenfeld wrote:
> Hi,
> 
> It appears that as of QEMU 9.1, it's possible to boot LoongArch machines
> that don't provide EFI or ACPI.
> 
> Would you consider removing the `select ACPI` and `select EFI` from the
> arch Kconfig, so that kernels built for this minimal QEMU environment
> can be a bit leaner and quicker to build?
> 
> Jason
> 


