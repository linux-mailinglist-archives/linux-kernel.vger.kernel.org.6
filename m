Return-Path: <linux-kernel+bounces-177857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632808C4560
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACD01F21975
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE522616;
	Mon, 13 May 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GOgbe9zy"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87065224DC
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619255; cv=none; b=R0K784xziT4EQBadUR+Gau4zERZPEVTZH0dEVBgqvKrWMJP9HS2Mk9x36FTtJEB60A6DaFP4nqOMztTxWRKtRvzZ6cm4DI7K7vcmF7HIluLtT5nt8j1mTx5lRJZZUQdIpEMmDSWQ+oHI6sGbs81atXe4KXkgRH/NcaMGkiKz0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619255; c=relaxed/simple;
	bh=VSyMo7DaP8KwB5t5bwaEbjfbFZwEfyRtAF6IFAROUOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhW62aX1Vogs775nfL4kEMvpofOjsmRRrIA0QmUw5Ct4CbsITHQ2J+bV0ocSi0qGNkDqqaIo0dPS7hs0YfWlHSvNlSdVq098mj6YhLjHipb5y9e6c9OufQQb6EEp1M7fQs0dAW3mtBryGK/Cisu+NnhqzwWxYqLvngA9bPdju94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GOgbe9zy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AxpmKkEHWsf0GDlqpvJu8ao2VhIdXEomezlWOSgaREw=; b=GOgbe9zy7XQs6mjdR1ZG6ET3v/
	M2pRaO1M62ufIEErA602bm/pjg4R2nmBO5jGSlMKHos1Wcf8oUg171SfV8oaLGKs0d5ac51gf9r+T
	IX3goI9IKFZbuvYu4DspFBgNHtmqEppw2RiZbhM8Ow9K/SkQVSUOwKb+VYFMfM5mwGf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6YwE-00FK4D-P4; Mon, 13 May 2024 18:54:10 +0200
Date: Mon, 13 May 2024 18:54:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
	"OlteanV@gmail.com" <OlteanV@gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
Message-ID: <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
References: <CAHx5RXBfazB62qpbGGK3_YjwCFbiJbEXrgo88V6qHFdTW1CdRQ@mail.gmail.com>
 <338daebd-b4af-4a0c-951a-ad7f86dc4646@gmail.com>
 <CAHx5RXAOKBGXRgC8pqEyY3MZGXxj0-vrwnqg_WZqKreYp18dAg@mail.gmail.com>
 <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
 <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>

> What I am trying to achieve is to use dsa_loop to connect a CPU
> running Linux to an Ethernet switch via a "conduit" Ethernet link
> (e.g. eth0) using the port-based Ethertype DSA (Marvell) frame tagging
> protocol, so that the Linux kernel will present the userspace with
> separate Ethernet links for each of the switch's user ports (e.g.
> lan1, lan2, lan3).
> 
> As I understand it this is usually done via a fixed phy-less conduit
> (e.g. xMII) and an MDIO link between the processor and the switch so
> that the processor can configure and control the physical user ports.
> 
> I want to do some software development ahead of receiving the
> hardware, so I want to "fake" the MDIO link, or in some other way
> configure the kernel, such that it uses port-based EDSA frame tagging
> over an ordinary (PHY-equipped) Ethernet port and it looks to me like
> dsa_loop should be capable of doing this.

That is an interesting use case. I don't know of anybody doing that
before.

As Florian pointed out, dsa_loop_bdinfo.o should be built into your
kernel. When you insmod dsa_loop.ko, it should match the data in
dsa_loop_bdinfo to the dsa_loop driver an instantiate an instance of
it. Do you see that happening?

You could hack dsa_loop_get_protocol() to return DSA_TAG_PROTO_EDSA,
in order to use the EDSA frame tagger. dsa_loop does not have an
implementation of .change_tag_protocol, so i don't think you can
change it at runtime. However an implementation of it should be
trivial.

   Andrew

