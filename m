Return-Path: <linux-kernel+bounces-412525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BA19D0A12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B75282557
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846E13D279;
	Mon, 18 Nov 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hd/QvC5e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+Gm6KFJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBD15C0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913793; cv=none; b=Al6yVGb0F8cIPSluPt3Ero0nTCtZxms7OAvIZRd0v7IlNSj5B5fCqDFv1WeSnVxFVLCU67OR42DD9+wqPArTEsXnwWAFXS85nzjwWuJ+H4/kOJrV+q3nmCokWjxHowvKHw4LS48avyYQ6D/A4mqxjlXLjuXrgskUSlx5c7jJ0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913793; c=relaxed/simple;
	bh=0XF9IxOkZ37BXw11NSjsoy/uw7fph1Fz+H0GeRhncNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSNTQ2veGBzBWqzWGGYhxc5Verf1EvwI0uVwWM8oojBEotDvKXI+84mQrx/ksKa/6ciu1Whi2HEJze1uIckFms7at5SA1nuzzd2Y8hIEbcCDSdtNsSEXAL+teuLKVsL7jrabDJq0CF1KWphSw+4E1V2oXxNXTFySnvKAPSsXMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hd/QvC5e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+Gm6KFJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 08:00:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731913237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oF5pOKmdQCV/D0pgaED0/XtFmy0l+sX6C2AEp8x+rhs=;
	b=hd/QvC5ePU2BoRKlRKMSF8eNQXPXPIp+AMyx0AqzS55fg+MZkdgI63wew749KsiJ9HQxJs
	/4zIWiIBFoN3U68jTfyYVVAavvWZsc6YV5ZT5i3pLpRhEuleX7g3JfYwjzKekgriIDEeRF
	TSlwZ3lnbIZLnAIdJmN46xU/kdG2923xLnf/R6WqL98g73OvxnFb7AX5RcuMnN0aR0O1ud
	LSSjzMMsBiRBvfSEB3pk6C/xIA5CLmtI6mR2Nb0k/PStsUzr344a+zPxPOrBwl+AyFCMIW
	QBar7txXUXXY3v7wyk9fbiyCliEvuegYxrXLoKl70VXZFRq+eGUaY2uQydT0mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731913237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oF5pOKmdQCV/D0pgaED0/XtFmy0l+sX6C2AEp8x+rhs=;
	b=F+Gm6KFJNo6WSUjy3CL9r0U73w9wGA03l4ySeoI1nM4Rh5+c2P5zuGwktkiDDWgkQ6mdy4
	Ih9bpFaZAjb4GiBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso: Remove unused clockmode asm offsets
Message-ID: <20241118075902-8b0cf2ea-d772-4c05-9b5d-14aba194e649@linutronix.de>
References: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
 <173184539749.890800.8297350541963703609.b4-ty@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173184539749.890800.8297350541963703609.b4-ty@ellerman.id.au>

Hi Michael,

On Sun, Nov 17, 2024 at 11:09:57PM +1100, Michael Ellerman wrote:
> On Wed, 13 Nov 2024 09:06:58 +0100, Thomas Weißschuh wrote:
> > These offsets are not used anymore, delete them.
> > 
> > 
> 
> Applied to powerpc/next.
> 
> [1/1] powerpc/vdso: Remove unused clockmode asm offsets
>       https://git.kernel.org/powerpc/c/d7a82238cb8c77d4ed8cc97cd556c5f3e64bc749

Thanks!

Is there any chance to get this merged as part of topic/vdso?
My vdso rework patches for the 6.14 cycle rely on these removals.


Thomas

