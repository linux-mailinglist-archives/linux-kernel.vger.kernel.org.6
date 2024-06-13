Return-Path: <linux-kernel+bounces-213443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A06907570
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9841F231B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2446145B2F;
	Thu, 13 Jun 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTX0lJj1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESLAE//P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6974146598
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289638; cv=none; b=YgMfpK4qo+kCaR61iZAGliWBy/+EUcMQRwBFOIkQXmB9xp9fwFkT/LAKfL1gRQJnCqcHw9/bMp7DD9grUPt0PAkMC2GOtPcEiyAQoq2IwCXVSP31l3Zlm9fiQSCCFIAp9UVfm9vbqUZ602JyMYMOTJyu7CqyxS7xDw7vBULTvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289638; c=relaxed/simple;
	bh=8eap8VUfItT/YZ854UrE27SSqOujjOEBdEbl/8rGOaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DN1c9be4Nmxjdg9MDIqaeqW3U99/hYUiwOkX8oKQZfGxiagirS+IxkGy0FytfUHtgLPh/0/JaDs1L5dwgkbBnSN61XOQ7lNAqTWqOF7hUHddoiLGwSCT9Jflm1mZL/S9q6R0kmB30OqBHAqQN1aXoExNndIbApu21E91b6qmXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTX0lJj1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESLAE//P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718289634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZZKqIZa8LpMpBMJeK4UkZIyqzDHa89DLPPeFmhbgkk=;
	b=dTX0lJj1niKJsTKr2z00t/wrL0ocvPoBfR0q4Ag4cbX485kFNrh4zvYR4L9mqQzNNiSy2G
	3+Pfy90OXzyynxOYIMvpXqlosbdNjsEg6+THdFSiOfNzN0VypLIfqfkODzgYBeFx9hy7JV
	CugNoHAcdi/eOt9ShOWJzfi+/3PD7eU3bXfBfodCucHndjUMfC4ORmPAsnH0mrEwptqSgl
	DQsfS7JLBO9jjTJqxT1lj6PyG6o0dApit4JaiJhwWJklAFf/PVM/CZXKtipL+VVrncACMh
	J0/WByr2U9KGLBnReZ43XX2xIAdqMRAVdoCY1SlHI6ceh+EUyQngGWYeTqPUkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718289634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZZKqIZa8LpMpBMJeK4UkZIyqzDHa89DLPPeFmhbgkk=;
	b=ESLAE//Pppun/KPWB60BOw0kO9Wqfa8Y0tCL6uZgE2XUsn491f22zzmTX41oxU/H3Cl7sO
	Tcz7ZpDHSegUtSCw==
To: Borislav Petkov <bp@alien8.de>, Frederic Weisbecker <frederic@kernel.org>
Cc: Narasimhan V <Narasimhan.V@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 7 PID: 0 at kernel/time/timer_migration.c:1332
 tmigr_inactive_up+0xd2/0x190
In-Reply-To: <20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local>
References: <20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local>
Date: Thu, 13 Jun 2024 16:40:33 +0200
Message-ID: <87h6dwzz1a.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Borislav Petkov <bp@alien8.de> writes:

> Hi,
>
> one of our testing machines hit this today:
>

thanks for the report. Is it reproducible? If yes, might it be possible
to enable the timer_migration tracepoints and provide the trace?

I have a vague guess, but a trace output would definitely help.

Thanks,

	Anna-Maria


