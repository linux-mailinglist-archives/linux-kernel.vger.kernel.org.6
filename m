Return-Path: <linux-kernel+bounces-227856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E391574F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E141C211D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955691A01DB;
	Mon, 24 Jun 2024 19:41:09 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07361A00D6;
	Mon, 24 Jun 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258069; cv=none; b=QKaxCSGwvaPyXNERb8b7KieHWVAerH5VGrVZ2wn7q4PCTQIitoO8QctuRcnOMY0Uknzm6vian+JTlrEz06sme+Y7wajYgn0jswEyFXiFNhLFpoKUp3krLC8nxBRFZxLQSGgtPU36iKWrnoNLUB3tiQG5phh4NBNwShV8GW0vokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258069; c=relaxed/simple;
	bh=/HQHefx5ixps2RIsdDJ0RMHxpXiXTb6YPJOtWT56png=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHxZtTBw6K0CRhPAT1MgasPe7Ge4qrBoPuzi3WgDEKspGmGvUSV3GvIe9c9wZ8lNmMIJqDXVRAUFpyyU5rw1/JpLk05QN78/oRQ57jqlqKQ2TlIl673nZT33AR5paqwwTmvFuBjmjUBM1+fSlsbZHAdFFNUPNmELDrH6zTlbr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sLpYg-0003zr-Kf; Mon, 24 Jun 2024 21:40:58 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Alexey Charkov <alchark@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Delete the SoC variant dtsi for RK3399Pro
Date: Mon, 24 Jun 2024 21:40:57 +0200
Message-ID: <4778243.neEnAmRlxL@diego>
In-Reply-To: <84e5719fad4d405bf188ee86d12bb251@manjaro.org>
References:
 <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
 <CABjd4YziNk1NJb6p+AxAVK0CR7igE3-6h-sN4MEWwyoW2qaKfw@mail.gmail.com>
 <84e5719fad4d405bf188ee86d12bb251@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Montag, 24. Juni 2024, 20:06:19 CEST schrieb Dragan Simic:
> Hello Alexey,
>=20
> On 2024-06-24 19:59, Alexey Charkov wrote:
> > On Mon, Jun 24, 2024 at 9:55=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>=20
> > wrote:
> >> Just checking, are there any comments on this patch?  Is there=20
> >> something
> >> more I can do to have it accepted?
> >=20
> > Heiko has already applied it quietly a couple of days ago [1], and
> > also merged the v5 thermal and OPP code that I rebased on top of this
> > patch of yours.
>=20
> Yes, I saw that already, but this patch is a different one, it's about
> deleting the redundant .dtsi for RK3399Pro. :)

thanks for the reminder, somehow I overlooked this one in my patchrun
today.

> Regarding your v5, I've had some health issues, so I unfortunately=20
> haven't
> managed to review it and test in detail yet.  I'll do that as soon as=20
> possible,
> and I'll come back with any comments I might have.

if you have comments, please send follow-up patches :-)




