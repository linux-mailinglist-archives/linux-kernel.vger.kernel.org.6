Return-Path: <linux-kernel+bounces-574812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2487AA6EA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA116167ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036920E6F7;
	Tue, 25 Mar 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G88fFkTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFE19F127
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887332; cv=none; b=EwNHjAjY+zvI3c0NbnkkFfpE9ESCLoxyqDSNN1a+2zRQKkvLLzrM2vhlrRlfK1EzJWZ7AyalgPw3x1a0bFYHMZYwmRHrJPnm8L6aZtkHefQ/NqokBzNe0VmrSz6YIri/f7fjKrMwXn/eqR3dLlZkjfEU11QYUzkkxvGowdmrUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887332; c=relaxed/simple;
	bh=hTw7ODPmVvCLjzzaNK33EaWl8zTW6KipSZhrFdJa/FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIQpeS3Zdcn0TYo45Y1mav5ZZe+CBQ8zVNEJLh1JzEJ/DTEMoFA2Y+9Pp8/k3lw9eIqscbLaEXG73VkV28vV96bU42EEcfdjKefASILczs1PEksAexQxArvPD8KVHW5+PINhTd9HgBw48uqYGgvS2SBF2IqbjOWQZbd776BwgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G88fFkTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B095C4CEE8;
	Tue, 25 Mar 2025 07:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742887331;
	bh=hTw7ODPmVvCLjzzaNK33EaWl8zTW6KipSZhrFdJa/FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G88fFkTJLN1ReX/V1hlj0C5wdQVGTbPpwlhRVAbqv9gy7yP6NTTV7ABj0pzckhdpn
	 xsHfm0mi013gKj0HtbSpD3iYedr2t3Rj1Fn+zJVSs9wjLxZYyBILhWdqG35kxKHVFx
	 nazICSxVCXbSBVJMvHNvvKfkljei1Zo7NpYYbKPWvChGT2wHh0RL8PgcASALqCOIbw
	 zg/t8TcdsGcnLx/AHesCVCGvtfUGUIDPJjVe7wfXNMf5PRSyIk6MQrh2Zu06CVQ2pv
	 PZ1hfc9hVjoc1OJzYu8biIIfEmZ/mT6UXuv8bMZs6udayEAGfcZL2eIy0qDy8cCOx3
	 PJgVdHKfhjfdw==
Date: Tue, 25 Mar 2025 08:22:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, David Heideberg <david@ixit.cz>
Subject: Re: [PATCH] x86/Kconfig: fix lists in X86_EXTENDED_PLATFORM help text
Message-ID: <Z-JZnueg7EvMFJqK@gmail.com>
References: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
 <20250322175052.43611-1-mat.jonczyk@o2.pl>
 <Z998eR-9QNL1R-71@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z998eR-9QNL1R-71@surfacebook.localdomain>


* Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Sat, Mar 22, 2025 at 06:50:52PM +0100, Mateusz Jończyk kirjoitti:
> > Support for STA2X11-based systems was removed in February in
> > commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support")
> > 
> > Intel MID for 32-bit platforms was removed from this list also in
> 
> Was it? It's rather hidden and not recommended as far as I understand.

Well, with the '32-bit' qualifier the statement is true, isn't it?

ca5955dd5f08 removed a MID reference from the 32-bit list and added a 
different one to the 64-bit list:

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -549,12 +549,12 @@ config X86_EXTENDED_PLATFORM
                RDC R-321x SoC
                SGI 320/540 (Visual Workstation)
                STA2X11-based (e.g. Northville)
-               Moorestown MID devices
 
          64-bit platforms (CONFIG_64BIT=y):
                Numascale NumaChip
                ScaleMP vSMP
                SGI Ultraviolet
+               Merrifield/Moorefield MID devices
 
          If you have one of these systems, or if you want to build a
          generic distribution kernel, say Y here - otherwise say N.

Thanks,

	Ingo

