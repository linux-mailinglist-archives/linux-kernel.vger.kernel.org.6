Return-Path: <linux-kernel+bounces-227425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF912915104
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2C62874F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A519B5B0;
	Mon, 24 Jun 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HL+ctw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTGtUhrs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751FF19B5B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240533; cv=none; b=qsVXPgIsKJUSH0pcrn81VNas1DauJRpeVCP72BAi6MwsBPql9zTM/h3wYVwOxTty2scTPar5NTCIbC6kYt9x7XvY/mIX+5C5JpL7pAigz3baiE02IAAA8Jrf4D+fphf9/+xFZV2CmWlwVQMt6FrHC2XFpfopyvGmw3jtfFR4JKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240533; c=relaxed/simple;
	bh=ZuUZl/MdSwZobl8eVZMKnwCIh7akcs8oYeGYYfgAsXs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=hpnEF01wCyYsUNVymmYPOMKNFIIQw518QDCD+MXr33fe0oHbShZmlxDPmYwpywmewnWmir4y0xvVJQuw323hzQtOCjVJ8Nxvlq6gKu9yB9k+P4ACXsGZx6xDru8SpNb5tCF8sTEcV5Ea3x+69gsJMQCQ+ROvrSmSiEn7avCw29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HL+ctw2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTGtUhrs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719240526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=eW9JS4CRtD6TmnSj76hMtLfS9H5BnV1ORvXGhQ9awuE=;
	b=3HL+ctw2EUoVtEUjZvAPAclEnSOswzY2vSIZC+pzwpWfE/sI+Ya7viLGFWljQhfi8CUIYV
	mmQJEjspGgEpc1xOEEaiiqrEKedGW1AcbLGhMzlJvSkrWgn2mymc2ooBYxv6mQytFDCCXl
	j3y67I7XVhKQQp+cJ1LaFZmsqrB/kbG3M55xxQd2OIsFTlScYE9orjRTLt1FJL5vifBptP
	moRpgU9UpdN1Mw4Lp2oPMI4RhDwriTi13rAApd2z1X29E8j7sgGUTD+n9KdPqkSYP0p4Ir
	PGSil84VSj99ZAFC7C4YfKlBbkEKjaFsM4ndNFZRj0VW62VSVNeE+PCDlHdAfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719240526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=eW9JS4CRtD6TmnSj76hMtLfS9H5BnV1ORvXGhQ9awuE=;
	b=RTGtUhrsE8CbEp88o+V4L2qY9TmVLa3vXdVq0/U1Shy04rL6hX6urMHJkndm0HGA1wo4Ag
	6BZVCjmrcUa9EWAg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH 0/3] timer_migration: Fix a possible race and improvements
In-Reply-To: <ZnlS1QcFgHvJGm7J@lothringen>
Date: Mon, 24 Jun 2024 16:48:46 +0200
Message-ID: <871q4mflbl.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Frederic Weisbecker <frederic@kernel.org> writes:

> On Mon, Jun 24, 2024 at 10:58:26AM +0200, Anna-Maria Behnsen wrote:
>> Frederic Weisbecker <frederic@kernel.org> writes:
>> +static void tmigr_setup_active_up(struct tmigr_group *group, struct tmigr_group *child)
>> +{
>> +	union tmigr_state curstate, childstate;
>> +	bool walk_done;
>> +
>> +	/*
>> +	 * FIXME: Memory barrier is required here as the child state
>> +	 * could have changed in the meantime
>> +	 */
>> +	curstate.state = atomic_read_acquire(&group->migr_state);
>> +
>> +	for (;;) {
>> +		childstate.state = atomic_read(&child->migr_state);
>> +		if (!childstate.active)
>> +			return;
>
> Ok there could have been a risk that we miss the remote CPU going active. But
> again thanks to the lock this makes sure that either we observe the childstate
> as active or the remote CPU sees the link and propagates its active state. And
> the unlocked optimization tmigr_update_events() still works because either it
> sees the new parent and proceeds or it sees an intermediate parent and the next
> ones will be locked.
>
> Phew!
>
> I'll do a deeper review this evening but it _looks_ ok.
>

I will send you a v2 of the whole timer_migration series where the fix
is also splitted. And review should then be a little easier.

Thanks,

        Anna-Maria


