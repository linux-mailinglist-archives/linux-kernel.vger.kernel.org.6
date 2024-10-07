Return-Path: <linux-kernel+bounces-353940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F79934D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A04282D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA551DD54F;
	Mon,  7 Oct 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sO1oLD+2"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210A18D624;
	Mon,  7 Oct 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321693; cv=none; b=pnBpKRiiap97QIt0qPZ+f5NASmhzfHxHmJYFnMrh/icv4Pmer4LnrAt+OYs744sPALpwEZ3V5v8G8xgvmbCmTPpuNen/Gc2pmY2lk98/eWcDVkbRRy+aeouNaYKEyTLDh5HmIt4UEncm/dYNMpbvpuAPiX0KVM/D9sz0B0B927U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321693; c=relaxed/simple;
	bh=YFqABopLbGYZHFeUXzmIkOVqmzrj3+gOqFDF7MeYdoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjhTynmD0IIFwww6ea+mVZGXGk9v+3PM6r0jd+UYFZEcKwmHmCdZK01/eusvi5L4onUz2v2zCErOJQ/jGRd0AYH+byifXSiriuJ4nCFyxHD6FEpKfoE0RhFPAwc9pjtqtEVlP8YwPClh4bu7lTF715pTSqKbsknxehzlj7+/R4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sO1oLD+2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B219842B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728321690; bh=D4BPuEuxvT9MrzzfwMCqAtovMNgMLu0lAHfm47rbxos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sO1oLD+2rgoFYBtz+05b3A8Kbfa4UIhyYPjJGlxjDSH9BARmVdZ+Ju8JfTbEs6ALr
	 D429kaLHb7vuWmIOrfa1q+T9E5VAz2UOa/Q6VXqMnzWZIN6GXYJ92qHt19KmT2f6OC
	 S70L797ipRdD8jkgKT+9H0fkVyE0Oq9fNMxF+YWyb+9qWyzholEeMfZxmJaYKNVkvb
	 RCWKWVSe0T+KKAra9MsZnYMrQr31U+7KGRgAr3YSH2NiH0nwiQrSI0nL9NMn2nwrRn
	 KZdm7MdPHsuokfWRHMCZF5rdZwQnvxbYdtwXcezWNRe6PuTltzbId4bvnUG+NGWTwv
	 5ESPlmEdybflg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B219842B38;
	Mon,  7 Oct 2024 17:21:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Davide Benini <davide.benini@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: update I2C summary
In-Reply-To: <20240921215729.23796-1-federico.vaga@vaga.pv.it>
References: <20240921215729.23796-1-federico.vaga@vaga.pv.it>
Date: Mon, 07 Oct 2024 11:21:29 -0600
Message-ID: <87jzejj0bq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Update Italian translation following these changes
>
> commit d77367fff7c0 ("docs: i2c: summary: document use of inclusive language")
> commit 20738cb9fa7a ("docs: i2c: summary: be clearer with 'controller/target' and 'adapter/client' pairs")
> commit 1e926ea19003 ("docs: i2c: summary: document 'local' and 'remote' targets")
> commit d77367fff7c0 ("docs: i2c: summary: document use of inclusive language")
> commit a5b88cb9fdff ("docs: i2c: summary: update speed mode description")
> commit 75d148c90a34 ("docs: i2c: summary: update I2C specification link")
> commit d18b822c8f62 ("docs: i2c: summary: start sentences consistently.")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../translations/it_IT/i2c/summary.rst        | 72 ++++++++++++-------
>  1 file changed, 46 insertions(+), 26 deletions(-)

Applied, thanks.

jon

