Return-Path: <linux-kernel+bounces-289107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092B95421B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65171F2347A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E071F136671;
	Fri, 16 Aug 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DtUekxEa"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909512D758;
	Fri, 16 Aug 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791107; cv=none; b=qUgYhPybpxbqtkQm6HaY6GNlYWuqtuO66QW8sTsJt8ZK5Xf43gMVvvKThJx4RvvztUUVuKNN4rR9RM+pP2sLDdC9AxVTQSwghLgHsbSLX5nNkSQsc2WlKztQPcAbr3UZ5Nn0P910BGVeD8RCr3QYu81UE2C2vlMNWlEZ6PyN8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791107; c=relaxed/simple;
	bh=+hVS3W3MEkjPt32QKq233gBf8FSSn1/LzNSGlcg+J7E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VtnyD9zqAnL8UECoX5wqOIrMeagjO/a8Atrqq8s3PgkY2Tw/MGNvrMHlqb2lXaSDHUMKrCkWqbCOJoLLROI8m+KsPKtNCUhpfftLsJs5GN9Fmk38Jd2n13XKfWkZyaWaW00pch6jJ6K3IxyGSxml3QxXMo45VeMCdiohRNlXWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DtUekxEa; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723791101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erdeOGfMKnjJZthRQ74ZwqFW9cbRAdXya4HEE8czlZo=;
	b=DtUekxEajDyHcJ1DEsY/8VEsO+N6NYgruSKHNHe0ivJpXlj9DQu/LRb+Eg3kHDi0x6mIBo
	gS+Hsibva5U/JDu847lT27TVtlRnMf3tPXALDAvVk9XVa3rpxkalsV6HUL/2mKXzy/Acj0
	fBUWYKfvvG1Fj3JeXQ1WVgXmp5uKvu/ApsuYIYdHC1qLx1bbE5yxTMQ9pps75Wxy1pWhmJ
	2SxOAuk5zOVSCMtwajBHCL+wo26g84iFVAenQILZzc9ci2KZTYz0cWmlwfmuwXHkNbrv7K
	a6BQHUXj0mIZy7QY/5HRbx+MobPTlxrzJsjrGI2xGFXw4H0HmSfso3pHUyFk4Q==
Date: Fri, 16 Aug 2024 08:51:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sergey Bostandzhyan <jin@mediatomb.cc>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: improve eMMC speed on NanoPi
 R2S Plus
In-Reply-To: <20240814170048.23816-4-jin@mediatomb.cc>
References: <20240814170048.23816-1-jin@mediatomb.cc>
 <20240814170048.23816-4-jin@mediatomb.cc>
Message-ID: <002107db3dcf3f1d1d1a767f049b5b79@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Sergey,

On 2024-08-14 19:00, Sergey Bostandzhyan wrote:
> This change has been suggested by Daniel Golle during patch review,
> adding mmc-hs200-1_8v; makes sure that eMMC gets detected as HS200
> which improves it's performance.

Describing who suggested the patch in the patch description looks
out of place.  Instead, you should add a Suggested-by tag, whose
purpose is exactly to describe who suggested the patch.

> Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> index 12eabdbf8fe8..146b1da198b8 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
> @@ -23,6 +23,7 @@
>  	cap-mmc-highspeed;
>  	supports-emmc;
>  	disable-wp;
> +	mmc-hs200-1_8v;
>  	non-removable;
>  	num-slots = <1>;
>  	pinctrl-names = "default";

