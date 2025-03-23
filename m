Return-Path: <linux-kernel+bounces-572723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DCA6CDCD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 04:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1811890ED9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A21FF1B6;
	Sun, 23 Mar 2025 03:14:08 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037E3C17
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 03:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742699647; cv=none; b=aTYLj+n/bD1IfGsMWhOF8hMRdIwl5I2CTBoJ528v9eUuEN6C837xYa0fr9j0sziDgY7EuYh/B4PEUiI/n0oLs4l1KIILyKvPiNOz4xqC56bB98vqAQ6kmZsknjR2UGXU/k1SX/ZuFyQFPQKnb8OdF9lTY9mXO0piA4xqQNARTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742699647; c=relaxed/simple;
	bh=7GveGCQCYTU5v0qgQ3tT1lOZjUiaVEx5E/VVh3TLFxY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0b9VkUrpx/nGW1x3TjCSnKtvGR6pYlknHtPl2t313s1MaKI0ibCY2+J3KpNRg/ft1bKZe8x5JNl/L5hIdkx6ePgyK23jWEBUR8iLgPjCGK4N7WM6VHN74lJ7/uax4jfTCI9oqgUBuWl7IlDyg6mCPiqe+766o2ag+is9vvRJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id de42652f-0794-11f0-8de1-005056bdfda7;
	Sun, 23 Mar 2025 05:14:02 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 23 Mar 2025 05:14:01 +0200
To: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, David Heideberg <david@ixit.cz>
Subject: Re: [PATCH] x86/Kconfig: fix lists in X86_EXTENDED_PLATFORM help text
Message-ID: <Z998eR-9QNL1R-71@surfacebook.localdomain>
References: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
 <20250322175052.43611-1-mat.jonczyk@o2.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250322175052.43611-1-mat.jonczyk@o2.pl>

Sat, Mar 22, 2025 at 06:50:52PM +0100, Mateusz Jończyk kirjoitti:
> Support for STA2X11-based systems was removed in February in
> commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support")
> 
> Intel MID for 32-bit platforms was removed from this list also in

Was it? It's rather hidden and not recommended as far as I understand.

> February in commit ca5955dd5f08 ("x86/cpu: Document CONFIG_X86_INTEL_MID as
> 64-bit-only")

> Intel MID for 64-bit platforms is a duplicate for "Merrifield/Moorefield
> MID devices".

-- 
With Best Regards,
Andy Shevchenko



