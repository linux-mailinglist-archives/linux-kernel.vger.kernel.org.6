Return-Path: <linux-kernel+bounces-332884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F5197C045
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DB71F224B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5C1CA6B5;
	Wed, 18 Sep 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Za/GncK3"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7D1CA68D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726686163; cv=none; b=KaAA/5GhR0r33/W5p7t5TbzGIwSnqWdiqgXg8py5PF7EjjcNV1W1uy7yYqqryHvVTo9ENbf6gzgONgJsEAZmzF9LsqyTvrIoV6DuoEtOWAB4vobY5OqtlvM4mM17sMAaMSYRjnxwpvjKZ4KDe7yTvvLgeArGpWIWwmyVITUqCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726686163; c=relaxed/simple;
	bh=EFhN8pV0NsDmmoThr/HumcCuLJsKNQM9JtplMTtoCl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8uuffrwg8pTMEA4OFN55OU4WLMqHavfgJeeBJmTNBkOZOSXymMViasmks9EiOZ8soxhVDHKIa2ifjDPJ0kGLID0V6H6Lo40MJ/lX+JPrnq8M6+P3sW44N9zCrsY+rLlnV74/Wr+fJC8oPjgCkg/i5eQYcKWZY8HTQVOxuueGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Za/GncK3; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hm6f62me5zfehgqo5swzxhteqi.protonmail; t=1726686152; x=1726945352;
	bh=7GdcvU5FkKUSpgrTsdDxfk8ra0wQuGtzZmsZwzAUU8U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Za/GncK3DVZssQwzShrhHherOL5eu2X0IGkuB7FzZddsN8SgtX19AxCGDp1i01NOy
	 QqWaU4g3kMa/RmmU+/nzUOkOuDw0RLgK6Dl5IkpQm4xZdQAe04vtnTdFTZ8cKCimr0
	 cpjAauk7hcZqlM63gjqxvE9VKqeTs9g/2SSpK6/bAiSBuWK2IlBPOkGcUhP7Nx23+T
	 JTRixKjRpeG8YqDlH2X+hGT4SjDxBHzSbqQ3znXqeRPBViBGC1Ui8sPgkxIpzeSHpD
	 IHTyqRnh19q0GIc+QfJsYsku2WAvbuMjzpVBlrxfpGkAX2bmqJX2kt+wo0TMjD0W5f
	 5TyTWKDojoLbQ==
Date: Wed, 18 Sep 2024 19:02:28 +0000
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
From: John <therealgraysky@proton.me>
Cc: Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <JDkDAyklisK_zhy8Ecsw8Z6t4ALDO1Jzzza2DZjWefD5erI-tTPGD6GhevyIp1Ee1xoWg1ouqkMCOqcylaqwZg2YBO7h9USi0qzCIRotUBo=@proton.me>
In-Reply-To: <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local> <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 67efbd4f66f81f3745ad239ca85166873095366f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, September 17th, 2024 at 2:45 PM, H. Peter Anvin <hpa@zytor.com>=
 wrote:

> On September 17, 2024 8:22:38 PM GMT+02:00, John=20
> Also, these are not uarch levels, they are ISA levels...

Thank you for pointing that out.  I see now the differences between ISA lev=
els and uarches.

> Besides, there are already well-known patches exist for years. So why rei=
nventing the wheel here?
>=20
> E.g. graysky patch used by ZEN kernel:
> https://github.com/zen-kernel/zen-kernel/commit/6f32b8af8ccdb56ef2856db36=
31eea55b79378c6
> It contains way more architectures, includig ISA levels.

Yes, that is my git repo.  I created the subset (just -march=3Dx86-64-v[2,3=
,4]) patch specifically to post on lkml thinking that the larger patch with=
 all of the uarches would be too complex.

