Return-Path: <linux-kernel+bounces-300369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C6495E2E0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FE41C20C51
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150B13CF86;
	Sun, 25 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ln/ntWGA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZeKhGV3O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6C2207A
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724578824; cv=none; b=fkJmUYEc5C3lAKJSPIYSDOn2PZ6owMXaxou2qZpvPfQzbjKaluVx2s+aMlKUtVEqwtP8EVlSMh/e0Hr8IaASlhFIicKnidgIooFjoYPUrQNqfk8T3xXK9YNQqlueUxLRYgInWz8iutKwOIQ5KGJdBW4wQfHk2hA3nSWIX4nnd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724578824; c=relaxed/simple;
	bh=Y6lOVFeGkZEIul1ReUgf0vf760b/SZtjUkjqrPFWgkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrHbqHkffxOaplke7Q6Aji5RsXnKUCZNnZuoWQ86/mLIbMEr2kwBCHxloEDECQYcLkTvUkLI20YUHK1Q8b+OKej5Qp+KZNXr2jxawMyrQI8Rik74wTOl9r8AnKLqudTv32c2g6KMkLYHP6XP6VzkG5GzcFGT4G66jeGZzL3aIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ln/ntWGA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZeKhGV3O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 11:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724578821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuwXP+rnomcsRu2oRLSiPatAHOqbx2HejldrdgYTASg=;
	b=ln/ntWGA+giDjya2mW6mxYjy78rWFPWGa8NJjF4BKz/OuS5rp55HVQJjGdobjM6Ohtbduz
	Enul8mSDlMYm1Rv56q2cQHPNoIxJZApQHlI8UCJuk8Khg1lxMz6F8JSfHanW7M4tZlyhj6
	YtuFFI0kJkPr7viwc5fFf6ieKJtIAmvHVEYcFDxpYUO59cVeYIiXLPPp0ArZ6GlykC9gzW
	9kGCHLvu9mjYzs3MqQoJuUbvtex5vhGZB345gbDHPX0lHfKZs+wwVDRJN9Nzvf9C2V7c2f
	vsoJ8BNR03uNXP2RqMK/LmeDyr0som1YpfZC2BkjnYSpcrJ1W0iwLIg773eiPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724578821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuwXP+rnomcsRu2oRLSiPatAHOqbx2HejldrdgYTASg=;
	b=ZeKhGV3Ot0XCzxlAFI8ngO5Ui8JKSi2snzw6FjQ9JHHLxguB4aA0l2Ld50eKFk1+2m+Njw
	5csVtdnj9m+ygUBA==
From: Nam Cao <namcao@linutronix.de>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Change slot number type from int to
 u32
Message-ID: <20240825094018.bm5yDW4g@linutronix.de>
References: <20240825072955.120884-1-riyandhiman14@gmail.com>
 <20240825075017.WNpBd0l7@linutronix.de>
 <CAAjz0QbOVn-M2uDnWVsh1AJjdN5d-AYsMkx3DjgaXVmS+SzARA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0QbOVn-M2uDnWVsh1AJjdN5d-AYsMkx3DjgaXVmS+SzARA@mail.gmail.com>

On Sun, Aug 25, 2024 at 02:20:34PM +0530, Riyan Dhiman wrote:
> > Are you sure none of the changed functions ever return a negative error
> > code?
> 
> Yes, I have checked all the functions and variables for it.
> the slot function is defined like this

What about vme_slot_num()? It may return -EINVAL, right?

> static u32 tsi148_slot_get(struct vme_bridge *tsi148_bridge)
> {
> u32 slot = 0;
> struct tsi148_driver *bridge;
> 
> bridge = tsi148_bridge->driver_priv;
> 
> if (!geoid) {
> slot = ioread32be(bridge->base + TSI148_LCSR_VSTAT);
> slot = slot & TSI148_LCSR_VSTAT_GA_M;
> } else {
> slot = geoid;
> }
> 
> return slot;
> }
> 
> Here, slot is defined as u32, and the value read from ioread32be is also
> u32.
> In the else case, it is assigned to geoid, which is an int global variable.
> This global variable is a module parameter defined as follows:
> 
> MODULE_PARM_DESC(geoid, "Override geographical addressing");
> module_param(geoid, int, 0);
> 
> which I assume will always be non-negative.

If this should always be non-negative, then perhaps we should prevent users
from specifying negatives values. But that's a separate issue.

Best regards,
Nam

