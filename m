Return-Path: <linux-kernel+bounces-519231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCACA3995D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0EF188A951
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759422F16F;
	Tue, 18 Feb 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o77uuRVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QgESSf/V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E241A83E6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875279; cv=none; b=GZpf1GmvD0K6gR4Xa3nyKHeN0D1spDqHuqEZALI8YsdkkGQnZKs/Wox8ue9h9ToMDrw2q2DBrg1UhWpePDJUmZ4DBociYEIbfS+Co2FNf/yIbGTDPxOeCvSrER2pu1Hyo1iEgNUAHUT71IkYboC8Up2IkTH4X51vdsn8xMt9NwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875279; c=relaxed/simple;
	bh=um5V+wPJbcZy5/duhKrjfbJ/N0p9R/g1eF+9GZJvmwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoiM9Y9E3a4iC8gO/g91kg+nRNEL0VxNgkMgOteHjoLg1xpgMnTXWK7R/xkorfQJjM1XRyqduysWHBLeIwdYyuS08Ra1MtM3vltsnlnV1Ct80hJcxihJ5e6hHeFK0XHhLTUjnggDGFuJRXrhIZHcYiiXT20l/9qnKNNUS8xJiU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o77uuRVL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QgESSf/V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 11:41:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739875275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEIAK/m7WrZyrJSsVGS/iVZPONh0zjc3OTiph0Kbp0o=;
	b=o77uuRVLd3jCKh9qnoWx+GZW8rCqIFvnPoihABC+skfI9jhfxYy09zZ3i2TcFHx8sRChuj
	h8Rkdo/h63UwxrAs0M0nM+5AMa2nFKATUXCF5C3vUM97myBGgnZ4loMI0P8YhsucM2PFut
	FbkTe8Kj4QfNFoLoqCowjH8V9z5O+MTUJ+iv+97fzrx8Qvw256gYQBUUxX+RVrbdLTzLlG
	9NC0PH+WRRLjT79lb199DxoEsn4YImsN/Zt3w5ym41bjYoouYgDg3ktVvF9ICeyYEX5B33
	8UHVkGWoSlPM7g6d+YFOegxixkqgxCkZ1NEwpP8kma7wbA+L/+Z7kXl23Kl7Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739875275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEIAK/m7WrZyrJSsVGS/iVZPONh0zjc3OTiph0Kbp0o=;
	b=QgESSf/Vee7lFLhMaetXJnky79AZ5lNHVJbAcxvK03G6+Sh444nQuHkAtbnv6bH7IiLclg
	Fh2Wk5W+vKwj6HAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mm: Don't use %pK through printk
Message-ID: <20250218113329-baca2d3d-5b2f-4f0a-8953-75fbba9bce71@linutronix.de>
References: <20250217-restricted-pointers-arm-v1-1-aaa0fb22e18c@linutronix.de>
 <Z7RgpaLeIPMQ7kgp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7RgpaLeIPMQ7kgp@shell.armlinux.org.uk>

On Tue, Feb 18, 2025 at 10:27:49AM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 17, 2025 at 08:38:37AM +0100, Thomas Weißschuh wrote:
> > Restricted pointers ("%pK") are not meant to be used through printk().
> > It can unintentionally expose security sensitive, raw pointer values.
> > 
> > Use regular pointer formatting instead.
> 
> ... which means that the warning is pointless because no one can debug
> it when someone reports that this has fired.

For the most common setups which using the default kptr_restrict=0,
%pK is already the same as %p.

> While I get the security issue, changing this is severely harmful to
> fixing problems should this warning fire.

My next goal is to get rid of the easy to misuse %pK.
If the address is really always important then %px can be used.


Thomas

