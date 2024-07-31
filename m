Return-Path: <linux-kernel+bounces-268814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01E89429C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B9EB22288
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE21A8C15;
	Wed, 31 Jul 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F58miuXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C511A8BF7;
	Wed, 31 Jul 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416229; cv=none; b=ppVY/TRGzraRWLbpHizvCPtXxyNl8jS52tsVkYr5GF632eos6zz4PV2hOGG6GAN1LQP7CsJ7WcwcGpJNLa/qQZJKt6bO9EJEvKReYOp+hJAbEHYA3lNBT0HOkTxuO9VYe9zC8kJBDHS5fWBC6oSPu4rRMpfQkje7Qz9jRZZK6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416229; c=relaxed/simple;
	bh=WuX9Hh+nd6fFDxrD3P7RjEZtEtMoWKCvvFiRe3dKksM=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=Zt/r6yL/026ZLYKqvBUmgxnobsxe7lrLxNe4S90s4JwJX3FJAOjpgkh6GjBGgozF8LraA/kVk8VZL0aVo2+8vMXh0KJbyqZBl95ipHJwZg543X8nNRcohnJx+T0bhqfa13KbBwBq9OTJg/yi5VviukX3p4ZDA4EDoU+dCpE7C6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F58miuXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C35C116B1;
	Wed, 31 Jul 2024 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722416229;
	bh=WuX9Hh+nd6fFDxrD3P7RjEZtEtMoWKCvvFiRe3dKksM=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=F58miuXfPdH3ZgBcRfjit0jAxCWO/JV+4VZLxm0DgRajGQN2/P0t0bdrRTIxVtSN2
	 guZE2f+PO9NWo4/paz0trEGBrJw0c84ZjfmUrpp6CjEOrDNfCJlVYNE44Cvtxm3RLV
	 Aa8rKBC3jWlL+O2y4qSldOa9NKi17FolGduLYbf7rgX0pfoAv6MDRU3BX6007EaRFO
	 jpfgHF8cF0fTjtFmC0bicHCoO4pWJBLh0lBC2RBrN0T4dfY4QoarjJSRkqEsh1PwHA
	 Mhr3wvu6c6OHMQHLoa7URtfdxGAmXW0NVbjqt9Qc6hoSTeXHHbZGxJYlWZ6oN97maV
	 zshxuhgfxvTIQ==
Content-Type: multipart/signed;
 boundary=a278cb899e5ffd9b3580bbe7a8320b9336286ac50c0dd6fece958aadcd6a;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 31 Jul 2024 10:57:04 +0200
Message-Id: <D33LLE6K8QGH.1BCZM42INRVEX@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: gadget: f_acm: make bInterfaceProtocol
 configurable
Cc: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240730194337.2583784-1-mwalle@kernel.org>
 <2024073151-violator-unskilled-6866@gregkh>
In-Reply-To: <2024073151-violator-unskilled-6866@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--a278cb899e5ffd9b3580bbe7a8320b9336286ac50c0dd6fece958aadcd6a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Greg,

On Wed Jul 31, 2024 at 10:32 AM CEST, Greg Kroah-Hartman wrote:
> On Tue, Jul 30, 2024 at 09:43:37PM +0200, Michael Walle wrote:
> >  struct f_serial_opts {
> >  	struct usb_function_instance func_inst;
> >  	u8 port_num;
> > +	u8 protocol;
> > +
> > +	struct mutex lock;
> > +	int refcnt;
>
> Attempting to "roll your own" reference count is almost never a good
> idea.  If you really need one, please use the proper in-kernel apis for
> this.  But you need to justify it as well, I didn't see why this was
> needed at all.

Honestly, I couldn't grok all that usb gadget magic, so I've looked
at similar gadgets and took that from there:
  grep refcnt drivers/usb/gadget/function/ -r

They are all doing the same, so maybe that code is old or didn't use
the proper APIs back then.

The refcnt will prevent changing the options (the protocol here)
while a gadget is still in use/bound.

-michael

--a278cb899e5ffd9b3580bbe7a8320b9336286ac50c0dd6fece958aadcd6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqn8YRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h1tAF+OTXTi9KQMmLqtPm8xGWK616McmKTMRUM
i7dFuk3aHdKr/IyBXnGxlaqnLLj3n7ecAX94j2sIOIxhJXk5f3oqB+W9PXIhCExp
+L9hITypnd0thm4LfsZvB+VuLLDJkbMLM8c=
=USbP
-----END PGP SIGNATURE-----

--a278cb899e5ffd9b3580bbe7a8320b9336286ac50c0dd6fece958aadcd6a--

