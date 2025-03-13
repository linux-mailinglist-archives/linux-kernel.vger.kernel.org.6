Return-Path: <linux-kernel+bounces-559000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C02AFA5EE31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6B81899D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40026159E;
	Thu, 13 Mar 2025 08:39:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0A261588
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855187; cv=none; b=HDIrJ6Xmj1Gz2IfybgiLZMUbcatCr92gBmFcnxBvK2sSk+hSO65ZNoRMY8YFICW60jdkNphsrb9V24AKwJ6UncXjov1IQIX74v1V05buGIOrUOM8ZqrFS831Vo5VZZj7WvX9mrY1CqkhAqMWBZbd8iah1T0u7X7ZAPLWDbBda0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855187; c=relaxed/simple;
	bh=oERwgEGkRpQfJ5TM4RzUH6Rt+2x2KEGHNHeoatdW5o4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3OXj/xLpr0bCCdm3N5WI8zmXVrzYCPRBApc75YpfTDdjEV0IENfLoF+UAxSLpxrB+SLdSYhcoRxL5vOGZUoki+7U37STRun7yE3iebkL02d3ouskxjwtuEaX+Sr0oPpga8mBBKLv4DHfYaIYGPj8wylymefGBdaOjBUK2mp1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tse6F-00085s-GA; Thu, 13 Mar 2025 09:39:31 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tse6E-005VQ8-1o;
	Thu, 13 Mar 2025 09:39:30 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tse6E-0003Oq-1h;
	Thu, 13 Mar 2025 09:39:30 +0100
Message-ID: <d6ba31482a0a220bf0c413e5b3c1661498c1485b.camel@pengutronix.de>
Subject: Re: [PATCH v8 5/9] dt-bindings: reset: atmel,at91sam9260-reset: add
 sam9x7
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Varshini.Rajendran@microchip.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com,  claudiu.beznea@tuxon.dev,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org
Date: Thu, 13 Mar 2025 09:39:30 +0100
In-Reply-To: <cab4ad68-cf3e-4385-8721-837372df2e12@microchip.com>
References: <20241010120142.92057-1-varshini.rajendran@microchip.com>
	 <20241010120419.93043-1-varshini.rajendran@microchip.com>
	 <cab4ad68-cf3e-4385-8721-837372df2e12@microchip.com>
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

On Di, 2025-01-21 at 10:41 +0000, Varshini.Rajendran@microchip.com
wrote:
> Hi,
>=20
> A gentle reminder to merge this patch. It has been left out while the=20
> other patches in the series have been merged. Please do the needful.

Applied to reset/next, thanks!

[5/9] dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dd41f0d0bbd79

regards
Philipp

