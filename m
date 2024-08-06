Return-Path: <linux-kernel+bounces-275878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC9A948B62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D0F1C23152
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF791BD00C;
	Tue,  6 Aug 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="agqLfE/b"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECB163AA7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933294; cv=none; b=LMH5YAegnRxduPUqzG70H1uDKN5+8J/GL3NlTxtaqiFAmzyRmYcAFI9TWIOd/dmMXmQqMqAyu0QnScgWhseNV8RRuYoIyjPYssvTeKuOhxD4s2VW9iGhzJoS6S+28Yz8B4jee2GqDvSn9dCcuT78NzVLkhQDeWfIB/+whGHzUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933294; c=relaxed/simple;
	bh=BaHrcKDghwPfb0F2etM4FCtPaaEtqHzH8y92MezMbHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyjrHl2VamYuwLKkAIko2mXyMDlvgUFZDXmZAcNVvGRzOJHLoiy+uKBbPRfUy6CTadIfqIVeryRZSKnMjufAxFc/C49XrRIlSEGkY8q9V93J5Oc6mNbbaEwlFpm9WGXb4HVx/AtBTkkBUSfM4HwIE5ddGZV/FknxTEYlr2r/1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=agqLfE/b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6a8UVs78b8Kbnh8esRwUDysH0sXB9nMDXzMjC+Yj8WM=; b=agqLfE/bqeTfnGM0i9TRH67frb
	r6OVfT2d3A45dHBABoMMa+Xabhdzi1kQ1gNS0ZET2twKmiAOODaOg0WZaZW84vNpUfmv/egh8Mvf4
	o0+spDamwvdeIp4JWUL44pGIOunP63tkUUmgdz65mzxX3iq8kpZLpWpgkdjlRPUnZQBSaDvqTkc8+
	eMsYuZx53gjzpVyWHL+msEC6z4kfDkFxzndD7pXYlU1mWs0cXmzmc9n7fMUhluuw8ej43L+kHkpGo
	zmLVL9MZgG9e1JgJ5hNPhlhmOQ3C+Jsb6/b0FS8KagHvXkSpUnhRu83V9hpNrWV76G4wWE0Ez6oBj
	4or0Wfxw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sbFeP-0004IE-1I;
	Tue, 06 Aug 2024 09:34:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sbFeR-0003CL-WC; Tue, 06 Aug 2024 09:34:40 +0100
Date: Tue, 6 Aug 2024 09:34:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Baoquan He <bhe@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Message-ID: <ZrHgH9hFADBJrtJ6@shell.armlinux.org.uk>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
 <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
 <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
 <8f051483-46be-87b6-03bb-5e0d145a2ac3@huawei.com>
 <ZrHasuAXM2Ph9V5p@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrHasuAXM2Ph9V5p@MiWiFi-R3L-srv>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Aug 06, 2024 at 04:11:30PM +0800, Baoquan He wrote:
> I am fine with it. BUT have you addressed Russell's concern, e.g how to
> test it actually?

Thanks for bringing that up.

Let me reinforce my position on this. I will _not_ be accepting a patch
that allows the crash kernel to be placed into high memory on 32-bit
ARM unless it has been thoroughly tested to prove that it can actually
work.

Right now, I don't believe it can work as placing the kernel in highmem
likely means it will be located *outside* of the lower 4GiB of physical
memory which is all that will be accessible when the MMU is turned off.
This is a pre-condition to boot a kernel - the kernel image _must_ be
located within a region of memory which is exposed to the CPU when the
MMU is turned off.

Unless it can be proven that placing the kernel in highmem means that
the kernel will be located in the lower 4GiB of physical memory space
with the MMU off, then further work on this patch is a waste of time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

