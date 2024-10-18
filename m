Return-Path: <linux-kernel+bounces-371314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E797B9A3990
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F309B21EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708519049B;
	Fri, 18 Oct 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eCrTItxr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leR3RKOj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E2D190485
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242656; cv=none; b=hsG8+SQv0UHY5uHmWTRUXHlZjZ6QmLwV86CWrbtgjcPSfNFZ9oFhU8ALmXbIGPP5BJ5E7/eN1lXrdTl77xTQuRW2WBPtb/Wbk61dWgqyF8AN5SsXHvyCh2EvhsscWlvsrmqy0xNEPdh95/gEOQJ2T6RzUoOfyGev6eIJlHokvVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242656; c=relaxed/simple;
	bh=xGLqvXeDhAlpjhEz8LEj4dLAv8q7q4+ghpJOlZeIjL4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBJcpB51Y+3jHvRbl0GMK3vsYuhUK5qxXtD4cUZfDfgVUXCaD4g4SVafuAQUsqm3KlPuRY4Nb8BA4armWcgxnVaKeG4bjklk7FzpAGp0//Inxbmh2IJZpxZXszUH7GDhIaSj97KI1J/A56gUbFFhAduGvu8aIRsoFPJjNmy5YWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eCrTItxr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leR3RKOj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729242652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aqsq6sGsPM5+soqFYUsB3MWHzWE353HoEn3MXg37dko=;
	b=eCrTItxrCQwMlHEryxy82HaNAmV9fbvLi/Sjy6L9T7vz9ffCwzHk834u2blWFwrszZnJat
	GWxUJyk+Xq74EmB3wUUdIZcNlj9IVlipNUFGaf5wmfOtR8v8iReVxHIPJsIeIe3iM0RLtV
	3RDe6jc+lWsoPeiKiA30nJ7xofEbyCX92R8+w/YcS3+r889ibdV+CsfkUAfcWtY5dltXeX
	iQdX0NjlwqWYe/4XhGRTQEFTdZWQbRuhoMALCq9qMQ6fYWpxfanwd5dw+NEbRw18ENwwxY
	q9fj7qD81wacDOBjGU5wBmx2BQdeXaJfjk8wXhnAIPc7jazUZNx2epmDKpe+Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729242652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aqsq6sGsPM5+soqFYUsB3MWHzWE353HoEn3MXg37dko=;
	b=leR3RKOjANGyhxHqwOfU/HwRqrQmyqM1VWKJPNjykWg/4YciOO9KEQv7Nxvf5em4oqUmUD
	BQv8b7bFyJdH0CCg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, frederic@kernel.org,
 tglx@linutronix.de, richardcochran@gmail.com, kuba@kernel.org,
 ruanjinjie@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] posix-clock: Fix missing put_clock_desc()
In-Reply-To: <20241017133249.3496025-1-ruanjinjie@huawei.com>
References: <20241017133249.3496025-1-ruanjinjie@huawei.com>
Date: Fri, 18 Oct 2024 11:10:51 +0200
Message-ID: <8734ktai90.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> After get_clock_desc(), it should call put_clock_desc()
> if timespec64_valid_strict() check fails, put it ahead to avoid this.

Can you please rewrite the commit message so that it uses full sentences
and shortly explain the problem why get/put pair is required here? For
the subject I would propose to change it to: "posix-clock: Fix
unbalanced locking in pc_clock_settime()'.

The patch is no longer against next, as the change is already part of
linus tree.

The change itself looks good.

Thanks,

	Anna-Maria


