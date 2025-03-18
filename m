Return-Path: <linux-kernel+bounces-566585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F3A67A23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A45423047
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3E2116E6;
	Tue, 18 Mar 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yCNbrA8X"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030CC22094;
	Tue, 18 Mar 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316866; cv=none; b=ouip9XMIXzXMPQAygxzm51QyeZRw0paCnLOpcpXRrcyBeNksDxZuxjjfe7ehE/N/ThUDuhlmcALGgaVobheEZIhq//fFj2j5zSVXwt/3oaEiSovRGcPZ37MzIp5qv1BLkxY4nem2BqI4ukGbsq3FzQB1uIfyCzsy0WICxSbHg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316866; c=relaxed/simple;
	bh=8ipEegjfuDkIN6p5149xZDkbJ+ck6Z7Iz3oV0sOhCPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4RNnzWzNeBzF+9ouIf+YQEh8+bxvnbWtudOTDf9sDOCp2U+BHickscI3kFMr+g6Qdy5sAZ1rMlYYXqK7NMhWWN0howPpU/4QHr05k4OPAiJeXDr1Nh/tGC1VEJTUX8ybnblIXpkxiTf7VYPEF9L2MAMUjhMGbmR8u4HD8fz1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yCNbrA8X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cu8WjOKvjc7xER6FBh5x1tsTM5cnZ9iM06KfKZsppec=; b=yCNbrA8XKXcgrihH6JvsnO+10G
	Uvq5lfXLMOkRw64d+Wm+k7JhW55u2hRBpbkA/9kOBslNZtOqKVWXKSsgdj6R5Be1G9Y2VGCJ9SSrN
	ckwVAmG6G0JYvfrc9QF4tFzrsb9EvamSZ8gxh/wUAPdnsyh3eNY0bQEacQd+K1VK7lyc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuaCc-006Hsy-Mr; Tue, 18 Mar 2025 17:54:06 +0100
Date: Tue, 18 Mar 2025 17:54:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rajaganesh Rathinasabapathi <rrathina@amd.com>
Cc: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>,
	devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, robh+dt@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Supreeth Venkatesh <supreeth.venkatesh@amd.com>, jothayot@amd.com
Subject: Re: [PATCH v3 2/2] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
Message-ID: <6ca63f35-05c4-472d-a412-74e5c7ffeefb@lunn.ch>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318041224.1693323-2-Rajaganesh.Rathinasabapathi@amd.com>
 <fdd969cb-aa2d-4d55-949e-e2631757221e@lunn.ch>
 <ab74593d-a3be-4283-ad83-3525cb6d7dd1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab74593d-a3be-4283-ad83-3525cb6d7dd1@amd.com>

On Tue, Mar 18, 2025 at 10:18:46PM +0530, Rajaganesh Rathinasabapathi wrote:
> On 3/18/25 19:38, Andrew Lunn wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> >> +&mac3 {
> >> +     status = "okay";
> >> +     phy-mode = "rgmii";
> > 
> > Does the PCB have extra long clock lines to insert the 2ns RGMII
> > delay? Or are you another victim of aspeeds broken MAC/SCU driver?
> > 
> >        Andrew
> We're following Aspeed SDK and referred other dts based on ast2600.

Which are all broken.

At the moment, you are joining NVIDIA and IBM waiting for Aspeed to
sort out this mess. Maybe you can apply some pressure...

     Andrew

