Return-Path: <linux-kernel+bounces-364654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A436399D77B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFB71F239FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B51CF7AA;
	Mon, 14 Oct 2024 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aIrV7BYp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8671CEE84;
	Mon, 14 Oct 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934123; cv=none; b=nExbErt7U5WaQJpPq7eauQRJ1dpBM9csvTllF2JeCBAq6n8KCUQJ8byFAaeFebFiqCLtKA3If1SVlG78zZd3jlD6A1bSxwHCN2JWL0GK7qESfBiPxUwTpvSuNC3Adl/PrPknE1s7qhWat7stCw29Pjr9ixnL1hCSRhDGiZrDUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934123; c=relaxed/simple;
	bh=IWnzP00wzrDv0auMLOlud0uz1nYqK6oGV9xppajUfDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deqMgPgiqRxmp6SpL4huEd41c9LxoHZ2alXiCmUCIa5NaFyDVnlhJWDlFVxYAjUJZYHD6AdF5t+FWBV6eqLySTUaBFKy6YGwiDYOps+XBNOuOvgKFg+GrIwZnVtMRDELfcXoAzOK0A1qAi49kmzo7Wyawl0t0BqQ8yTTVmuLreo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aIrV7BYp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 106DE42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728934121; bh=ehW9SNQgOSlaN+HFXu1QIy9eUOI+LDWn+1IDhlmUqdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aIrV7BYpKx7zMAGgY1QrbPIAKUYAeUmfQa3+7WBw1l4+ZAV+IBLybG3sJ+rO409/Q
	 dOAgQScsmeGqVeIMjcGIsMjue4vBUo6oyiUljgbIVmROcxVb3QaVI9t4OPHPiAQbRf
	 oBnE72rG0e5yVtHXU8wMUt5fLDvpYod7UCm/KlBMwxyuJzrQ/j0ZLVSBPSxwAsK8Xl
	 zeDTqJ4jXNujrmExFAVLOMZkqo/R5ir2pn8haK7x800SRlyVsLlesYch9FaxPHBZX2
	 0NmuWzjJcd27nBJmpjs/1TSUE3HriioSV0h4pMpLv9L3C4XKDuRrDFaLdvHD1OHdNU
	 xc7jKLerF25zg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 106DE42BFE;
	Mon, 14 Oct 2024 19:28:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vishnu Sanal T <t.v.s10123@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: Re: [PATCH] docs: update sysfs docs
In-Reply-To: <20241004141303.46592-2-t.v.s10123@gmail.com>
References: <20241004141303.46592-2-t.v.s10123@gmail.com>
Date: Mon, 14 Oct 2024 13:28:40 -0600
Message-ID: <875xpuscuv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vishnu Sanal T <t.v.s10123@gmail.com> writes:

> update sysfs docs with documentation for all the subdirectories
>
> Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
> ---
>  Documentation/filesystems/sysfs.rst | 57 ++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> index c32993bc83c7..b455ab32aacc 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -302,43 +302,64 @@ The top level sysfs directory looks like::
>      net/
>      power/
>  
> -devices/ contains a filesystem representation of the device tree. It maps
> -directly to the internal kernel device tree, which is a hierarchy of
> -struct device.
> +block/ contains subdirectories for each block device that has been
> +discovered in the system. In each block device's directory are attributes
> +that describe many things, including the size of the device and the
> +dev_t number that it maps to.
>  
>  bus/ contains flat directory layout of the various bus types in the
>  kernel. Each bus's directory contains two subdirectories::
>  
> -	devices/
> -	drivers/
> +	bus/devices/
> +	bus/drivers/

This is overtly wrong, that is not how the directories are named.  The
original may not have been as clear as it could be, but it was at least
correct.

Please have another look.

jon

