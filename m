Return-Path: <linux-kernel+bounces-376068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347619A9F87
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420D91C23B03
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F0E198E86;
	Tue, 22 Oct 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GmZP1Wbt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyHXdVwy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167E145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591489; cv=none; b=M8ZN+3zO0e8nNaf4ZtvfPMIA6WIh/EUSfh88S4Q0zKx6aTTO62QJPqJqzMEkPfjImSHEq6173PMd1OSQ+qpYQmtUEK8cJ7lbYDB+tQc1NYg8VpmyvaTBgtGaNlBhQa/gZCcYTTcUA5G7QiO1YHjWU4t35vcNptUXm+1n3pUDb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591489; c=relaxed/simple;
	bh=wqqgPEicIJguEb2jiL/mUEYUCg0aOrQlvHt0dFaReu8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7iE1/SGOf6xzcFtsml0XaPnb5jAxFz7GtwyxZn1mB456T673D5sma8KGNtYwhN1lWDCpEFodUD/2/2q86owNC4T3trhYvnZn+lHo0So0nerY7H+blzevq7RC91HekJ+wMvazEdEN4C30mto2v55BrRoKsr51Qc00PvI40EB/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GmZP1Wbt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyHXdVwy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729591485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqqgPEicIJguEb2jiL/mUEYUCg0aOrQlvHt0dFaReu8=;
	b=GmZP1Wbt5pgTTXfQLtiQpywq7bKG6kUznS2FTeqjqr141NsFjvuxpFz3zdGby/nenbnsz3
	uJK7GcxhbffDKiXelHF8hH4mUF87+2sGMfvPd8WVerlAsPOxsjw2qZj7a2zJ8dlArLiNCA
	l29kvlWwFgn0Utdkw+ddlwFHcPrmQe7OKl0W/+HxUvjixUHNWRI7UhR4Jelxrj51m8FCfv
	9gbBV442c9a09tn0HGqwZ8moaUKp+oqTVxN4+kMzbZEakIPtRJY4+4Xwls6ifcysUQ9kvr
	uS0A+CoatMhS41+Lu+rSE7a6hpjRPE6XJNBEHKFDfguRxJBt8lIbQE8kqbgxIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729591485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wqqgPEicIJguEb2jiL/mUEYUCg0aOrQlvHt0dFaReu8=;
	b=AyHXdVwyzdbXacMI08in420sg/M5uC/dcfqcwqesCdR3Dkpxx0AeZa+Dz1sBAdxy9pck6k
	t+nLuK7S04O2JBDg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, frederic@kernel.org,
 tglx@linutronix.de, kuba@kernel.org, ruanjinjie@huawei.com,
 richardcochran@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] posix-clock: posix-clock: Fix unbalanced locking in
 pc_clock_settime()
In-Reply-To: <20241018100748.706462-1-ruanjinjie@huawei.com>
References: <20241018100748.706462-1-ruanjinjie@huawei.com>
Date: Tue, 22 Oct 2024 12:04:44 +0200
Message-ID: <878qug78sj.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> If get_clock_desc() succeeds, it calls fget() for the clockid's fd,
> and get the clk->rwsem read lock, so the error path should release
> the lock to make the lock balance and fput the clockid's fd to make
> the refcount balance and release the fd related reosurce.

There is a typo: reosurce

>
> However the below commit left the error path locked behind resulting in
> unbalanced locking. Check timespec64_valid_strict() before
> get_clock_desc() to fix it, because the "ts" is not changed
> after that.
>
> Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
> Acked-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

