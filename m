Return-Path: <linux-kernel+bounces-353923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE9993481
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B5CB23236
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE661DC752;
	Mon,  7 Oct 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BpYasyLV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE11DC74E;
	Mon,  7 Oct 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321075; cv=none; b=DcHSGujyOuI6YeGOAr9eOaU8x3LgxN3Abep9uZLALDW5NI6/q5EuDyWXhCSxSc4hpDAwN/MSXVujAY2JKvOrqqA2FCKI/B1Hg7qC30WCNA4zrXB8Ess6zN0o9yF+Q4MqKs/CeUyJzl4Ev9xna6pb4qWPSRZ5hL/Th+1UAaQL+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321075; c=relaxed/simple;
	bh=AptONEvCNX1GKVvhPkzoF3vywhPwo6cOvMbQHNecPGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpLGkvH7IgrM94m+TTZJtnBeWXSIybIRkA2K31F17X0ebDxDfqkLFNElx6jaN9ba5OUk0u6QZXNyPWd/vTTmOH7ZNuG1/EU9NXMAOYrwWAWNQZXvBE/pEqRGeYNsaVVPKeZ0MiMqUeK6EHmLdHuIzLdozvnFwWYiiL91ghIPOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BpYasyLV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDCC042C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728321074; bh=2bTYKJiPDek+61ldh6+ljnqYIrz9NZnpUzQ4fuxn8vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BpYasyLVKUuaLgKvHJJknf17RS+GFgARpw33OJIhjaypMDtmeLJXJpS/5ARA/AXKf
	 svfjN7nTpCEqiPQ0j/Q72+Lu3v+q8D1R2W1TpdxMGnvkviSwsHZzFb3QXYxqFodzbC
	 m/io0BFTYKOUsK/sUrAxOxnNc76sMIB2pwxkiGZjFR9a8xbToRJdkGtMSKR8Mhjz5D
	 d4JJrlOs7+FgMpO4is2BuOxMhy/uoIioZzlUbQde461cNdyjYJUtQKAnqaWxE0GF8G
	 RjKEyyvw3tyVbK3Oub0iBOtbwQHTS9cNSPVv4OIPBIoWW1+JloVkCpjbuq7oG3cHCD
	 TVmSkXMjRasaw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CDCC042C0D;
	Mon,  7 Oct 2024 17:11:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vishnu Sanal T <t.v.s10123@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: Re: [PATCH] fix grammar on false-sharing.rst
In-Reply-To: <20241002100852.70982-2-t.v.s10123@gmail.com>
References: <20241002100852.70982-2-t.v.s10123@gmail.com>
Date: Mon, 07 Oct 2024 11:11:13 -0600
Message-ID: <87ed4rkfda.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vishnu Sanal T <t.v.s10123@gmail.com> writes:

> fix the grammar mistakes on kernel-hacking/false-sharing.rst
>
> Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
> ---
>  Documentation/kernel-hacking/false-sharing.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
> index 122b0e124656..ad7cb60bef29 100644
> --- a/Documentation/kernel-hacking/false-sharing.rst
> +++ b/Documentation/kernel-hacking/false-sharing.rst
> @@ -196,9 +196,9 @@ the hotspot switches to a new place.
>  
>  Miscellaneous
>  =============
> -One open issue is that kernel has an optional data structure
> -randomization mechanism, which also randomizes the situation of cache
> -line sharing of data members.
> +One open issue is that the kernel has an optional data structure

So here you are fixing a problem, which is good

> +randomization mechanism, which also randomize the situation of cache

But here you are introducing a new one, which is a bit less so....?

> +line sharing among data members.

Thanks,

jon

