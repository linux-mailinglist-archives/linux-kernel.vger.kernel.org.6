Return-Path: <linux-kernel+bounces-306307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A639963CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B371F21914
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F316CD1C;
	Thu, 29 Aug 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Anmad/q2"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2871898FD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916605; cv=none; b=WE4gpFZNfqV80g3F0xNDQxWvYVRcuEHnSo5nwKAvWuc/QHB5dgv0BY+2QiNx1AE6ZsdBR7DLkWRi86X6FvtUIXsnxLRp/oF2kZR3xU+t98vPIyADsktB5g5ao/ssgEJpNRSMmk8MVVNNx8cRdI2QYZN1NLWyzD/RbXei/eo1wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916605; c=relaxed/simple;
	bh=B22L4EpLZ/nJYRm9ioZMoDnSAsmGmN2WDW+2SjK4HqA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BjwP6vGUyVd3NCikaHaImP73bQHnfblrq6lj5jW8Hw1h4g+xXrsgy1IpIL7+DDeHfVt3PSTeRpd+KmZNv390quPORY+g9qhid1iKXqJQUJMIrJLua0AdUw1/7/KA8vJvYeyv0JgVHaqWn2DD6I78De8DG9yexTrlqLuoQHvi7EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Anmad/q2; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724916603;
	bh=B22L4EpLZ/nJYRm9ioZMoDnSAsmGmN2WDW+2SjK4HqA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Anmad/q2SsIQR10cl38/i+vfJNz1NOqr7rjRysxtNZKle5a9aG7ByUUX4PYtgSHeY
	 3c+O/6cGphVyZgzBdmOHqTchaAEnrwEU62K7xAK3FszV9PcCB3P2nVVP98/F2CWFLf
	 5E7tYFQdqkjmze/mniDzLuYTeL9waXfdIYYiymac=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 30CF866F26;
	Thu, 29 Aug 2024 03:30:01 -0400 (EDT)
Message-ID: <9236591104ebcbb7db9561516f38ab889c05a17b.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Remove posix_types.h include from
 sigcontext.h
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Thu, 29 Aug 2024 15:30:00 +0800
In-Reply-To: <CAAhV-H6QxJH9y34326La4yFkz6AxUKPRYNkmkxhEe0i0S6QLyA@mail.gmail.com>
References: <20240828031421.147944-2-xry111@xry111.site>
	 <CAAhV-H5dDkyd5qkipwbKJvNduWM0UgENBqMHJGXhEoekizneaw@mail.gmail.com>
	 <e8cc0f2d1e82097ab8646edfdd2a4a1fca386bcc.camel@xry111.site>
	 <CAAhV-H6QxJH9y34326La4yFkz6AxUKPRYNkmkxhEe0i0S6QLyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 12:43 +0800, Huacai Chen wrote:
> On Wed, Aug 28, 2024 at 12:27=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> >=20
> > On Wed, 2024-08-28 at 12:11 +0800, Huacai Chen wrote:
> > > Hi, Ruoyao,
> > >=20
> > > Just some questions:
> > > 1, Changing UAPI is not a good idea.
> >=20
> > But removing unneeded includes from UAPI is fine.=C2=A0 For example, th=
e
> > commit 44e0b165b6c078b84767da4ba06ffa27af562c96 has removed
> > linux/posix_types.h from termbits.h for all ports.
> Need more tests, not just kselftests.

I've built and tested Glibc with this change.  But if you want a full
system rebuild it won't happen in the next few months, and I can resend
the patch after the next time I rebuild the system.


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

