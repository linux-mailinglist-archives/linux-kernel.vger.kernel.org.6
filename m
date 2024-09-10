Return-Path: <linux-kernel+bounces-323885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9639744A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF481F27489
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952F1AAE0B;
	Tue, 10 Sep 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="apB9xSqN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CB176FCF;
	Tue, 10 Sep 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002950; cv=none; b=j0A8AsfiONA+6kLWJKBCBQWpFZ/5uj25ilKiQzIfNMs5mNP1bm6fXzUHobSZl74746exrf4EgU/4DWfIyaql9phS/gbWhAa1BU+5ZrW3vqPYQ7+2ugXxTxisudy4DSSkCmF9f4VyvnzEYfMtNH5GxlxySyvdySxQMtm8k5N6H34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002950; c=relaxed/simple;
	bh=5TQ8/UV3hO4ur+jfjcsj75jtLHy0mdRgUDHGupgfsr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQSrwztOg1j/VeXZkYrgas5L/gb82dwi6M6my5XpUiqKvgSEQozC+q1hAl2iCfn6J7TdP3Cdulrb0rv1GOi/RZT0GRqA2/jPD7Njz8O03ewdzZFTVvwtoFYng+svJrWP4YMAKk7igojFl3R12A+wt6SqitqQlA+pG5eeVDoCr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=apB9xSqN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A09984188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726002947; bh=XQZyItrUlPA4KQFBJYAYXdbLUeVuVhUkugnc7NtJSRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=apB9xSqNZI5Gj0HlIoGyOPwxaJVnEhnWBV8Xj5FZVFCqgKn7Ty9dyPrZbA4vgfBU+
	 Pvy4HqMlPUf5FgdCnSkFf7Xw6Heqt/Dc0Z5pARlbQWKPZdkcG48LIa+zx0pgf/fOtY
	 bKHvGjrVaYdOm0LgJA2n+fGjjENy/zBDd7sZTEmNTuOrbLOPIK8jcx4DVK9jAVxxZG
	 7X6jRgfKTUOPNSTFwmYWImeYkNhU+i/gWEEzwRk+SFgXFYsGu+VLRCd7jy6QRl8/r1
	 pSqDvrrcUOkd6dr+PeCLzYWis8p4pAem4WLwyJNKU/qL7/05b8CxzGBizcEU94//ot
	 c7MNlS1JDKV3Q==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A09984188E;
	Tue, 10 Sep 2024 21:15:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dennis Lam <dennis.lamerice@gmail.com>, jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dennis Lam <dennis.lamerice@gmail.com>
Subject: Re: [PATCH] docs:mm: fix spelling mistakes in heterogeneous memory
 management page
In-Reply-To: <20240908161928.3700-1-dennis.lamerice@gmail.com>
References: <20240908161928.3700-1-dennis.lamerice@gmail.com>
Date: Tue, 10 Sep 2024 15:15:46 -0600
Message-ID: <87mskf6whp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dennis Lam <dennis.lamerice@gmail.com> writes:

> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> ---
>  Documentation/mm/hmm.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

(Just FYI, the merge window is approaching, so expect the response on
these to slow considerably soon).

jon

