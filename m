Return-Path: <linux-kernel+bounces-551333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CDA56B34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58113B4C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383721C187;
	Fri,  7 Mar 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfWt7KhR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gBlER4Vn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DA218AB4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360031; cv=none; b=MTxx8Jwo0meOutw6vInDIG3URJEHII2T88GSoW94t5OMMnIpc//3OSlXnqg2XcSGiMtRr+owvIo+NleGG2wdN4P1r1lSnOgrJ4Ob3JNgkfDCwEOzhDsXT/jGgbB0llyT3NUhViBfz/LNXgVw1ucqYiytMRL8Antcz0SEf6YzL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360031; c=relaxed/simple;
	bh=K81qHcFj6LyfMm5ZG4lzsBZ76BNWPEyWlv/v9Xx/4oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0ehCA7kGFVLpDLrmKspaVqqMN5ctZafUOn8uoZhyki+UQWdiY/yqwz3A4mEouZ5oQ2uVd2sZoYEs4sVKTsGz35XrgTxjVw/Z52J6t4phhbGPZ6eLepwTcVPE1KjtoztrQtJzMUbX67DVYXFbLfa84Oj2EMlu/8lWdC6mfAxMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfWt7KhR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gBlER4Vn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Mar 2025 16:07:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741360028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4OXppOUTNWbHeKmQNaA4fWquj1UNfzSqj7kwRoiD6Y=;
	b=nfWt7KhRFQ3ME/0F4O3+ADqmO7g01JvYbadQYxyEcZYQUYmn5jdeLDllYbz4eTjNLN2QyT
	7VgxZ2BfTNV113JT8eLbBYHiuY5B4nFmthRBvHAnDSSvgB81aCSTmll/mfB4x92IkJ2BxC
	IzA7jNx39KvZvmNi0fAiTDcDmyYekDiPfM2LD+Oi0euL7fZ1rxZt2gpSyjkT6dQnlNF9IP
	X1zAOi6CQlEKpD9ghHN5uioQKEjd92uTv441+vuJPhX55Gaxt9jXS97Lr6Sb1jvMph6miR
	KEA0CUuBOwXjFFATyBIIwG4nn/wpqDHIV7+tiG2H5hjXy1QFKlJnPDzzcnEp3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741360028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4OXppOUTNWbHeKmQNaA4fWquj1UNfzSqj7kwRoiD6Y=;
	b=gBlER4VnRTO8k/GMM7Q8cO2TK04eVOOB87mzZh8BvAdhgrd2RBiMWHzVUzg+566VNfvq7g
	EnCs6amj75r50zBQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 10/12] tools/x86/kcpuid: Update bitfields to
 x86-cpuid-db v2.0
Message-ID: <Z8sLmGf2L4mszUEp@lx-t490>
References: <20250306205000.227399-1-darwi@linutronix.de>
 <20250306205000.227399-11-darwi@linutronix.de>
 <C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C7684E03-36E0-4D58-B6F0-78F4DB82D737@zytor.com>

On Thu, 06 Mar 2025, H. Peter Anvin wrote:
>
> Leaf 3h was not unique to Transmeta.
>

Thanks, I missed that Pentium III can provide leaf 0x3 as well.

It seems that leaf 0x3's format differs between Intel and Transmeta.  On
Intel, PSN is at ECX:EDX, while on Transmeta, the PSN is at EAX:EBX, and
ECX:EDX on non-evaluation models provide the rest. [*]

Unfortunately, so far, x86-cpuid-db does not support having a CPUID
bitfield with different interpretations across vendors.

Given that Linux force disables PSN at early boot, I'll just remove that
leaf from the database — for now.  (Time wise, finishing the new
linux/arch/x86/ CPUID data model for mainline submission is a much higher
priority.)

All the best,
Ahmed

[*] "Processor Recognition", Transmeta Corporation, 2002/05/07.

