Return-Path: <linux-kernel+bounces-199271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9478D84AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487D41F239E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AE312E1C6;
	Mon,  3 Jun 2024 14:15:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A7126F0A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424111; cv=none; b=cLCv2AnP0XzvHomfO/WNJdkv8FS6b443QbvHpCNKX0W+veGn3JhviwSDIpfLsiFcYri0UbaHEjrQ9vbWUsDs/AoIlJVQ7MX0muxcqfUVo8Uso4yFMd0Ug3OboRAJWEWtMFzJ0KkGVy479FNHxCdSO84wJy/+C+yT6K9myLPWwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424111; c=relaxed/simple;
	bh=RycexeqACn7xqxJOGcg/HhyDwq4dh8EZGkg2zQ9BtNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pX1hUd++BXdcGbhh8L0Zf929rgEn1ErJc4lxO8yj5SY+rc7QN1R8WUazOhro58YMEkiDaJMbaave4cir3gKHM5MG52mLW6SxUTPhHlKpyhNAhUviU3lFz5g7t/wvXtFChK2GvapQhfXUzGwK+uWS155+TNI5JwfGHEz7zsU1zNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VtG13132Vzcl0Y;
	Mon,  3 Jun 2024 22:13:43 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 64AA4140109;
	Mon,  3 Jun 2024 22:15:06 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 22:15:06 +0800
Message-ID: <daeb2b80-98d6-44c1-9045-3a3fb087b858@huawei.com>
Date: Mon, 3 Jun 2024 22:15:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v4] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
CC: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Fangrui Song <maskray@google.com>,
	<geert@linux-m68k.org>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<kirill.shutemov@linux.intel.com>, <geert+renesas@glider.be>,
	<corbet@lwn.net>, <rppt@kernel.org>, <robh@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240316023932.700685-1-liuyuntao12@huawei.com>
 <CAMj1kXH5bpbagOO+WFwxp4=U=Kbu9RVbPrEemt80S7My1jTEdw@mail.gmail.com>
 <a800254e-f305-4adc-9d8b-fea8c5926539@huawei.com>
 <CACRpkdYJkyqc5PkwTEdC=inqFHvZS4J9AoJOnBzxDB+wU6bZcg@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CACRpkdYJkyqc5PkwTEdC=inqFHvZS4J9AoJOnBzxDB+wU6bZcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100004.china.huawei.com (7.185.36.20)

OK.
Thanks~

On 2024/6/3 21:47, Linus Walleij wrote:
> Hi liuyuntao,
> 
> On Mon, Jun 3, 2024 at 2:55 PM liuyuntao (F) <liuyuntao12@huawei.com> wrote:
> 
>> Gentle ping
> 
> FWIW:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I see you put versions into Russell's patch tracker, but please mark
> these as "superseded" (you can do this in the web UI) and put in this
> version of the patch based on v6.10-rc1 and tested. Basing on the
> -rc1 is usually best for development work.
> 
> Yours,
> Linus Walleij

