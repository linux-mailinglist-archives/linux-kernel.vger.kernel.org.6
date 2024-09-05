Return-Path: <linux-kernel+bounces-317651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7396E178
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3EB1C23689
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBC417B4E5;
	Thu,  5 Sep 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UD83NBa1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2E7464;
	Thu,  5 Sep 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559398; cv=none; b=iAQtSY4w8gAUJCA/kyc0fE3s8y5szP0pDAxs3pd1ZUpCHCw+6SuGnCZUhNUq6Ul286BzXEMZKw/ilXYs1rLSEvOAgrDeDzsIHNV0y2n6CwLWY9pskdctxslgYqiISu77aAhNtgrgRgBCH68gHRIFOTGF2td/LWhK/zYpo4NRP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559398; c=relaxed/simple;
	bh=mKcvdx+iWVZ2zzidPNlMM6ss5Oo+nEsUbCeSr4gp4Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEi4/PNBzozWKyhQwdoqN5+SNspoZeKQnNx1uTwCwg4844TxDaoRn7w/msztquPBseri/msZjdByoPuHASuplaDDh5b2oGe75jlMBi9t4MLCMb+FG0CY6ZisCWlQJf2+vDkbMkAqbzjPe/ieHj5CunO8/Cd8s/R/1n7PQ0ARmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UD83NBa1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 925CF42B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725559395; bh=mKcvdx+iWVZ2zzidPNlMM6ss5Oo+nEsUbCeSr4gp4Uc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UD83NBa1ghmdmu3ZcT4z941To/hfiS1IQ0A8zFwxRc5xPtCSxXnh/Z4TSpcIT8Hyx
	 t77Wrwzpler5QfC9acQaiQGXJnL1vRk55KcPXvjS9/jzz0QCOBcTjZsYx6JYNDciRZ
	 7IGWiCphDS/30ntFv2KIUKS5+ZmtydJ6OjqCh5PTL/PyVTNJpsb9yWoEhJHB/MeG1P
	 o1biDkfYeCY4jtQ7OkcAvveghwn4j4nM7pxcsTwZccyZPUZDOaKXHtsE1Ws9vW0fKQ
	 X9TdQfNmrI0FCSwHJRZAHVM+AsFcChd8PWSGZAc7mqCI7Mzgxs+TYqdvbEOdCMTsw+
	 RFBJ++obnUGdQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 925CF42B25;
	Thu,  5 Sep 2024 18:03:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mark Brown <broonie@kernel.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] docs: submitting-patches: Advertise b4
In-Reply-To: <20240905-documentation-b4-advert-v2-1-24d686ba4117@kernel.org>
References: <20240905-documentation-b4-advert-v2-1-24d686ba4117@kernel.org>
Date: Thu, 05 Sep 2024 12:03:14 -0600
Message-ID: <87a5gmj7vh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> b4 is now widely used and is quite helpful for a lot of the things that
> submitting-patches covers, let's advertise it to submitters to try to make
> their lives easier and reduce the number of procedural issues maintainers
> see.
>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Remove some blank lines.
> - Link to v1: https://lore.kernel.org/r/20240903-documentation-b4-advert-v1-1-c89d6f5db7b1@kernel.org
> ---

Applied, thanks.

jon

