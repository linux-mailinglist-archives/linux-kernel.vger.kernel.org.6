Return-Path: <linux-kernel+bounces-524128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C972A3DF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89497A4B27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32BE1FF1B5;
	Thu, 20 Feb 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gvRfdxP1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4F1FBC9E;
	Thu, 20 Feb 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066966; cv=none; b=Vkq3/3pACjs9h9I9BqkegMOw6z2GZxFR+WIqpjqKwqZR8eOxRhRp0mJ68zL2nqPlkSkeRAC1W+YRA+0zwtUpxS1SD9/N93quLt4619u2F7dzJUcZIDZfgdKojwN/QwBH6ce7qqpGF7JoYxO0fYtLbQmLa0SMYeBOS1KG2R3Yit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066966; c=relaxed/simple;
	bh=Dd68mWyJibumUB8TwEojxnqCXZ3BFmtso9EvwgpCMTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4T9IZbZvyuc8j7G8ulIEmuMFfP6ClWKkpnTJsNH1QWEI4CCzeRc3hdin9VIRu237xHF694/Lw/Mr+Tit6YIVOM8gwuHumwnoaC4gX9i4CNNRwfbO7kIKhRfq50NF4zvQHGlc/sjACcGAnQsEbbyqDW0icIigswrUArywoypeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gvRfdxP1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740066962;
	bh=Dd68mWyJibumUB8TwEojxnqCXZ3BFmtso9EvwgpCMTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gvRfdxP1yjGqu7HQ7lttCRdMEE4nZ8PLonPHC5dan9B3mNW1GnHKIiDLkkjIj2v3g
	 KHypzBBQk2cW9FHUWtjDzw4ryElrN1yujKOACsgkVW4B/QXOmrUs+LQ2BYG7Nli+hP
	 O0K8W5n7G0IjxbxqSTYZ5XTCki04ysZiEtImkwyPARnqBIyobzZTex7ihtm7UrZYIC
	 dgLhEjpr1FJs3EU81c5mxE81nm5/f+Ux4GfhYn9TGYAyIV/J6FDRpD8aNOLVWuJ+Bo
	 A2j0WrGnX2umT9I3mFst3Ft6at+hoj4OMwnJV4mHWTPhnaZolCe5GyrsLCg/MWIV9A
	 siui4kJs6qApQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E4F617E0E95;
	Thu, 20 Feb 2025 16:56:01 +0100 (CET)
Message-ID: <ae34efcd-4fe1-4e45-a1e1-0744138a84b9@collabora.com>
Date: Thu, 20 Feb 2025 16:56:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: mtu3: Add ports property
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Chris-qj chen <chris-qj.chen@mediatek.com>
References: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/02/25 15:22, Macpaul Lin ha scritto:
> Define the ports property in the mediatek,mtu3 device tree binding schema.
> Include definitions for port@0 and port@1, specifying their roles as
> High Speed (HS) and Super Speed (SS) data buses, respectively.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Some SoCs do have SuperSpeed peripheral mode, so for this commit

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/usb/mediatek,mtu3.yaml       | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index d4e187c78a0b..21fc6bbe954f 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -155,6 +155,18 @@ properties:
>         property is used. See graph.txt
>       $ref: /schemas/graph.yaml#/properties/port
>   
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: High Speed (HS) data bus.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Super Speed (SS) data bus.
> +
>     enable-manual-drd:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description:



