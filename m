Return-Path: <linux-kernel+bounces-332949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D997C144
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EAE28412F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412761CB326;
	Wed, 18 Sep 2024 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ODYjglyj"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33C1CB316
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694081; cv=none; b=DXwBW3krBAaG0gxYYsUl0D0ZwRO7ixPWRIAMA0AQr3Mj5x7DZN5h+WvKjDHCeaEfF20xam9syKwwT3iT/d+rcM9W8cUQHbkVI/I8hYSaDybiODWbLYLR5EY4cZAL/7lIUtLMvUh8l8cwLGRkHfk9uD6fR5SV1AqVdldE4f9Fo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694081; c=relaxed/simple;
	bh=v4+WneK4Otq2HS6/cX9VHcHqK5xOC5WrTHm95K8RyZs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkU36JSkA1A6faKsfMIDybMu8hfTXHqHSG6d2SgTBaWxhrUmMLhuEW6zsMv3WIwwUZyiST75cyvnQwvAGLT5/xMBffgGRWGDsp4ZJCbVFPUpnFG5Ow4MqFsoCZme2mGyi2Wro6m9xRw68nS/FTAdK5UMBlawg9YLutGh+MPOhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ODYjglyj; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tk2oqe74ajfvlimcyoyqfeh7sy.protonmail; t=1726694071; x=1726953271;
	bh=N70NHrTlvOcznXSQveTTiRfCxrbVrvyR4DszAbe3NUE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ODYjglyjxF39OkvsfPb69gDZlR+SpyzRXYxE3YK56s1urvtsGZ2InfuEg/r3RldRm
	 8FI5WjWCZ/dYRn5xLYrQxd5HXnOLPN6K3vOSeLOCA/WVBE9w4DLU2V+F3x1kcsohl8
	 J9DQm0gXlQWnx4WuQOY5TlsQvTNvl+3DSyhTt6O18pRJ8Kk3/M00QF26NwU3H3ToN+
	 wqaAfoD4uKUUR4ddBlovIas6rpblRY0Vm6NXQ9dgReyQ++l2bJzHEQHcSA6m/IwIx/
	 UXoUwW1e50sMNNAWkTpPZktzfN0M9GtzP+jRd54aXp4u7PJnADamNvtbHua8nLsxwa
	 DUmkAbbWpdiwA==
Date: Wed, 18 Sep 2024 21:14:24 +0000
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
From: John <therealgraysky@proton.me>
Cc: Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <KcA5fQwm2CimaycjqPqz-HP7y7Dyx3MbSNUc2F6eYqN5T48hLrFAUwiajYvOaat8Apn-dZvzQ2RAp2Ln-9BE2s1uYn7LwFdTX7NLqbBkC5k=@proton.me>
In-Reply-To: <96f609c7-f185-49c8-a9d5-a26bfd093b09@gmail.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local> <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com> <JDkDAyklisK_zhy8Ecsw8Z6t4ALDO1Jzzza2DZjWefD5erI-tTPGD6GhevyIp1Ee1xoWg1ouqkMCOqcylaqwZg2YBO7h9USi0qzCIRotUBo=@proton.me> <96f609c7-f185-49c8-a9d5-a26bfd093b09@gmail.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 788f1d7ce3aa28a5356a0ca8a8c042eb3f77d602
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wednesday, September 18th, 2024 at 4:25 PM, Hanabishi <i.r.e.c.c.a.k.u.n=
+kernel.org@gmail.com> wrote:

> Even better then! Could you please explain where the performance gains sh=
ould come from, considering that the kernel force disables all SIMD extensi=
ons?
> https://github.com/torvalds/linux/blob/4a39ac5b7d62679c07a3e3d12b0f698237=
7d8a7d/arch/x86/Makefile#L67-L80
>=20
> I.e. if we won't have them anyway, what gives?

I am not sure.  Are some of the other things -march=3D-x86-64-v3 driving th=
em?  I will say that these timed benchmarks have been consistently reproduc=
ible for me.  My code for the benchmark script is in that github repo as we=
ll if you would like to give it a whirl.

As to the code you referenced re: disabling the SIMD extensions.  Do you kn=
ow why that is in place?

