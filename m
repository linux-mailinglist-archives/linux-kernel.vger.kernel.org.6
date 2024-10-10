Return-Path: <linux-kernel+bounces-358926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB53998561
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24241F2498E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC981C2DD5;
	Thu, 10 Oct 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IIe+J1UD"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461681BE23D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561344; cv=none; b=AKf4CG9foMZj50HvyiXJ9/XqHFRMhpCHgf6p4PZm8wch8ddKaiq00NoJ/t7Br2egjsWPTa3rxfEMLm/z60mELIFwxcOm9/ehtjdr2RPIO9bj/0DG4jED6BjPHhEz3WfCmFCoJZw8CXT++LXM016MbY0C1tdk/1DZ++aza/6u90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561344; c=relaxed/simple;
	bh=9ypUntO+knrZwXW14pBBJWuCGp9e8ARsbAZz6ZyvuJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPd96FPP78hv3K+RX8SqhYfSu/KA/Cns4Px30VvsvplnhTLIgFTZmZBgkx6Ac6aAiKhQH7BBKX1Q+SmWbvkSTC+c23mqX05rDHb9JYyEkCxySIARHgQ6yR3rUE3dPfUnOxwUaELRTpd5eAa+CrdEydeXCeNmXzB8kEPxZbdJd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IIe+J1UD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jgzc/uLviO7J54OVqHpsyMnCk4VTRuOJ3qugkDERST8=; b=IIe+J1UD8SkmQSXtqZvX4LjYxM
	/0Qpcshk2xUqgwE/jU5u5u9nB6ve8edCv9dFAsxYsM3S+wjJZD+ytsnuWIIx0lbtBnTmW70PGy/Yg
	dhq8BZm077nnWVQf3Ucm0qP01tA13M774TFjnv4b2zZekyAYVM0HKzbPVdH8lElXZSh8hnskU40yw
	9uQ3M1J73m7NhJRRDeKEZf514jrZ1G4Gdmzvj/8Vl9ladGZy6kRKzrMjnP+BJC0ha7VTjxjMn40Sg
	heqvJhzhOJfoe353S5xm8RhxMf8zN8UUHuNKHPTZDrBkvkarvSNRmIc3ZCCpFgA/4jVj0MqTUgQtZ
	LqmG04VA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53502)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syrlZ-0002IO-0l;
	Thu, 10 Oct 2024 12:55:36 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syrlU-0007HP-2r;
	Thu, 10 Oct 2024 12:55:32 +0100
Date: Thu, 10 Oct 2024 12:55:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/28] ARM: Switch to generic entry
Message-ID: <ZwfAtJfNm95sXgo8@shell.armlinux.org.uk>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 10, 2024 at 01:33:38PM +0200, Linus Walleij wrote:
> This patch series converts a slew of ARM assembly into the
> corresponding C code, step by step moving the codebase
> closer to the expectations of the generic entry code,
> and as a last step switches ARM over to the generic
> entry code.

I haven't looked at the series yet, but I guess we're throwing away
all the effort I put in to make stuff like syscalls as fast as
possible.

So the question is... do we want performance, or do we want generic
(and slower) code?

It seems insane to me that we spend time micro-optimising things like
memcpy, memset, divide routines, but then go and throw away performance
that applications actually rely upon, such as syscall performance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

