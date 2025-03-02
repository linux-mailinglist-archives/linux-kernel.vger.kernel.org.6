Return-Path: <linux-kernel+bounces-540591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26DA4B297
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E77B189042A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4EC1E5B6F;
	Sun,  2 Mar 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cekcKOiZ"
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328422D600
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740929011; cv=none; b=el6kwlgmrw8ulyJksXfciE8m1kjKKrDSoXymkNtgwY9PoUrUz1fbRyfoI8WxI8K4IML4dwxNP8MyNrZ75e/bjCnkRmcJzjvwOYDNnbEZDVksrrJ77i8NtVxP4dQGt7upER6PGx3lgnItQizE8mY1XXuLwqbUZq+9XSDiqyCxf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740929011; c=relaxed/simple;
	bh=tEv4/48JjEv3JWIfkpqi+0pjDBOd/eJ1dtGGC2UOQgY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V98azZQHPgvSZztPzSN1KvKlMqA0xBuAGw3D4oaf0QmrSInddGVpzZtcQrlmNd3TFoPphSrHTW/xMmtff+nwAU5bK6PbvABIc8H6+LH1koR2sHY37XwxKf8zL22//udBU6Hou6nb9QaRycg/ZgvFAKC06NSL/18syqr12Lz8UOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cekcKOiZ; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740929007; x=1741188207;
	bh=tEv4/48JjEv3JWIfkpqi+0pjDBOd/eJ1dtGGC2UOQgY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=cekcKOiZFnN0eQFPQVefT2fzEMjeSMuExRacNg/rjUKSISjUiH3BdhnAWfZN399Ck
	 WslfR46TO30cqK8O7dPHEHUJ27J8xhIf0HdYsm0rSHpuKpbqZJRyVEt5782PFxEsbM
	 P5pi90+hoKIjLsG4OkI7Wt+nx12bV9cUMlBh/NFG3HXvbtWZpZJ29eUVZoQbjwB6Gn
	 shnEMECyxJ2ODHv3+VxWZmhxgtH7CkQI9QmUTU3Wby9J5ewUoiSPQpr34L2KJnJ0Rr
	 n9RzI7pvxO1HpA2jB+NYiUmEjdkIZEshC0r+2D7cAU/2JyrvCZY/o4yNO1zZbvOL2N
	 C1Iq59OZ+8Zjw==
Date: Sun, 02 Mar 2025 15:23:20 +0000
To: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
From: phil995511 <phil995511@proton.me>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>
Subject: [GIT PULL] Generic entry for ARM
Message-ID: <0oXU8PP2CHCw1Qblhw1cKOTt90K2CLbHo4BLw9LOs-J1klN1Y_N7IagulWZHR7bGhmxyPXlZTOUEqVZDtwcXj9j93_BxdrdnmW7qk3uIrU4=@proton.me>
Feedback-ID: 128908939:user:proton
X-Pm-Message-ID: fd884b771593dbe59e5596e7e95d08bbfa8fd04f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It is a very bad idea to want to code the Linux kernel for ARM in C++ !!!

Our ARM CPUs on RPi and others are not powerful enough to use a Linux kerne=
l written in C++ and therefore lose performance, while these ARM CPUs are a=
lready extremely low-performance !!!

Suggesting to code like this is to be in favor of planned obsolescence, of =
the scrapping of thousands of small machines ;-(

Regards.

https://lore.kernel.org/lkml/CACRpkdZCiiMTwf7eGJJ9aCKFOC3_xTGv1JKQUijjyp+_+=
+cZ_A@mail.gmail.com/

Envoy=C3=A9 avec la messagerie s=C3=A9curis=C3=A9e Proton Mail.




