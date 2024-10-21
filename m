Return-Path: <linux-kernel+bounces-374250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EF9A6775
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5F1F2295D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9861E9072;
	Mon, 21 Oct 2024 12:02:43 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186E1E907B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512163; cv=none; b=he9Vw1zYTW9gCz8rCpVg2KpG7H1FFpaV8G1House6n22CZj5dbuQQQBkmCW29GRUwww02vj83cSlzMT5kLEBztDCuI7mWEhKITdH1DQuxaTnY4Axn4UdCetuIPOQJpMs9bsuVjZvb6h4k5RQbj9FXOTc9c25OYV9NLAOO2K/26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512163; c=relaxed/simple;
	bh=XB/ma5czQuICzNFrraRxoB0KoIC4DnukcfKzkvlvMMU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zx8ybpb9suYcstgd//75ALThMRaOxqZ1rW9p2GYrdnEqdlAhd1U7G1vKYU71ICTT7kW7Gb8LYvE4DAP637ECueIeTe/68fidtXlHYMGMZzgXAKwrE1hxJ1NaR8AT0iO/TsZ5UtHqF+sbQJzOPXxYrJjTxn01USBWJToaDxjTrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a141:3544:6743:cb10])
	by andre.telenet-ops.be with cmsmtp
	id T02X2D00A5HsszL0102XVT; Mon, 21 Oct 2024 14:02:31 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t2r7H-004FNQ-Ob;
	Mon, 21 Oct 2024 14:02:31 +0200
Date: Mon, 21 Oct 2024 14:02:31 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various compliance
 requirements.
In-Reply-To: <2024101835-tiptop-blip-09ed@gregkh>
Message-ID: <6c773870-6eb7-394b-8be-7a414c99b5f1@linux-m68k.org>
References: <2024101835-tiptop-blip-09ed@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Greg,

Thanks for your patch, which is now commit 6e90b675cf942e50
("MAINTAINERS: Remove some entries due to various compliance
requirements.") in v6.12-rc4.

On Fri, 18 Oct 2024, Greg Kroah-Hartman wrote:
> Remove some entries due to various compliance requirements. They can come
> back in the future if sufficient documentation is provided.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[...]

> @@ -888,7 +882,6 @@ F:	drivers/staging/media/sunxi/cedrus/
>
> ALPHA PORT
> M:	Richard Henderson <richard.henderson@linaro.org>
> -M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> M:	Matt Turner <mattst88@gmail.com>
> L:	linux-alpha@vger.kernel.org
> S:	Odd Fixes
> @@ -2263,12 +2256,6 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:	Maintained
> F:	arch/arm/mach-ep93xx/ts72xx.c
>
> -ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
> -M:	Alexander Shiyan <shc_work@mail.ru>
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Odd Fixes
> -N:	clps711x
> -

This also removes the mailing list entry, causing submitters of future
patches to forget CCing the mailing list.

Why not just drop the cancelled M:-entry instead, like you did above?

The same is true for several other sections.
I have sent a fix for the sections related to Renesas drivers[1].

> ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
> M:	Hartley Sweeten <hsweeten@visionengravers.com>
> M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>

[1] "[PATCH/RFC] MAINTAINERS: Re-add cancelled Renesas driver sections"
     https://lore.kernel.org/all/0a189e2c4090a1b308e18005d2552e335bac354f.1729511337.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

