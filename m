Return-Path: <linux-kernel+bounces-209926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD6903D04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E121F23F39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21F17CA06;
	Tue, 11 Jun 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hX++gOoL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55417C7D7;
	Tue, 11 Jun 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112083; cv=none; b=jWTGmawK4pfzR+DdT9l/o9kvyJUgpY8SN9sc1BJ7Vdd8hDuxUHXtaXXR4UZJukHWQyOrknuWGvmG8x6wwMYXyAucF7yduid1IR/5E06d191D5/99ECm4gIhnbQTBAY9CzA5OdiB2cfN88ZbFrTsUoYroKdN+JQPVNbwBvEHS46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112083; c=relaxed/simple;
	bh=yBk1izK7yPb+2BLQn/5bpktLFQpC0tjKDfxcjcrOTNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ughbzw0zUjtimTbGN6wbWwoeshgNk11vcEyGQVTqNuyXRBNvXgykzNGaF+3ytzDAp2iCJ5JoalT1vJlfoe0lqF/q43gmYrGGKJP0lTig11jXnL5OkfMTCbSnxmxfIhEdC1Smmk0zaqiz/yVjbgiMwSQ6f8ZyBETEVNF9DTlYMlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hX++gOoL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+V9OrxfREx1kEorG7byrGojydV3IAsYO8seACV3xijQ=; b=hX
	++gOoLYyBwkJbyP4qyqh6HbF3FaCGVTobhWZB2jsGS5h8TeWiDY4fZI8C8jDMdYmgyDSj8UtlIwPN
	GPf9JZ+5CY1GbvzRw1MPj9sTYPsgAu2UHLidh79Q8enULgT44fs1Emr0coU6HRJzypmnVNNKYJEk+
	IBETdPzE+xCgvvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sH1Qv-00HODM-Gr; Tue, 11 Jun 2024 15:21:05 +0200
Date: Tue, 11 Jun 2024 15:21:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Message-ID: <243d5e27-522d-408d-a551-d11073cf330b@lunn.ch>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>

On Tue, Jun 11, 2024 at 05:34:14PM +1200, Chris Packham wrote:
> The Realtek RTL8224 PHY is a 2.5Gbps capable PHY. It only uses the
> clause 45 MDIO interface and can leverage the support that has already
> been added for the other 822x PHYs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

You probably should Cc: Eric Woudstra and Marek Behún who have both
worked on 2.5G variants of this PHY.

> Notes:
>     I'm currently testing this on an older kernel because the board I'm
>     using has a SOC/DSA switch that has a driver in openwrt for Linux 5.15.
>     I have tried to selectively back port the bits I need from the other
>     rtl822x work so this should be all that is required for the rtl8224.
>     
>     There's quite a lot that would need forward porting get a working system
>     against a current kernel so hopefully this is small enough that it can
>     land while I'm trying to figure out how to untangle all the other bits.
     
I don't see this as being a problem. It should not be possible to
cause regressions by adding a new device like this. If it turns out to
be broken, you can fix it up later.

	Andrew

