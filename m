Return-Path: <linux-kernel+bounces-212284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A821905DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A242F1C21276
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A181537FF;
	Wed, 12 Jun 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="C1hj442D"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2D8288C;
	Wed, 12 Jun 2024 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228101; cv=none; b=Dz3WbHORiPH7biKD6pTLsKMkST4F6yBjRfL/iaoYUYcFMfuB2r7jOno8yJVIM/CV9D1xRUkIVTneKzNvHa/eXaUEaz8zte/+Ic2dzE7SXFe1FUfxBdIVhuVECtWPLBAK0WQQ8bQWaooevlqPnvGEMC4Cl1mRPod2MHcQ5WFUxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228101; c=relaxed/simple;
	bh=oKmLrfV29L06io4Kl2VwMfLYa4V+Ackek1fTDA0ZM4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFZl8udJ2K7vBytcVry+AtedzZFeDY9dfET9yDH2Htf9S2jNK7pTLhZvCep2+uh4qFXkpAay3ZBhpfJXz26FvuJzpjH7H/zjGf5vv3q48QvIgHmJrEiYCBzC+0YFuRSSligfghjF8g7OzEKYG32lizrMEWLby0QGKYO3TWLe8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=C1hj442D; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 778A445E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718228099; bh=PWyCuv3xpZwwaaYLqnj6S829Q1/vduw8lKyGFP2raD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C1hj442DpXdSmkexosDIUYoNYF6f1ELKkhouiFKhLvnp7hedK7mHnwIGilYKh5imM
	 YB32lEJevqYYNGpGVCppj5ET86KteUf+iLtUojSt5MnwGvDUYj6Dwi2TIZrX1PZ7/r
	 hWFNzn6gnIzUlcBHfP+dvopcWp63bxsdNHcheRWyAFlQL+dOwceTFDxmnqomoVovPT
	 0qQxdwGM+qHgQvZx/0+eAHVQeVM/3DEKOgOS+S2sTwNILpqT6CWWxlo7Zo2N2dXiKs
	 N3Fk/6SGZnuVg09SVJPRhGiVLrGim3f7HDKclGDU4Br4avCjAyLOaBDo3sDk5xLoiB
	 4huyw27ZyOIEA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 778A445E09;
	Wed, 12 Jun 2024 21:34:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
In-Reply-To: <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
 <2acd884f-2f04-4d39-b559-aac99f9ae35e@gmail.com>
Date: Wed, 12 Jun 2024 15:34:58 -0600
Message-ID: <87h6dxonel.fsf@trenco.lwn.net>
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

So I still am unable to apply this.  There is some sort of whitespace
damage, perhaps some sort of non-breaking spaces?

jon

