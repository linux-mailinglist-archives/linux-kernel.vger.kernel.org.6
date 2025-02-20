Return-Path: <linux-kernel+bounces-523824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A3FA3DBC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2477A9CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC761FA167;
	Thu, 20 Feb 2025 13:53:31 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EEE35942;
	Thu, 20 Feb 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059611; cv=none; b=dvmDqeL5252kdo4jChxoVuoIQTBJP3bV8NbUmnvhYsKU3ICMdjQqHRCxiIu8aQaqIb56RUGoT/CsxQZNtLAAbXdvlvWuVoxIlesXDm/4khUXN3XL/IW06Rdl4PIibrZCbcfz4ttY0QjZK6malvpsSD1KlUU/JGSkGCaaVx/fDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059611; c=relaxed/simple;
	bh=YTrfqrXQzae09PdK/UYmPBhj3Ws6othGssExcxPJGyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyjSsV5rTvAIbLiU7av9v1NJeWqX6NlDJlhbRjOOahPQyo9oVJMpwIkWs9BwQh9t86u3vqntyu+Kk1dr5gOwFOu4gsd4ou10z5JTWqMkWo69zGK9eXCl9GtatjiQYGTB7Zy7I0sJ3DKUpu2qOPoMMLs3/E65luke8foRRoxMc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51KDrCqC031662;
	Thu, 20 Feb 2025 14:53:12 +0100
Date: Thu, 20 Feb 2025 14:53:12 +0100
From: Willy Tarreau <w@1wt.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <kees@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250220135312.GC31486@1wt.eu>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
 <f77d549c-b776-4182-b170-571d1e5bb288@p183>
 <2025022007-angelfish-smite-a69d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022007-angelfish-smite-a69d@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 20, 2025 at 07:53:28AM +0100, Greg KH wrote:
> the proposal from Google about
> Carbon, a way to evolve a C++ codebase into something else that is
> maintainable and better overall.  I recommend reading at least the
> introduction here:
> 	https://docs.carbon-lang.dev/
> for details, and there are many other summaries like this one that go
> into more:
> 	https://herecomesthemoon.net/2025/02/carbon-is-not-a-language/

Interesting contents there, thanks for sharing!

Willy

