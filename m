Return-Path: <linux-kernel+bounces-251530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68AD9305F3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131B11C20D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4F139D1E;
	Sat, 13 Jul 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Bvgq5RaO"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3B130487
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720881349; cv=none; b=gI0qyFCuWehRZZlngHon1EGNRwvQos0h3eBex45MGa7cS76kRYnsmjieWAwHAPPD+rANLesgw7lgcCyiZPzhdannAMLJuf10Uk/gOukHVcESHUrhhT3axQFWwF9JH6zAFnZCVQrK9P1CXrcFNhgtcHzRlXHG8W57S01KE1bddb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720881349; c=relaxed/simple;
	bh=GDkOuYBmZxlE+4QxxeGmxRMs4f/1khlimHi5ON26yj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDhwAQecGlM3JG/1iA6Bfq1pnKs0V3NfZcZT2AvEF7iiUEOC9sgzmpgnX6b3VK/5qQQzrZb4EyxlYjtUDpsE3ZBHsFRWZpSVyTbdSOPKENDkaog78+gv7aSgnG2JU73fhglu/izeS+CXPhJ5ipt0IGA3OYmTdxN/827Z/E9Xk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Bvgq5RaO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dsimic@manjaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1720881343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sY3DzHg+dlAc4azoMf3OPo0CkoCBcBYF6R4NMkIUhzU=;
	b=Bvgq5RaO6jyBwcqSrbgzUC/dLRdIFw93AmaGjcI4QNSUuxgbfH5xCnNYUnkNITiPEdhDIf
	xtJh4TSGMUENM8tckuXBsd/O9P0NryxqnK+Px6soV51TReV5OzoVxjWIKyjwBVVm/KOzGS
	p/5pGaLyLx3MZ9R01wvQB3TQLCucfFvDjk8iVzGIn84YfcarG54T8jMF/Ui4sCf7Fq2miV
	nXGHd1BQqkemXm2dVHr8Z3Ff6u5E+8dgCwAgVkWJae7WmtvuqQSwKUE5Gmo6t4S6xXGIF6
	MM3tSfyU/5pMUhCo32yH7wKcmD9CMHeEPYrAwGIAnsvm4GGn1NmGoQJi4sWJpw==
X-Envelope-To: heiko@sntech.de
X-Envelope-To: knaerzche@gmail.com
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: jbx6244@gmail.com
X-Envelope-To: wens@csie.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Alex Bee <knaerzche@gmail.com>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add sdmmc_ext for RK3328
Date: Sat, 13 Jul 2024 16:35:34 +0200
Message-ID: <2735059.JVtD0IzA6d@bagend>
Organization: Connecting Knowledge
In-Reply-To: <72718d8d02c25993c138567c96340792@manjaro.org>
References:
 <20240710132830.14710-1-didi.debian@cknow.org>
 <20240710132830.14710-3-didi.debian@cknow.org>
 <72718d8d02c25993c138567c96340792@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2866865.qWf11O12ap";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart2866865.qWf11O12ap
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>
Date: Sat, 13 Jul 2024 16:35:34 +0200
Message-ID: <2735059.JVtD0IzA6d@bagend>
Organization: Connecting Knowledge
In-Reply-To: <72718d8d02c25993c138567c96340792@manjaro.org>
MIME-Version: 1.0

Hi Dragan,

Thanks for the reviews!

On Saturday, 13 July 2024 15:45:12 CEST Dragan Simic wrote:
> Looking good to me, cross-referencing the RK3328 TRM and the
> downstream RK3328 SoC dtsi checks out.  Though, it will remain inert
> in our codebase, because no supported boards use it, but that's fine,
> we're still improving the correctness of the RK3328 SoC dtsi.

Indeed. But it's hard to argue with technically correct ;-)

Cheers,
  Diederik
--nextPart2866865.qWf11O12ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZpKQtgAKCRDXblvOeH7b
bs7DAP9IVMN0oMrNBHeLgpMzL1AegDXUwW6vrLjrH2ayh3cqtQD/fHyImAwOALmM
TIOvYwPAjXuwZtckeR3b/XVwbLJdtgQ=
=tC+4
-----END PGP SIGNATURE-----

--nextPart2866865.qWf11O12ap--




