Return-Path: <linux-kernel+bounces-573699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79EA6DAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841AA1699D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375D725EF91;
	Mon, 24 Mar 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="lU3l+Ig2"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB238DE9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822331; cv=none; b=X/Lz4esHrwBgT7AuoOUmLjowQIiqNAIL7wwL6433wAOtpW3mVKuAQriDhsqg+ChSXHN7yBjaScaTHVJujY6dsNvO3E4em2GCRbPJZcD9RlkBNdkEfRYwd60zF4ARK9f/AnWFRkbhk3rXeLPnuxuGIuumYZXxl68A9Q3o1rszf58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822331; c=relaxed/simple;
	bh=SDiqh0ysPGzyCfjrTu72lDTTTS2qXy/UjlB5vc/Sayk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CCtXj3P+1KxYexpqF1qxRdtry3qWcTl3QHfFkUwnq/G64y/21IIRceJbEep8vUHR5FDY2q2RibAUaCSSgtDx+i09IuiPVm3nuILyYKJLijy6Zyr0HIVOLjRof+WjHDbbBPOi9bg+TLIKjIHGJVOjj7wKVYNWMVqNHvTFTDlWFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=lU3l+Ig2; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id wheVtfUP6tfOnwheVt0Wdr; Mon, 24 Mar 2025 14:15:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1742822140; bh=SDiqh0ysPGzyCfjrTu72lDTTTS2qXy/UjlB5vc/Sayk=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=lU3l+Ig2sse+tbumA0SVjxNyqRwt9VRCOOK7vGvNnqxheuInnrGE+QSg23Ao9b2zv
	 F+gzTcNL9kHUF8Wek40TcLmB9lhU9hrsA6gxq2zeDXHj+R8AtXvILnCyo8gQuIrBdy
	 GTdGYyPq0T62lQ9EOfpafCYqsZxzeZ3VAexJDFFpa0bq2rulX/sq7RstsWDF0x5evZ
	 tkGAcE7Yr4cem0lQBl+HoXKD7LhBqTNSpDGIhgBT2joes5ybu+ihPjawpjacM3CzDn
	 20sce6NvZrER8TRUVKvjkiXILbjgfkgujPhkurMV/iZ/Byol0pQcstyJ0ds+hZaOtH
	 9Qq1bQCHwklJQ==
Message-ID: <8bd8ca96-1334-42c7-8dc4-2db1785301b9@enneenne.com>
Date: Mon, 24 Mar 2025 14:15:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pps: gpio: Correct indentation and style in
 DTS example
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324125122.81810-1-krzysztof.kozlowski@linaro.org>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20250324125122.81810-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFwkio3Nsm9t/3K+JUXUTLnymPuZfWkyLodVABraDib2lMMuehDO7OtHqyP9/f5bCkqq7xu5U1aZzkLd4sCZJ75twsEE1HlWKJgOHZd01GBHLG1dn+pd
 lfApRn4G9tJo+YDpH0BHxaXqA45z4zxogwbXE6yaKt9ibi3KgubXMa0pFGtLV8DQ8QQ8iYyQJDWaWlbP7bNwArK/KAYa9onPHWAQV58ZbAYplOqBBey/mi/y
 9ZZZTwwCsVxY47LKhI7e1uN8Jb6rQchYz5PJ659q76uxscWOYFsaxPibqqDWYrBTA4vbwzhOiPZsE0rIEFRL5SjgtAXeoiCkSQpe3BECk0pioaPqnFLLMuhb
 /lSRwkRl1ncZ/uYMneDWju17ujzOrV40SnQyV0IQrTamhDMUqTs=

On 24/03/25 13:51, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   .../devicetree/bindings/pps/pps-gpio.yaml     | 20 +++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.yaml b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> index fd4adfa8d2d4..383a838744eb 100644
> --- a/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
> @@ -36,14 +36,14 @@ additionalProperties: false
>   
>   examples:
>     - |
> -      #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/gpio/gpio.h>
>   
> -      pps {
> -          compatible = "pps-gpio";
> -          pinctrl-names = "default";
> -          pinctrl-0 = <&pinctrl_pps>;
> -          gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> -          assert-falling-edge;
> -          echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> -          echo-active-ms = <100>;
> -      };
> +    pps {
> +        compatible = "pps-gpio";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_pps>;
> +        gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +        assert-falling-edge;
> +        echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> +        echo-active-ms = <100>;
> +    };

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


