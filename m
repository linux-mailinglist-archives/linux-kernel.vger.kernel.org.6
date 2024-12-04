Return-Path: <linux-kernel+bounces-430734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D59E3565
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFD3B35426
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77471A08CB;
	Wed,  4 Dec 2024 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZgHPpa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E518FC84;
	Wed,  4 Dec 2024 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298941; cv=none; b=kxl6nk0u7UemFRgjwjztIAXi2aw/Fh3mRYXU3L3a80DS1+c9B9+v/PXqffVbQlGBg3ux7SexQB4kyylLuTUcXharP5SjhJ24CJVh6gyNWkrI9CXjdmlOQrDdvV3ZvVqPIEo6dSesoYbhwUt8LC1WauHTX/WdkUbWnJpb9/UYVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298941; c=relaxed/simple;
	bh=hPODO8PELZFLZa6SXMLpL8BBZ/VtgIVp7qDgFBO/ZKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtwwFnVQxp20/JdTaddw1/zWBVfpRtBeN1PnsrTxIrZcS//xHtACdCO0oax7wK0L+kWeKSVgjf4N/pwBbxRDAEhjmVQa3YFlzzyoOAkxCfVMyhsdO8SvrFXKoATHI0slJouCSArwiFSgIqu2aGcSkFZjjOBpv01xV9JOfPHj/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZgHPpa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E40C4CED1;
	Wed,  4 Dec 2024 07:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298940;
	bh=hPODO8PELZFLZa6SXMLpL8BBZ/VtgIVp7qDgFBO/ZKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZgHPpa1ODXfiDsQb5yZisbf7IbJGnJwLQtQvf9NALoxZsno7DgERHfGJzpzIeOJo
	 aMjY5M+KRJ47mytxU7UTCor1191elfGQOMMSlfx/eWifmAUpeutyC9eC25Mga0Tuox
	 rS7nylc+u4ZSVzXONjQNfyOnWFlZfWYn18MCrlZVBu430oDDV54aNK/IVuWIWjpsww
	 GWyFjVHkn07u24trPmqd3TiRiOKEaB46d7M9WvFym6Cbe/zIJfvWaaU2qnZiVwDQ+i
	 rHasQhUdnIZdmW3ZCUkwvZi5Hd+XaYsOdrz5ty0wgQhZxZb4XP+WcVC0UTV2OQKxbG
	 X8NdcXroNrZMQ==
Date: Wed, 4 Dec 2024 08:55:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: usb: max33359: add max77759-tcpci flavor
Message-ID: <2ulwa4oqvpifnjpfqrq57oexams4luah7nhz7mjoxidf3lws4d@xcv7updmrg3v>
References: <20241203-dtbinding-max77759-v3-1-e1a1d86aca8e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241203-dtbinding-max77759-v3-1-e1a1d86aca8e@linaro.org>

On Tue, Dec 03, 2024 at 12:17:35PM +0000, Andr=C3=A9 Draszik wrote:
> Maxim's MAX77759 is a companion PMIC for USB Type-C applications. It
> comprises the following in one package:
> * top (including GPIO)
> * charger
> * fuel gauge
> * TCPCi
>=20
> While in the same package, TCPCi and Fuel Gauge have separate I2C
> addresses, interrupt lines and interrupt status registers and can be
> treated independently.
>=20
> While the TCPCi part appears identical to max33359 on the surface, it
> should still have a dedicated compatible, though, as it is a different
> implementation. This will allow for handling differences in case they
> are discovered in the future.
>=20
> max77759 is used on Google Pixel 6 and Pixel 6 Pro.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


