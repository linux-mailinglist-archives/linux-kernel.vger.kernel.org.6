Return-Path: <linux-kernel+bounces-547221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F0A50466
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1CE1883E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F515DBA3;
	Wed,  5 Mar 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="orXjR8AV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qMZAhEYx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22F2E3361
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191517; cv=none; b=IFyVPMd9oKIOcBhRUyuGHyO6Rh13shU2mNRheTVyJsLg160IXRMlmVkGziNCSIxqUvxqQtP81njMNY3hF3DwHPOdWo6ETNcsq3owogJ4IwTd+WF+h3uBvZEHpCYmaJGwJ2n5spp8ve8IcM5HtPlV9xaf7JIaYdefdlGP9q6ynhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191517; c=relaxed/simple;
	bh=+BPUt8lHDc3+pod8h5vk3760BpjXxiNMN6F5ieHmpI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odcNz5UHQrgnlRIaxvPXqlMoTadjjoHotdd5vFO58PBcz94YaFOk7tTn1SMmehltOiD6ctTiSnKszTzllRYOeVKsmcGKMgJtJcGOBPnG2hAHQYbkC4zLktOYVbHaEwY+66Aclyq89fg68vxG+h3DhNBJF+clnBCvfB8WBY9E79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=orXjR8AV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qMZAhEYx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 17:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741191514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ69AeXYPTOT/EG4vDrbaZmzkRTmmMycyz4TxqzIVco=;
	b=orXjR8AVB9FAw6U1sFUzFNVGvKfQGQ037gCU+OkS4kNT+bardxvkqwoGdUzLuP9V2047a8
	iSdwIIPoHZKT6mieSZ/Oiq9xtFcNr3anuZsodriWwWUVJwThSQhPVKQvCHmN4WFDrfT1uz
	/t9G6cIGe/2JstIYCNgcKPAdr9h8b+L7ul86T6yxE4NECIRKjinb25qGxhePzoZniL3EY9
	L5YGM4XRnVsJwNwOhAOGQCcVxswOg2LMBgHo6Yr0DS0fi4XveldfxS9mp30s7Mfpu6cUvB
	AiLxv5Sz04VMRRU6Ah3ZdMEXogEUIs067KkAxL6oE7kNITw/j1xuLEy+HCg4TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741191514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ69AeXYPTOT/EG4vDrbaZmzkRTmmMycyz4TxqzIVco=;
	b=qMZAhEYxxBcHohs1muQ+wBkQRw40Zh+UYpJwMbWK0bAkVO3W/FUpqkqfxYeig9ZeETHYms
	9aNJ5LIBYGNvCaAQ==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 30/40] sizes.h: Cover all possible x86 cpu cache sizes
Message-ID: <Z8h5WGf2BnQs_9Ex@lx-t490>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-31-darwi@linutronix.de>
 <Z8bJb_NKdIh8jQkt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8bJb_NKdIh8jQkt@gmail.com>

Hi Ingo,

On Tue, 04 Mar 2025, Ingo Molnar wrote:
>
> * Ahmed S. Darwish <darwi@linutronix.de> wrote:
>
> > Add size macros for 24/192/384 Kilobyes and 3/6/12/18/24 Megabytes.
> >
> > With that, the x86 subsystem can avoid locally defining its own macros
> > for CPU cache sizs.
>
> Please take some time to read your own changelogs:
>
>  s/Kilobyes
>   /Kilobytes
>
>  s/sizs
>   /sizes
>

Sorry about that.

I just don't see my own typos, no matter how many times my eyes actually
passes over the text.  I'll integrate a checker in my workflow.

Thanks,
Ahmed

