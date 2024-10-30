Return-Path: <linux-kernel+bounces-388667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3429B62C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8536B241FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431A61E7C0C;
	Wed, 30 Oct 2024 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOyBYSLg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="92LZUgWS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED61E4928
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290543; cv=none; b=UGdVD8Aow2bq/e3EPEnn4B8RTaX4jEiU3kbk0RgOR1syBVQgzpvjAXuHUqGPI1sRTCoFMBwUQDXsSJrHT1PHp+cHqAc54gP/HxO+444eXdPag2k6dc9iKXJon5suUgEBUaV3K9M5iKrZVe2xeFgkUfwv4zjjBcLSHDHCrUQ9qQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290543; c=relaxed/simple;
	bh=T+B/ZaMD5FsUy3FtRIiqS+1Ki8qeR0PL+NMNNh6EHSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKmMDIjLi2RLaJXG7agoe9yzCkBMzXZ5l/vYfdPNFctTtixr2lHi+fCrJ+7cSNu6iBOcVRZ9S0nNYw7YW40wF3Y85HvwhYvoUzYJjf+of8G2w/CopVnsiQAhpl4xKCNni7AYS827FCEHJeoFLdOvPQVPm7DwpnNZmYmqjpn2WOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOyBYSLg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=92LZUgWS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 13:15:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730290539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPG2br2Sq4Y836MTVVhKgsi4hka1K43VnQrzOI2sxVk=;
	b=UOyBYSLg2gmrTyFQA49OLegbYa0hiAkb9IBOT7b0YM3Y3iPw66Gj1kWOczULdwt2jZdRja
	WxFM/+m/gZ3vHDKIGgi/fVYkfre7QG/Am8+6VL9/zZLEesZE9Wd1Ejnv0Pk/kpPn4x4WVi
	/TRwZeqwpOTs+yu/wSaBo/My3wu0qmZggYAFUZgrPL+pJYMn8eRC6IQHKZUVQgvFJkUYbh
	LesrpjB0CV+y1sgH+E13aFJsZz81DMfgRftirV4nhQmOcVcX2qLupCz0Mj2btRyet8wksr
	/weWwb/TT9ZLCSAUp4Zs9K+Q4mlfuKDmPrhRIDv9vHjMS87KIadhDaFrEhbX2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730290539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPG2br2Sq4Y836MTVVhKgsi4hka1K43VnQrzOI2sxVk=;
	b=92LZUgWSu3QPugH4D7yuSgqbTr92RRq/nD4L0Z1SHzZGVKU/vV/wsH8kqATj+5Mw0QNEOv
	3M8AwkZJSfJeO3Dg==
From: Nam Cao <namcao@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 05/21] can: bcm: Don't initialized an unused hrtimer
Message-ID: <20241030121533.ioTNvYpX@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
 <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
 <203a1560-76c9-4c47-b1b8-b44ddf40cd16@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203a1560-76c9-4c47-b1b8-b44ddf40cd16@hartkopp.net>

On Wed, Oct 30, 2024 at 11:49:49AM +0100, Oliver Hartkopp wrote:
> On 28.10.24 08:29, Nam Cao wrote:
> > The hrtimer "thrtimer" is not used for TX. But this timer is initialized
> > regardless.
> > 
> > Remove the hrtimer_init() for the unused hrtimer and change bcm_remove_op()
> > to make sure hrtimer_cancel() is not called with the uninitialized hrtimer.
> 
> NAK.
> 
> There are several other occurrences of thrtimer that are not covered by
> RX/TX distinction, where the second timer is canceled.
> 
> This one-time init and cancel of an unused hrtimer costs nearly nothing and
> is not even in any hot path.
> 
> So this incomplete patch only adds complexity and potential error cases in
> some 20 y/o code for nothing.

The "real" motivation is preparing to use hrtimer_setup() instead of
hrtimer_init() [1] and deleting hrtimer_init() [2]. The new function
mandates a callback function, and since the TX thrtimer doesn't have a
callback function, hrtimer_setup() cannot be used.

Your concerns are also valid. So I can drop this patch, and use a dummy
function to make hrtimer_setup() happy, like how it's done for the rt2x00
driver [3]. It will make the driver a bit ugly, but it's obvious that it
won't cause any regression.

Best regards,
Nam

[1] https://lore.kernel.org/lkml/e4ce3a3a28625d54ef93e47bfb02f7ffb741758a.1729865232.git.namcao@linutronix.de/
[2] https://lore.kernel.org/lkml/7bde2762d82d30dab184c7a747e76afc41208da0.1729865740.git.namcao@linutronix.de/
[3] https://lore.kernel.org/lkml/49f2bce487f56eb2a3ff572ea6d7de0a43560c0f.1729865232.git.namcao@linutronix.de/

