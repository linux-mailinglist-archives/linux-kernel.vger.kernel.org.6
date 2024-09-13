Return-Path: <linux-kernel+bounces-327827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB008977BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 762DEB258CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D914D1D6C4C;
	Fri, 13 Sep 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J1s8dfmo";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YkeDtf+w"
Received: from a7-32.smtp-out.eu-west-1.amazonses.com (a7-32.smtp-out.eu-west-1.amazonses.com [54.240.7.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5741AD256;
	Fri, 13 Sep 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217762; cv=none; b=I8rB1ZavceME8bEQKrsPvMY9yR+0Ld57ySOzf6uTfvELE2gHhBtR8Yn2I7XPBi4GaPQiADIUWCw9Pyy0t93C6jtqzbkWJQfpV7GRVdW/PQNv2JL1VbWewgHElijdLz8GtqwWD7dyxN5sCDEBeMIAxMgIQa5LvA3rqUkh0PuI/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217762; c=relaxed/simple;
	bh=yRGGn9KUcYp+ecXIoiuLZBY3QdwMcXtt0dMTBMqC+Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twNNQo7OJxwAoBn68HW1wdjYBWY95Li8sgH+MZXFSaqu5WfiYsI/hpiZjBkFWOlBTkHWsKso/lT0UvtSH/Qj92OpZNTkDlRE8bi7//B0PfkWgURAjIztvjF/qgbZsSr+xJlTcLLKUBNdtsgksoDbtt4+L9mKT5N3DdkXznztJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J1s8dfmo; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YkeDtf+w; arc=none smtp.client-ip=54.240.7.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726217758;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yRGGn9KUcYp+ecXIoiuLZBY3QdwMcXtt0dMTBMqC+Oo=;
	b=J1s8dfmoeCoXie2NoIr5GgXLR3tnjN+/YL7PHr6Qq7OG8wirlezjvKjyoFTuWiZE
	tf1MJwRQmSgEL96UFThJ4clzGQeK07CGIOnOOoFbXsGjokyzgMRCd8FdbpZ/wqYLWR2
	IOijmY4xUxK/6b2y7LUQdKXQDyTBP99E/E4cgLM66D7na0wujBjhaee/zyRx20cXYyW
	willCxzoAggd5qA3iHMk+zGctgghmUukT9BE3usFGpQkflf6ZPKyBLbim00xKPf0bRg
	wH7kJyivEYE0XgQOSGoDYTZg/YpMtS0RdeMV8YsiV/hyzUrX0O9ZPEF5btCUgcWoobu
	4lf3Bcofbg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726217758;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=yRGGn9KUcYp+ecXIoiuLZBY3QdwMcXtt0dMTBMqC+Oo=;
	b=YkeDtf+whiDS718vK4g6f8eVb3O/c/g+4EnaW2/ic1nIXOy31oRmfbrN42QJE4bL
	jKRK1LdovtTjGYJYTl0ATmtSymkaitSl/6EcWqiqBqBCjW66HcDxmExAYkDI+Zpiq9y
	mVfdXxcXoLjsZpDhydLhvEk47xHrNeEyXfO8csJw=
Message-ID: <01020191ea98a643-2d0be5d1-e00b-48e0-b823-bfe2c65b0d00-000000@eu-west-1.amazonses.com>
Date: Fri, 13 Sep 2024 08:55:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta
 Chromebook
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>, 
	matthias.bgg@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, knoxchiou@google.com, hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240913031505.372868-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240913031505.372868-2-cengjianeng@huaqin.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240913031505.372868-2-cengjianeng@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.13-54.240.7.32

Il 13/09/24 05:15, Jianeng Ceng ha scritto:
> Ponyta is a custom label Chromebook based on MT8186. It is a
> self-developed project of Huaqin and has no fixed OEM.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
> ---
> Changes in v5:
> - PATCH 1/2: Remove sku2147483647.
> - Link to v4:https://lore.kernel.org/all/20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v4:
> - PATCH 1/2: Add more info for Ponyta custom label in commit.
> - Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v3:
> - PATCH 1/2: Modify lable to label.
> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Chage since V2:
> - No change.
> 
> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..43a824bee1b6 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -257,6 +257,16 @@ properties:
>             - const: google,steelix-sku393218
>             - const: google,steelix
>             - const: mediatek,mt8186
> +      - description: Google Ponyta (Custom label)

Instead of "(Custom label)", why don't we just label it as "(Huaqin ODM)" or as
the ODM board number (if not confidential)?

Or we could even drop it and just say "Google Ponyta" instead, maybe?

I don't really like "Custom label", as that looks really like a placeholder
for something else, which doesn't look right.

Cheers,
Angelo

> +        items:
> +          - const: google,ponyta-sku0
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
> +      - description: Google Ponyta (Custom label)
> +        items:
> +          - const: google,ponyta-sku1
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
>         - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
>           items:
>             - const: google,steelix-sku196609


