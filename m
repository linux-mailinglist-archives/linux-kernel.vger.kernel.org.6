Return-Path: <linux-kernel+bounces-332006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799A97B41B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5938E2888AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540B17C995;
	Tue, 17 Sep 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nm02z22d"
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66217A591
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726597372; cv=none; b=aa91eBgOdZKr8XveV9Mu+vV6qZPcI1pOyH/GkndFRjWuiEcD58UkXr0ZopgpTQsb+xdxDfJ7eexG8fTm7Jn/WaTwCsBiEvLK6Ua/Z2ESYoyuPfFcNQmghtrhvAluo1cw2z8FL8sFYW5K9nxpGPjqmntWzzE2FWZhUGUani69HOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726597372; c=relaxed/simple;
	bh=UVtbDhQAhwXKJeYJ2aCra/yibrzIuX1YdMKMOpmOxcs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e35ZiuvKoONW21od7o7+gd/At9q99wObf8zkbZPTG+FFwVlwmAfXtyaYjPO6lbN9y4JgWiBVsB+mi+nj/VLRDAoH80w1DyQsjLJTtF7Q84zR+q5peyuSVcURnFdahDs6x7j8MkzniQ8UcLtJqhKyPZXZ0Fc2OQHLszlRl9MJoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nm02z22d; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726597362; x=1726856562;
	bh=FgeJqjaJlWaY5ugZwcddgLjQdpW/i8zhBRxK7KXlhSs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nm02z22dYUF7/FcEGC9/hhSaoTKm2hV9ky+DKrNQoydpP7uXI06cB2+9UrNIGieSW
	 rEnGB0bSXsCzs3qg01+4EksFXl7iBMiNnVmLxWxUmv56mwSi8mNijhvFfa2b4wsBpq
	 h6iN0b9YJKSP1owdEJVzTlc8TtydY5r/oN4lgIB7wW9uUMI7lA1siSc4fwn03fdFzu
	 c2L6UWRIXmOuEeJR5/bRYtv9nHJKUjhUUWhwJP+xQI/2DknW8ogvf8e4zOIB6gBYFK
	 kYerbb8TyNsSgWDA6A0+lZQgcEX6rFcD/96kac4o2pPLfZs4kmUZbVyeRRB21isDyx
	 +G/o3gaaKUHrQ==
Date: Tue, 17 Sep 2024 18:22:38 +0000
To: John <therealgraysky@proton.me>
From: John <therealgraysky@proton.me>
Cc: Dave Hansen <dave.hansen@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <yePf3dKBhN5-MT4j8MbstYrbVupKBUlpBQ-Oo4kXHVTWaCcWMAMgvY9_e2RPbB-tv4U30Hg33aaziplcL-T9ovY8aFNYdihMdiL7ysifliI=@proton.me>
In-Reply-To: <XngBYmNlmx5HynQiady8B6MsNyjWhWsWHhjmEIw4vhFYS_Pyi082MCXetLK66amn2j2XQiRlzFVdrUu3V0UN-3yDWOSOv9Dpr7sAgShOme0=@proton.me>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com> <XngBYmNlmx5HynQiady8B6MsNyjWhWsWHhjmEIw4vhFYS_Pyi082MCXetLK66amn2j2XQiRlzFVdrUu3V0UN-3yDWOSOv9Dpr7sAgShOme0=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 4b9bcd5385099d4d76cbf20817d8f62484dc05b8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, September 15th, 2024 at 2:42 PM, John wrote:
> I like this approach much better, it is more streamlined and clean. I ran=
 with your suggestions and the attached seems to work. I am grateful for my=
 feedback and suggestions on the syntax.

I pushed my draft incorporating your suggestions out to my github at the fo=
llowing link.  I am going to unsubscribe from lkml now (hundreds of emails =
per day) so please cc me on any replies or use the github.  Thanks.

https://github.com/graysky2/kernel_compiler_patch/blob/master/lite-more-uar=
ches-for-kernel-6.8-rc4%2B.patch

