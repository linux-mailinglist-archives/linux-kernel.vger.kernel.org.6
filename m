Return-Path: <linux-kernel+bounces-419367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA4B9D6D00
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9015D16166F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19C154430;
	Sun, 24 Nov 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="e42iajU3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2B3BB24
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435281; cv=none; b=NaL5kckvF03SwxgrEf1+gZXuAo5L0fAHlZyPL7GaA6CvkysPbO37k4VimWKLhXeV0lZhKOySTbCIHnMzLXAeVpvW9Bnaca++YPVK/uDq2XFm+Kgwd+yjnXZe3kDTUTck55lhbpwn4vt9BnL/GBuMS/Fnik6hhNHq/5gcfXlTqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435281; c=relaxed/simple;
	bh=28knUzrcH+Gzu63QW8w2KHri0j/rwrIZsolWY24ZjxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+TZ17Ptop2Rtjp5Xr+t0sgcFIzVyfQ81+pf/yUVPOxDsgu5ZH6v0Rl1Tdh475oVUZXI+ZfcXURQ7EL0n6MPv8VXAkG/KzlY6TCy7E3snnLEsNhOIe+a+Fz4IAxy+xsrUR1XyxlhVWpg6UpaqTMoRrXoGSQlczn/cn3dblsx23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=e42iajU3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732435269; x=1733040069; i=efault@gmx.de;
	bh=hRpw2mFARz4JPL2jz9auhVwjpypxeeuI9QzgVzO0Ktw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e42iajU38Ptb7rRor6qv2iSRd5h3N3TQffoqWD/3iLVbecitLhtKwyGnmoTUl0d4
	 AD3D6tN87Vs38nzX9CaA4YMioGbbQLz3/6u9KhxAApe/stcp7ISoWoPmpGwtIahYO
	 EHskkBj46IzWdom+i62H0pvyHTooEd9e/3t0hWGTM9FT3kGp6Ry+iWZ2oy/pVmyV1
	 fCz2OwIGyE8KJWJMx1uppS0lfNPvew3apzywxAvWyrSSfXy/Rt4r7NFeywg6Ke6Cv
	 lDofJcpiZF6ZgCpjGi7LTwC2nlAUkx2OiFzUaVcPBMtEb0T4NJvqTHPeKl3Sz4ok9
	 CPvw52Dn99JQaDNGdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.176]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNcz-1tvZqk0kWd-00lbK1; Sun, 24
 Nov 2024 09:01:09 +0100
Message-ID: <ac800b7930c473f2653d9bdc5be0781a08d8bb58.camel@gmx.de>
Subject: Re: [GIT PULL] HID for 6.13
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina
	 <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Date: Sun, 24 Nov 2024 09:01:08 +0100
In-Reply-To: <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
	 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NUw0HrOCLfwF1gEOIwtmp25IYOHpYVIaiJ2xllhdXUedFXmf5uT
 xRi8LF4YZcvhEFr0e48zhdHubX8JdPf93ngbuBWxe5lnDLQfDB90XpBdR+ZscQEmHYJHv3y
 eVKT5SyznB64IlQ7a0GU+2Rlio+t40MFIKt8FKJ/gAU2IiL6NW+L9flQtsLpjbbwZUIZNhK
 ulpolkgsrlRgfaVmrJOfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gA24hbxXr4M=;JOemUTBbETXbtgMZwtptJ2IPtgj
 tVte5PGpEngv2ZZu5X6Kty8gJ5eJE30rFj7xcbpPzScSH10bcD/9wHzytuutDXWAuF+hGvv3t
 E0sbNesc+SsxsdKJHQIcViMEc8jAivxU1kMG/bjuzQxKeucxs2GGfSAWRqKHYLJ9U/DutRouq
 irY2Bap4UZiIl2YXudq+fWCvucPs4apGsHwjoCwI6rgkLGH6aRlCehpvf0H/mA5rg+GRwSdUk
 qbxRvl34ZmTdRZakpld8mHND1oMadwotUB01/vCYhPGq3LnP81ElcFkNS7HiSqGfBEe5tm2ML
 kZXxkZ62bz4nOnVmV9Sc0QFd1XMFGiqqA6JutJLVxm6KSlrz23mmuTp+uWtv0gSPnwd/8t2Uc
 X3JLNkJI0bR3Dtceila1TzT8kIrArpQw1QUBZ1k51g5V3mOgF8NA2qIc1qYfsT0reGYbj/VQl
 RFEJj1oebN4qvvEm9hcqY1GXDQ6/+sEAgUP/PujPj0PSz1eSnvcsm0fiUmqaltEJEn3SzcOE1
 rS4Cw3yo77DHfdnlc0bl7djKrN3WG/EvBxjQ+5tz+xsI6lwhzhVQJypPcjLhRO9JgMqF4KjEG
 kNmB/INHrt6WQQoRrQTFmMGG3zYdZAYfphANs//G2AgskLUx0iqHovSrFPH8+078a/+dd7ZWH
 k63EnvrHe/oclr1FdjlFd7G4G3/k6ZHBo9l2YDHj6bqA4PwASDrAWQyVg7paxxfZ7kMVpjARu
 9oRs3bcL2hnywZR/TuAt0xc2sgZhoW0cjEGz6Qb2GzEDl+TgOWFj6P8H5ZkAwCdn5IhlxqTD1
 GxRwmsqVTZaAMmwEZvVUK7PSdGMs4prayKojoLSnMeBAPO/LUAykUZO27MJniYGi7IVPYKO86
 tdXGWW32z+4AcFMrIon3ZDEGC6+m8LyYYiebRAtlsyQalKCZfV4zmHmzx

On Fri, 2024-11-22 at 12:13 -0800, Linus Torvalds wrote:
> On Mon, 18 Nov 2024 at 13:16, Jiri Kosina <jikos@kernel.org> wrote:
> >
> > please pull from
> >
> > =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/=
hid-for-linus-2024111801
> >
> > to receive HID subsystem queue for 6.13 merge window.
>
> Hmm. There's something odd going on here. My mouse scroll-wheel
> stopped working (Logitech MX Anywhere 3), and this pull would look
> like the prime suspect.
>
> The mouse otherwise works, so it's not that the mouse isn't found,
> it's literally just the scroll-wheel functionality that doesn't work.
>
> Oddly enough, if I remove and re-insert the Logitech wireless dongle,
> the scroll wheel works again. So it's not some kind of complete
> breakage - but it also wasn't a one-time fluke thing, in that it
> happened twice in a row when rebooting into a new kernel.
>
> Any ideas? Does this make anybody go "Hmm, maybe ..."

No, but my M215 had the same issue, it bisected to 6fd47effe92b, and
revert via patch confirmed it.

	-Mike

