Return-Path: <linux-kernel+bounces-301657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9AF95F3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20789281DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF018BBA3;
	Mon, 26 Aug 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="xluqtBuL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pb0j8WMO"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D67BB15;
	Mon, 26 Aug 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682129; cv=none; b=cU9bmz1iRfaT1HKZRV6CWs0eiMNNhlBfYVlo0laLBC0u88zczuI5yfkTHHCYYndRI3cw6n9OVoXAcxkkUMNP4N4xFf+idxU45Tj13YsD+YmTxcKSf+2a0pZQ2L/4rbWjQsJ7X7lyWOSScK3zhoog7heOGQlbxKRVKy6E7NNk874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682129; c=relaxed/simple;
	bh=CYbj1j7FjoELrxn0RAajPNibHiZ38GUK7VqfvUgDIA0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tg1/s04ppuuM85UOo+GcyQFAqjVllfKOSTRcM0oRKdHsgrldAqY7fYUV3KgGilWAVp8Vrkw6BDTZYtpYxDrU7CBnyvgxEorGxSXmAQfmaOaetHIAPrv0jjF0wDpOdejpGJeZ6q7zpIKPyXOMLC2qjRA+CcsISzKt8+NTFbRCVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=xluqtBuL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pb0j8WMO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E41BE1151AA9;
	Mon, 26 Aug 2024 10:22:06 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 10:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1724682126;
	 x=1724768526; bh=ASEjOFtcIjkhF5bkMjqXjN8mcsXwNaXpIL2eHm4tIjc=; b=
	xluqtBuLZNvJPbpIJabYMEVgvEfIecBY4topuzyZssk2Nui0A6zlN+klU4ZuN9Hr
	s1yVM1NV3JLa8Y+wKwiwc3rrChbmhFwqy0txAmd8OkAEziDAH/6cAoEQEdOLoIe3
	RNqi678ccIp22JpdtcA6Vi3pjzs4HNKFVdJS38JcMiD3ZPgHv7tq1ewX6Oi97B0Q
	aRf3JJL/ta1cMgsFf4Ql81pKtPOhU3s2e5Cr509ZmUlP+7dsIevWqPtY6BnIac8E
	M51+UaOlKk8fhR1B4plsyUDzhzDvHQdI4v7Bf/lntO0hc0/ZAj1NnHlqP6T+UNio
	wIWxpfGcyFQgt9W6BXE/aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724682126; x=
	1724768526; bh=ASEjOFtcIjkhF5bkMjqXjN8mcsXwNaXpIL2eHm4tIjc=; b=P
	b0j8WMOdX6tFGg8l80rhzOBXm7rDlvBicl5TITD54lAbSGS6EeVUzllm8l/hfO3H
	jfqXvR1SWqMcEowXHinKftY3jStGR//ueM451Do3Yrb0VqzHhbh6qNbvDSNIIJEp
	RMOYCZKWfmGo6cLbKRyOuGORu/RQbWoin71pVo0PnrxXl6Guh6N1lhKzp+hEQbl6
	HhGjGvIeNDiz425JAJgUEzTWDEzp4lCr81s6pzjmdDa1b67Uz+yaDchYAvx3fSzC
	qeQGT+iaxddg4XLbIaVhK1DkLM6PfJQEn6GU0Ig9zHXLJoUHvT9n9l+HTm1TcVib
	3DY8wuRpMldLjBSJXk1QQ==
X-ME-Sender: <xms:jo_MZpD4PeXsE4--zX3DCy-u5tHZuReh8Zx2CqClDVr65o7d4N2jlw>
    <xme:jo_MZnhRapWA_MVjce7TAT1nGhvt9IbWZOe25kpsiGI2t2NxjB_kDw0zSZpFOQ19R
    jwq73KypojjuQqb5uI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
    gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghrrghvrghnrghksehgohho
    ghhlvgdrtghomhdprhgtphhtthhopegvnhhkvghrvgifphhosehhohhtmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeguvghvihgtvghtrhgvvges
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jo_MZknYdkUJWPqqIP9gEcWj82_PWzUPxQMRUhfa58PFFA16zwtPyA>
    <xmx:jo_MZjwZG1A-AGUiecrxmEUZNe3Bgw7BM4VR5D9NRQXFT_r6vEUfsA>
    <xmx:jo_MZuRqyfuD-f4Bm1HhLcqiGCc6eHhsZ7MT3Mz2Z_xYHB0N9apcgw>
    <xmx:jo_MZmb34e0yCBDZ27D0U1ng0LjAVaDxK6OWSwvnJP8jMS8w0wYlKQ>
    <xmx:jo_MZtGhWv3rhutNT_PjpC3QXJyuO6sU2kVYh-90OtIFyLVZ9wGIxHkn>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 794AB1C20064; Mon, 26 Aug 2024 10:22:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Aug 2024 15:21:45 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Rob Herring" <robh@kernel.org>
Cc: "Saravana Kannan" <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Kevin Wheatfox" <enkerewpo@hotmail.com>
Message-Id: <c0df4919-21b4-4526-8861-f74234ffd390@app.fastmail.com>
In-Reply-To: 
 <CAL_JsqLeVPBz4mEedXEm=rb6ghWwROB7jr-PDw3qVsNRz20Z_A@mail.gmail.com>
References: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>
 <CAL_JsqLeVPBz4mEedXEm=rb6ghWwROB7jr-PDw3qVsNRz20Z_A@mail.gmail.com>
Subject: Re: [PATCH] of_reserved_mem: Save region name string into struct reserved_mem
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B48=E6=9C=8826=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=883:09=EF=BC=8CRob Herring=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Aug 21, 2024 at 8:51=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygo=
at.com> wrote:
>>
>> Previously only a pointer to fdt string pool is saved to struct
>> reserved_mem as region name.
>>
>> As on some architectures booting FDT will be wiped at later initialis=
ation
>> stages, this is breaking reserved_mem users.
>
> What architectures? Be specific.

It's LoongArch and MIPS, I'll expand commit message.

FDT might be placed in .init sections or memory not managed by kernel, t=
hus
it may be wiped out.

>
> Why is the FDT wiped? It should be preserved and you need it later to
> implement kexec.

So KEXEC is using kernel's self copy of FDT created by unflatten_and_cop=
y_device_tree(),
while reserved-mem scan is performed before copy to ensure that reserved=
 memory
are being tracked by memblock before possible memblock_alloc in unflatte=
n_and_copy_device_tree().

Thanks
- Jiaxun

>
>>
>> Copy and save the whole string into struct reserved_mem to avoid
>> FDT lifecycle problem.
>>
>> Reported-by: Kevin Wheatfox <enkerewpo@hotmail.com>
>> Closes: https://lore.kernel.org/loongarch/ME4P282MB1397447C3C094554C7=
AF2E37B58E2@ME4P282MB1397.AUSP282.PROD.OUTLOOK.COM/
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  drivers/of/of_reserved_mem.c    | 2 +-
>>  include/linux/of_reserved_mem.h | 4 +++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_me=
m.c
>> index 46e1c3fbc769..22841599cd83 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -70,7 +70,7 @@ static void __init fdt_reserved_mem_save_node(unsig=
ned long node, const char *un
>>         }
>>
>>         rmem->fdt_node =3D node;
>> -       rmem->name =3D uname;
>> +       strscpy(rmem->name, uname, RESERVED_MEM_NAME_LEN);
>>         rmem->base =3D base;
>>         rmem->size =3D size;
>>
>> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reser=
ved_mem.h
>> index e338282da652..ed9de36c9cc9 100644
>> --- a/include/linux/of_reserved_mem.h
>> +++ b/include/linux/of_reserved_mem.h
>> @@ -8,8 +8,10 @@
>>  struct of_phandle_args;
>>  struct reserved_mem_ops;
>>
>> +#define RESERVED_MEM_NAME_LEN  128
>> +
>>  struct reserved_mem {
>> -       const char                      *name;
>> +       char                            name[RESERVED_MEM_NAME_LEN];
>>         unsigned long                   fdt_node;
>>         const struct reserved_mem_ops   *ops;
>>         phys_addr_t                     base;
>>
>> ---
>> base-commit: bb1b0acdcd66e0d8eedee3570d249e076b89ab32
>> change-id: 20240821-save_resv_name-4f2e2cb8883b
>>
>> Best regards,
>> --
>> Jiaxun Yang <jiaxun.yang@flygoat.com>
>>

--=20
- Jiaxun

