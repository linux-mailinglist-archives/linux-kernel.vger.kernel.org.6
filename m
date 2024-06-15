Return-Path: <linux-kernel+bounces-215796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E463909719
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53FC4B22281
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F12030A;
	Sat, 15 Jun 2024 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="QeDy1YrO"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082218EB8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441514; cv=none; b=lJbuF2LyIcRDZylmqpEN7YUDsUoRIqrQ7Zv+/mAHxbvyl7gG1JBTa8TgVeOchwrCFCd+eC3Zl/OwGY26opNP64s96e08DZkrn7kwPjK3VkIY4iRejNcwFTBmeNVjz01gppebyp4u9PAMgb6OMqgSXVQrIOYyboSXU0nyarJ8kSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441514; c=relaxed/simple;
	bh=2uhNmFDzmca77n8/NYMgx5PLYKQsfE2F4rpsDHEStzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkafxXoLnepCJw3X1HQZx55ws4hzmsQU44gUz9CcqT46erqpbcZ6GI8sUpOz1wajhzxGmSZ6z+Xayg/s2odqJQfNUo4F10u4H1WWuXJMuIk8FUsi5yrXsj410Syius1FE94xZdU/rfNcnkH0Z+8YyZ7q8xrwqzLVVh62ho6eIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=QeDy1YrO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: linux-kernel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1718441510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FzCprlv9GxaDwbOC21n35gObXPY/amCP46gcmpDxZd4=;
	b=QeDy1YrOxKKjkHJdePkDCle/LiRFoccvtCuVRnqHasyfAD1jXs8sM0xR/XLODlq+yHXE7J
	QoodMcP8WCQEbHdDeq1ci6I8HIHG4e9/raQle5ZGipBK2gouPgARL67W26kt8f9tTvNMv6
	HBuQOQAsk+jD0jB+kXUysP8AqskjdOU+iS7pHsmEjDkdEIR4qMTWc4/rTfbzyJ+wHz+jZS
	f4jFFiP9JhsRpL/LpvLMPoTkG08Eb4/nmEvvIom1l/797aDmrjBhZKVgQKxedovcIo9yFw
	ynlOh5JDc9Q9Xpd/JsCJ1Y+RDmZCPyd93WkHdJF6+1AHs6CzRA5n28v3mZgaOw==
X-Envelope-To: detlev.casanova@collabora.com
X-Envelope-To: mchehab@kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: heiko@sntech.de
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: sebastian.reichel@collabora.com
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: alchark@gmail.com
X-Envelope-To: cristian.ciocaltea@collabora.com
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: linux-media@vger.kernel.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-staging@lists.linux.dev
X-Envelope-To: detlev.casanova@collabora.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Alexey Charkov <alchark@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andy Yan <andy.yan@rock-chips.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 1/3] media: rockchip: Introduce the rkvdec2 driver
Date: Sat, 15 Jun 2024 10:51:38 +0200
Message-ID: <3333233.eAoTOS8U2s@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240615015734.1612108-2-detlev.casanova@collabora.com>
References:
 <20240615015734.1612108-1-detlev.casanova@collabora.com>
 <20240615015734.1612108-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8264659.XZnPd2NMnp";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart8264659.XZnPd2NMnp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH 1/3] media: rockchip: Introduce the rkvdec2 driver
Date: Sat, 15 Jun 2024 10:51:38 +0200
Message-ID: <3333233.eAoTOS8U2s@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240615015734.1612108-2-detlev.casanova@collabora.com>
MIME-Version: 1.0

On Saturday, 15 June 2024 03:56:27 CEST Detlev Casanova wrote:
> This driver supports the second generation of the Rockchip Video
> decoder, also known as vdpu34x.
> It is currently only used on the RK3588(s) SoC.
> ...
> The core supports H264, HEVC, VP9 and AVS2 decoding but this driver
> currently only supports H264.
> ...
> The decision to make a different driver is mainly because rkvdec2 has
> more features and can work with multiple cores.

https://wiki.pine64.org/wiki/Quartz64_Development#Upstreaming_Status uses both 
the rkvdec2 and vdpu346 words and I *assumed* that meant that the Quartz64 
Model A and B would use rkvdec2. The Q64-A and -B are rk3566 devices though.

So is this just an (unfortunate) use of the same words or is that wiki page 
just wrong ... or better yet: does rkvdec2 support RK356x too?

Cheers,
  Diederik
--nextPart8264659.XZnPd2NMnp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZm1WGgAKCRDXblvOeH7b
brgQAQD+T08UA2/wwhvAFvEN6YbiMOcTnBEhemxyxRye7DTggwD/YEcUSIQQ/RPc
NSTPgX06r8mCGK7SuZ4YyKRWnCMpWgQ=
=M6ol
-----END PGP SIGNATURE-----

--nextPart8264659.XZnPd2NMnp--




