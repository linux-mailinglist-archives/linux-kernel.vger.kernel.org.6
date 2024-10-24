Return-Path: <linux-kernel+bounces-379772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABB9AE37C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E709282D19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988251CB9E4;
	Thu, 24 Oct 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h4v8fwln"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942F1C9EB7;
	Thu, 24 Oct 2024 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768137; cv=none; b=TT5QIT39HJ843UFU6DjXyAMts830Cqe2tAQVQ3nD8eAv40BWP4DZxsLj3v7G4mUcfq8ZwtWAMDInAdR2bIT7jwUWSuEOyCZ9ofyDws0rCVZ4f8HgCR4ohXIqHQrbkO5ZYXrrkAt5pAracHeHAqX68k7w9o39r7wAQNKitNT07IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768137; c=relaxed/simple;
	bh=MnKSyhEsyEdO5LA9IJjUNtWEaFpz4mZqpHKbzfWsJ1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wtx0Bu+eL18gxB7ReFsWOii1FSxuRbOFQh9fqNVwhp2LIQIQJUC8kk2yWiPqIlDosEf+sbcC+/vTAwh1Nx1DHPt9A+kqfKE52gEsbuKfiEVosWs5bCYmNl6/u0B1jHAZO6n+n5LqmVsB1La03pnfHKK/BjNVaiIMgbOmkWVTmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h4v8fwln; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729768133;
	bh=MnKSyhEsyEdO5LA9IJjUNtWEaFpz4mZqpHKbzfWsJ1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h4v8fwlnqIlVmTuT7OQfJPxDVKa/3JPBK3JfgdaYs3MZCS/G3QecI/lZYEq9/wIba
	 qTjmlX1IkxoCd4p4Sw0bBy9VxyIJCt5RBvVntUrx4Iq8RQTIAyiN6z/mGYcEJornZ8
	 0K3dWHQW7LbOU1aYtboaYQWZ17CvzupuZ75/P6sjP8yEtAhssTN3MowRIarmhTByyi
	 bzMlHzhmE7LAlWDxW/Hvl2lOT89lMqTJA0hPEP/d5Z9jNIvqzzUtD3PleUAuo2xMYF
	 /s0MMvQugu6AJ65TaCbpk9yRIKU3V+RnM2SKPDJjoXmrr/8UmHBrPjbRlj7qtDrog5
	 43gfwNGTELK2Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 904DA17E1541;
	Thu, 24 Oct 2024 13:08:52 +0200 (CEST)
Message-ID: <c2ed4f4b-3f02-4de0-820c-04640cd2cfc4@collabora.com>
Date: Thu, 24 Oct 2024 13:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: mediatek: Add apu-mailbox
 document
To: "Karl.Li" <karl.li@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chungying Lu <chungying.lu@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241024092608.431581-1-karl.li@mediatek.com>
 <20241024092608.431581-2-karl.li@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241024092608.431581-2-karl.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/10/24 11:25, Karl.Li ha scritto:
> From: Karl Li <karl.li@mediatek.com>
> 
> Add apu-mailbox dt-binding document.
> 
> Signed-off-by: Karl Li <karl.li@mediatek.com>
> ---
>   .../mailbox/mediatek,apu-mailbox.yaml         | 55 +++++++++++++++++++
>   1 file changed, 55 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
> new file mode 100644
> index 000000000000..cb4530799bef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mediatek,apu-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek APU mailbox
> +
> +maintainers:
> +  - Karl Li <Karl.Li@mediatek.com>
> +
> +description:
> +  The MediaTek APU-Mailbox facilitates communication with the
> +  APU microcontroller. Within the MediaTek APU subsystem, a
> +  message passing mechanism is built on top of the mailbox system.
> +  The mailbox only has limited space for each message. The firmware
> +  expects the message header from the mailbox, while the message body
> +  is passed through some fixed shared memory.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8188-apu-mailbox
> +      - mediatek,mt8196-apu-mailbox

In addition to Krzysztof's review......

oneOf:
   - const: mediatek,mt8188-apu-mailbox
   - items:
     - enum:
         - mediatek,mt8195-apu-mailbox
         - mediatek,mt8196-apu-mailbox
     - const: mediatek,mt8188-apu-mailbox

should be like that - I haven't checked if this gives any warnings, but anyway
you got the point, I think.

Regards,
Angelo

