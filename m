Return-Path: <linux-kernel+bounces-274150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6C947400
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86150B210C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2813D53B;
	Mon,  5 Aug 2024 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XmONgy++"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BD225A2;
	Mon,  5 Aug 2024 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722829948; cv=none; b=gKdL3vvi7HLUrXV/IRNs6gM0N65SjJt/fb1cJ0P/qz0nCMys5BOZqpFzDVnGKY8UUdOTXP48HAFilF5A1/jZ4tBRqE+cALgA/6HMOATylDqsgavUOnaa3uRXgkhzYOw962DP3a6198eA2rOSalIlqycLTjsnlUrWI5qg2wwyp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722829948; c=relaxed/simple;
	bh=ZwlnphfCoEMS+z+iQWMwIhBP6iE2KkGeJ1dcX4OZt88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwAJIJ38yzUipD2n3SOZttJSzYB0bvxkobg8wFKQZ5G5XNgY0GcXJFBStN20zTxYtokQmcYNMh1ajt7I9r6SL2jzCh7D/ER/hBrhZCGlLROGYjwhNjzl7uQTyhyKYm/N+rMq+PpSBmTTEc8957DY2x+Gn/zbLBfyxgfbDg8CXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XmONgy++; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722829936;
	bh=TZvll+HrPvEqH8y0dNSmG8aX1CRXxihPJx0XNGZTiG0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XmONgy++mPxu3VFgoGB6JR3uIFqenKM+jkKleyY5t+itipZDhN1oEQI5oxcJUZx9A
	 ql/kTTc//AcRbkmm42wIdjhKPRnIFGerv5d5kjtQOuoqX70UlUceSa0eOBG98iXcwq
	 qFEOnx0ybyvB1x1X4ZWsOvedJ/xTs4s4n/kVky3bbpu6u/jZoypvkKtA4787Q+U2Ki
	 WKepPFMF90e8BdPx1MkxCy3Rbs/2aoKwqQGVx/FzFD+BkJB6xB5UfqRKTw8G27E6xZ
	 sg8PAICL/lvZxWWEYxd/7UaMiGQbCXZc+5k9tolpHEIM760HOLtL7UDTvcmShlgqqc
	 TCdi3toOBzu5Q==
Received: from [192.168.68.112] (ppp14-2-105-65.adl-apt-pir-bras32.tpg.internode.on.net [14.2.105.65])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 73A2465665;
	Mon,  5 Aug 2024 11:52:14 +0800 (AWST)
Message-ID: <1176b2ddb609b462004fa7e7b36fe6657b89bbf0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: catalina: add Meta Catalina BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, Krzysztof
	Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 05 Aug 2024 13:22:12 +0930
In-Reply-To: <20240802-potin-catalina-dts-v6-2-0b8f61b80688@gmail.com>
References: <20240802-potin-catalina-dts-v6-0-0b8f61b80688@gmail.com>
	 <20240802-potin-catalina-dts-v6-2-0b8f61b80688@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Potin,

On Fri, 2024-08-02 at 17:07 +0800, Potin Lai wrote:
> Add linux device tree entry for Meta(Facebook) Catalina compute-tray
> BMC using AT2600 SoC.
>=20
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>

Running this past checkpatch gave me the following:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Potin Lai <pot=
in.lai.pt@gmail.com>' !=3D 'Signed-off-by: Potin Lai <potin.lai@quantatw.co=
m>'

If you can't send from potin.lai@quantatw.com then perhaps you could
work around this by adding a `From: ...` line as the first line of your
commit message body as documented here:

https://docs.kernel.org/process/maintainer-tip.html#ordering-of-commit-tags

Alternatively, change your S-o-B tag to potin.lai.pt@gmail.com

...=20

> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
> new file mode 100644
> index 000000000000..70cec690f541
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
> @@ -0,0 +1,965 @@
>=20

...

> +&gpio0 {
> +	pinctrl-names =3D "default";

Not sure why you need this, but I think it also causes the following
warning:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: gpio@1e780000: '=
pinctrl-0' is a dependency of 'pinctrl-names'

Might be best to drop it.

Andrew

