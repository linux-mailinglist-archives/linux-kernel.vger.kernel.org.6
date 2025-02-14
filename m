Return-Path: <linux-kernel+bounces-514165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65888A35375
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741C23AC039
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA3F275407;
	Fri, 14 Feb 2025 01:03:35 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9C3A8C1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495015; cv=none; b=ecKvCEkJ5Hagu5EnECSdGO15mtX37AqXnNz7GCn0EJwfmAFVaPpPIGKNbwaHKFxhcLbBGr+SVDLYY69V1HAz2aPKOiAsKk+jHPezvuDGZYjtQtP2oSPhxnkt5qqIcfG4nPGQW03NxKonUKWLwgzIiPV+klOK45IiANW1ST6ZsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495015; c=relaxed/simple;
	bh=epixnDeIsibTYaU/K3pXMNxKkDCO7YvHbG/JpNPMj2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw/s4e2J3IWq4zeLbzAMh/Y2OnIMPDpd8VDCJC/RuwD6hIDuf3b3NCxIUauVeTGyu0aSjkmBKDS0VdoigQKv8i25WAHuFE+YlLWAct2HYcpan+SIOP+px8PES87HAAtYpVuX2CoS8FwBLoeJ3qY+tPtr0+pLa1AkD3Uhzz7E2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 1826C72C99C;
	Fri, 14 Feb 2025 04:03:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 054817CCB3A; Fri, 14 Feb 2025 03:03:25 +0200 (IST)
Date: Fri, 14 Feb 2025 03:03:25 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/31] ARM: Switch to generic entry
Message-ID: <20250214010325.GA12626@strace.io>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>

On Wed, Feb 12, 2025 at 12:22:54PM +0100, Linus Walleij wrote:
[...]
> - Tested some ptrace/strace obviously, such as issuing
>   several instances of "ptrace find /" and let this scroll
>   by in the terminal over some 10 minutes or so.

Could you also run the strace test suite, please?  Given that it used to
catch quite a few regressions in the past, it could be useful in this case
as well.


-- 
ldv

