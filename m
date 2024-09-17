Return-Path: <linux-kernel+bounces-331561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803AA97AE44
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26DC1C213CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14A15E5C8;
	Tue, 17 Sep 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ch5lzFGE"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACF15D5BB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566781; cv=none; b=hQvAUUP1lAssXYErqTsjqy0QYjk7xMUBnIZ3yM0DlD9WlaIugPqafqY50WVMxe/X75q4ubv1h1OeuPGqRvdkIQ6hFybrQwgIzUQgZjgeWBiXX1fcWPlhbtGb96YWtUOPdwVbFMEe6Uppe2/6PP6Na1cp8K/UvNjz/83pOW+PytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566781; c=relaxed/simple;
	bh=yekIoU8RPpjcOV1si9w4OlRIJpaBJRwrb6G63MrwfKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snwMOfYtQpDjGYWD6uk8E0H+VxMjrPJOtPUFiRcaSp8M+XFd6FHpC5dJOHuWk+yqoTEjecPb3ASdLblRSKm1ynIEVywHxCfDWCJWiwt4Y5SpB8TzuEGAk6G6h/kWaLd9Ii/LPTFTkFAlEqodaaUsjrGJ5aid1pZ6LCg2VzAwEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ch5lzFGE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5yGljVnafxjfOf4oYVp4y+Ih5fCdjClNcPxVb3Q5Rc8=; b=Ch5lzFGEsJqhhrWQsgRSTd/p0E
	96MGsGzo/iaT2CQFz7YxZxK0S2sNmNg2xgAh+zZT3sZvR227fIfX66mCpig7lNL9HGVn+KIajyOde
	9ONPqp1NNnfHxUasKY8PSmlm5gokkb40VZNLzGusulqWAwTES4aZ/Yh+YJ/xrhL05RwldoUMFCNV1
	VHRFUuRqfxlU7zgFWgzCEoVNExbQfGioSt5xyDIj3Ybh4zqBm+3XJ/1k9iJHH7sCAK4L86hPJ3YHz
	H/blI8H1pHx3pPUROPStK4MYapvsmwQQNI2PklQlOaRnEDXeNyPwcdEAGabjX2zvfipKbtZLeec06
	c8hqubsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36428)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqUt6-0006pk-0H;
	Tue, 17 Sep 2024 10:52:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqUt2-0007sh-2j;
	Tue, 17 Sep 2024 10:52:44 +0100
Date: Tue, 17 Sep 2024 10:52:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH RFC 0/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
Message-ID: <ZulRbGQf1b+Gy2Ox@shell.armlinux.org.uk>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 09, 2024 at 07:37:31AM +0800, Zijun Hu wrote:
> This patch series is to make amba_match(), as bus_type @amba_bustype's
> match(), also follow below ideal rule:
> 
> bus_type's match() should only return bool type compatible integer 0 or
> 1 ideally since its main operations are lookup and comparison normally.
> 
> Which has been followed by match() of all other bus_types in current
> kernel tree.

How does this work with e.g. udev module loading? If the ID isn't
known until we attempt to probe a device, then if all AMBA drivers
are modular, there'll be no drivers registered to cause an attempt
to match a device to a driver, and thus there will be no
peripheral IDs for udev to use to load modules.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

