Return-Path: <linux-kernel+bounces-331815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCA97B182
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B211E1C2153A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE42C179967;
	Tue, 17 Sep 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H04SHWy0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Xo7XX0n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0517BA4;
	Tue, 17 Sep 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583783; cv=none; b=tWsQ/u8YNvTTV7g4Bpb6NkWL/QAiMyQ2Wri4qurD+6mc6z1WONZI0cM/D9fyaGk5yAlf2sqll932cQtAi4bPxUhajj/Fd4+1GSFwHVmaLkT3vjeDaDDKwUMat0aGUS0u6aJiVZ+WHm2ak8fq+1BV8KPPX5vartddaXkA8HlP8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583783; c=relaxed/simple;
	bh=eERQoFLLKS1jUFQ/esGCtA/zHSeXSjRjwERE5ZyicwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrO0AZ6ZGI33/M2xgVYPkuAWheQaak2nm+EfyftaCMwn7Bui1IGeYy9qChe4PpIX32C7BIeyZmfu15F22+2dcl4LEtafsplAIq++TLkz6KhabLiVjgrwyIboNBrwqXGFmxohFdPGrNLcTRUA+ni7yKAvYp/fFH/EIm8NtfCMf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H04SHWy0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Xo7XX0n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 16:36:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726583780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eERQoFLLKS1jUFQ/esGCtA/zHSeXSjRjwERE5ZyicwY=;
	b=H04SHWy0if3JwmyAIX5dHfOx7haa9PYtDcTksq5gknDhTTGaDmsVb/nzgdZJmFGWjqvIHE
	nc90KEFhe84wBbncaquEHrLgAHY5ikQAMCKY0hniT4bDZGHF1Vz1lRrLDlEj9d1FKp9nsd
	jqFshsskwGp/fp8j49TpwzfdXkTT/gdvDChb9XaSlb2nwfzWyyb6cheE0zXnNK3szXdGJM
	PQM7EiI+/HsMH4G7AnE7FD5xWAIC0k6S14WcoKUUtY+JeHbIJ73/hVeGkOp6Mc7LrFi5od
	/aHPvqWKXVJhrXPH0AvGIMbHtzbddy3QrGLihvGWPAfvdvlkNmQq6EX6+1eXcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726583780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eERQoFLLKS1jUFQ/esGCtA/zHSeXSjRjwERE5ZyicwY=;
	b=8Xo7XX0n9CV/lD5msiazedGWUo7Pgclqo3fGx9r8VGfkwZ0zMP1Ew0WlbNBVR4xoAhKJaL
	RiDen92OMherceAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>, Kees Cook <kees@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Richard Acayan <mailingradian@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
Message-ID: <20240917143618.jPgAwF3M@linutronix.de>
References: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>

On 2024-09-17 15:56:33 [+0200], Hubert Wi=C5=9Bniewski wrote:
> netif_rx() now disables bottom halves, which causes the USB gadget to be
> unable to receive frames if the interface is not brought up quickly enough
> after being created by the driver (a bug confirmed on AM3352 SoC).
>=20
> Replacing netif_rx() with __netif_rx() restores the old behavior and fixes
> the bug. This can be done since rx_callback() is called from the interrupt
> context.
>=20
> Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in a=
ny context.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

Now that I see v3, my v2 question stands.
This supposed only to disable BH if invoked from from non-interrupt.
hardirq and softirq should be good. A backtrace would be nice and further
explanation how this becomes a problem. Also lockdep should complain at
some point.

Sebastian

