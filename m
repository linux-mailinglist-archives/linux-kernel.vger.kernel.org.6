Return-Path: <linux-kernel+bounces-195829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61298D525E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2119A1C23685
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD100158877;
	Thu, 30 May 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OmDLroNq"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66846433;
	Thu, 30 May 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097660; cv=none; b=Sss425NCmRfCQy/6ejQy0uuDdDSjwb1CIHc/ojsi+TvEZrdSYbirwyCWS66hs7c7SD7MCX2rKwb65MtX5zmgt1gerUzhNjmQ4YPSVcH1UhFQeviCrNDlJXKOUut2M+f1zkh3K5eu6TDPiJgBObc5aBGuCzOV4nw87JJMSbq+AdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097660; c=relaxed/simple;
	bh=wm/Bo5gpyU2MWACRe9RWzANZe4lLTtb4K7qdjMH+xPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTsJlaFRxrsTu69cvPiu8OfKGTHidZ96D3SCz5ToXtNlfGlOWGHt57xbhwR/yyE2EQ9PfT6DTwMy4/CALxX7G/E56NeV4O3FmZfQ4Vvvki1rNubwbppYU1nhEK4NOiQyib1XDfBo5IUcgDTYpNNvDsCpJKFBh8PFJc4P5CYzibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OmDLroNq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A56E47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1717097652; bh=pbBSGU39oenKQ+SleKq6L+P/aT6z045AIZm5hbh/ASI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OmDLroNqIo1PEB8by0sazTWLDGfzYd3OpBGDqH11F+bJG0LgWmPd9xc1aZzq1q5no
	 lvku5bIrXWYb3w9W6I1HoAcfQIFT6k1nWs/yFZU2bMgxO4z4Pa7frEVYUDLovPOpFd
	 CaNikeNRdI1hmJSZrOuQNuFphVz7JZL/iLWRnX1oIlPpOzgak3ezKAo+7yjRV6L8Wc
	 ltMiwZwRiUsphaMT7ONBaVYe6AAaN8/UsyRZkkjo4JoB52vS362PifbfTLi64WEook
	 wlqdS5x4pg32tWbeoYr+G052GIgg3jVN5l46n/GcysX+XMZtwvQGII/qF/04n+qqmv
	 nR7kpkV0xHQxg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6A56E47C39;
	Thu, 30 May 2024 19:34:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
In-Reply-To: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
Date: Thu, 30 May 2024 13:34:11 -0600
Message-ID: <87ikyvccwc.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> Extend the Index of Further Kernel Documentation by adding entries for the
> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
> on the second edition of Billimoria's kernel programming book. Also,
> perform some refactoring: format the text to 75 characters per line and
> sort per-section content in chronological order of publication.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
> =C2=A0Documentation/process/kernel-docs.rst | 68 +++++++++++++++++-------=
---
> =C2=A01 file changed, 44 insertions(+), 24 deletions(-)

So I was going to apply this but ... it doesn't apply.  It looks like
some sort of weird whitespace damage?

jon

