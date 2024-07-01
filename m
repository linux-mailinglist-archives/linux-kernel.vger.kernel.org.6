Return-Path: <linux-kernel+bounces-236569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF091E426
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613091C2253B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213516CD30;
	Mon,  1 Jul 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NB2G6Gq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O2OOo8mN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6F1667E1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847920; cv=none; b=TNgcf3+wGwNAtoSO0aPz2Oa764qgTcbARJ1By2w5afx7EyMwhIzEKMPjdHu7fYIVGnWzC2ybZ+iqFDUUGnBzgu8QhrrITCzrxmPjmpgDfhqTFCUe6cDk37ShI11krPJpZM+XQB6NrH3ZSnqYp3iFUYHZaOIIn1Hf/rCWmbXq1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847920; c=relaxed/simple;
	bh=pBefBFQISj+SLPUpRh65IkIM1bQiuIkiZ3Yx/rBLESE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TGS8mIGHOX5BM0a9q47Cg4Na+Bom7AcXvINACUc7YdX1PYCcejV7YIm0dsTJ0olqj4jy8/1Ye+bJed/taD3QZGwUOSaJgnwXEYXVy951eqDi9NjYWBIFwB/IdlAh5WrY3fegO9ZlSPtyeySWqoZQzlPtLwhvSKN8URsaT6MCQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NB2G6Gq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O2OOo8mN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719847915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+kA/lXdJ25YFJXZIkbkmPwC4oxjPacNqt89/eTqigNE=;
	b=3NB2G6GqIjVscVO4SWn1DY07cpTyHhcXRWz5P0kXe2qb9Fvs9DMlcQhGbhGVgojubTgx8i
	tv3KE+CFD08Y4Q5ANbCuQxhYuQkeVHpiMgqoWmURzugqTEuuQCVy8Vd5D9vGS+dXNTxypx
	rJSs3WGcv6Ae2D19wh0WKFMEqXu0girrvTH0RDVv0aayd3iL27XMOgYrmw78M9wvSPRYK4
	RkqBRIq7Llyj/Sld3xv9l7tygaNij6WYNgmOQqiqQ7nXu9vINx1/7O/9hjhKqlDqjc6WKb
	3hkcVtGZVFTDV/iHyyL2JdK9Btt+Ln9s7nrgj92GmCfg9VNTLfgbEPbUrAhxGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719847915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+kA/lXdJ25YFJXZIkbkmPwC4oxjPacNqt89/eTqigNE=;
	b=O2OOo8mN8OK4sibdmi2iuhdbwuUyuRqBi8pO1z/7NEh8JD4+D5eBt/IOBDBlzeVpzIIckV
	gQvYdRRzUXEtLPAQ==
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] vdso: Add comment about reason for vdso struct
 ordering
In-Reply-To: <ca4f5359-0999-440b-be5d-becfe7f500c8@arm.com>
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-2-36eb64e7ece2@linutronix.de>
 <ca4f5359-0999-440b-be5d-becfe7f500c8@arm.com>
Date: Mon, 01 Jul 2024 17:31:55 +0200
Message-ID: <87jzi5p1qs.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:

> On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> nit: Can you please add something in the commit message?

Sure, I would propose the following:

The struct vdso_data is optimized for fast access to the often required
struct members. The optimization is not documented in the struct
description but it should be kept in mind, when working with the
vdso_data struct.

Add a comment to the struct description.

>
> Otherwise:
>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks!

>> ---
>>  include/vdso/datapage.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
>> index d04d394db064..7647e0946f50 100644
>> --- a/include/vdso/datapage.h
>> +++ b/include/vdso/datapage.h
>> @@ -77,6 +77,10 @@ struct vdso_timestamp {
>>   * vdso_data will be accessed by 64 bit and compat code at the same time
>>   * so we should be careful before modifying this structure.
>>   *
>> + * The ordering of the struct members is optimized to have fast access to the
>> + * often required struct members which are related to CLOCK_REALTIME and
>> + * CLOCK_MONOTONIC. This information is stored in the first cache lines.
>> + *
>>   * @basetime is used to store the base time for the system wide time getter
>>   * VVAR page.
>>   *
>> 

