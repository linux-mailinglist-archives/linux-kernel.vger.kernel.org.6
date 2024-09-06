Return-Path: <linux-kernel+bounces-319119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1E696F7F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D6E1F26093
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF21D278F;
	Fri,  6 Sep 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PsmzuHSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c8xPMN/F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E981D0490
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635614; cv=none; b=cCzMVmmfPp4t3JXFmJ5FfzLFpzEH2aRrnriKlFSE6CkC7EBC+OylM7rA96+o7zLnKVQEQW79DoGTMirv/0D5ysKGgg5NoSspEG3FbcQz3maOirpHgcc8EHzNp/kDKrpPNTfKeiI4e4Tfi81gBXrroBE+IcY2NT1VqblNWF8QN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635614; c=relaxed/simple;
	bh=BNfZOF8I49vHYAO7rniG7tM//ryETnvzdGsiSGDf1NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUjISmMY4BKzfCw8+faILBdRiZ1ZiyUquzM/OSOtP6nhhcWw4DPI7EUF+wfGc3IZLgdi8gE7Hg36PhEy0xOP4SnXsp/H8iPvSkNKvGUE76WEgoVmHOHvpYdOHBB1EFautrqEFuWD44hbJZIKCeQb+C4c1GAtQoSIEp/2Vn2rxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PsmzuHSP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c8xPMN/F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 6 Sep 2024 17:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725635609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D0LcQBjxhJJ1AT5w4YUeZZjy397PwHo7bQDfurXH4c=;
	b=PsmzuHSPPsXBekPPcoob60zTYBqoqXnp6kmaOnMKt4TwqcREqNE6+mpTA+r4u/cXnlHA5E
	oZgW6zAkKY1prDkhkmJ6hWmNwsk8pDem1qIsE1ibbOMHE5Q5GReB0qxaIVpwxnF1DsUJOD
	0hZYo6rMa0C6VzAwYoyQq+m9I24+bjPOYylpbnK7wJ256+IUS1kzOZUnJ4qEa6Vurpczo5
	OeIpl7tggkVXKV1kHGoYQ+xBv9yxCIZYNr2RhanugHWT33r2GV2dtKKUz9n9+w+skZixBi
	hT6XpUyX96yDzN6kereU1WQkJ0kj2Y9c82/lEptC1d/gkWkw5kAh3SOVURdwTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725635609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D0LcQBjxhJJ1AT5w4YUeZZjy397PwHo7bQDfurXH4c=;
	b=c8xPMN/Fu00bImPX7/GwPpKS8scd2dkJ8KjZbFkePnrWay14CKKulnP8Gz7AvDVmKT5ual
	zWEjfEHm5bHAIECQ==
From: Nam Cao <namcao@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Clark Williams <williams@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
Message-ID: <20240906151324.tVwX6lFy@linutronix.de>
References: <20240906111841.562402-1-bigeasy@linutronix.de>
 <20240906111841.562402-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906111841.562402-4-bigeasy@linutronix.de>

On Fri, Sep 06, 2024 at 12:59:06PM +0200, Sebastian Andrzej Siewior wrote:
> It is really time.
> 
> riscv has all the required architecture related changes, that have been
> identified over time, in order to enable PREEMPT_RT. With the recent
> printk changes, the last known road block has been addressed.
> 
> Allow to enable PREEMPT_RT on riscv.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

With the printk patches applied:

Tested-by: Nam Cao <namcao@linutronix.de> # Visionfive 2

Best regards,
Nam

