Return-Path: <linux-kernel+bounces-249451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4972A92EBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB85B237DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046F16C877;
	Thu, 11 Jul 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mgue9FVi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3VD9vjD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121228FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712647; cv=none; b=XlG7ebFmKMfYjhL7m+NmjttdmMULrSGuPeSuNYJeQj7dSYDRfg2+jlm4za/e6klD44kRT2naPHoRk1EUWnYJdryIp5LdXD6OtYViCIbnYhBjWtYyJq6emn96fMaVsbeJ7dh2S4jHlpfKau2Ey/Xa0atWvqg9iA1irS9tUNnqjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712647; c=relaxed/simple;
	bh=Fbo8YKOfE/vh2gPWfzfDfW5w9421Jxqaucc+dHoI/DA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=UuFD+bgp3Pd+//0+4pmRV9UhvoqoFwOJk86ymloNwgIN3AKYJVERMNMelFcIa2PLpPwSuBDS28/RulSNx+tu2QoB0TrXd9QLXm5iTeLVCe1V1RVVGX1S7tKIz2Lf6NiAEFlM0eDjmDOoRlmxyR3ka9pC72gIBG1kmJtR+3t6I4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mgue9FVi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3VD9vjD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720712644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=gsVCOIP7ktdqEeTkNBsylOO6Eu7vpCJrbAXHMxMmpIM=;
	b=Mgue9FViQCazBmkx93u1E4w8K3D0uIrSEofvXBrMAd7hiJXGxUjXIecZfzrXrJyDPVJv3d
	XeIDADRXpB4/vAArli0GfJVfphnH5P90OU9L50GodlAV/qQpozOYM5vGvXNW/b5N6t4jko
	nUxZsULLGWwR0aGP3tW6PrDYSNuSdkparpkm+9wcemiHIfhA1QRiNthhJE2exdyyH0W5/o
	hCjcJr63ma2QBFL/ATAD4akVes7y5e/MBNSgD903AIcTY213RC5Wp8xL8RcikmfEoExPY4
	kKEPDasrHZdnvAKZHleEgB2bgrKH0EX1cC3XOXCuxbHK2i42t36Kjoy9Opg5KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720712644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=gsVCOIP7ktdqEeTkNBsylOO6Eu7vpCJrbAXHMxMmpIM=;
	b=n3VD9vjDskNbsBwRHE1QN/krzrfmQxHmPJDxvrA5BfzmduifSEMU7AtXChemGlcvnlzYyU
	5GsjQQAsyeLFgWDw==
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 0/8] timers/migration: Fix three possible races and
 some improvements
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
Date: Thu, 11 Jul 2024 17:44:03 +0200
Message-ID: <874j8wc4sc.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

(cc Oliver Sang)

Anna-Maria Behnsen <anna-maria@linutronix.de> writes:

> Borislav reported a warning in timer migration deactive path
>
>   https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local
>
> Sadly it doesn't reproduce directly. But with the change of timing (by
> adding a trace prinkt before the warning), it is possible to trigger the
> warning reliable at least in my test setup. The problem here is a racy
> check agains group->parent pointer. This is also used in other places in
> the code and fixing this racy usage is adressed by the first patch.
>
> There were two other races reported by Frederic in setup path:
>
>   https://lore.kernel.org/r/ZnWOswTMML6ShzYO@localhost.localdomain
>
>   https://lore.kernel.org/r/ZnoIlO22habOyQRe@lothringen
>
> Those races are both is addressed by the change of patch 2.
>
> Some updates/cleanups are provided by patch 3-8. ("timers/migration:
> Improve tracing" and "timers/migration: Spare write when nothing changed"
> are the same as provided by v2).
>
> Patches are available here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc
>

Thomas, please remove this queue when possible from
tip/timers/urgent. There are some things broken and needs to be
fixed. Otherwise we get a Fixes-Fixes-Patch. See report of kernel test
robot:

  https://lore.kernel.org/r/202407101636.d9d4e8be-oliver.sang@intel.com

Two main problems are:
 - wrong CPU hotplug state is used for prepare in cpuhp_setup_state()
 - using this_cpu_ptr() instead of per_cpu_ptr()

Working on preparation of v4.

Thanks,

	Anna-Maria

