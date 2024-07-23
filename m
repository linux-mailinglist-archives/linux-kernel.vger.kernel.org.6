Return-Path: <linux-kernel+bounces-259713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0746939BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54919B2172B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACA14B08A;
	Tue, 23 Jul 2024 07:46:58 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE83D6A;
	Tue, 23 Jul 2024 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720818; cv=none; b=l4heD9RVFnA+EFrz2gX1W/OgudsmIlqG8ypVqS1/I02/Y+LTtBJc6mPZzr80fWrCCR+9b2grmTUiwWeTIu1RXibbpPpjRLqgkh1BegrDBmxDIlFFrP7/cLGP+oZQZSyCy9cmJuEp/HC63TNoG0HvmEb2l8K6Orhjt9Wkr3eezK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720818; c=relaxed/simple;
	bh=V2aTDtK4v9AmRRjzT/jpFIhjpbT//RrJRDBhw3CTBgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNQZ1/zNIon+2907Ek+YSBu9jutWqr3ou1GhGphV4pqNDBl43p2K8QNKxqImFoRiKmeBJanVcPATjdGbQXQ8xvpV4qiRNfnp/2uMUOUjfC/0yPCZWgRvtCr1Q6LD/1FM7Qz6srXtvf+OcdEkZVjvUhLkUundJTIRMMFr4MQezjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sWAEE-0003KC-00; Tue, 23 Jul 2024 09:46:34 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 8A1E9C0814; Tue, 23 Jul 2024 09:32:18 +0200 (CEST)
Date: Tue, 23 Jul 2024 09:32:18 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Loongson64: Switch to SYNC_R4K
Message-ID: <Zp9cgqukMx/iWT9z@alpha.franken.de>
References: <20240714-loongson64-cevt-r4k-v1-1-98afed7260aa@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714-loongson64-cevt-r4k-v1-1-98afed7260aa@flygoat.com>

On Sun, Jul 14, 2024 at 10:41:05AM +0800, Jiaxun Yang wrote:
> Nowadays SYNC_R4K is performing better than Loongson64's
> custom sync mechanism.
> 
> Switch to SYNC_R4K to improve performance and reduce code
> duplication.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Last minute for 6.11 :-)
> ---
>  arch/mips/Kconfig           |  1 +
>  arch/mips/include/asm/smp.h |  1 -
>  arch/mips/loongson64/smp.c  | 35 ++---------------------------------
>  3 files changed, 3 insertions(+), 34 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

