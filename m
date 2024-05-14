Return-Path: <linux-kernel+bounces-178942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B15D8C599A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0271C21C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9E2180A94;
	Tue, 14 May 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="THYMR3UD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B71802B8
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703453; cv=none; b=hc01LI8twfCD5fzdTwZO1rvArl2RwP93U1aVs9lrK4xSy2yRQuwPLkCp+O2d1lTuUZdNuMGvcCMSKb3dDecrj2huJ25fsqNW3Y2f8Qrmig9fqAfDyi7R1/pD00sU6rcaWiURQH1p1jxsWeQ3unSjOOGEywJl+QQuw0ukhmDKqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703453; c=relaxed/simple;
	bh=zvOVv3+ivmY4QFFVbdYxHcA7EI1kFoZjcLjdZuXCnbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbKXnXJ9dWogWoUqrFNLYsHdATrPba+sIGsa7uQWLx2Dz7qPrWcaZBJUkZ0xTOCBofk9NkdYQ3t8XmIjJ1rJ/Sg7lwLBFi7L6AA1WV0BtcK0G4KeZQ3lg2LvjWMDu/QbO5Q76ftgeojHqZ0nrLSdxv96ZQFtGdcRGdl8QxVZVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=THYMR3UD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=hvq3vXQtPyfB87Ws5zCdXGhwZMa+XbmLTwbYBUinQuM=; b=TH
	YMR3UDPptwNktXUqLIzBrRV2/mPInYHrIyReZG09qn9gs/TBMSNdDdmz8NcWhwHrF64dcEwMpJzu3
	KJr/js4Wot/gPMK6ZoLo1jdNXOvls+xV/Ybyuca4jap9n41dcTFYfri3LMl9pzodf7VTe30V/Tlj3
	EU9ucQxuq45DRdY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6uqF-00FOrN-VL; Tue, 14 May 2024 18:17:27 +0200
Date: Tue, 14 May 2024 18:17:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Langstaff <stephenlangstaff1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
	OlteanV@gmail.com
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
Message-ID: <949fcbea-23dc-44c1-9146-c358b15b9253@lunn.ch>
References: <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com>
 <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch>
 <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch>
 <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com>
 <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
 <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch>
 <CAHx5RXDzN93WaYFe2bk6m2TmMC+A9vsmhodRFmZi17cFY5CrWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHx5RXDzN93WaYFe2bk6m2TmMC+A9vsmhodRFmZi17cFY5CrWQ@mail.gmail.com>

On Tue, May 14, 2024 at 05:08:24PM +0100, Stephen Langstaff wrote:
> On Tue, May 14, 2024 at 1:32 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > So try to making FIXED_PHY = m, and load it after dsa_loop_bdinfo.ko.
> 
> In my configuration FIXED_PHY is selected by several other modules:
>   │ Selected by [y]:
>   │   - FSL_DPAA_ETH [=y] && NETDEVICES [=y] && ETHERNET [=y] &&
> NET_VENDOR_FREESCALE [=y] && FSL_DPAA [=y] && FSL_FMAN [=y]
>   │   - FWNODE_MDIO [=y] && NETDEVICES [=y] && MDIO_DEVICE [=y] &&
> (ACPI [=y] || OF [=y] || COMPILE_TEST [=n])
>   │   - OF_MDIO [=y] && NETDEVICES [=y] && MDIO_DEVICE [=y] && OF [=y]
> && PHYLIB [=y]
> 
> ...so it looks pretty tied up with the MDIO support which I guess I
> will need for the real PHY!
> 
> If I sorted out building the dsa_loop_bdinfo.c code as a built-in do
> you think that would solve the ordering issue?

Probably.

Florian test setup shows it can work.

This mdio board info stuff is based on the same concept for I2C
devices. However, it is simplified a bit, since it is not really meant
for production use. What i suspect the I2C version does is that when a
new board info is registers, it walks all the existing I2C busses and
sees if there is a match. The MDIO version is missing this, it only
runs the match when a bus is added. So it is less forgiving of order.

     Andrew

