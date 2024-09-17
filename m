Return-Path: <linux-kernel+bounces-331808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1562D97B176
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF482824BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015BE174EEB;
	Tue, 17 Sep 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jivuHYw7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KK/5QAj6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4429182;
	Tue, 17 Sep 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583621; cv=none; b=Iz0v23/7XelkhZqeIzqHe1fqSW+cMqVGlLNQJnyHPrhjIbEVINGnAmAXkSkJGgRlyDhijBs3kzLZ8uyeUQ0V2H8qe/24x0EbT68WpDuqaaOvNrfrlfsiWtlASsGwCmecVzB9Xe9sN9mbr0U/zreG9gzq7jn5Mhi6rjgHnhR4jOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583621; c=relaxed/simple;
	bh=oGzlw87oPqHFdR25vE+og8sUGLP1VRSzbkYsHeyM9a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVKp8FMGLBkjlS/Ga35NF+nUUjPPJBHQiNxhDUiGNYNdFgMPTXyLEZw6QDREiAKPAHsBnRFYKqK3blQOPcNX/cm8y5KAcqoKvnxqtmizidK8grH8dH3sbRkGmRQYcXYzHCPVZwqSmjaDgq3guznLwqOdggsIQnnFggj8wvjlBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jivuHYw7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KK/5QAj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 16:33:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726583616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGzlw87oPqHFdR25vE+og8sUGLP1VRSzbkYsHeyM9a4=;
	b=jivuHYw7h74bdlH3bkN59aqjIQS03u2kThH0T9unTy407uw9sNggcRsD43ecBsb8wlVmLO
	rONgW40RMhaz5kcbBVMps/reHJTew3FSMGc+EwC0GrgmJqW846WXMPyvyJwYj8vTqep4C8
	/F9AKbiWvUrxQPGsrAWWcbUulMgSTvQjg6u6NP6vawUQI6MrNFD1ie5SKwm+vf4S2qq7qz
	Eqqy8w035boW2wOH05AFW3Ss0LQ1YCIMTMo2Dwtjn48vpGL5LI0SQtgzoWTViAwUm49GRI
	LbTehJwZ3H9WF7pSvUduKYhVHVrRyH24xn5ora53UX11OmP5m695iv/pbXUeLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726583616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGzlw87oPqHFdR25vE+og8sUGLP1VRSzbkYsHeyM9a4=;
	b=KK/5QAj6HuNfkeLZatTaTCdRZM8yiqxJq4c9WaiwBYTAd72aSFfjbUAxwEztFi8FjOiaC0
	YO8GjUB+qKGfzMCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>, Kees Cook <kees@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Richard Acayan <mailingradian@gmail.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
Message-ID: <20240917143335.YO5zm3JG@linutronix.de>
References: <10019b141275f7fa3e2446e207e7a9afaaa98b3d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10019b141275f7fa3e2446e207e7a9afaaa98b3d.camel@gmail.com>

On 2024-09-17 13:19:25 [+0200], Hubert Wi=C5=9Bniewski wrote:
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
> Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

This does not look right.
Can you add a backtrace and check with lockdep enabled?
netif_rx() should not disable BH if invoked from an interrupt.


Sebastian

