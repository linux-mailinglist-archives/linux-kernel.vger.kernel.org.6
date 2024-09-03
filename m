Return-Path: <linux-kernel+bounces-312728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC73969A5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B501F24096
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C991C62D1;
	Tue,  3 Sep 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbLZ50+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA51C62B5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360071; cv=none; b=nsGNH/F3cCjTjllSFWx1vewi7l1ElVNO126ybgFHZGyd6d+23E3W4e8Il1Ck4E40IeOsWp6KLihxAlwsGK1PDikGkxf89EYj9UIweRpSVcCh2APCKW96dNFGhczvCxwOkFNMeH1pAPbyo+wzgPqQJZV5t6r3SpsnUJvaCCFqDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360071; c=relaxed/simple;
	bh=vdSamChvhScNFAigi34S22GZUo0zhekTFtDxWBf3MQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQYwClpb0Y5W8P4WlToIRkhbqdF4DRfis54zd0fz393rOZ0/+n2OtJAVivN9rtfgokR0jRJn1qNcBQ1fshsRzqki14WPgRMgXPaSeSsrEdHoTgHrtGpxS8xCZQT/T+VdT5OuIibcfUf/l8kxEoaMbSQYf32FyzqhFqMbNhYUiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbLZ50+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B737C4CEC8;
	Tue,  3 Sep 2024 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360070;
	bh=vdSamChvhScNFAigi34S22GZUo0zhekTFtDxWBf3MQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbLZ50+8WiXsf6auu5COtQJMs112ZH7HdRmG6VqFTY9jKtX5kinRRyVCGg13enbJ4
	 4NkoPMGf4BKm97QKYDXRkb+M6eLXcwvT/G08pUqzKewoimvIBgUy99RN5sbJQO8gGG
	 xFJZLT9yeYfnSYe0lX8O8xUkpBar4i8wuwh+z9OA=
Date: Tue, 3 Sep 2024 12:13:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 5/9] MAINTAINERS: Update path for U-Boot environment
 variables YAML
Message-ID: <2024090303-affected-hurried-9364@gregkh>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902142952.71639-6-srinivas.kandagatla@linaro.org>

On Mon, Sep 02, 2024 at 03:29:48PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This file was moved to the layouts/ subdirectory.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25fe91a49314..fb25e47adda4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23341,7 +23341,7 @@ F:	drivers/media/pci/tw686x/
>  U-BOOT ENVIRONMENT VARIABLES
>  M:	Rafał Miłecki <rafal@milecki.pl>
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
>  F:	drivers/nvmem/layouts/u-boot-env.c
>  F:	drivers/nvmem/u-boot-env.c

Also does not apply because patch 4/9 did not :(

