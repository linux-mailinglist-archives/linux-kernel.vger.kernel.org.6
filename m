Return-Path: <linux-kernel+bounces-549793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02681A55750
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1BC189736A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0452270EC9;
	Thu,  6 Mar 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b="dGhADVRM"
Received: from mail.mvand.net (mail.mvand.net [185.229.52.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451342A8C;
	Thu,  6 Mar 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.229.52.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292011; cv=none; b=GEPk/YFrx4HMQ4Nw1iC1Q8iK+7e4qAyj8SGVG2wkMkvdpYdCOSb5PfGoZqVWpk70ipyacNaJedXlISfIE8U1zRQuQXjEKQ8/ojM/pjKsHnhmtWC/4jYt3ehiJ41e3kPDOZwmbT7JKb99BUe70iwNpbFw6ZFhq2tpEk60OOEtWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292011; c=relaxed/simple;
	bh=Cgdy+MoS5drv8lXdb22ppJ0XjnIjqmgcB7r94/9mKUA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 Mime-Version:Content-Type; b=mffgCTrqtxjhM0DJ6GkFPgYyEMPt5GSfMLXPd8CfakQj9eKONwVguX0Mn4yq+qSrpa8CJKK4FFvlqBhEoT2gO2hClq9R6cJ5PmbjNDZZM8UFxtHCeY8QM7xGIdjTb8MfLEstzkAdFEUksEr2fnFgf/VFRHyBbcLhdp59tCrlHR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl; spf=pass smtp.mailfrom=martijnvandeventer.nl; dkim=pass (2048-bit key) header.d=martijnvandeventer.nl header.i=@martijnvandeventer.nl header.b=dGhADVRM; arc=none smtp.client-ip=185.229.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=martijnvandeventer.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martijnvandeventer.nl
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.mvand.net (Postfix) with ESMTPSA id 20E551FFBE;
	Thu,  6 Mar 2025 21:13:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=martijnvandeventer.nl; s=default; t=1741292008;
	bh=Cgdy+MoS5drv8lXdb22ppJ0XjnIjqmgcB7r94/9mKUA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=dGhADVRM3Zmg4x5jYwZff6ZrtJpm2vttKQC/YMrDTscaLRqd5tODw5ozbBXiKYgok
	 Pmzp957BJE0rcZLmw1bDfpA2od0rQL1OB9n6lLNAWulycXkgl91lMesltuFWr0dUhm
	 gcgHJHT78nIm59YuSP4tudZ0RCUPezElCf9bY9qrpN/RDf402faQvDTuhzfb8Z/SRR
	 +BZJcnPZHkHSuVyF6Y2ur99XAl9agj2t5y6rxbtzG2kUJCaSYQjHMLg47xaGcpzl2U
	 /v272BM1oQwqFG6Ez8vpTKLRPWDnp/IcTFEbf5GQQqPOTTDhvHDYSiS2jxkC5tKnmZ
	 qeg7rEW5Y8WOA==
From: <linux@martijnvandeventer.nl>
To: "'Jerome Brunet'" <jbrunet@baylibre.com>
Cc: "'Neil Armstrong'" <neil.armstrong@linaro.org>,
	"'Michael Turquette'" <mturquette@baylibre.com>,
	"'Stephen Boyd'" <sboyd@kernel.org>,
	"'Kevin Hilman'" <khilman@baylibre.com>,
	"'Martin Blumenstingl'" <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250213221702.606-1-linux@martijnvandeventer.nl>	<1jpljkzyf0.fsf@starbuckisacylon.baylibre.com>	<003301db888e$8ea84e90$abf8ebb0$@martijnvandeventer.nl>	<1jplj3g21q.fsf@starbuckisacylon.baylibre.com>	<004801db8eb7$99808e20$cc81aa60$@martijnvandeventer.nl> <1j4j065avo.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j4j065avo.fsf@starbuckisacylon.baylibre.com>
Subject: RE: [PATCH] clk: meson: g12a: Fix kernel warnings when no display attached
Date: Thu, 6 Mar 2025 21:13:27 +0100
Message-ID: <001401db8ed4$392ef030$ab8cd090$@martijnvandeventer.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Thread-Index: AQH3Houg6kGqwWGxu7A7A+ZA83tGEAI4axMrAfruu2QCUs8BLwIt43dLAg23U/Sy2VxfgA==
Content-Language: en-us

Hi Jerome,
> 
> Once again, you are encouraged to fix things up ... where fixes are needed.

Encouragement is not the problem, time is ;-)

> DRM is hardly immutable. If you don't feel like you can do it on your own,
> you can still engage with the other contributors who may know this
> better and help you.

Maybe in a few months when I have some more time. Thanks.

> >
> > On the other hand, I also understand that if you, as a maintainer, allow
> > that, chances are it will never see a proper fix. :-)
> >
> > Cheers!
> >
-- 
Best regards,
Martijn


