Return-Path: <linux-kernel+bounces-540687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A1A4B3BC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82728188D184
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8971EA7E7;
	Sun,  2 Mar 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LzOvHwN6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445182BD04
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935881; cv=none; b=PltNg969tJVkfjeMofTnRIVMu8c+cnrjzmyX8aJunQZ3dMB0eUl5dindMC07P4UrINkvxZ038MjYu5JEmveeHDUwWNe6VlxfxoHVOZCfh3Q3M/LZerYc1cAxcEIm/fr0cEhe/ECmc/Y3o/pE3ELFp2CE0VbdgBKZF2gxlPGF8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935881; c=relaxed/simple;
	bh=iVmWlrKU4nBtHa8hxKOuSe6SPI9KYuZKEtbsJnBTzLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZpBQ960XqtBNxKO/Uxmk9GcERNPUYtmwKbS8W5V1bHuRSKx+VeY/ljOia145HRI/wqJp2Ad/QQvpOaiDnrPkysctGrK6qA5ZG26XjaPTnf1uFBCU0Y1pU6/qk0dD1t+NRzOmKADKTWE5PP6Oy4NqP4FrJfesZcQu2iyzgOGd0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LzOvHwN6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=41Urw9pUS3IkmTIPuFqUDyIbxUtgIUEIRMkgs9tsTLw=; b=LzOvHwN66Ik5fv+w2t06injFiY
	YnZ7FHFsu59lHmZLKCvLkcctp2IUR0KNjkAdFAkvTNZCPjf/c7IYZsKVIyum/p4cX1ILzZU5GuwZU
	VXpiiAnLFveSWPBVTgDxYJHOFDXA0HmHI8FPU35tID0MBZQFz+U+tSmT0kJHCb2TOhxgqxshZ0vl5
	CWrVkqWwloCR2ZstuziJXR4hpHrSely7AiMtoXLuWjEUxOLVZiO10d29xWzzKzzIT70LUGnPcQZqa
	9Cwa9Uk8S7Cq/X84pbEfJ0i8Roq8/2HaVUI0Slg7NTYGoFG6jN4dbn7+KSQQgniAwoDqFcmAQpheC
	JsTriIpQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60310)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tomwi-0006rb-2U;
	Sun, 02 Mar 2025 17:17:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tomwg-0002vQ-2a;
	Sun, 02 Mar 2025 17:17:42 +0000
Date: Sun, 2 Mar 2025 17:17:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: phil995511 <phil995511@proton.me>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [GIT PULL] Generic entry for ARM
Message-ID: <Z8SSthQ-gK686k8u@shell.armlinux.org.uk>
References: <0oXU8PP2CHCw1Qblhw1cKOTt90K2CLbHo4BLw9LOs-J1klN1Y_N7IagulWZHR7bGhmxyPXlZTOUEqVZDtwcXj9j93_BxdrdnmW7qk3uIrU4=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0oXU8PP2CHCw1Qblhw1cKOTt90K2CLbHo4BLw9LOs-J1klN1Y_N7IagulWZHR7bGhmxyPXlZTOUEqVZDtwcXj9j93_BxdrdnmW7qk3uIrU4=@proton.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 02, 2025 at 03:23:20PM +0000, phil995511 wrote:
> It is a very bad idea to want to code the Linux kernel for ARM in C++ !!!
> 
> Our ARM CPUs on RPi and others are not powerful enough to use a Linux kernel written in C++ and therefore lose performance, while these ARM CPUs are already extremely low-performance !!!
> 
> Suggesting to code like this is to be in favor of planned obsolescence, of the scrapping of thousands of small machines ;-(

With all due respect, you have your knickers in a twist.

This is not about C++, it's about plain old fashioned C, which has been
the preferred kernel programming language for decades. I have no idea
where you've got the idea that LinusW's commit has anything to do with
C++.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

