Return-Path: <linux-kernel+bounces-332721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51D97BDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818FB1F231BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D71218B47D;
	Wed, 18 Sep 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b="bPNd6doL"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F87F9CB;
	Wed, 18 Sep 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668607; cv=none; b=fdAd9y4f45ZDEKLJH+Xr8epqBLImrVNBvOJXW9ohB/lDbONjt8gqpCTpOxq1+RipRK3K0a37JY7gJ+l8pGu1sSgcfJEvuUGeKec8wxgC4Sty2J0T57X6GG/PLmwnlU5qRe/6vYA/ACNefLJQHPLQif8PlyQUNiA4JGrjc+mX9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668607; c=relaxed/simple;
	bh=13VMKhIv2lXRTCy5STsEsl6Vx30Qfx8Efz6mgtaPZwo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=otspe0VZ7coO/Z35VA+K0i1rYdKplMzjuO8jP08aKh83gIF6wo5JdwOTMvEM4QeaIs+QTOVtkRr3GTC7HL0D3vxa/tvPAbQfk8PWT2R/Nt+PSUipUpG7YrCFa4+5xkMJMLz+gEx5qkkyHT73aWwehF+fCi62+GrVIdwJuYA5eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de; spf=pass smtp.mailfrom=tuxedo.de; dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b=bPNd6doL; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedo.de
Received: from mail.tuxedocomputers.com (localhost [IPv6:::1])
	(Authenticated sender: cs@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 1B98E2FC0173;
	Wed, 18 Sep 2024 16:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedo.de; s=default;
	t=1726668600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0n5gawmEzxr38cZdSrO5pp3uPMCaZrV3zJ4YL6eIaL4=;
	b=bPNd6doLl6+drAkUVWagvecGNXjYiBWcFeoNu1sBezyUoG0Nz4F2jl8cZU8vM30tWG5VnZ
	QeWO1PCIM986b9W3JH/GW77XX+QBV6NbNWwVkodd6tFh/lekcTOYf46piaYlm0cQ4waXN5
	AvyWy9wyWeqxzpTamPxE3E+gxGUkqiOIApf1OzO3S7xzXZXfS6Oa9jrPXKwF3YEMCrG30m
	wVrNUqOuxDaFsUELTtMWc2EaRr3wAtVuuMUbWEPjb+g0WwSdTequTzl9N3TlxmbRfA2S/U
	mUkcilxp97v2KVeLs4oK96ikoeI+p/DLNe0pLBK9cR6mxqQ7LF6Nd+3CiocVYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Sep 2024 16:10:00 +0200
From: Christoffer Sandberg <cs@tuxedo.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Jerry Luo
 <jerryluo225@gmail.com>, Christian Heusel <christian@heusel.eu>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <87r09hcbr0.wl-tiwai@suse.de>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
 <87jzfbh5tu.wl-tiwai@suse.de>
 <66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
 <20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
 <1fbba03e-56b8-4e74-adf6-998e3a2d9dac@gmail.com>
 <87setxe68m.wl-tiwai@suse.de> <87r09he63e.wl-tiwai@suse.de>
 <dfb141e8-6afa-4d21-8cd4-f9a53e8a192e@tuxedocomputers.com>
 <87r09hcbr0.wl-tiwai@suse.de>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <cedb8758bb506bf9454b90eebcaaea24@tuxedo.de>
X-Sender: cs@tuxedo.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit



On 18.9.2024 15:49, Takashi Iwai wrote:
> On Wed, 18 Sep 2024 15:39:28 +0200,
> Werner Sembach wrote:
>> 
>> Hi
>> 
>> Am 18.09.24 um 10:09 schrieb Takashi Iwai:
>> > On Wed, 18 Sep 2024 10:06:01 +0200,
>> > Takashi Iwai wrote:
>> >> [...]
>> >> I don't see any relevant about the incorrect volumes by the suggested
>> >> commit, but at least we should avoid applying the quirk for a
>> >> non-existing speaker pin.
>> >>
>> >> Jerry, yours is with CX11970 (codec id 0x14f120d0), right?
>> 
>> Yes, at least for the preproduction sample of the Sirius Gen1 I have
>> at hand atm.
>> 
>> pciid is 2782:12c3
>> 
>> @Christoffer: I guess 2782:12c5 is for the Gen2?

Yes the other is for Sirius Gen2

> 
> Hm, and one of those PCI SSID conflicts with System76 Pangolin
> (pang14)?  All seem to have the very same codec CX11970.

I don't think I saw the pci id explicitly listed, but that was the 
assumption.

> 
> If they really conflict in both PCI and HD-audio codec IDs, the only
> way would be to check DMI string, I'm afraid.
> 

I asked about the volumes since it could be a hint that a second speaker 
is activated but stuck on a fixed volume. This would make a low general 
volume setting sound louder but still somewhat adjustable.

However, if we can not verify second speaker pair, then I agree, DMI 
limit would be the safe choice.

Christoffer

