Return-Path: <linux-kernel+bounces-304304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACD961D99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FAB1F24064
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C51487FE;
	Wed, 28 Aug 2024 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NPApUo+Q"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84513D50C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819245; cv=none; b=snUSKgVYHX3mzgBWncNHyzIaShKkBwk3YjLDw7laouUnLT0+gRJkCD3ov7QFTYh4rTX+sGwr+pf/Zd1T4BrnmH8cEsTmclxfoFxlbIz+75tLUDTM3JRqQMtz0k9ODc7s+0pdcibpqYWfbw/nNXropE9BC9HGtCZ7idx4saIw1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819245; c=relaxed/simple;
	bh=a8RPUI8QDKl+MEnGDot+dfjOh/NfKzktjzctWjFN0bI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s07ZuotYfITOkECAU8r5k1KbbAJW+tuxYWFmANFQPXNcy4BtBwTVlfRCZ3kaR+1rblyZtYq4a8P/X8LPbKYS7RkJ4d5jDLocoXcFQ2Tk8FV0PZe5IDfV71mmXICA2IfyAuNflWMW58FiPE4CtHlAwED2smjx1v9Oky7US12OR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NPApUo+Q; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724819243;
	bh=a8RPUI8QDKl+MEnGDot+dfjOh/NfKzktjzctWjFN0bI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NPApUo+QuQZjOb8IGOt4AfCzqxXm2fbR31fbWAN8DZu8UMus0rupTwn3Sc6LY67dq
	 smuOlUvzFZSktomPFRqCF/lcs9PJX8p9wK8k8P3MQJI89Yir44CsdLY1oNfvQ4YZoH
	 OlquvpBVl0gUlsev98sEagvN3/QlxRwa8OiWe8JM=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 44D6E6656F;
	Wed, 28 Aug 2024 00:27:22 -0400 (EDT)
Message-ID: <e8cc0f2d1e82097ab8646edfdd2a4a1fca386bcc.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Remove posix_types.h include from
 sigcontext.h
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 28 Aug 2024 12:27:20 +0800
In-Reply-To: <CAAhV-H5dDkyd5qkipwbKJvNduWM0UgENBqMHJGXhEoekizneaw@mail.gmail.com>
References: <20240828031421.147944-2-xry111@xry111.site>
	 <CAAhV-H5dDkyd5qkipwbKJvNduWM0UgENBqMHJGXhEoekizneaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 12:11 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> Just some questions:
> 1, Changing UAPI is not a good idea.

But removing unneeded includes from UAPI is fine.  For example, the
commit 44e0b165b6c078b84767da4ba06ffa27af562c96 has removed
linux/posix_types.h from termbits.h for all ports.

> 2. In another thread you said that "paper over" is not enough for some
> cases.
> 3. include/uapi/linux/types.h still include linux/posix_types.h, why
> your "paper over" works?

Well maybe it does not work (I've not seriously tested as it's just a
paper over).  But removing unneeded include is correct on its own
anyway.  And ...

> > The unneeded include was found debugging some vDSO self test build
> > failure (it's not the root cause though).

So it's just "found" debugging the issue.  Maybe I should change "it's
not the root cause" to "it's not really related to that issue"?
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

