Return-Path: <linux-kernel+bounces-568384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20FA694A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FC88A2ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1D1E1C3A;
	Wed, 19 Mar 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zOwMfYiw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CYmRdPjv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602823CB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401002; cv=none; b=cxXEjmjc9omBwSX2Sl3CRlLXY3x1WvHdYRL/3PWmPCH14UXqU+PabZfICp05zNzDgd0MdZQVvlNjmOBiZ7Hnblh7+MDmKEZolagOa9SKBUNJPlARtpF0GzBO1htv/bj1/UViOuHBLXUr2FSioXcOJ/lVf/NqWKgRR2WbnGyXgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401002; c=relaxed/simple;
	bh=I48t3G+zI/DqaZbmsbXC24iEmLF1ScercaVRJJZw/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGj8CEaL/Vc1HW4o2EvVDK9s5zkb7ST6yXSDuns7/4RiBChKVftvOXecsv9faFRkke4WTaFrdYi6IRKLF8hu1sDUy9NN1IsCBQ5Drh3CV5XtA5uTnJzYPNrdFFes7e2AfJUN6Cggl1JnNMhTgtzW6Sj6Z5899FfB3rd0dSr8/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zOwMfYiw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CYmRdPjv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 17:16:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742400999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5ALVHkpdt7i16xvL9Sq6iWXM43kC76kXA1K3lnVR4k=;
	b=zOwMfYiw6lG6jNRVOrGkwyZZrmareTnzRKR8hunLu3dpvuijW+OQJ3oGxhtQi+Sxf7hk9G
	SLA9zl8Kh7bEl3h7HGOmezhbcKXtmkTyXYrXuG9S6t8Ax86KvcX9n6WSn9qPIgiE0RK78l
	HPMOdUoTt++RpFK9jtlZ2Y5ozZqoqjpzOE2kR0jnUrpDOWybCHqj+JLCZBegcK3gNS9IUI
	9ZzG0yo1N0U+hiZAceLGaQ1MA46CwMMHDjcPeCypRELhulQBDjnLKo3pN8wWu19cxYIVIc
	wZZ9Refm6080Z+LvKdHCo5zmLrGJSdRi4mSQUX2ayE2RLahIQi8H8XeVKAjj3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742400999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W5ALVHkpdt7i16xvL9Sq6iWXM43kC76kXA1K3lnVR4k=;
	b=CYmRdPjvK0RG3lBt/kQd3/vl0FIJRQpzNDaWlJo+39tpEh+dDKzS4FpNZmUEgzl1JBMSec
	z8vtWfL29RjnYWAQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, oe-kbuild-all@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 19/29] x86/cpu: Use enums for TLB descriptor types
Message-ID: <Z9rt5Umvps26qqjR@lx-t490>
References: <20250317164745.4754-20-darwi@linutronix.de>
 <202503192339.PuCOnZaa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503192339.PuCOnZaa-lkp@intel.com>

On Thu, 20 Mar 2025, kernel test robot wrote:
>
> arch/x86/include/asm/cpuid/types.h:56:1:
> sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>

I'll fix it in v4, as detailed in the other email:

    https://lore.kernel.org/x86-cpuid/Z9rsTirs9lLfEPD9@lx-t490

Thanks,
Ahmed

