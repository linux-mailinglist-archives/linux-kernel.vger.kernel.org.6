Return-Path: <linux-kernel+bounces-422233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B09D9649
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D01C285724
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDE1CEAD4;
	Tue, 26 Nov 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BnJSnDeD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414647EF09;
	Tue, 26 Nov 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620930; cv=none; b=aAqBtvxhfCsxCqWDc7pP6+5sYAEvBjP1Iqt0AeyuqrWNP7DdP6yuHpft9JMvhyPQm/S3JEtGMlJBrs+xa6mDX4kNlmFgpvdxkdCfzFflA8QxfsAMX0mBOJcJ9kgjjxsCKEhh/CaMjzukmqWihVPDaUd9rCuLBrJ3s02PnhsTAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620930; c=relaxed/simple;
	bh=CV+EAh560LJIoimDrOBgkVVzf9cbXH8VFS1iu4pNypc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nYVKqVHtP2Vb3dOp5rbFY5sRYXh50mlH4JryPHpQfolWpyFl1FgqR6OtDRSmBzE92grivkXfTXOKPlW5Pwu8X4memW/4vE6UUuvUKEEn+01dCqX1TffUj6/WQCXR5o83qMHDz+yaYWq8ZwlSpryqPVAkMcPEXAH2+YGk2yL3Bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BnJSnDeD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732620925;
	bh=CV+EAh560LJIoimDrOBgkVVzf9cbXH8VFS1iu4pNypc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BnJSnDeD2UWN82nsol4KcZwcYGcKpTLWn5VI0kfzd46qp7ZJltWhoiJBn+q7Wx/98
	 bsPB7usIlFjU9YhgPIhjsEcJnzNX8mR4HFm70dm/3nz3WP1MfyB2wX9c5cOSpO/W6s
	 Qb8j4amAmvPIBQhX+W8dnlF7yGuWoiuPGJM2cqyiZy798ZC4pyEOdcpjSTgRngPGua
	 hQq6i+fwon3/Eu9kYfCZR6psQFPGJUGQTa5Ivs2k3RNknJL9N3xUsrXs49gvHN70Zp
	 TluYai6VaROKZmWxY7A3pYvWZCZCAw0kDNcSK1vA8rdUbZLhTZN01LYFpMT//kJGPK
	 GNbXq3Rg4rPgg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C4E9317E3625;
	Tue, 26 Nov 2024 12:35:24 +0100 (CET)
Message-ID: <3e485c19-7298-47ab-a2a7-dd94a7ac1a7c@collabora.com>
Date: Tue, 26 Nov 2024 12:35:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie
 Chromebooks
To: Wojciech Macek <wmacek@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241126103632.419469-1-wmacek@chromium.org>
 <20241126103632.419469-2-wmacek@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241126103632.419469-2-wmacek@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/11/24 11:36, Wojciech Macek ha scritto:
> Add an entry for the MT8186 based Starmie Chromebooks, also known as the
> ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> a tablet style chromebook.
> 
> Signed-off-by: Wojciech Macek <wmacek@chromium.org>
> ---
> Changelog v3-v2:
>   - No changes

Why have you dropped by R-b tag if there's no change here?

Regards,
Angelo

> Changelog v2-v1:
>   - Fixed items/const bidings description in mediatek.yaml
> 
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..6191a5320c14 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -263,6 +263,19 @@ properties:
>             - const: google,steelix-sku196608
>             - const: google,steelix
>             - const: mediatek,mt8186
> +      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (CM3001))
> +        items:
> +          - const: google,starmie-sku0
> +          - const: google,starmie-sku2
> +          - const: google,starmie-sku3
> +          - const: google,starmie
> +          - const: mediatek,mt8186
> +      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (CM3001))
> +        items:
> +          - const: google,starmie-sku1
> +          - const: google,starmie-sku4
> +          - const: google,starmie
> +          - const: mediatek,mt8186
>         - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
>           items:
>             - enum:



