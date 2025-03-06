Return-Path: <linux-kernel+bounces-549599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518FA5546C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7490175D74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8BC26B2AE;
	Thu,  6 Mar 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="r5sEDRIG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978D825D8F8;
	Thu,  6 Mar 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284531; cv=none; b=lzHNthyTr4L96NP/rQ4OJyTwDs7FJJp3/zVCYBmGD9k4qTvUK4GNwRMlg7SEUIETTKKFLd4ZDCG0qkfgJZZmpXkSE1HcJG2LZG/364vHeXIVuS9SQKq3eKmMTL62C/rCbBdVoDs8HiqtuAs+40FZ04a+UewSak2Ve+4/Cz9zuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284531; c=relaxed/simple;
	bh=95aCu9KRIh6bsNk0DJdly4sMY9zLTrem/lSRmRwQZ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzXUfqKyqkIXa23kbOLVZRsRBIUaGZFYTMjqKLhrVBDcrPXQmAG31X6fEEmpMlzUagMWouGHYdy0Fdg5s4XqcL/N9hFZBRmFZz4COvfOIr+dviY1+LA9zYonmZGWOMYKzhL4HAfpXfPHy85AM5CX+53ano1mmstWAl6ESaKkY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=r5sEDRIG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qoSIZeEZItfdQePn3xpCH5SMAbZNHhyWtQWXr+rp4aI=; b=r5sEDRIGxBH5f3gyz69wvRQSgC
	t7CIcyI+U1fP26VBt8p8YKwZFGcGW3bvpz8Z5Vvzsq+xzhjX/qmWP2+LuRDlfBkasaCAMhh84pJKs
	6ho59zt56Lv+Wbr07v4wpaMNgLx4T505ik1wUHZS6IGOhM3mca8GbssBhJztcPkhhBIjCi+guQ9cR
	lrBqyIUlEJwqu2ITq4EII85fjWKwmJeNgfwDmAmBapvG7dw0a/trEaxmpotVMPbqYBoqt0dfpGV2c
	YpsnWiEEf1NKxxRknYHSq+f2quCO2svAH2xIQ/H8k4lx7CGYb0XFuCuY8sYSh5h73ZdfaXCOyvlBy
	aX6mzrJA==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqFeA-0005TK-H2; Thu, 06 Mar 2025 19:08:38 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>, Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Thu, 06 Mar 2025 19:08:37 +0100
Message-ID: <117081043.nniJfEyVGO@diego>
In-Reply-To: <cdbc1556-4662-4078-a4d6-33545e2e2491@kwiboo.se>
References:
 <20250306123809.273655-1-amadeus@jmu.edu.cn>
 <20250306123809.273655-3-amadeus@jmu.edu.cn>
 <cdbc1556-4662-4078-a4d6-33545e2e2491@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 6. M=C3=A4rz 2025, 17:55:16 MEZ schrieb Jonas Karlman:
> Hi Chukun,
>=20
> On 2025-03-06 13:38, Chukun Pan wrote:
> > The Quality-of-Service (QsS) node stores/restores specific
> > register contents when the power domains is turned off/on.
> > Add QoS node so that they can connect to the power domain.
> >=20
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 160 +++++++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> >=20

>=20
> These QoS node are typically referenced from power domains so that the
> PMU driver know what QoS to save/restore when a power domain is power
> cycled.
>=20
> Vendor kernel only reference the two qos_gpu nodes in it's power domains,
> do you have any documentation or knowledge about what power domain the
> remaining QoS are related to?

I think the GPU actually is the _only_ fully switchable power-domain on the
rk3528. The other powerdomains seem to be always on, but can do this
idle-request thing.

At least that is what I'm reading from the pm-domain definitions in the
vendor-kernel, combined with a look at the pmu section of the rk3528 TRM.


Heiko



