Return-Path: <linux-kernel+bounces-512145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D24A334C0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245821888A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD648633F;
	Thu, 13 Feb 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Dt2Qll0r"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE01A29A;
	Thu, 13 Feb 2025 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410510; cv=none; b=lCAW44SEGLt6HjqhBobNB+G2fYHHtpACJObhBKmDqzhn8lywRkQWaRWT1D9qvpuQ6eWgbcEylHd8+j5Bs5ibXQe4UhjCoc+IIXxi06SvAGvnfaBpPmlWoRhv7b0zHhx4RITGD4ddnkaG0wmRnn5TVFKFKQDn0Tqt1WvRACVGTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410510; c=relaxed/simple;
	bh=7VGU4GfhPMqJEXler7778/nCovI5qCQgVoJqnQCQB0k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJkhuK0ayGFx3Gxq1VSh+VP5ZUwqTgzRKp40Vs74ourh0agEuzeBKRrnpZK0Dvy/VXHIwK7k6wAyiDwFFsku2gXdppar2/4xDjO28lz5RQCeSzpK+h1kZt1GN/M2GSqyt5iWUsmwV+nxVFjyOj6OiPceNAC13A8sXMNF32RX44g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Dt2Qll0r; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739410506;
	bh=7VGU4GfhPMqJEXler7778/nCovI5qCQgVoJqnQCQB0k=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Dt2Qll0rbSoLUxnB0twbir6+FHpnuwPZEw8dZgzabM1BDg+KUDwwQcVYlTuaikOnZ
	 SGgGTMO0TFLCJqvj044vDNGvijq11/Pm8Te9g86797aGwPePKFY0pQnseRcVH8qgMp
	 Z//+afmjw9kXgkHxYCanUP+CukG217Kj//LdRx/rGVBLECQAbGcOEQys4prUg+mtWW
	 GBdnKgf8Onu4LQJR44+chpQhPq49jydIXQGUoVVeGloOlTpXoPoKFGbWd3hu8iEVeI
	 pNF3ribb00h9rECGOuNm/+HDM3sd2bErTVPglhvMODJK093Uvz1HeIr411vwXRR0Ae
	 V+Wm6iVtQLjsA==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7D1B37576E;
	Thu, 13 Feb 2025 09:35:05 +0800 (AWST)
Message-ID: <5d84475dc07c43fada8f3e10169739d57348eaa4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: nuvoton: Align GPIO hog name with bindings
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Avi Fishman <avifishman70@gmail.com>, 
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>,  Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  openbmc@lists.ozlabs.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 12:05:02 +1030
In-Reply-To: <bdd7b203-ccb3-453b-ae91-32f257fc909f@kernel.org>
References: <20250116090047.87499-1-krzysztof.kozlowski@linaro.org>
	 <bdd7b203-ccb3-453b-ae91-32f257fc909f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 21:36 +0100, Krzysztof Kozlowski wrote:
> On 16/01/2025 10:00, Krzysztof Kozlowski wrote:
> > Bindings expect GPIO hog names to end with 'hog' suffix, so correct
> > it
> > to fix dtbs_check warnings like:
> >=20
> > =C2=A0 nuvoton-npcm750-runbmc-olympus.dtb: G1A_P0_0: $nodename:0:
> > 'G1A_P0_0' does not match '^.+-hog(-[0-9]+)?$'
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Changes in v2:
> > 1. Rename rest of the nodes I missed.
> > ---
> > =C2=A0.../boot/dts/nuvoton/nuvoton-npcm730-gbs.dts=C2=A0 |=C2=A0 12 +-
> > =C2=A0.../nuvoton-npcm750-runbmc-olympus.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 120 +++++++++-----
> > ----
> > =C2=A02 files changed, 66 insertions(+), 66 deletions(-)
> >=20
>=20
> Any comments? Can this be merged?

Joel was taking NPCM SoC patches through the BMC tree. I'll pick this
up. We should probably update MAINTAINERS so they don't get lost.

Andrew

