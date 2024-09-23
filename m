Return-Path: <linux-kernel+bounces-335815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012E97EB19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5BE1C2158F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D719883C;
	Mon, 23 Sep 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5ZEe+/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC741EB48;
	Mon, 23 Sep 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092387; cv=none; b=R9j2yazD+/flN7zdXgcI8TJiMn6pKYA1GZN4/WV/lziMqwIbBOx/gkgt0XAklg+ApjDVhO0yhB/nUBgblh6CJHyEr2mjM43fhiLPhvZHmiKwCT1R88Lkz7FbBMEZMa9taOqE1Tob8YZA4pK3mLf/3wjoxCPqqzMIa5NAbiPpJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092387; c=relaxed/simple;
	bh=BHCAGMjIfbhDX04xdZmHDFbvFp+bkX7fak28gq87iMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdPNFoFMMqqunL+2tvqARyZdbofdhQiHh428up+JMuLN8BrfcoQAYXHXNw+TkjiPK0CaMEUwI8vtiyGBXfxO6ryoCgxwyXiWRCBuwEscYsUOL3Y+XVN9TcvdMxaLJIl3u2u2+tLssyzgR8Yhimte8kvQMUwI3aBkyX3dYgAFtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5ZEe+/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5078CC4CEC4;
	Mon, 23 Sep 2024 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727092387;
	bh=BHCAGMjIfbhDX04xdZmHDFbvFp+bkX7fak28gq87iMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s5ZEe+/1C9RNXAbdxM9JZPxfllH2UGzYtgh26TiTjjHcFKB5e+7tmXKvPBKb9u4xo
	 7CFHH1vj/6/73vF5nV+YegbueAIi74ggtrHVEGERJAJHc4ATcM4Mn6dT0g1kM1QpwG
	 GdnvqviV+d+HB3C6rIQNy8ohmS1d6E6fpASIaiBso41P/SjLfI5r9zO69+w0Oh6hz3
	 QxWXsE6zHY9sexaXtINuC0rnDTr+cyu3mbr5RSpRPedZXPR1Xesqo2NZsQ1ftDOrA9
	 Qo+ZP0CMzq9G7wy5C2SKxD++6fNXvrnlsKOMVRDKV/Q7NMvOvy6ZS1Mme1FtLWBOmj
	 u32AKj/xywBhg==
Message-ID: <a02e472c-f206-44d3-9a6b-d921e73110fd@kernel.org>
Date: Mon, 23 Sep 2024 14:53:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: add missing compatible arraylist
To: Karan Sanghavi <karansanghvi98@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZvBNLRc8xnAoGvoc@Emma>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ZvBNLRc8xnAoGvoc@Emma>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/2024 20:00, Karan Sanghavi wrote:
> Added the vice versa order for compatible property in the yaml file so
> that the dtb can parse for the order mentioned in the dts file
> k3-am642-sk.dts for ti,j721e-usb.yaml

k3-am642-sk.dts does not introduce any nodes with the said compatibles.

"ti,am64-usb" compatible is introduced by k3-am642-main.dtsi.
There is only one compatible introduced so there is nothing to do about
order here.

i.e.
        usbss0: cdns-usb@f900000 {
                compatible = "ti,am64-usb";
                reg = <0x00 0xf900000 0x00 0x100>;

What is the functional problem you are facing? Maybe then someone
can point you in the right direction.

> 
> This is highly ambiguous to me as where exactly the changes needs to be
> added is it in the dts file or is the yaml where we have to reverse the
> order already mentioned or do we have to add the another order as I have
> done ?
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> index 95ff9791baea..822653217c43 100644
> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> @@ -17,6 +17,9 @@ properties:
>        - items:
>            - const: ti,j721e-usb
>            - const: ti,am64-usb
> +      - items:
> +          - const: ti,am64-usb
> +          - const: ti,j721e-usb
>  
>    reg:
>      maxItems: 1

-- 
cheers,
-roger

