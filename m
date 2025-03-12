Return-Path: <linux-kernel+bounces-558558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BDA5E79B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904647A68C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349341F0E40;
	Wed, 12 Mar 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AYL1O5eo"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD181DE3A4;
	Wed, 12 Mar 2025 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819218; cv=none; b=NPqBcTilS0DR5Rwfu+iFaXES5NREnFyF4bBmeeS3lFZVQhyczFITkQPczSFv8BRwnzFLTA2/V3pDoXKzvvYLmFxdzVcxt1vJjqLEpRinh+wNjpdNS6A7C5Avy+XbNa8uFjifTqOcqnbCvrnRu7FVB9MZjxPd05JaQMNuqWQqBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819218; c=relaxed/simple;
	bh=nOGc1cFlxWoNByBIEwbjULSNuxTomN8lTnfBh0pcSSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TsPuTcn6lcKC0LRxXNkFnMr+AXPS9RB5JY1idCm3atmok8ATX5CZtDi0hNFjzikUd9C0AN5WJTG3H+b1vQBWt6LdKC2vodgO6vrdLlAMNtFueFD7XM8MBADoHYm0+Cv8j0K0dxs2Jw5iMgLo8ejeZtKb0hxttUwRJ/tOCnw3aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AYL1O5eo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E383341063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741819217; bh=f84jOPt9U1bHiN66MhNYWZZzC61SlwWeEcWYlAw2pqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AYL1O5eoi4O43pVn1Y7L0xBLFiyLUG4xFQjURpwkRuduU9vzWBiD4t6VF5bTC0DJd
	 9no6vCVS6Y4hqwhLqFzzWvdxd5JYIxmAKJZY+Ubzlux8LUD2di/JCK1As7TxVLrX6m
	 rl7+SZz+YWp39Dx4Qzy4741P9Pg/S6rQt4B3RcJ9HK8NQ08gxuPP27zS+d7gdMdQUe
	 1WtEnbm0EZztUeIgI/BrZmY9m08e6NBgpzOYgagXb6A3eeyyFrv+dd7gDBBjdrBay8
	 cdT/RMr551/bFx8Knk3nrscMQDwexi91EwIrmRclFUmujauN4wyMooZaOut/NwiBfy
	 JqCVQdx9rZAjA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E383341063;
	Wed, 12 Mar 2025 22:40:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: charlie@rivosinc.com, acme@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, I Hsin Cheng
 <richard120310@gmail.com>
Subject: Re: [PATCH] docs: Correct installation instruction
In-Reply-To: <20250306030708.8133-1-richard120310@gmail.com>
References: <20250306030708.8133-1-richard120310@gmail.com>
Date: Wed, 12 Mar 2025 16:40:16 -0600
Message-ID: <87frjhlvov.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I Hsin Cheng <richard120310@gmail.com> writes:

> Ammend missing "install" operation keyword after "apt-get", and fix
> "build-essentials" to "build-essential".
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  Documentation/admin-guide/workload-tracing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
> index 6be38c1b9c5b..d6313890ee41 100644
> --- a/Documentation/admin-guide/workload-tracing.rst
> +++ b/Documentation/admin-guide/workload-tracing.rst
> @@ -82,7 +82,7 @@ Install tools to build Linux kernel and tools in kernel repository.
>  scripts/ver_linux is a good way to check if your system already has
>  the necessary tools::
>  
> -  sudo apt-get build-essentials flex bison yacc
> +  sudo apt-get install build-essential flex bison yacc
>    sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev

Applied, thanks.

jon

