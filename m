Return-Path: <linux-kernel+bounces-240311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3448926BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AF51F22758
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D0191F69;
	Wed,  3 Jul 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FrIvN3X8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FD13C3EE;
	Wed,  3 Jul 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046131; cv=none; b=XS9pM9rkYc7dRfVfMQkij2hBXJT9rjNrZqOk0cE1uD3n0+D9Qbg9wzRENE5cTXY1GjuV0Y7x6mU47Jj8nEs8FuV/pcZjC5ja6tbIobdv79Vfk6/ivJMZOs55CRtudory0UjLiFt2gMQ3T1RPXvNPNamTudbDs1VOtVkq5uY5/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046131; c=relaxed/simple;
	bh=EZOgZKlULUJHBi14XPIFf35LD2LoPkdOopF8BGLtTYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUjVf1MN2M1jq/VrpSyCtAadCesfLuztnLtUFOt088B6sD0KP6iG9NJb+aWPMQJQHFFR1G+Zd70bX6JFFN4QWInHoODdatld5pP+HWmeZXB59RvmZnQZyDsJonKMTyiSw4TVsWW2bkNE6+ptI95B3OSvmXNLq25I4VIMOJ4DsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FrIvN3X8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8E29C4189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720046129; bh=MhChzzvgjO8GPkUYQDu0xVCJVkL3BK5qrTSeUbHMLCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FrIvN3X8RJAAsHudC/Ma1tjGMsngEzkgVn+56YgUIh2/FORBc7rl7Piyeedt6C4yR
	 EL0YlfUDRefTgCGeKPTN0X+qWBETMmh5a9Mxj0KautpWjs/e3JYYlkjXDAGXnX0BqZ
	 Cv8RF1y4phtgiOudXlacO+dkUM1aCrFhvTrnGRigzW7elgL5PZuNwyw8qtjB9t7TC4
	 7eztOpciqG24cTSxlOVvl91wI3qTkKl6fBpyRSKQQe6J+qPSYumrlsif858Va38M4B
	 /DTc2aj5BXNbeP/cL6+xL0I7YNvhiX9js+eyKFAX4mixr1FBn2VRafXqxl9JH3nn+9
	 F66Bt3TkNdgWg==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8E29C4189E;
	Wed,  3 Jul 2024 22:35:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: bilbao@vt.edu, jembid@ucm.es, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH] docs/sp_SP: Add translation of
 process/maintainer-kvm-x86.rst
In-Reply-To: <20240626221942.2780668-1-carlos.bilbao.osdev@gmail.com>
References: <20240626221942.2780668-1-carlos.bilbao.osdev@gmail.com>
Date: Wed, 03 Jul 2024 16:35:28 -0600
Message-ID: <87bk3et87j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> Translate Documentation/process/maintainer-kvm-x86.rst into Spanish.
>
> Co-developed-by: Juan Embid <jembid@ucm.es>
> Signed-off-by: Juan Embid <jembid@ucm.es>
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  .../translations/sp_SP/process/index.rst      |   1 +
>  .../sp_SP/process/maintainer-kvm-x86.rst      | 466 ++++++++++++++++++
>  2 files changed, 467 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/maintainer-k=
vm-x86.rst

I've applied this, but it generated two warnings.  One on application:

  .git/rebase-apply/patch:487: new blank line at EOF.

and one during the build:

  Documentation/translations/sp_SP/process/maintainer-kvm-x86.rst:3: WARNIN=
G: undefined label: 'documentation/process/maintainer-kvm-x86.rst'

I fixed both of these (see patch below) but would really rather not have
to clean up things like this.

Thanks,

jon

diff --git a/Documentation/translations/sp_SP/process/maintainer-kvm-x86.rs=
t b/Documentation/translations/sp_SP/process/maintainer-kvm-x86.rst
index 127238f44ea9..053b6a06db01 100644
--- a/Documentation/translations/sp_SP/process/maintainer-kvm-x86.rst
+++ b/Documentation/translations/sp_SP/process/maintainer-kvm-x86.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-sp.rst
=20
-:Original: :ref:`Documentation/process/maintainer-kvm-x86.rst`
+:Original: Documentation/process/maintainer-kvm-x86.rst
 :Translator: Juan Embid <jembid@ucm.es>
=20
 KVM x86
@@ -463,4 +463,3 @@ host (kernel o espacio de usuario), o que pueden ser ex=
plotados por una VM
 anidada a *su* host (L2 atacando a L1), son de particular inter=C3=A9s par=
a KVM.
 Por favor, siga el protocolo para :ref:`securitybugs` si sospecha que un
 fallo puede provocar una filtraci=C3=B3n de datos, etc.
-

