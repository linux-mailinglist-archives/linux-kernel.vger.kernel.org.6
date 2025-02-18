Return-Path: <linux-kernel+bounces-519219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ACFA39958
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6E03B900C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857A21A83E6;
	Tue, 18 Feb 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="04WhkOQE"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856C22F140
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874474; cv=none; b=sr4jPT/BbiNEdNBzkCoaCJnKORWRXOR4Scnj3WL/BFcg37Bc7a/pL1MzCWoFCNsQlvAEVrR9uZ/v/DuxIz2xGUUkYNYeNZaU+r4+N39YVyQ//cG22lfUt6l1/90UXBcKXa4R/PxKp2B+s02Nlgag4DIePREZ4jugzoXUqAkhHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874474; c=relaxed/simple;
	bh=Vdo3YoM+Y5MCWDl87fb+uCczK1tumNtMPVk2GyUyEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnYXyMO1+7XwkgyNfEZw2gWXmrcTgqB12rS6yPBRiabG9b/ZijaoUU3cM6Jd5EvFUuQ2tuHToMJL5/mHHivvGIkx0hgBkj7ITPLh2iFoRYwdQdIhIcg9191n4SqKbvzAlR8FKiCnIqhpq/IUNGoJDon83ez15P44d6d3XTmPtTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=04WhkOQE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5VZaPhGDFIj0K374e69EsB2q90XVhzBFLGncOIer42w=; b=04WhkOQErXn7MDlifr5TYzuxT2
	ZHCfetxWFMJFQs61BXpjOXzQYuLkt9Bkoghq3Yy2zk3VSwHMMqvy4T7Q3Rmj//6Y7mBZafjAOeWWX
	QWmIqbWBvC9e8OjhOmRv4ep9SLhtdvHvr3tFr6LEPJH0DHdYSwG7mnpDzMm4xIfhjAiJAE5HV4Z0i
	A4yFvA+bNUvMFdr4X47XMHINBocmR3fmesfgedbBzLxdknOW83ZaVkXgHR1HcrwbyhLFi1BLlhlJQ
	f7u8NIJ+Sb5K4m0qPOJxARLF+6/5sxhM9bvkAno2cCLndP73rCaEtpNoZuNA5Swn3vXEkn+LUwwFy
	WZcSrKyg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44206)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tkKpS-0001Xr-1J;
	Tue, 18 Feb 2025 10:27:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tkKpR-0007BK-0z;
	Tue, 18 Feb 2025 10:27:49 +0000
Date: Tue, 18 Feb 2025 10:27:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mm: Don't use %pK through printk
Message-ID: <Z7RgpaLeIPMQ7kgp@shell.armlinux.org.uk>
References: <20250217-restricted-pointers-arm-v1-1-aaa0fb22e18c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-restricted-pointers-arm-v1-1-aaa0fb22e18c@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 17, 2025 at 08:38:37AM +0100, Thomas Weißschuh wrote:
> Restricted pointers ("%pK") are not meant to be used through printk().
> It can unintentionally expose security sensitive, raw pointer values.
> 
> Use regular pointer formatting instead.

... which means that the warning is pointless because no one can debug
it when someone reports that this has fired.

While I get the security issue, changing this is severely harmful to
fixing problems should this warning fire.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

