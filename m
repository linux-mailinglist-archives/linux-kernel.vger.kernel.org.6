Return-Path: <linux-kernel+bounces-311036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E135968431
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89101F237EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5DD13CA99;
	Mon,  2 Sep 2024 10:10:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953E13D2B2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271846; cv=none; b=lfSnIRvc1CRRfQjWQXS4aWUPKxoc22rG8I41e0qIDkZWapTZ+un3Z5iFSGY7S8fevsgocaIEKSOquJvxKIXcknTpdJ8xKDO4QGmcS2BD4L/Gid/A8zmm476misoAyNMlYfNi6GBS3c7Loyl7GJH1Pznw2ywcjVpdLaw15HrY5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271846; c=relaxed/simple;
	bh=a8GcO42/o7aCSNv1Vh5dlAWTPZU08PXqhFxmBmm04zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0nOJ1Pu7vQ0c59vyo78x1oVOKY/0IQeJr5tYNzPGGZFGnAD+V8RVWvbSI4D0OxF/RHbpLdxM2AWjbvQp9i6ExYBAoTWujU7rZ0LOZyEwsMYtmi0KMZIjbTzFE+qUVRocd45JeWlOjSqXPtIf83nR2NeCbJliQN1bG1nG7YIkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl415-0003mL-3M; Mon, 02 Sep 2024 12:10:35 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl414-004sSW-5b; Mon, 02 Sep 2024 12:10:34 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl414-000gXa-0H;
	Mon, 02 Sep 2024 12:10:34 +0200
Message-ID: <d00b9c940d5b6156c846b8e513adff1eba0993aa.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] Add support for Amlogic T7 reset controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: kelvin.zhang@amlogic.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin
 Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Zelong
 Dong <zelong.dong@amlogic.com>
Date: Mon, 02 Sep 2024 12:10:33 +0200
In-Reply-To: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
References: <20240422-t7-reset-v2-0-cb82271d3296@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mo, 2024-04-22 at 19:11 +0800, Kelvin Zhang via B4 Relay wrote:
> Add a new compatible and device node for Amlogic T7 reset controller.
> And modify the driver accordingly.
>=20
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>

Thank you, applied patches 1-2 to reset/next.

regards
Philipp

