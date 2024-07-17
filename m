Return-Path: <linux-kernel+bounces-254761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D51933750
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB47D1C20442
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCEC17545;
	Wed, 17 Jul 2024 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HFoysgEO"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0601643A;
	Wed, 17 Jul 2024 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198613; cv=none; b=NETqqIwqGMZfvFr+IPvVYflJbnYjBVEMrn7VcxmJGK7Ma5XWcpJA1HCS1tov3JgHDBAc2g9ljv/6crHqc6iWV3RoortTv59WMGyOMVD3RdsYmpXJvFaAyx++EGE9e3cx+lp2hHkv1Nx5YyqobYPD+FhhbrmYCDvEZc0D9pfcD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198613; c=relaxed/simple;
	bh=ja7zeoYposPScr+T5LloA2DwfVJSupnGw+spH+7H5Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvFPwIq+7Rd8JQ+pdvtgtemNy5S6byWcacR1J3SZZ2kW7e4FxfztTrh7X7VzEAh+335iebcrAb2CxSQutLcoENZHjeSch5Fm/CT/V+ujQ5mbqR/8gNw0xJeUgXUZAjfmqQq5Rzwdxf7cPle4qGk2Hl0jq4fWATfuZIaz68KhCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HFoysgEO; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721198559; x=1721803359; i=markus.elfring@web.de;
	bh=ja7zeoYposPScr+T5LloA2DwfVJSupnGw+spH+7H5Do=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HFoysgEOSnRSdxn0p1smH508PnxPRO5c9h3Pp81TPewOIJPM4bvkBJEvKTpFuBXa
	 cSNe7C3PZDA53cK82S8LtfGWgaZPr+yYYaHtDS1FYqvZG2+nu1sB4ZofUbDh/Ro/6
	 OkF3K0CtO41MFcaeJfxHWtupqZAY9vngWjAKVngolmBXwbzvpsi+IX0PMYQ+QdNqV
	 MnvPI0OIMPVVHm4w6iSSfzTfYvUWqt87/hfUAHAnxbmDM1jNd2NpqfPLFGHA3Z1tR
	 hV8uB8kGhLo099uACdjsNr2TJtemn30fXqTzuNIqpbrJyyVRKwwgOlpLvXwzm3+0A
	 Pq4/NzrySaRMjMIECA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Movne-1rzqYD0cfu-00mLwS; Wed, 17
 Jul 2024 08:42:39 +0200
Message-ID: <d4d6c5ec-f884-4942-b90e-a3b58edd1e4e@web.de>
Date: Wed, 17 Jul 2024 08:42:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/resctrl: Use seq_putc() in two functions
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 kernel-janitors@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu
 <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
References: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
 <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bsbBHCh9dSOnyJFlUE4Y0uTiGVM8gEVJFaqti2cjqpWIHVQXB/m
 4sdHifbKPC3+mSW735fEhwT5WCu+dOtYOVWDP41R9wNQr0xgLV/+xWkLytFodM3QPlz8Prl
 oI/4xx0YYTM4YjvppGG+W3tdARtJI4WkXl9VgP6p1hWHCtcf/H9Cmh0t3Hd27FwZksNSffa
 W0UCNgvC8FGL+yYTCX47w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+YGqUFSdjlw=;4Xe2f9TWnn9td51FmwdfuX0V+Xa
 G9SpiSoFT7LI5sdwfUavt3JgIrEoEUpqoMAVfIq3RiVh/C9Lbsssk72/3ZEQ14SVqZLGkjbGs
 TWiRhujvHqRAbRaXvxSxIHuHOYyxlxky3rZiEauvFKvspLvErGyHl3qPld2bW0K9eqXlcyhrG
 TywxzktMTEnfG/O9WbV4/Wz3lRCVSTSHAf0tvCTScQv5H+R1DSq9mJ9k80BzU5HflJAfXkemJ
 u8KbSuFsw14ZG/6W61EGx++ogkncq9evV5xKlVzRzfu3Dvm0KjIspdugYxa3Fv81zVI4d68tR
 MM4CB6ToxvyUm8zB6F4vw9IL/WQOK4A0IIlxgr9pb3aKdbWn5kAYfVbTb4kvkjpzeb5cNeeNi
 l9/iwfAxvHxZguviq5U+aLUGWxcAbryzbH/TkTJI5QRxzqOh27nro67z3k43oaQx8ToK9UoQV
 xMA+c3I2EgEWVjsUKGs03eEEzPHZ7RxW71gYePi/gAE5eDp4hKEBF/zrQ44SNcNKuODxTQNtv
 4lOfJcLvjJlupgFu2Lq6iKWSs1UD/YneOYfAxe2x52dFxTrFdJQltq6kNV2mX4us8Uhz3nXYT
 WBEZPCoBE/UBa4Eub5Eu4Qvi/5aRRYtSX5byntIw51o4dYVeIjAA5Z+mSjeJ0SJgtn9nyW0DA
 iZWnWRl/7YMc21rBof2acTmN8iCZtcOygtq6saUw2g6hx6pF4t3Rd13njBh5KMoG+0rPxpM13
 xGUbbNTTZYCOiZnPoMDK7tGuP0asVQg6IrNjmlLtLgBIg+yqnrKBn1PghpKqTWG558tCwvcTa
 O6BpWRFgkyOPXswQovtHwt4Q==

>> Single characters should be put into a sequence.
>> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>>
>> This issue was transformed by using the Coccinelle software.
>
> Could you please point me to how you accomplished this?
=E2=80=A6

Maybe.


> Is this a new coccinelle script outside of the kernel

I constructed small scripts for the semantic patch language according to
the presented code refactoring a while ago.


> or still on its way upstream?

I am curious if such a transformation approach can eventually be integrate=
d
for the coccicheck tool.


> Could you please highlight the benefit of this change? Looking at seq_pu=
ts() implementation, thanks
> to [1], it seems to me these seq_puts() calls will result in seq_putc() =
anyway?

If the appropriate function call would be directly used, extra optimisatio=
n efforts can be avoided
by the compiler.

Regards,
Markus

