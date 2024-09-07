Return-Path: <linux-kernel+bounces-319706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ABF970103
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27766284ECF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143D14B95A;
	Sat,  7 Sep 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="wQkj4bC+"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7917753
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725698854; cv=none; b=AKhxJLc8EU7qVlnfTsYYEoSWrtTpk1mR5jEJC0bCeHQ9EjPLJQp8lbU1I7b23dtTMFreaUZSG8BljieLz1ns28E4tijcil3OrJ8f5jY8Q3re4jl02LOL9HOo7dD5h+o/Tarsdrcp6tpWykgN6EN7m9Zwh8Ddk7BOeX99bZ4+au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725698854; c=relaxed/simple;
	bh=bFFKmA5dR8CDf/cqC4+a/CD6M/tAFzcrkNRMmQJPzSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oJVeG169q4mIx2mBwdEyFlpNFDefYWM+btmE9azGhZURKvRHAE0m2OEUxmsCCSVru4H3Pl7XWamTfL41ghYxqUMPrrJwAt3t8pgMmTWpPO/qg4GhFJkC4MOYtOwA7+fMQcTCKG0gGLkxzaawvG1N2SWjwHopiCMINLsIWRoD80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=wQkj4bC+; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1725698849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U/V4gJDEeseX5jQFeW0yYA0toqnpKY469k3mQ17ssiw=;
	b=wQkj4bC+WErNtAEm8BxqIHn2dlwtM4UpfbVG4kVsVCFyPcyJn1hfJUAI3PAIatPtYMw6uh
	0MUlu+Wy4C0/RtBqiSyAsTiqtu8ayeMonmgPbJaWaKFR9Wd65RyQK3Iu7j0zt1nJtV/y5A
	VmmjmG8EsLLzjvL2O4YsHVzt6tVMvSV6sSmCC2QL0yHzHn3NZqnDA5FPGRpop315vUTMx6
	2tGNMflQrIP6EzT/fbsSpBZH8+OS81BkYsYv+y7rd+fKvRSnBKvSUDpOtS95robjbLhpYk
	xTf2LWG6bsf64yAHsqCtCbxFJuCOrfB4AqyVA45T0OF/EcnLtjaUNYNHbjAFNw==
Content-Type: multipart/signed;
 boundary=ae02d6677900286bbc830f90aa3ab8aa0d85c0a15f3e902cf9eb68b94b65;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 07 Sep 2024 10:47:18 +0200
Message-Id: <D3ZX6LZNLOYC.30CT6AX32VI2T@cknow.org>
To: "Min-Hua Chen" <minhuadotchen@gmail.com>
Cc: <airlied@gmail.com>, <andy.yan@rock-chips.com>, <andyshrk@163.com>,
 <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>, <heiko@sntech.de>,
 <hjc@rock-chips.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>
Subject: Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <D3Z5JMTKPQIS.2M5O5DY0S4U9G@cknow.org>
 <20240907030259.1243487-1-minhuadotchen@gmail.com>
In-Reply-To: <20240907030259.1243487-1-minhuadotchen@gmail.com>
X-Migadu-Flow: FLOW_OUT

--ae02d6677900286bbc830f90aa3ab8aa0d85c0a15f3e902cf9eb68b94b65
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Sep 7, 2024 at 5:02 AM CEST, Min-Hua Chen wrote:
> >FWIW: I didn't see it either, but I assumed I was missing the right
> >context (i.e. patches) needed to trigger that warning.
>
> I triggered the warning by the following step:
>
> install 'sparse' first
>
> ARCH=3Darm64 LLVM=3D1 make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDI=
AN__' mrproper defconfig all -j8

This, especially the 'LLVM' part,  is important context information
and should be part of the commit message.

I had only just started when I saw a number of sparse warnings:

  DTC     arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtb
  OVL     arch/arm64/boot/dts/ti/k3-j721e-evm.dtb
  OVL     arch/arm64/boot/dts/ti/k3-j721s2-evm.dtb
  OVL     arch/arm64/boot/dts/ti/k3-am654-idk.dtb
  DTC     arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
  DTC     arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-wifi.dtbo
  DTC     arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
  DTC     arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6b-io.dtb
  DTC     arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
  DTC     arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
../init/main.c:192:12: sparse: warning: symbol 'envp_init' was not declared=
. Should it be static?
../init/main.c:290:16: sparse: warning: cast to restricted __le32
../init/main.c:291:16: sparse: warning: cast to restricted __le32
  CHECK   ../init/do_mounts.c

And several followed, including in c-code files. So I stopped the build
and assume you've identified a or several actual issues.

I've seen several commits where changes were made because LLVM flagged
potentially problematic code, where GCC did not, so it's quite possible
you're on to something here.

But it would be helpful if the commit message said what code was
potentially problematic and why. And then the proper fix for that could
indeed be to include `rockchip_drm_drv.h`.

Cheers,
  Diederik

--ae02d6677900286bbc830f90aa3ab8aa0d85c0a15f3e902cf9eb68b94b65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZtwTGQAKCRDXblvOeH7b
bjrVAP9sF01iIKgasYGx4OaHq+E2M92V0wabM3HMo2iTFErnoQEAkAD2CVBFzBtD
wMom4q6z9MP5ClefkbqycuAelKYGkAU=
=iQLh
-----END PGP SIGNATURE-----

--ae02d6677900286bbc830f90aa3ab8aa0d85c0a15f3e902cf9eb68b94b65--

