Return-Path: <linux-kernel+bounces-529904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50CA42C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE03A364C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24E1EA7E9;
	Mon, 24 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HmNfCxc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLSYzHZB"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084171E5B82
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424014; cv=none; b=dDY242XpF2stsL6L+wogwqdiygHJZeVdQtusaTAzQqtRx43jRHLwyElEXgWLl5WJUAMXQcV0V0g0QEAFEmVGJGF4CXn1fW9KcXzJvnjxxCbaiAcQpceVL1RMhzhn1uld8oSZmQar4ZCRp0iV5spnLVXQWj3CH/kyFe9wttb5jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424014; c=relaxed/simple;
	bh=UC16zEXqao2dlx855ziFoNerD1hduUWXhg1aZResub4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HOTVtOzjAziPYGzp8gAu8rZZ8MxIpDJOBlINdGNx5JNcpq6SQDGbdPYAEWFdnrBVEs6TU2T8/jsrbYVoNZATqeMSPjOOnHP7Wd28t1nHtE1dbmfw7is5xzc4Lp/2rGPd6ZXF4x/WUiskRMfFkaMua8R2bg7sLvFvhfWZMU6uEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HmNfCxc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLSYzHZB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CE1F2540189;
	Mon, 24 Feb 2025 14:06:50 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Mon, 24 Feb 2025 14:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740424010;
	 x=1740510410; bh=Xa16rFVbwHjyddy4WX/VwkxxP6PBp3La/1/uqQ+Vg/s=; b=
	HmNfCxc2Nxcus6tmJOqyjzX4PI6MQjDTwmbRNx5YeuD/iHQMKzaQuz1Bj5aJJyhp
	bPsml16+eFKopsFzFun9IJgkdCW1zdqRNW/PnOoPFYiWTGiBOPquBJz++M5UfDZL
	0zc9PbEJzmwFadsJBJDzGspGIQ1lBHVkUKC2ncJ4SSQCNXSdO0gX1oudsQ2AgmxM
	QEyiyPEGK7fnx5ScIc6jtrdDPwHYbiicpSAKf8qFFzgEL451daAsVU5Irnab1Zu/
	9B6reFwmSvxZxDhFS7i2cfGqFkhv56B6NAOTfBPfDFTOPvVWICTWKsOx+lOQ4sPz
	VzqVGpkUww+l1GoSEBT1qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740424010; x=
	1740510410; bh=Xa16rFVbwHjyddy4WX/VwkxxP6PBp3La/1/uqQ+Vg/s=; b=J
	LSYzHZBxdCiFFXytVsHm4mVk0Yg9nk3jMknBf8hiNZ/jb4pl5MyJDCnPp4eYgHuu
	nEGdaXQC0EeYeoFPrkXY2Kxxq9v7vnOOxE0U8baovVjnjFWGeFcFJvWOzS1iFCC6
	CFWGn+PxLebzY8Vhor/Kl+2idPaD8c1HijuWDr0PkX37v+uc1K5wDn557OpPYQZs
	234B5s/y22hiNtrr0g/b0Qq35HRVhQ/yz/543/DhI2F+3vz64bEJrwd44JIB/2vL
	Jc71qZfkE5DkuUrEDv9A2YsP0YzGN+ixONok4lokLvdV8uWxt52dV4un3Col7Jk0
	j5FsMcxB/IBw9n0Q/fUcg==
X-ME-Sender: <xms:ScO8Z0slvA-3Mjh8jUGU46zJXS8CRNwXpLQVakyl1hc5cRAgNLxFKw>
    <xme:ScO8Zxdft28j76EFSGge6MQs6WvSKAbQ8ya60iEwRvJVosQxRU0S9Os5tCmL1UTM-
    YSPC1irgrV32LCo46I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhr
    tghpthhtohepvhhivhgvkhdrkhgrshhirhgvugguhiesihhnthgvlhdrtghomhdprhgtph
    htthhopehmrghksgesjhhunhhiphgvrhdrnhgvthdprhgtphhtthhopegrrhhnugeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopegrkhhpmhes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhhuhgssggrrh
    gusehnvhhiughirgdrtghomhdprhgtphhtthhopehsthgvvhgvnhdrshhishhtrghrvges
    ohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:ScO8Z_x-FuMcKUQuxap0mdpFA1a3JaBF06YCJlyZ8_DxhjgslUPvug>
    <xmx:ScO8Z3Pl3cOLwKk405AOYxegKLZA_QSzn4sr1FaIJwdWyX92J05WAA>
    <xmx:ScO8Z0_I5z0ax2I2M8nPebhWHW-sOy6KtM1osrzat4S8FHiQ-ny8CQ>
    <xmx:ScO8Z_XfYUXwDViaP0tYD7JYBLmPdeGI2p_OcuLOh4USEqCPLGwzEA>
    <xmx:SsO8Z-fXuBzyWYA73aqen8lQ_51HZ-3Av8_9zmuOBM2CtAHxS3AAGqG9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9CAC32220072; Mon, 24 Feb 2025 14:06:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 20:06:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Brian Mak" <makb@juniper.net>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Kees Cook" <kees@kernel.org>, "David Hildenbrand" <david@redhat.com>,
 peterx <peterx@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "John Hubbard" <jhubbard@nvidia.com>,
 "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
 "Vivek Kasireddy" <vivek.kasireddy@intel.com>,
 "Yang Shi" <yang@os.amperecomputing.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <95b00b45-c9c3-4a2b-ae9f-a0144ac3d05e@app.fastmail.com>
In-Reply-To: <6EA7241F-A4B0-400C-B338-C375512727B5@juniper.net>
References: <20250224151225.3637934-1-arnd@kernel.org>
 <6EA7241F-A4B0-400C-B338-C375512727B5@juniper.net>
Subject: Re: [PATCH] mm: unhide get_dump_page() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 24, 2025, at 19:42, Brian Mak wrote:
> On Feb 24, 2025, at 7:12 AM, Arnd Bergmann <arnd@kernel.org> wrote:
>
>> The definition of get_dump_page() is guarded by CONFIG_ELF_CORE, but
>> the caller has now moved into a function that is built based on
>> CONFIG_COREDUMP, which leads to a possible link failure:
>> 
>> ld.lld-21: error: undefined symbol: get_dump_page
>>>>> referenced by coredump.c
>>>>>              fs/coredump.o:(dump_vma_snapshot) in archive vmlinux.a
>
> Kernel test robot reported this issue yesterday here:
> https://lore.kernel.org/oe-kbuild-all/202502231914.ROOVWMZN-lkp@intel.com/
> https://lore.kernel.org/oe-kbuild-all/202502231818.fP8cuxmf-lkp@intel.com/
>
>> Change the #ifdef block around the definition to match the caller.
>> In practice there is very little difference, as setting COREDUMP
>> but not ELF_CORE is not useful.
>
> Good catch! I wonder if we should guard the sparse dump size calculation
> logic from the get_dump_page() caller behind CONFIG_ELF_CORE instead
> though. I guess the question becomes, will we ever have a non-ELF core
> dump format that won't skip zero pages?
>
> Anyway, I'm fine with this fix as-is.

The only other code that is guarded by CONFIG_COREDUMP now
is the powerpc spufs, but that is only used with ELF_CORE as
well.

The last non-ELF coredump support was removed in 2022, earlier
versions had some form of coredump for flat, a.out and som
binaries.

We can probably just combine ELF_CORE and COREDUMP into a
single Kconfig symbol.

      Arnd

