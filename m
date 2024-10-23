Return-Path: <linux-kernel+bounces-377235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3147E9ABBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00BA1F24450
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8B3CF73;
	Wed, 23 Oct 2024 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jlY+sOSi"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FE917F7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651614; cv=none; b=C8a/DE66o/xxbs8Nbin7RPNi5yttmGpjARzeVtxG+wh6u6MqYNnD/wi9pGdvEsdCNLI+v9YGk62Np0VvQ1SKsCMoRkbtY6Eb69HeYWP6/sqZaQ5QNPZvUbbjRuL+NA8sEKYFB3/MVluvF/OIPe7KUTjAxTVhCPmwlaW/GDiGSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651614; c=relaxed/simple;
	bh=qXHyjnLdTMaTeRNvxee+MbwqwKvhwKCS49a5shfc/+w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HgJWn744gUKzcIdomi+RuZ2CYwKV6GZtq560lvhtu+QF1K4UYQwN9JFUZe6PjrXfvaIRUoCkMe68s82LHWFL2RqdiVLXRKXwHjhxE60y5vX1EQZPpOYqtUnrOJXTF59BPYYlM7K8I35GJKMruwxbNcR9/cWJytvijDy4i/i5Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=fail smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jlY+sOSi; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729651610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEq1SZifJDXlP2JwO/RVjrcRncUXHgMqVXF5WLRMOHg=;
	b=jlY+sOSiupErrBepM9mxZc4CBuX4roOR2F4e37HAakhWimwO7hJwA2v6AOYij9+fkvPqph
	gQ1Dz6tDiQ/AqAQRalDnRkpFljOsEfNYv8TKHN2xpC4mAYP48BX9Cm7Acv6K+gS9kVuaMh
	yVDb7PM70oe6XYAfkEsGt4no3Ah9KUDRxInrU1deMDsXl/rqxoA6pjUfmljnRulgW6r3V9
	yd8ap5JfpLAyOiLXW7T9vPeJzUDuf0JDoD3EO/XpWcuu9i0hnzcOwOINALMqeoPm9nhEZU
	no+juS2TeKVSBt7vzbccrCqB8RIkJLvu9MkJKCJYkfOeFNppqjOCr4n8zakTZQ==
Date: Wed, 23 Oct 2024 04:46:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: Thinking about firmware and hardware description for latest
 Rockchip platforms
In-Reply-To: <20241022165413.2156-1-shimrrashai@gmail.com>
References: <20241022165413.2156-1-shimrrashai@gmail.com>
Message-ID: <b12103b968cd5817f25deb7277d6054a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Shimrra,

On 2024-10-22 18:53, Shimrra Shai wrote:
> Now it would seem, then, that the most straightforward approach would
> be to simply bake a DTB in for the hardware, but the problem is that
> it appears that DTBs are continually revised in kernel development
> even for long-supported chips (e.g. the RK3568 and earlier). And that
> creates the possibility of breaking backward compatibility, so it
> seems there's a chance that if one were to just include a mainline
> .DTB into a firmware package there is no guarantee it will remain
> compatible forever with every future kernel version. And having a
> user have to upgrade firmwares all the time just because new kernels
> came out also seems kind of to defeat the purpose of having a
> firmware-provided HW description.

As you noted already, the DT definitions are fixed and improved
all the time, which is actually great.  However, the backward
compatibility is ensured, because newer kernels are guaranteed
to work with older DTs, which doesn't mean that the board DTs
provided through firmware should become frozen in any way, as
explained further below.

> And to this I can think only of two options. The first would be to
> have a "political change" on the part of the kernel developer team to
> agree to "freeze" in some part the DTBs for these platforms (I also
> seek to work on firmwares for the earlier RK3568 platform and perhaps
> also other RK35xx variants) so that they remain continuously
> backwards-compatible indefinitely. But I am not sure that would be
> something that'd go over well here.

Freezing anything would be simply wrong.  It might look good from
the perspective of having something "stable", which is similar to
how x86_64 firmware works on PC motheboards, but the continual
bugfixes and improvements are actually extremely good, because
they prevent various ARM boards from effectively becoming abandoned,
which is unfortunately rather usual with x86_64 motherboards that
become so "stable" that some nasty firmware bugs are never fixed
and their users are left high and dry.

> So that gives the alternative option, which is to do like on x86
> systems and start to add some form of ACPI support to the entire
> Rockchip driver stack, because the ACPI tables are maintained on the
> firmware side. However, it likely will still require a fair bit of
> back-and-forth here to do the initial establishment of a full
> "standard" of such tables for this kind of setup viz. my discussions
> in an early attempt at this on the I2C subsystem, e.g.:

So, there would be never any updates or fixes to the ACPI tables?
That goes back to the above-mentioned abandonware.

