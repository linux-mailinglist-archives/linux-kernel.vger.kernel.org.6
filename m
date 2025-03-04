Return-Path: <linux-kernel+bounces-543690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B32A4D8A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3C9188EC20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C579F1FC7D4;
	Tue,  4 Mar 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSRXsKon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cD4mHs95"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7161FCD06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080531; cv=none; b=Bp9edrzmtKB/kvhqj1qPOr3kaplMVB01d6ooFxZDYLW9+pDsBfnz/DZOjmX5UhNfDo5i5jBdJOVOW+OI6HR9NaP3me9U6JU9fc+zUnAhr0UnqsYXKdnyWN2uYaHXSC3AWb1NJ/6RAqjZjQZsTCPLYqVdfmgJaS68H/N1LKdQC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080531; c=relaxed/simple;
	bh=NN/jF2K71fBQKoNartJZu5Q1DPuRsEOcnXVTdidkoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqDj3WoOfGLib3J0wjhk6zjN5kL9clV4iEGev3mt4FfSpfeM0EHdIZ3n4AwLIf2r/Dchz9caDsXETruwK30UE/uD6kxIyfsChc+j3G1R72bxWs4v4ewKAIOvg8LPVBNl5R01ahnbUboMlwSq8S5ALM9FFbprg4mA0lrCZlUoe8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QSRXsKon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cD4mHs95; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Mar 2025 10:28:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741080527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDIQ41H8uq3SlJZIpmnYfmJNWfvZdJsc7pN3IQwF/JE=;
	b=QSRXsKonapLYEA0jCtYenQAiI3ECQ+IZ0+LuoGxVSEGYnbI6MoQZkDVzU2edRk+NdYA3nc
	D6r+smrk8dWNHyk/vmSme7Wo5TRR+5KGtUXddlGfcDTXBXzE+X9Ow4rj3YTCfteOm7NeRT
	vqhdhh7oHmD8SxtKpXHAvl/gxlsvrDn72o9ZJdd8qBjDZi2NcwEma5RGXqixV+/S8LEkOb
	++t5ValeRLysfmPTOHK9q+20CKPiwhlfKhccbrsbAdt84Jfv+B7BZMpsTw/XTyADtLPm4L
	aX9Offmm6ME2AYdXcJlpV7Eg4eEtFDPpqyu9Gto18Ij6/lLGBs2W0Tsqr4/wfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741080527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDIQ41H8uq3SlJZIpmnYfmJNWfvZdJsc7pN3IQwF/JE=;
	b=cD4mHs95p5GK253fsRt6hU47Vx0ENata0S2Nw77EzbHn73tg2e8xjFIZXy5eg6RGXln21s
	PenYsU6YjK/OnsCw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 05/40] x86/cpu: Remove unnecessary headers and reorder
 the rest
Message-ID: <Z8bHzaFjfRcZOKer@lx-t490>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-6-darwi@linutronix.de>
 <Z8bEiWu-Vvu5844p@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8bEiWu-Vvu5844p@gmail.com>

On Tue, 04 Mar 2025, Ingo Molnar wrote:
>
> This patch has an unexpected side-effect on i386 allmodconfig builds:
>
>   arch/x86/kernel/cpu/intel.c: In function ‘intel_workarounds’:
>   arch/x86/kernel/cpu/intel.c:452:17: error: ‘movsl_mask’ undeclared (first use in this function)
>   arch/x86/kernel/cpu/intel.c:452:17: note: each undeclared identifier is reported only once for each function it appears in
>   make[5]: *** [scripts/Makefile.build:207: arch/x86/kernel/cpu/intel.o] Error 1
>
> Due to the removal of the <asm/uaccess.h> header.
>
> The attached patch fixes it.
>

Thanks a lot, will do.

