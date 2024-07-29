Return-Path: <linux-kernel+bounces-266548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF24940180
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACAC28370C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01D18EFD9;
	Mon, 29 Jul 2024 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JqfV4MU6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6463D9E;
	Mon, 29 Jul 2024 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294367; cv=none; b=EB/WCEZgkEbK7EeNyPrFyt7pqX+xS0Fw+1i1KhKeR2tafikXj8ldnjUSnoXX3d+Hn6TjLMQMLTPwnMcLkXhysqylsvFdVxkzGZgKlnXXmU3Aj1O983vPJ/3Ru3jowPYvwatpgtFycZ99iyMYI92xZXPt9E8QVAJoRE+9FSRNGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294367; c=relaxed/simple;
	bh=Gfl6I2KMTd2F4Bs7Nyn6FvRlxYYPJdX/FqpN6xw7NW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLGt3pe6brR+pX3m0jCEno4WgXCU0hgGbrofOM0AFA8nuvSQ2wqJtL0AD4EOV+sXEUxxCo9MScyskrj8YnJoMQWBqtpglQE4QOmKUM0AQQmoVj608IYTvz25cEGYOSWr+0J5tPwS79exLzM9EtjGYP7CRBjkbG6K2RDOOeyNYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JqfV4MU6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5ARsY/WTbTgGzVzGk5/1H1xcrMraKjZ0eOY3UedZGWY=; b=JqfV4MU6BdbrlZ31Mje46q7kWl
	rNKiRThqyJr1fo/VcQFQIHhx2gQAz3Uq3ZtH94eJZaTg5lC1sLealfOmY12HS4GirXLJDr6f4Yfd5
	hpH7bWqMSJJsRpFlkAzvqkNzNxhqgMsdEv8Ki9PVOLP5dlfZ4q6k9EIA7YKE/7XQtVSxEJlQEQD7v
	Pfcn8eK9KN+hJT/b7PqoytPefhQQ+OUcXeUa/OLNKD1NAxCMxwSwRRHisYh2Y8wbqiWTWL0wvgrK5
	2+Qgs6kmRK0PTkUlOKPM7MofHS8ILl4kVMeZI5gYzP4HjTbmFOcQ92uT0eKZVo9edGYx3uhMxBsWH
	+7AUCiUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43670)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYZRA-0005ah-1e;
	Tue, 30 Jul 2024 00:05:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYZRD-0004hV-Dg; Tue, 30 Jul 2024 00:05:55 +0100
Date: Tue, 30 Jul 2024 00:05:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] net: dsa: vsc73xx: fix phylink capabilities
Message-ID: <ZqggU9zWlvBh5fOb@shell.armlinux.org.uk>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
 <20240729210615.279952-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729210615.279952-2-paweldembicki@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 29, 2024 at 11:06:07PM +0200, Pawel Dembicki wrote:
> According datasheet, VSC73XX family switches supports symmetric and
> asymmetric pause and 1000BASE in FD only.

What about the configuration of the pause? I notice the mac_link_up()
method ignores tx_pause/rx_pause, and instead just does this:

        /* Flow control for the PHY facing ports:
         * Use a zero delay pause frame when pause condition is left
         * Obey pause control frames
         * When generating pause frames, use 0xff as pause value
         */
        vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_FCCONF,
                      VSC73XX_FCCONF_ZERO_PAUSE_EN |
                      VSC73XX_FCCONF_FLOW_CTRL_OBEY |
                      0xff);

which suggests only symmetric pause is supported by the driver _and_
it is always enabled irrespective of what was negotiated.

I think this needs to be fixed first, before changing the capabilities.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

