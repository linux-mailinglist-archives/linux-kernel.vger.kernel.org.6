Return-Path: <linux-kernel+bounces-239727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77309926495
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229B91F242D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58903181B9F;
	Wed,  3 Jul 2024 15:13:08 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FCD180A86;
	Wed,  3 Jul 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019587; cv=none; b=HQWlftd8Nmo+NBNjA/ChMrJ5Ic7CKkn5mwOL21Rr9PS3wdDyAcxzLCh8HHJiaz6+KBxWljEeQ4/EEh0iMG5Q52q8TlVZPRZq+/IpBTOwcvn54Olr1OSjnhiHjUyUVDVV6dwsyMv51dE5tC6Jt6wg5qx8StyfiCTFnubFrcWJzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019587; c=relaxed/simple;
	bh=jKTmlKxi/yn3cFG5v91xEFOOukpAGESCC2WZcF+oqLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvv11adozgLWpq7aiZsH+APDcfIx4gn79S0w/NFdWVRg27TQJX/LPju/9CkgkKaLmVTssjND3CARwWBiF3LqRctdcwk8d2C051E13GzIO42pE4oT9J/94ObJ0sCRYN1kLCMeYqZCU+LzdAoMi59gj7nemuPuKTgNuxQNHL1g7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sP1eq-0000BL-00; Wed, 03 Jul 2024 17:12:32 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D500DC031A; Wed,  3 Jul 2024 17:11:38 +0200 (CEST)
Date: Wed, 3 Jul 2024 17:11:38 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: smp: Implement IPI stats
Message-ID: <ZoVqKlpQ5K+w3VDn@alpha.franken.de>
References: <20240616-b4-mips-ipi-improvements-v1-0-e332687f1692@flygoat.com>
 <20240616-b4-mips-ipi-improvements-v1-5-e332687f1692@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-b4-mips-ipi-improvements-v1-5-e332687f1692@flygoat.com>

On Sun, Jun 16, 2024 at 10:03:09PM +0100, Jiaxun Yang wrote:
> Show IPI statistics in arch_show_interrupts as what RISC-V
> did.

it probably still does, but either this is usefull on it's own or
we don't need it. IMHO it's useful, so drop the reference to RISC-V.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

