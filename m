Return-Path: <linux-kernel+bounces-302343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584B95FCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FF11C2130B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D619D077;
	Mon, 26 Aug 2024 22:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WEjzEoCr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4019B5B2;
	Mon, 26 Aug 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711963; cv=none; b=KO2M6Y5GUs6b2odaXRvEXPfteTR4av2qJkF8D9WTG24Och3bDJ1XCVjHDfJ9cZvhp14vMUvnSNH9ovJZPAhAVaxJWqB6bU9HNqOC+xCkcKO6oYm/h1yJoNqGeQp6rHplpr+qu3uVvrbQkXg6xKXjfi7K36PsTCirBMmkDIV0NVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711963; c=relaxed/simple;
	bh=Npd+k9aJeKY2/fw6H0Xv+ExgcBnKlUjyVkQ5bOGmKY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ohyGKw7gKYegV7CPywu5dMGoAp5Qr51fXhJd9fIjWkNFH8DZQIKglFMEmst3zJ3F9ms6uwwFCfT4T905ewCUQWbCwOWoVthgTkedU5nf9vFnVhTWu6VkBWExfylWiS26AmhkCumdS9oHbgQxGwsHKe4BgH7JPu+y+WW9vzVLiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WEjzEoCr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7114642D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724711961; bh=SOB4Y/mA83RGuSSHmVBE/QBRUDrhbB4ZbfzoXM4B1TQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WEjzEoCrAjZHAqu0olqak+6AuVUtH6DmcGoAcL29C/7q6KR528vBLCAb8JABl0htX
	 LJB93rbiAbYLogPmnvD5naDGLeYqxU8BEBCvyzPWHKdsm7Q95YbAX80CMsC9rmLTiT
	 tE8heJ1EIaCqlXTdaytHxnRSFyBEuDukjp05KZQd4aDXdZmWyecs0ohPqqz6f91Uve
	 Diq8FS4sbOQAiyHGMGIrYeTIYwf9Ln5G1SfAj2Yq75NstxH0OxNqC3QfCPEPf1SHy/
	 rUIRxIfzDmQULsupFT/ezX723XVH1fTpTt+NkxDDXNODwN+VL/2Fyn4Js71DyS8eiJ
	 deI7ABtP6WNmQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7114642D39;
	Mon, 26 Aug 2024 22:39:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Docs/translations/ko_KR: link howto.rst with other
 language versions
In-Reply-To: <20240826010949.78305-1-sj@kernel.org>
References: <20240826010949.78305-1-sj@kernel.org>
Date: Mon, 26 Aug 2024 16:39:20 -0600
Message-ID: <878qwi6h9j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> The menu for documents of other available languages is created for
> documents in same file hierarchy under the translations/ directory.
> Because howto.rst of Korean translation is at the root of translations/
> directory while that for English is under howto/ directory, the Korean
> translation is not linked with other available language versions via the
> menu.  Move the document under the same hierarchy to make it be linked
> with other langauge versions.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/translations/ko_KR/index.rst               | 2 +-
>  Documentation/translations/ko_KR/{ => process}/howto.rst | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/translations/ko_KR/{ => process}/howto.rst (100%)

I've applied the first two patches, thanks.

jon

