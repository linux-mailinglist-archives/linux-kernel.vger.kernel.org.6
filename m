Return-Path: <linux-kernel+bounces-538231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26104A49619
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A7E163584
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952125A34F;
	Fri, 28 Feb 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rI4kydmr"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A125A2CE;
	Fri, 28 Feb 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736605; cv=none; b=TKxpFZGrb5JUXk5pL8L1YNUbnPYuyGNJ+iimK+l0GYvxFsklVNZTI8d5ff+tksJoYvnDaTbdZriTPvRtCyYqOHtIJwKhSC9X4zAtM0C04kbQ4RhNwj6Rgs3/HxHxdA3D7v5uiM3dTjo7TCCzWaEGNrEtka2lcoBpBjcxw4DmAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736605; c=relaxed/simple;
	bh=rSYwADEpFPpmAgx4fF0rvjP97pxuyd5uqw+Hg+v/7/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVSZLXxCIp75Rh2raN0/G3a5khBzk3GkwuXDGf3tJRJzgph0fVFVpPtC+LBuz3uhO0Y4yBa0gbTjxSb6/gIcdDRPkMZaLxUeWCc1Cx54zFdN9O7zD6qsWqyRekynXKHEm3y88dzx6mVtxl8tZ+XIssHHgBjp6I8yGZZX2l27CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rI4kydmr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CF9171FB6E;
	Fri, 28 Feb 2025 10:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740736601;
	bh=XTocGVc2MASEq20lQzdg3r1UFQEPztqxGB68Vx/zNVc=; h=From:To:Subject;
	b=rI4kydmrCNJr+mnASvcrsFRM5ZvE+xEroHyP76emsEsbXXTlqtsCg3pSSoVeM1bib
	 4DV7t8E9JCgxncP7jiesSqYAgCx4JR3vX+8h6hfZ1SN1zG/6YiSvEHENCChEqifrfe
	 R/uJd2V9QUZeJb/GKVQeEVyg3KjdUta8qWkXqnRk3+xV4CLuWU2mjAMuN8vbOobEra
	 FpqqypTswRMUVmw0eO5w2Dkb5tyNVYrV3R5YeTWisQcUOP+f2MbI8wofMq5XVJVtLD
	 ppLp9GAIr3nImacxjXswoNetUKOklG14D4f1vL8pFfqltON+Vd1udlhWh4kcedAxj3
	 yk+/P/+fmNV4g==
Date: Fri, 28 Feb 2025 10:56:39 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: apalis/colibri-imx6: Add support for v1.2
Message-ID: <20250228095639.GB16617@francesco-nb>
References: <20250227170556.589668-1-ernest.vanhoecke@toradex.com>
 <20250227170556.589668-3-ernest.vanhoecke@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227170556.589668-3-ernest.vanhoecke@toradex.com>

On Thu, Feb 27, 2025 at 06:04:53PM +0100, Ernest Van Hoecke wrote:
> Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/touch controller,
> which is EOL, with the TLA2024 ADC and AD7879 touch controller.
> 
> Accurately describe the new hardware.
> 
> v1.1 of these SoMs is still described by the following DTSI files:
> imx6qdl-apalis.dtsi
> imx6qdl-colibri.dtsi
> 
> v1.2 is now supported by a DTSI that modifies v1.1:
> imx6qdl-apalis-v1.2.dtsi
> imx6qdl-colibri-v1.2.dtsi
> 
> For each carrier board using these modules, a new DTS file was added
> that includes the v1.1 DTS and modifies it with this v1.2 DTSI.
> 
> The original DTS can be used for modules up to and including v1.1.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


