Return-Path: <linux-kernel+bounces-246604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBE92C432
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C60A1F234AE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D868B182A7C;
	Tue,  9 Jul 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="jzY1FJBd"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090B182A75;
	Tue,  9 Jul 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555029; cv=none; b=pNWKy5OypB4oomVCRN5Rbr/2svfei1faECmF4H6sHz2qxPcth78o2H6OZSmGONBlAc5LYpIqYGycAFgvptK7UdxZ5aWLJJJthOHLZ7d3UvA2F2bafJ0cNn85Jl724Yy41YpIFHHkz+rjAG5nts1FuvkqyUv+GPcBsPqhEEuJAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555029; c=relaxed/simple;
	bh=pe6E40kD2UguQlc+1RZnhH3OiNQLpX1XEWsDvh08jx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/wpuqLP+uPyezRWzKYwn0MvYV2eRKEP4l8ocqlSrGppuU0oya+EBNakLxRHhAaPazkMMLyYAxulHZd/HDNSZxG2FXt/0zAh5i6GjZ3z058PjjBXPJTN63ei8XHy52cxUyv/1hYiQPmUEgwBpin5SuC5xSR6lku8Nx0n08p4kfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=jzY1FJBd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720555016; x=1721159816; i=j.neuschaefer@gmx.net;
	bh=X+Aym152/slUT1a8cnR0jcSyki1jKyW1FASNrMPLCdk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jzY1FJBdhCxT/HHU2tS+0TAm8kni7R9aeDkXMVQrIVDggCWa0GDCrrfuT+sF7caf
	 FfcoskCpkhelDEQXs2cPV0yLU8b8n4RrGvlqm/0ATL6utfBSShYiwyiowshuwnuy6
	 kcL9bouaOG55N/otNU4OeLt3gFuxcU19alIdvIgSnURGBdFPtEWN75hbEdhzKhqnK
	 eumCUBMyDoCz81Sl6qX4XXRsF29Zs0vvVBSB1bdWdJJ9UFANFJsrwaS9SOXlzG760
	 Vulowvw3I+mGbCOs6Q/OmudJ46ZRipJTQ8KEnDmSsi8VZTTfKuH/KeeXAX429VmMw
	 b1iMwLWGOu7LKdw6sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([5.145.135.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7i8Y-1sNN0M0lwg-013BSB; Tue, 09
 Jul 2024 21:56:56 +0200
Date: Tue, 9 Jul 2024 21:56:55 +0200
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Eric Anholt <eric@anholt.net>, Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: Expose Raspberry Pi revision code in
 /proc/cpuinfo
Message-ID: <Zo2WB_2szbCLgxNN@probook>
References: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
 <b1cc367d-6782-4116-b3e7-3dd12e83032e@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b1cc367d-6782-4116-b3e7-3dd12e83032e@gmx.net>
X-Provags-ID: V03:K1:HzpoMj+s7p1IKHbvapYEwrDBxL/rnbhNOt+116rouKn47XEs0yo
 8eFyc7oKimyGRicJDYM44pFm22cf5XMalPjNMeSEvJTMf3AshQaQULxVhyCAVRe5V+g1dts
 hSrBc810lkQfc1Ii3cocFqhGQS0PZQR+4A9MappFR27Sm8LRlr5qJS0JDRD/rXDzFlHeUWa
 sNA8mImy8Rb0bCMwRDfXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vhGguK/+o90=;iWeMgc6cMgIrp8RBv+RDpYUhOAL
 xMjrm4wBWQSNkchJLWM8A62yLdMPGag4ylSfLt9PR2992H3Wporx7y6FKZ7I0ilFKw8YxktQq
 x9OWMI5XzTfxBWwrF+BPOH0/hKpONJ10+xSSc9MSv4263qUPT+q5n0kK3+nYkh196Y4/ZqTJb
 glfGgSCGHfTq+4EOy8YAtkACdhidwxM+C5x7bWul/g1gi5Ss64m5cW//tG5q0wYKPdtXyTUPG
 2NtUVkt1RHYD/pYg5+CYrI4kj5Uu7pVxW/txQUlQVPwiA2Rl+pXYRAj8oGkgvUoqEfHbRC25C
 mTCC1SybGQhTxxxq8detQ2hOFsQUereDp8XphRqXQQJbzzw3VBRb90/xrhXwoQg9qWMPIfAIA
 ZGqapXSOEhr8eROkbOa6Xm63kKxsBv3k0zJMfrrhaQ60spnh3FIaCRNuoLdA3zuFYlbavafCW
 EPVqN7khRrfjniZuL9yNhzKCuXqiAXoWhr/X6+pifB5JYfDS0zSeKlBOdKEhSbfEXwfAoVi0M
 lfHZZHWZK08i5s8CmvYSbZGSiVefs0i3pqtNMSH+z6n9hQ7gVrqyrsp+hfKxra0YIBRk28BXc
 ZZELWyNrxGP4ZMNEA41cLlhWprQ0qyMB7mowC0/ob8NYUw8TAhp28rKUmpAbPeq3PtlYyheq3
 Ao+qV3sUDDjFgYQ/NebnoGxeRxnKGE4VmT5xrA7qBV411vVhgslqmj29MpuLLl83xRbHMBhxl
 snrSUEPQpmvHakLhzdIgXBYt04yt48JwMkrXIAbL1fdGGhAusyhJiIqnrbY0e0G9NQyqen1kn
 M6vF87RmmrglNAWSwgtZYPKo4tkysacPnhIvFHXLj30ig=

On Mon, Jul 08, 2024 at 06:14:01PM +0200, Stefan Wahren wrote:
> Hi Jonathan,
>
> Am 08.07.24 um 01:08 schrieb Jonathan Neusch=C3=A4fer:
> > Raspberry Pi boards have a "revision code", documented here:
> >
> >    https://www.raspberrypi.com/documentation/computers/raspberry-pi.ht=
ml#new-style-revision-codes
> AFAIK these revision codes mostly refer to the board and not to the CPU.

True.

> The abuse of /proc/cpuinfo has been rejected in the past and from my
> understanding this applies also in this case.

Alright

> > This patch copies what the downstream kernel does and reads it from th=
e
> > devicetree property /system/linux,revision. This enables some software
> > to work as intended on mainline kernels:
> >
> >    https://github.com/hzeller/rpi-rgb-led-matrix/blob/a3eea997a9254b83=
ab2de97ae80d83588f696387/lib/gpio.cc#L247
> This is a bad example because the application doesn't really care about
> the kernel and directly access the hardware registers via /dev/mem. A
> proper application would use the dedicated userspace API (GPIO Character
> Device or PWM).

Right

> I would bet that the application does not work with the Raspberry Pi 5.

Probably, yeah.


Jonathan

