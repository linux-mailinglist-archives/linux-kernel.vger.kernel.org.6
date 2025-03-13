Return-Path: <linux-kernel+bounces-559581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D57A5F5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333E4189DEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA6D267AE4;
	Thu, 13 Mar 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CbxcRkr5"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F65267735;
	Thu, 13 Mar 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871869; cv=none; b=GhHMS+rCa+HGrcZh64+LbX9rvu8CkTqMdFlGM7FYU1ahlPlrJVnLxpXmCaS48yAxaSbaV42b1W2xRyj3tVF5RwFCqPzxa9ji/vk9BRatoJOlhSv5qEzG2ey96S3p/2QUYKkKe+2o8U7WpABno4YDcXnEjYcVdLwKzI/Uu9KGRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871869; c=relaxed/simple;
	bh=yDGWynoa4NHLG+/FL8La2c2pXIbj5JLF9ZRJKihaX0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXeoA3aMiAKgz/9mdvWRAufys9FPB39eL60zrK71s1Y0i66f0kDJkhnDrGgMHQ/v+zQNRLhPBPOTPjQcONX7LRz7pEjWU4xy1NWOt+Qj5ug+1a3Gg75m73VZGXBvqFB2HTHZ01Vcbf0y/rcEbKvvk2U5gKBiTj3f7bYxL4syv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CbxcRkr5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4EvY1LEFvjjHJU3jZAtzphl1AzmykKRYyWCA/SvfCK4=; b=Cb
	xcRkr5Js6+IwxGpOdQ1oKGkQeF2cq/TMzpc3U5FT2lIMY76EHMFIggsHj8bcQ651yDwsQnnj+ykg/
	VVeS7E5Fzb19hUdFqt2smal5gYticNcoGaqM1qybqC23066JPaLgcwYgNZK7XSU5DFkTI5Si9hhIM
	sbyH5zQuUwYlRao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsiRD-004zrS-Is; Thu, 13 Mar 2025 14:17:27 +0100
Date: Thu, 13 Mar 2025 14:17:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Klein <michael@fossekall.de>,
	Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: bananapi: add support for PHY LEDs
Message-ID: <7cf91323-d550-496a-a8ec-ae104c77224d@lunn.ch>
References: <20250312193629.85417-1-michael@fossekall.de>
 <20250312193629.85417-2-michael@fossekall.de>
 <4637912.LvFx2qVVIh@jernej-laptop>
 <Z9KYqlfUYxRaWnGQ@a98shuttle.de>
 <20250313104042.694c1856@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313104042.694c1856@donnerap.manchester.arm.com>

On Thu, Mar 13, 2025 at 10:40:42AM +0000, Andre Przywara wrote:
> On Thu, 13 Mar 2025 09:34:50 +0100
> Michael Klein <michael@fossekall.de> wrote:
> 
> Hi,
> 
> > On Thu, Mar 13, 2025 at 07:07:24AM +0100, Jernej Škrabec wrote:
> > >Dne sreda, 12. marec 2025 ob 20:36:28 Srednjeevropski standardni čas je Michael Klein napisal(a):  
> > >> The Bananapi M1 has three LEDs connected to the RTL8211E ethernet PHY.
> > >> Add the corresponding nodes to the device tree.
> > >>
> > >> Signed-off-by: Michael Klein <michael@fossekall.de>  
> > >
> > >This is patch 2/2. Which one is patch 1/2? I got only one.  
> > 
> > https://patchwork.kernel.org/project/netdevbpf/patch/20250312193629.85417-1-michael@fossekall.de/
> > 
> > Sorry for any inconvenience in case I messed up the patch submission.
> > 
> > I made two commits for this change and submitted them via `git send-email 
> > HEAD^^`. The first patch went to netdev@vger.kernel.org, the second 
> > to linux-arm-kernel@lists.infradead.org, which seems logical. Have I 
> > done something wrong?
> 
> Well, for those really small "series" it's probably better to send all
> patches to everyone, especially if the first patch gives some context,
> without which the second leaves people (like me) scratching their head.

However, netdev does not like pathchsets which contain patches which
should not be applied to the netdev tree. DT patches generally go
through a different Maintainer to driver changes implementing the
binding.

So for your DT patch, you could add to the commit message something
like:

The RTL8211E ethernet PHY driver has recently gained support for
controlling PHY LEDs via /sys/class/leds. The Bananapi M1 has three
LEDs connected to the RTL8211E PHY.  Add the corresponding nodes to
the device tree.

	Andrew

