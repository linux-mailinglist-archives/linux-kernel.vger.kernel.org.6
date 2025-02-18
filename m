Return-Path: <linux-kernel+bounces-520487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F731A3AA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A71C162D37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DF286291;
	Tue, 18 Feb 2025 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WuTB4fGA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2EF286285;
	Tue, 18 Feb 2025 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912521; cv=none; b=H4teoX8UTEboGWPSv6TbicISmMxxoUyreWURBsvMomT98XVFUIRGm/tP4Yp+IR/d9A/UP2/Ng3Nq14cTksnkNVOoAwdcLZG2MDgcajQ5DnlU9XAN6mkjoc/d5xV6CHKC1Yu8tAWRkQ8x49mn9cIMW3C6WSLzkqlDf7RBuQO1hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912521; c=relaxed/simple;
	bh=7JwAhYXKnTo40zmF4OP05oqM/pSfRo/c9iCMt9/VWvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cESNk80J1O/n+GdAMFfIg7hzPojPyG+X2zfnh2APSgqhAI0hygRB7vKyQKIOvjukEwGY+hdJiPBqnavalkyUu6bptLnvUUZU0Ima802P68HaqlKs5XsfzfcbriXTWW/smsBU8N3l1wnIk/Eyjxtn/CD5ss3votwTKHsuDv5dASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WuTB4fGA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C96DF411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739912520; bh=8+u0BRxAlT+bofMTvxLUc3wbfi6cmZGV9c9V+a5P0rU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WuTB4fGAfH0IXaluotryfJWJ0YT/VTQm1cb52uppOc7wP/ivZDcnu1M8gf3I3fGXW
	 W0J2SyOYagz8hoMXTSO/MfJxNb9uw6VybdE2NYBARiGAyt2LigstdkBg/qcCusMWJ4
	 I9oh11hegwVw4O8M9kuFx7N4Z2f9ZDDAbDP135sWyYpW0YDI7gsaII5clmqKEasVkL
	 Vpo5eaGcBZBKZMRsMpu01V2Teqys294ZloOYj4UkSceJK+ITb53Ge3t8vYjRbToxaS
	 Y0bTMpAUUSTrjoyP4i3FPx4w29PfFRam8Br6jkYUiPdJZRyKgbOYdJg374zUAKok8e
	 iAT3dOiujxKlQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C96DF411AF;
	Tue, 18 Feb 2025 21:01:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Armin Mahdilou <armin.mahdilou@gmail.com>
Cc: shuah@kernel.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Armin Mahdilou <Armin.Mahdilou@gmail.com>
Subject: Re: [PATCH v2] Documentation: proofreading Documentation
In-Reply-To: <20250210192754.30283-1-Armin.Mahdilou@gmail.com>
References: <87bjv91yi3.fsf@trenco.lwn.net>
 <20250210192754.30283-1-Armin.Mahdilou@gmail.com>
Date: Tue, 18 Feb 2025 14:01:58 -0700
Message-ID: <87seobm0ft.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Armin Mahdilou <armin.mahdilou@gmail.com> writes:

> Fixed some spelling issues in documentations.
>
> Signed-off-by: Armin Mahdilou <Armin.Mahdilou@gmail.com>
> ---
> Thanks the Ack and Review. This is my first patch for the kernel.
> Fixed SOB.
>
> Regards
>
>  Documentation/ABI/testing/configfs-usb-gadget-midi2 | 2 +-
>  Documentation/input/devices/elantech.rst            | 2 +-
>  Documentation/nvme/nvme-pci-endpoint-target.rst     | 2 +-
>  Documentation/sound/soc/machine.rst                 | 2 +-
>  Documentation/usb/gadget-testing.rst                | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

jon

