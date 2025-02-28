Return-Path: <linux-kernel+bounces-537908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDDBA49257
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CA91884F15
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9473E1C8FD7;
	Fri, 28 Feb 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="jeAmfBcO"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96E1C5499;
	Fri, 28 Feb 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728314; cv=none; b=vAE8aFB/0URwBuZ0OjQS3NhBjdEP4chuWcEnkYgIZalo2/y7l/7TvdN3F46RZHkFMVjbnMqIwBXBCDk7bQ9eTrb/Je1iJMRQZOUO3DVHBGm5G4NhxaJoT3FN0VROnVLkGCf1VCviem0BJsbWFwh+pNOgI4mHRKXZolt0PO1/3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728314; c=relaxed/simple;
	bh=p9WcDjbRFZ+554q5cM6PdDKFgFq7ow4V9vG5uOZfBJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO2TanHnOobeZutTsM3DaJp++zy18Jg/P6NeMQgGhHgvtJprXG4Tdl0amlu6OG2RBQfJm6/i8EZBCuOpqTwlbK9sg/8lick+r7b85qsJ5iKB45rkQ3XcXigCOglmj0ttPj+Tt/PJBgFBNET9HP0fTP9igKMD9wkfw1ZNhOEsc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=jeAmfBcO; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740728310; bh=p9WcDjbRFZ+554q5cM6PdDKFgFq7ow4V9vG5uOZfBJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jeAmfBcOYRyMhHX1T66+0F9Wq2/UbKeKhN5k1B67TwnJ/fAW5GuTWiWZtCahJ3usf
	 fGatM3tLbUVIJ0DzV0aBFwfPgskybobXqfUFyCWh+GCHMeBkLJYEcadnuAQcRCDa0n
	 IHm6Nztwc1EcK83BKHAnEfn9l7oejbMT8Q/W3bDY=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 093A42052A86;
	Fri, 28 Feb 2025 08:38:30 +0100 (CET)
Message-ID: <bc969e02-6004-4216-be55-bdfc00e95702@ralfj.de>
Date: Fri, 28 Feb 2025 08:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>,
 David Laight <david.laight.linux@gmail.com>
Cc: Ventura Jack <venturajack85@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
 <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
 <rps5yviwyghhalaqmib3seqj62efzweixiqwb5wglzor4gk75n@oxki5lhsvhrf>
 <20250227221801.63371d19@pumpkin>
 <smghtqj4gnlo7dxo4t6u74c25e2qukhogsi5fysddputbuwbmg@lwuh2nipypqf>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <smghtqj4gnlo7dxo4t6u74c25e2qukhogsi5fysddputbuwbmg@lwuh2nipypqf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>>> It's also less important to avoid ever breaking working code than it was
>>> 20 years ago: more of the code we care about is open source, everyone is
>>> using source control, and with so much code on crates.io it's now
>>> possible to check what the potential impact would be.
>>
>> Do you really want to change something that would break the linux kernel?
>> Even a compile-time breakage would be a PITA.
>> And the kernel is small by comparison with some other projects.
>>
>> Look at all the problems because python-3 was incompatible with python-2.
>> You have to maintain compatibility.
> 
> Those were big breaks.
> 
> In rust there's only ever little, teeny tiny breaks to address soundness
> issues, and they've been pretty small and localized.
> 
> If it did ever came up the kernel would be patched to fix in advance
> whatever behaviour the compiler is being changed to fix (and that'd get
> backported to stable trees as well, if necessary).

We actually had just such a case this month: the way the kernel disabled FP 
support on aarch64 turned out to be a possible source of soundness issues, so 
rustc started warning about that. Before this warning even hit stable Rust, 
there's already a patch in the kernel to disable FP support in a less 
problematic way (thus avoiding the warning), and this has been backported.
<https://lore.kernel.org/lkml/20250210163732.281786-1-ojeda@kernel.org/>

We'll wait at least a few more months before we turn this warning into a hard error.

> It's not likely to ever come up since we're not using stdlib, and they
> won't want to break behaviour for us if at all possible.

Note however that the kernel does use some unstable features, so the risk of 
breakage is higher than for typical stable Rust code. That said, you all get 
special treatment in our CI, and the Rust for Linux maintainers are in good 
contact with the Rust project, so we'll know about the breakage in advance and 
can prepare the kernel sources for whatever changes in rustc are coming.
Hopefully the number of nightly features used in the kernel can slowly be 
reduced to 0 and then this will be much less of a concern. :)

Kind regards,
Ralf


