Return-Path: <linux-kernel+bounces-445088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F349F1117
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6992528292A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A0F1E2613;
	Fri, 13 Dec 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fVz9MSNL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEC4A21;
	Fri, 13 Dec 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104189; cv=none; b=E4cCFRzppcwXOhvb12AingSrteoAXtPY3DOjwoDq4V5oGZhkhYljeYJyZQnXqYeKPQNnxs4lhvC6toANYba8GZq362iueAD47sw1c/lXe1C41WRX9iwYcFKoVwR+6NeEzMPU69TjbA1W4RDKcaeevXhjHwWfm+LSX4rWEdGUEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104189; c=relaxed/simple;
	bh=oIOzX+vOpJyjLojOEEi4ugtWdFqi5Lz8ejWHCUPxgwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NL/KaveX+BU3BaEPP0lAFufgRR3kHRw4DtPP9/KpaQ9HXlpNZ4c5PmQuSJ103o8+a+exRBE5LtlfdySyZNFsO7ICP3YFB8UntnAHaB6yXOWReDbuR0BX71GC81r0fLJCmYivbaqEfy6Rhmq5bHS1FK6CdKuG4CsjTaUsXrHFH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fVz9MSNL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15838403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734104187; bh=kHjmEaxa2GbA3waLlFNsQZGKLNcayQZROKZU83HD2Nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fVz9MSNL9c4AbMLYyfIbiX/9ZEX0wpG65UG62kGp+u+UKAocTe0H8BxuuVFf1U6R6
	 lpxy75f4WGMUr5avjivgzZ0qFW1st6HEdG/9XJojflATTNZe5nC6lxWfcGTSxRQVVE
	 oCa9gDhe6Yi+IQZWQ/VN2wRv1BzW6sWSqS0qedjdA0dkZR4XmGSgS2kAlnyUK95t3j
	 F1Vg3+Jh4CiIc7K/FIz6IZox9VRNiSZ+YF9dpYU8TvjZS02EhUEwrWxS+sYRFDdDLu
	 0pNYDMiLdpuEpFAynvftdSmoKwFoBlqeIuurgWtYAT+DQD10OlK3s/yHM9ZKrFA3ty
	 EV3GkUguHvqKQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 15838403FA;
	Fri, 13 Dec 2024 15:36:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: cem@kernel.org, linux-doc@vger.kernel.org
Cc: cem@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix simple typo on filesystems/porting.rst
In-Reply-To: <20241213151743.23435-1-cem@kernel.org>
References: <20241213151743.23435-1-cem@kernel.org>
Date: Fri, 13 Dec 2024 08:36:26 -0700
Message-ID: <87ldwjy4qt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

cem@kernel.org writes:

> From: Carlos Maiolino <cmaiolino@redhat.com>
>
> Just spotted this while reading the doc.
>
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  Documentation/filesystems/porting.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 92bffcc6747a..2d08fd4a2280 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -313,7 +313,7 @@ done.
>  
>  **mandatory**
>  
> -block truncatation on error exit from ->write_begin, and ->direct_IO
> +block truncation on error exit from ->write_begin, and ->direct_IO
>  moved from generic methods (block_write_begin, cont_write_begin,

I dunno ... "truncatation" has kind of a nice sound to it ... :)

Applied, thanks.

jon

