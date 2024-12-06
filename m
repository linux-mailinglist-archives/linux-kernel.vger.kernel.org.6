Return-Path: <linux-kernel+bounces-435251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228149E7519
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B907B18881C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281320DD41;
	Fri,  6 Dec 2024 16:04:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E620D4F1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501053; cv=none; b=MWEyA2ZZQCzk9uekHQK8xWLUIggFHcJgPulq4kU1teLJITBXe7HUOPOnJJ9RiyGGSKEsMuWOGRwd3wV/QOJHzFN0C5wqlNax2oFxvXr3Cd6TE7NFou0XXYSG6V31RqNJr2laSNKdrtyIDjT4eMws4UOi7fJNKj0/H9B044pZsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501053; c=relaxed/simple;
	bh=jFa8lz7HpDNkCvte/qT/L5nUfXf9VL6uNXwtCXRfWHE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hapBpxJzTAuP26Ikcqe0zdwWeeoVG/OroAV1XVlVJDTBxUQTU76FPW0Kn4WHmF+gCy9Mvg14CDZHhNAF6QnSq53j0VPczBebkNtx2sH7ZQH3Pij8AZl5c12yRpXmvfnfjdpfBAu31btNxcm/yWZdGICkYM7yQHQrinczpqF3tao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJaoE-0005lP-Ai; Fri, 06 Dec 2024 17:04:02 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJaoB-0021SN-0o;
	Fri, 06 Dec 2024 17:04:00 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJaoB-000Bg5-32;
	Fri, 06 Dec 2024 17:03:59 +0100
Message-ID: <036d3c0e721947002dc598aef2b65d48967ab52e.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] Add support for A1 SoC in auxiliary reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, Jerome Brunet
 <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 06 Dec 2024 17:03:59 +0100
In-Reply-To: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
References: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
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

On Mi, 2024-11-13 at 02:00 +0300, Jan Dakinevich wrote:
> This was a part of series [1]. Comparing to original series, reset functi=
onality
> on top of 'audio-vad' clock controller also is added.
>=20
> Links:
>   [1] https://lore.kernel.org/all/20240913121152.817575-1-jan.dakinevich@=
salutedevices.com/
>=20
> Jan Dakinevich (2):
>   dt-bindings: reset: add bindings for A1 SoC audio reset controller
>   reset: amlogic: add support for A1 SoC in auxiliary reset driver
[...]

Applied to reset/next, thanks!

[1/2] dt-bindings: reset: add bindings for A1 SoC audio reset
controller
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D3465a696bd93
[2/2] reset: amlogic: add support for A1 SoC in auxiliary reset driver
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D3d99f9231bed

regards
Philipp

