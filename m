Return-Path: <linux-kernel+bounces-395186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EC9BBA0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7181F22A93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A71C4A07;
	Mon,  4 Nov 2024 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELeHiV4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245F1C302B;
	Mon,  4 Nov 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737074; cv=none; b=R/hPJ/Vcc1lZb1VpOIsWNaTnTXUB6uawf09w3z9t18MktotYa6Cnq01fP2FkQJN6/bBa505rnKpg6B6zIQ9/zhxiWqvDLCwEhl8Hcx7XuOCZ8bJO803NZpnfy66vHAW1tyUiYDk9jQYkSCFbpAHwMJlVFXSN7MvToNlT8oWVjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737074; c=relaxed/simple;
	bh=bfAsiSNijIbn9dA6dCEoAJCNnIpUVnYgwURSK8OS4ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQobsu5VIIO0CwXbww039kEDHa0/CXJdYHHK64Cdfdwlp+dlQuyk9aHYM5wgHRstQ5aj4N5sROgIm+YRmg5eW+oDsYexrLYOGK3RiNyX1esar8OlBdstoNlH3TaaI4uI2RaskbtNzdVYc2xssA3PRlYSObUAbcpPpDZt2M5bX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELeHiV4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E502C4CECE;
	Mon,  4 Nov 2024 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737073;
	bh=bfAsiSNijIbn9dA6dCEoAJCNnIpUVnYgwURSK8OS4ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELeHiV4vJKBVJKglPnNwM4FU9h4OgvTXusWR8lAPnMYQkdfviOs8EYxwcL7BFbdiL
	 2RVJSf42kx/VHzzyjb4XTns0+4vRba32OT2rKvpm8SOwYAx5UdrChcvvsSZ2CEFndf
	 daO4CLeyWE5Lbh8G7KVLF5o9n7K3VsPFRKrVV44BpsC97egsW8iREvcfqojKpnzwj1
	 03GkPzA0xMlNzY9F/Q3KiNX+Iqyda+V0dAPhUZYMyiihT49jsH9JICKfJKpendetVR
	 cx3TENatm5/RUWWRx9XlsjY818EJGeRDOmYYG69p1JW1AKCDsHHhDGMSFgkG2nm4P1
	 lv2vYvcLarrcw==
Date: Mon, 4 Nov 2024 10:17:51 -0600
From: Rob Herring <robh@kernel.org>
To: Ki-Seok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT binding
Message-ID: <20241104161751.GA320514-robh@kernel.org>
References: <20241104-irondevice-sma1307-v3-0-4bbe79895f54@irondevice.com>
 <20241104-irondevice-sma1307-v3-1-4bbe79895f54@irondevice.com>
 <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>

On Mon, Nov 04, 2024 at 07:33:47AM +0000, Ki-Seok Jo wrote:
> 

I don't see the rest of the series (I fetch from lore). That means your 
threading is broken.

> This adds the schema binding for the Iron Device SMA1307 Amp
> 
> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
> ---

v3, but where is the revision history?

>  .../bindings/sound/irondevice,sma1307.yaml         | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml b/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
> new file mode 100644
> index 000000000..0bb4ee664
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2

"%YAML 1.2" goes on the 2nd line.

> +---
> +$id: http://devicetree.org/schemas/sound/irondevice,sma1307.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Iron Device SMA1307 Audio Amplifier
> +
> +maintainers:
> +  - Kiseok Jo <kiseok.jo@irondevice.com>
> +
> +description:
> +  SMA1307 boosted digital speaker amplifier
> +  with feedback-loop.

Wrap lines at 80 char.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - irondevice,sma1307a
> +      - irondevice,sma1307aq
> +    description:
> +      If a 'q' is added, it indicated the product is AEC-Q100
> +      qualified for automotive applications. SMA1307A supports
> +      both WLCSP and QFN packages. However, SMA1307AQ only
> +      supports the QFN package.

Is this difference visible to software? The package is not, so that part 
is irrelevant.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        amplifier@1e {
> +            compatible = "irondevice,sma1307a";
> +            reg = <0x1e>;
> +            #sound-dai-cells = <1>;
> +        };
> +    };
> 
> --
> 2.39.2
> 

