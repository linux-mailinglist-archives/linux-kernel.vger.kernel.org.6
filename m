Return-Path: <linux-kernel+bounces-435351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA309E766A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A521614CD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458021F3D2F;
	Fri,  6 Dec 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PalGbWGf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A658206262;
	Fri,  6 Dec 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503922; cv=none; b=gHWK9S3mFTogbokQkdQGtgdkC31fmO3ZiRkX6DruaShFZFb1+KfMS/+KihNHNOsp74NvHZp+QW1JpdqnaT/3loIuqy+EdTRn4DDeEm/kvs1IsvjfyOfwKDy2MsFJc9g2zc+HId0RDO0XbRxrSfRrhEV05XosA/ycloUjTuo6KKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503922; c=relaxed/simple;
	bh=FN9nhIJzBhecUHMBE9d/uBJaiCApRdEAX5H8DyOTyFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dksfEOpmv9Ait7Df5llBzjRbtVWzjhYg4WvRUY+B4H+Vppgk5cKF7N1TuPuEjuW3dkJlwLAMIKx6LOyuOlbMDWmxHwrXwMFksZzDPj73LeNebSnVeKoWLrR1aT1xU2MPJ22HaL/6x5dzVhcw6GYKjsEmartNlzaUdmo+FDHiz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PalGbWGf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6B0444040A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733503920; bh=wjHcgMg27yH6RzknTEBhDR1zWGuFwkX/16m/dqb20O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PalGbWGf4W2l1gvlMp8jOEsbUMOZx+jyNA61Q5kHYsz0uZe85IkNwBeiFYm70dz7o
	 AYZ/pT+1mvqSobyU9NeX9bGlcWckvL41L45I66i6thfeB3uHPKhBR/v9XvAvt0KrNx
	 8xV8k+z/wM9RfN/jxwpyGW29aZpbLyGPXnFSUDcVf3PAnvuLaLFvoU55JulDR/WmHp
	 rgJIbAK1Xu5k5fAKGXFkTOxL9xuABpIVV7fh7Mgld1wAFClPMMcdOyObdTZnGUEP/b
	 bW6JspAmc7BPoYDI6O/JycG/YQPlxLBLIvwp9N599BSYtnqR3G6ho7mpkV2qfYQTGP
	 NbQejZga6Kp6A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6B0444040A;
	Fri,  6 Dec 2024 16:52:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove duplicate word
In-Reply-To: <20241120043414.78811-1-RuffaloLavoisier@gmail.com>
References: <20241120043414.78811-1-RuffaloLavoisier@gmail.com>
Date: Fri, 06 Dec 2024 09:51:59 -0700
Message-ID: <87zfl8sqj4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ruffalo Lavoisier <ruffalolavoisier@gmail.com> writes:

> - Remove duplicate word, 'to'.
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index 30c61474dec5..43b128c0225b 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -41,7 +41,7 @@ pre-allocation or re-sizing of any kernel data structures.
>  dentry-negative
>  ----------------------------
>  
> -Policy for negative dentries. Set to 1 to to always delete the dentry when a
> +Policy for negative dentries. Set to 1 to always delete the dentry when a
>  file is removed, and 0 to disable it. By default, this behavior is disabled.

This patch lacks a Signed-off-by line; please see
Documentation/process/submitting-patches.rst.

In this case, it is trivial enough that I have applied it anyway, but
any future changes will need to be properly signed off.

Thanks,

jon

