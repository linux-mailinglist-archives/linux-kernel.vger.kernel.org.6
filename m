Return-Path: <linux-kernel+bounces-180948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038DC8C754E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9715A1F2131A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFEC145A04;
	Thu, 16 May 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IQEiFTbk"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D61459E2;
	Thu, 16 May 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859246; cv=none; b=K0Xig2tY3vTi4HpJ20mvQdXSaK3QRXfNEVIJ6ogK/kCW+23Boq/tWU+aXGn/0qj6vVO6OxMWB2vaUIyHh2FUuBC6n6UsoQcUNYiOIrjJcWJP2bDwd/VvFKlYeGFROEA159d1cvlBsuK5eQYpQkNrcXAMfZr4BPsy+ZeN+43SEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859246; c=relaxed/simple;
	bh=WOf2leyhgMuRezn+1sQ8Gbe03Kn4oCimAqgdwwfMg5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akTxuU4uFuLocwhILJFi0GAHn1OpOhZrVPNDWryXwTBCdkHvH2WbYFbvxUsmcwYcAKqJYsAv2q+z0uiySnjLArCOCIsh4d4FCFutQuk6SQzjM3p6vOB/pyvn4BfapyMrrmjA8RVRxeIXYCkoymlzCN5chi7CRNdCZEJaFQlkJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IQEiFTbk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CXEnYn+n/oPUwvw8XY2bU5Doe0EGHASmi9eJ//nBzoo=; b=IQEiFTbkAL6mW74WuXn8eQ0T4p
	DbFAFRVc/6P6DGKfS4mRVaA1+Nb+es07n+jGFcVRZkonW+pNtmGuTlw81YgdrzQ5cJ6EtjaWZeuTC
	BwdbC2F+dvbEqJ74E1kfA08S4h38IRt6Hkh1KzAssSpWVehAnYpfhAVnm7vWnRPafxKUyJ94dDAqb
	+9O1NSu2DDs/gh9SMLiQLEENPW4WKxMfBUnjZkPApNIk5JvJTrnXRO07Jkue2n/HK3AHX9WaJOqcq
	PXQ/in7Iw+eFOsi2OViKDrwIX4ZAjtqxfNd5M/Ib5diSx/TNXdRC9Ngfx/b+Tr5JiUdPvPIZ+fasd
	2gLU5+AQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42986)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s7ZMv-0004mH-2r;
	Thu, 16 May 2024 12:33:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s7ZMx-0000Zt-J5; Thu, 16 May 2024 12:33:55 +0100
Date: Thu, 16 May 2024 12:33:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
	open list <linux-kernel@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
Message-ID: <ZkXvI2D8tH0aG/Cl@shell.armlinux.org.uk>
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
 <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
 <ZkUgqzUn1EmjrPdl@shell.armlinux.org.uk>
 <CGME20240516102738eucas1p2eee547d4b78c347308b0979fa98ede39@eucas1p2.samsung.com>
 <CA+G9fYurPNaW=u2E+h+segnXhY3cfWo3BJpfYDJxKRFPY4epsQ@mail.gmail.com>
 <29f30eda-deba-4092-9b4c-8cb101b8691d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f30eda-deba-4092-9b4c-8cb101b8691d@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 16, 2024 at 12:57:53PM +0200, Marek Szyprowski wrote:
> The fix for drivers/clk/samsung/clk.c driver has been merged to clk-next:
> 
> https://lore.kernel.org/all/f7a877622829db499bf2bc65fe9ffbff.sboyd@kernel.org/

Good to know, would be nice to be kept in the loop though, especially
as the first version was submitted to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

