Return-Path: <linux-kernel+bounces-246129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E7D92BDDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42407289850
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DE19CD11;
	Tue,  9 Jul 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MoJF/HEC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A419CCED;
	Tue,  9 Jul 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537827; cv=none; b=nAL5FcCtPI4+AeLpwSHdCHk5A1PIrdP0XDzMa/xnH/+9CGiC2ktwv/GK8s8VDvDJoeiXNJGNV6eDeKb1HF4xAe+3s7b5uNzi6Vv37yLBOYQgAgbkD3sZ6Hl+5xjn+lWz/1MSOfNnB6yxEjGVtWS+Taqua2XIyD0s2axtu32jes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537827; c=relaxed/simple;
	bh=bexX9PeTKg244ul9jCnM1y4ygq1g4p/lXHMFhQ58Kyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pm/sOkN88JcNkQruh7DnszvjznHOqcgbIugbJ9rhRGURUu37e7jJF2SfwZxQ8qrRPRTNkQoV3VfGhgPiCPE1ffkDxGkkC9JOTk2y3xEpiH354Pt1tObKucwDpkPqpBf2mJdPluHEPp/6p4qyqnFlme9/J6eoO1s9Sn1+2AQUfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MoJF/HEC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3363F41A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720537825; bh=6Jn3oeMGCWhaaCzq7lNvNUsv84+X5NCreXdp/K5oSy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MoJF/HEC6yGUDX4wYbrSIF6UzPcRTyGfCi/rHeauo5hEIz4noiGM4ouu5GZUms7c9
	 eah7Lhc2aA+df4Oe3Wa6C3PxQOje/bp8kcumTpxewBd+Q4Lc/LdaLzUfXfGZVWPVqY
	 r+yiiWQpzcAWqiBFAhhEptrkLODqu66zNS/imzuyKp9niutjrhwCYAgT1J4RYC8ILy
	 mxx1mxtaIkthiMGVjiPM2fTErNi1dSXTbSSw1LXN8CnjZWwfwqoOa/+otNyRJcR4ug
	 ke6lTo2/HQur6CtK4AZQ0LBuxn7iQrPHF/oPx6UHJKYzynHTJCaF4cjqnS0VRUI34L
	 26ZMCLdUagp6w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3363F41A36;
	Tue,  9 Jul 2024 15:10:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Richard Genoud <richard.genoud@bootlin.com>, Bin Liu <b-liu@ti.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Genoud
 <richard.genoud@bootlin.com>
Subject: Re: [PATCH] writing_musb_glue_layer.rst: USB Configuration Wiki
 Page is down
In-Reply-To: <20240618151938.1827064-1-richard.genoud@bootlin.com>
References: <20240618151938.1827064-1-richard.genoud@bootlin.com>
Date: Tue, 09 Jul 2024 09:10:24 -0600
Message-ID: <878qya8uu7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Richard Genoud <richard.genoud@bootlin.com> writes:

> The http://processors.wiki.ti.com EOL in january 2021
>
> The old documentation is still available through the wayback machine.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>
> I didn't find the new web site, that's why I fall back on the wayback
> machine.
> Bin Liu, if you know a better alternative, feel free to nak this patch
> and send it.
>
>  Documentation/driver-api/usb/writing_musb_glue_layer.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
> index 10416cc11cd5..e755c8551bba 100644
> --- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
> +++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
> @@ -717,4 +717,4 @@ https://www.maximintegrated.com/app-notes/index.mvp/id/1822
>  :ref:`Writing USB Device Drivers <writing-usb-driver>`
>  
>  Texas Instruments USB Configuration Wiki Page:
> -http://processors.wiki.ti.com/index.php/Usbgeneralpage
> +https://web.archive.org/web/20201215135015/http://processors.wiki.ti.com/index.php/Usbgeneralpage

I've applied this, thanks.

jon

