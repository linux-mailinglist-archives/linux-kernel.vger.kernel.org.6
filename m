Return-Path: <linux-kernel+bounces-333011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAB97C225
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F2E282BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694A1CB307;
	Wed, 18 Sep 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aqeOWF54"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9951494B1
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726700863; cv=none; b=KViIlyjlLiDfQ08qY1JHC8B4mcwrZ4+mo3ohzOxLKy/4HA+xVSeA73sjeECHZ3i62THK071+6+S0zxSc+Ik4zRoyaswresZuT5rWNQIS3Kvd2+vgXPgT1qEa+IOTQ1PewVHDi79LC8alO4CXF1AjBipoRYC3JESOSwz+a0PTAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726700863; c=relaxed/simple;
	bh=RabetCYHj7i4gO17+U0nL4rxLrsqv7MwH2GtRzUXDRg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmXm7acifw+SRDrAqS7WXFq7Z49CSNRP+eGjQDj6snwteTAbKkxf5vdHA3DzmAq0FsxZAvMxl0nDwp2u4cDkHPZQ1BeGUpvsKrGfzT1G6qTJ7Ff0MfhMEKmuAHh38RDZmbdQUPBo2sAcsb/h3Fl62s5bEG5IlvFJsBi00WrQqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aqeOWF54; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bbb5b2qdffbjrolisyrlykdxta.protonmail; t=1726700844; x=1726960044;
	bh=K38Lv9PKrxEa2nWi/1bE9IPIp19nx1Slw3H3HtLB50c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aqeOWF54LQBQJFN4FVCB0K6imkcS73blfgcPjR5dkGc8DMbTjgLwZmLUyfu8auMeP
	 g6jo8S+eqd11HAj4VR88b0ed3I6KiyFSao0v3f5IaKfQObbWJUZGFLhfyZ56ZXEpbj
	 X0/gW1MfOsBCI/u6hYMpAg2iQPxgoXRk4eMFTnOn+6bXp1XohxHqESwt+lU2QJ+LZ3
	 DAF8UnlLECUZSbxL9WPqDn/87Zztnfq4zGXWC+f55EhS8TnsDvdYOk4Aeg6oHcZega
	 MK8allpyJIVNXLq9auIZ3Mx3qjIyWpmuL9Q62341Aa1mWoQ9XdYJ4SLQyT6DnkiuLX
	 pXkxk6d3hAHgg==
Date: Wed, 18 Sep 2024 23:07:21 +0000
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
From: John <therealgraysky@proton.me>
Cc: Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <DyijdoLQry08D7NVc6TRSNOMrH39AvGg593R9i9wMJzLJNQAgZfXo4IC0POdIjJVzb2heTjHdGAtF98__58LXg1k3RWHphmRnHZYm9hiavI=@proton.me>
In-Reply-To: <17b2ed36-3075-4888-8057-0a471e5df209@gmail.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local> <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com> <JDkDAyklisK_zhy8Ecsw8Z6t4ALDO1Jzzza2DZjWefD5erI-tTPGD6GhevyIp1Ee1xoWg1ouqkMCOqcylaqwZg2YBO7h9USi0qzCIRotUBo=@proton.me> <96f609c7-f185-49c8-a9d5-a26bfd093b09@gmail.com> <KcA5fQwm2CimaycjqPqz-HP7y7Dyx3MbSNUc2F6eYqN5T48hLrFAUwiajYvOaat8Apn-dZvzQ2RAp2Ln-9BE2s1uYn7LwFdTX7NLqbBkC5k=@proton.me> <17b2ed36-3075-4888-8057-0a471e5df209@gmail.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 5001839f6294ceeaee377bcb80ab40f653ad737a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, September 18th, 2024 at 5:48 PM, Hanabishi <i.r.e.c.c.a.k.u.n=
+kernel.org@gmail.com> wrote:


> One day, out of curiosity, I tried to override it and build the kernel wi=
th '-mavx' (free performance, yay!).
> Well, it didn't even start and crashed immediately.
>=20
> I don't know if something has changed since then, but I guess there are r=
easons.

I also tried commenting out the entire line.  I too was able to boot into t=
he kernel but it just rebooted before the login screen.

