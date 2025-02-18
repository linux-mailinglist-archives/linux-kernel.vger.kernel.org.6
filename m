Return-Path: <linux-kernel+bounces-520353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC719A3A8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0992188B48F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C071DFD91;
	Tue, 18 Feb 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JyPjeumM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511D1DF73A;
	Tue, 18 Feb 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910335; cv=none; b=EWi8jflWrvJZEn4VFwmEmDDplEbspC2e/7ZrI9jP0c767uaFL5CUpCzSP/y0rr0k4OWsLlby2QIr86bbqN38zyPagWvEBzSvZL1ePVLKZqGJjBCHGismbtR8QadmAvzVD9aeR/HdBK5NC6u9D+jq2eHgLdHJUsEHM9YHwozVUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910335; c=relaxed/simple;
	bh=hXOebchP3NPkEm5a7VkktoCK9BvKPQOZTBMqv/ZYAuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSRXyqLotkK/7smbL1aSsuFRhr3wQS+DwH712+HaKOsZ4YjepihuBLrXQz5ZEV5U+uvoQNcleJi7jnKp9a2dufL53VZB9E8AScPyrIeeL8llWnz3Ff4EZZfm6C8xX65K4ckCPFdBebZtqTLWjdf8J+GCrwsU9WEiQtYh4iOzi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JyPjeumM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2D370411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739910333; bh=U3CSTV77h7wwcu0nijjTlqqSNsH/15U0jQ6w8xe2F6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JyPjeumMlalhwnsE8DnYyRgDTH+l/caE+taL2MZGvhpsARZhDNr1bfSvaJJBCQ98g
	 kua2sG3MFeAU0J52wjCl9ujHUQq0oiGgjsCQ6qiG8eJxbEcUIkKzIIVsJKld6XLi+X
	 Qr22GLhpumB/8fmIrZDETr6KUio1WYrzog1SYsEPd3ITrsswLmXeRgZuhzO2RxCq8i
	 gTnh2n91KzFqyglI3vmqoJAupeKqNd0OjuKEoeHhbSnDspSq++QZNc7LMlXP8kvsfa
	 uYEGYlNtzg4ddYLdTUt8+JrBPGfj76M7IStGzmzIuCTlUkdVzgm8KavI1KwHrd8LX7
	 rwL8Z91F2lhNA==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2D370411AF;
	Tue, 18 Feb 2025 20:25:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/kernel-parameters: fix typo in
 description of reserve_mem
In-Reply-To: <20250218070845.3769520-1-rppt@kernel.org>
References: <20250218070845.3769520-1-rppt@kernel.org>
Date: Tue, 18 Feb 2025 13:25:32 -0700
Message-ID: <87tt8rngoz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> The format description of reserve_mem uses [KNG] as units, rather than
> [KMG].
>
> Fix it.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb8752b42ec8..bf00552908bc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6082,7 +6082,7 @@
>  			is assumed to be I/O ports; otherwise it is memory.
>  
>  	reserve_mem=	[RAM]
> -			Format: nn[KNG]:<align>:<label>
> +			Format: nn[KMG]:<align>:<label>
>  			Reserve physical memory and label it with a name that

Applied, thanks.

jon

