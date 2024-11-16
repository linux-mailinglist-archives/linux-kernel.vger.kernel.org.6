Return-Path: <linux-kernel+bounces-411832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DBA9D001E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FB9283C97
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E833191F9B;
	Sat, 16 Nov 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c96XA77v"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96D199B8;
	Sat, 16 Nov 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779078; cv=none; b=oomsTqLKGlaOg0otJkrYcmRqw0lgm/btmkL8LG1WUdrD96VEVIhMrzb9PWl7vS/baC79eaGnemPETz6Z47fTxAEUjDZjX10VR5J7DBgFYCqCpjuLwECjU8b2XiLebktztw1UqJOWTXG8z7NHfKrBejmIBIOFq/zvt02hRtJ49uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779078; c=relaxed/simple;
	bh=QWZim7FQPbXfJxdh312FGeuv42qn/G7Zxw2QMmv5/mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2I+8IANOtHk5OsbnLqwrDQwSgffy+hj1Z8RW4azly7msAvl96UIQkkvcBwknyyARBpxxIXKbRk2LthIoplyw/q/0P5MafPtZZySl6vjUcFdtCt+n6dbT1Qk+WsLF3nYGSMlujnNJrM2QvC3T3DU3IbDFJPeAx1BJjuww5/3T34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c96XA77v; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8NNLLCEIx8IzwDwZu7yHwyqQ+HCj7SmlfLX0ltjHK1c=; b=c96XA77v161R7ji8ERnY0/Rb2T
	wNwGYefMTcknNBHUksYVjNHb2WnHftgV4lBTnCw42KiRfW5m5qoUI5CjCzeHvfvDME7qS2tNUPKTo
	90frI/JCUTUqUqqc7EvBPXYJQecn3dWm4FU4bZMARsCq/3sJ8shawi1d9mYbeVHvgw4h3N6vjXwY7
	K2iUqJguIZThrjMPNWdCa8EcMpK9FvkPzxjukmDb9QV1rEFT34ESldAZ7RYq5O0HlKJBGp4kaBPWy
	Oompd0zu5LWojhwPGb9lhG2+S3DO9lBFi27OX2OvAkJMwX5dxeu238KS7OBdJqdqGuNKvTEmnXVk8
	bLdNhxAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41742)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tCMqK-0007TN-31;
	Sat, 16 Nov 2024 17:44:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tCMqG-0003IR-1h;
	Sat, 16 Nov 2024 17:44:16 +0000
Date: Sat, 16 Nov 2024 17:44:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2 0/2] Fix 'ethtool --show-eee' during initial stage
Message-ID: <ZzjZ8EcwpU-YnZrz@shell.armlinux.org.uk>
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <403be2f6-bab1-4a63-bad4-c7eac1e572ee@gmail.com>
 <ZzdW2iB2OkbZxTgS@shell.armlinux.org.uk>
 <170a8d59-e954-4316-9b83-9b799cb60481@gmail.com>
 <Zzi7dqqZLCCVvlHq@shell.armlinux.org.uk>
 <3915908d-d70b-4fbe-b80b-990d02211965@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3915908d-d70b-4fbe-b80b-990d02211965@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 16, 2024 at 06:41:13PM +0100, Heiner Kallweit wrote:
> On 16.11.2024 16:34, Russell King (Oracle) wrote:
> > Hmm, don't we want to do this under phydev->lock, because network
> > drivers and phylib may be reading from phydev->eee_cfg? If we
> > update it outside the lock, and then revert, there's a chance that
> > the phylib state machine / network driver may see the changes
> > which then get reverted on failure, potentially leading to
> > inconsistent state.
> 
> Good point, then the patch would look like this.
> BTW: Saw that Jakub applied your patch already.

Yes indeed, so I hope Jakub will apply your follow-up patch soon!
This LGTM.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

