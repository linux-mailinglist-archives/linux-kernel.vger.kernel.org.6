Return-Path: <linux-kernel+bounces-247272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437392CD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB671F246C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E21420A8;
	Wed, 10 Jul 2024 08:44:33 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BF13C80C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601072; cv=none; b=u4tHy/QRz9zrnTHnKdTwZhU7JUQP6dEr0T9msYrcMtW+RTCSrH7BEQbwt6Ehyx3GPgd/nef+uaqZ7o3ZAK4f0qtMkW3dqZywmwY0wnjyPjtY/YlV8dFdafs7vsNY/Q2CocHD1E5USxg5ma1n6zzUPjKjTrVvlRIdQ4tTBNyIXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601072; c=relaxed/simple;
	bh=N901BoelxregF+OOcY274ORtjPEZKvp9ZxjkExOYyNM=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BR2wXFqqP5CdQVM4+q2+/65q7m+30nVAQFCVN/x4PY93UtLMGStLrusjHcLetvG3ak5x0umkS+hQ63AHS/fXyRi1UvD81ksEJDohLFKwDpEJYrKGqHQHdTArZsLUgjDl/ZwMvXi3hbpjWUNXGYVsKItpGHcziKPN2I0pREgfacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2340:18a1:4138:37d2])
	by albert.telenet-ops.be with bizsmtp
	id lkkU2C0054znMfS06kkUzh; Wed, 10 Jul 2024 10:44:28 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRSw8-001bTx-4N
	for linux-kernel@vger.kernel.org;
	Wed, 10 Jul 2024 10:44:28 +0200
Date: Wed, 10 Jul 2024 10:44:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.10-rc7
In-Reply-To: <20240710083744.2885335-1-geert@linux-m68k.org>
Message-ID: <a3af912f-4271-7eb2-e111-b6339f51d067@linux-m68k.org>
References: <CAHk-=wjv_HoF-5Y5QuNqMfiumwMyNZt63ajO44uKce4dWOeU8Q@mail.gmail.com> <20240710083744.2885335-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 10 Jul 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.10-rc7[1] to v6.10-rc6[3], the summaries are:
>  - build errors: +2/-1

SH gcc ICE crickets.

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/256abd8e550ce977b728be79a74e1729438b4948/ (132 out of 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/22a40d14b572deb80c0648557f4bd502d7e83826/ (132 out of 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

