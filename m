Return-Path: <linux-kernel+bounces-351311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3667990F95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F0D1F24330
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C11DDC25;
	Fri,  4 Oct 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nhue05u0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3FoS7s7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981FD1ADFE1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069141; cv=none; b=fXVWjMA+xhdsDqYjLU2u7JAXhuLQPCYtrnh+KUnr/jTccVJna/c4SDdKg4l/Q1ttlye/GnhwV/6chxTgaOAnYZ3FRZjrjI8sg78w/Am1irS5A4QwKHExAZiaZEApiLFSfPH9XF0pGufUlbSJ0VVtcKhq/vxkH+3zpT2DBa4xkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069141; c=relaxed/simple;
	bh=XJc5X3csANwu18UoM4cWEuAJVAJaP0gAXl/QiK2YXi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvCR60yPoWfOIm+bvt9YlfChtAkpPbvHqZSQbrxWhItrSw1Na2s9q86fTK5HHB5JHXZGJl/WqZCGUwj1P1HtulYx4LP7/v8LWTsLU2nGoZrxm5jx/xD7SjrUOom+tWLP9yCeCaCWC8qVk99LvkBZVg0pm9T91HVHJdX+thsALrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nhue05u0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3FoS7s7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 4 Oct 2024 21:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728069135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AeF0ZofiX5pl4vuZpB1WuoW4qG1+FzaxAU1/cHHP30=;
	b=Nhue05u01U/zZCZIlxKCOkfD4O/BLxG5TTEnJw8DqMjnL13o5N3VKr2EhaDJQCNI+hKaVb
	jOxyVzZgumSrwnHTx2GxNetFa36zqE+aE3iuAmZbYtrxtofC7B3mdsEtfP/9d/JpMsHOO6
	5KaphMGuv/JOqT8OHKgI80grB/PQQao7ljb6Z2TdcP7bNAoiHmSJEQSgnDHrY8zO5V34tN
	Ftj7PNCBBFs83f4v+ROuDyXMZlbOC8boMelFWk0/WWTbDiyQlYERNvLNNz/LJV0FGqGx5n
	pt4xeH6pel/knRw3E+WBuOAgPhT5fzDNKKkA/7kdtxUeUWcSZOGQ3vRUf9Q7KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728069135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AeF0ZofiX5pl4vuZpB1WuoW4qG1+FzaxAU1/cHHP30=;
	b=F3FoS7s7vcmWEL8t467rHR7Hhl1T+dLLZzNWb1+yRtuCuylQiqly+KBV6ozKSGp3xCqRbg
	ORMXfQtqclOrboDw==
From: Nam Cao <namcao@linutronix.de>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Linux-MM <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM_BUG_ON_PAGE(PageAnonNotKsm(page)) defconfig riscv64
Message-ID: <20241004190952.AMYdQn7P@linutronix.de>
References: <CANiq72k-wbyR=FeBVBPMqqF6Re9eO4LtdHYqvMQgXSe3cHQsGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72k-wbyR=FeBVBPMqqF6Re9eO4LtdHYqvMQgXSe3cHQsGg@mail.gmail.com>

On Fri, Oct 04, 2024 at 03:09:22PM +0200, Miguel Ojeda wrote:
> Hi Matthew,
> 
> I noticed riscv64 defconfig seems to reproducibly hit
> `VM_BUG_ON_PAGE(PageAnonNotKsm(page))` in today's next-20241004 --
> please see below.
> 
> I hope that helps!

I can also reproduce this on arm64 with CONFIG_DEBUG_VM_PGFLAGS=y.

Looks like an invert logic bug from:
https://lore.kernel.org/linux-mm/20241002152533.1350629-5-willy@infradead.org/

I made the below changes and the problem goes away.

Best regards,
Nam

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fe9abdf26ab0..ccf3c78faefc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1131,14 +1131,14 @@ static __always_inline int PageAnonExclusive(const struct page *page)
 
 static __always_inline void SetPageAnonExclusive(struct page *page)
 {
-	VM_BUG_ON_PGFLAGS(PageAnonNotKsm(page), page);
+	VM_BUG_ON_PGFLAGS(!PageAnonNotKsm(page), page);
 	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
 	set_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
 }
 
 static __always_inline void ClearPageAnonExclusive(struct page *page)
 {
-	VM_BUG_ON_PGFLAGS(PageAnonNotKsm(page), page);
+	VM_BUG_ON_PGFLAGS(!PageAnonNotKsm(page), page);
 	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
 	clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
 }

