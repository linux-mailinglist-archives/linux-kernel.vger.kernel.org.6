Return-Path: <linux-kernel+bounces-216026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B59909A12
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7BA1C2185D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB361FE5;
	Sat, 15 Jun 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="SeBI4fmG"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFF4F881
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718488457; cv=none; b=AQCLEckGWbSkra6ALOhuiN/x4uHxX46rzof40nOiSsFyCwB6rFXBv15+qpnnrGpqIsjLgfwdn8gTyYCls9vfqaM2HJa131xleesUe1fwE43jetzrugZTjBu/JDKgKimRdCKLAArfWfDe3cvZZ38Z3oYMx/Kr/o+8R1K4FuEDCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718488457; c=relaxed/simple;
	bh=sP7+7yYRFVKrfpXsMgVKtUyGT3YHuHrpHrvynwsk0Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktlg70QeU0K/7A0L/4Sj7ofoV6qo3KyVvrl/gjIiqUmj82GW7KSvni0I/FITZ8TkQ/B7tbZ6FXKQ+1iMyTubpfLIBCQ9xb3MsXn/O8KP2wY/DtI6nYXI9kJm192sWMbINRCu/8r4mCt/xkgjlPO1o1ktPg6+XVkKNdgn6eVFb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=SeBI4fmG; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1718488447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sP7+7yYRFVKrfpXsMgVKtUyGT3YHuHrpHrvynwsk0Kg=;
	b=SeBI4fmGitwR8BpwBbXVAWpQAz+GZDvJjyoKvALIv7cutdIQ+hPuRAWERFNLzAzUgV6ytN
	sI4S6XDdIZ1NaqqEZhMSweapHFzqbUZV7pRv1pzX0ZqEvO9K3/BOcxqqh/UoXrHf+LefWU
	imNJBsuItut0adOuYuBhk7hzG1RVi+h+bSRhOiX1BhOYVNhpe3Ki9SqWSyDAjzD6jaVFx1
	mnbYHFH8mRGBrlfbi0G4kVV2WkTxi3TrUxfQ/RNP2ZVvVJSTvMtWfVypXYI9GJox7VKEUD
	k3Ob0TZs2eBKwMMzm725XneTNV5k42IwtGUaC5kn0/h5cC6DDwCNUtq8G5H2UA==
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jonas@kwiboo.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 Jonas Karlman <jonas@kwiboo.se>
Subject:
 Re: [PATCH 06/13] drm/rockchip: dw_hdmi: Add max_tmds_clock validation
Date: Sat, 15 Jun 2024 23:53:51 +0200
Message-ID: <2357044.LC0K3s5jzQ@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240615170417.3134517-7-jonas@kwiboo.se>
References:
 <20240615170417.3134517-1-jonas@kwiboo.se>
 <20240615170417.3134517-7-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7974929.RqnHuFZ18C";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart7974929.RqnHuFZ18C
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Sat, 15 Jun 2024 23:53:51 +0200
Message-ID: <2357044.LC0K3s5jzQ@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240615170417.3134517-7-jonas@kwiboo.se>
MIME-Version: 1.0

On Saturday, 15 June 2024 19:03:57 CEST Jonas Karlman wrote:
> The rate limit for RK3288, RK3399 and RK3568 is based on current mpll
> table. The rate limit for RK3228 and RK3228 is based on the
> inno-hdmi-phy pre-pll table.

I see RK3228 mentioned twice; I guess the second should be RK3328?
--nextPart7974929.RqnHuFZ18C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZm4NbwAKCRDXblvOeH7b
blB8AQC/Rk03SLUNvUrFh0Zs3OLlTdb/1xIjrcPsDe+8VzXSeAEAiWSzPhyih8Lw
sE+0vY6wFwT/TXGJ8rcsyUVfdwvAigo=
=SrRQ
-----END PGP SIGNATURE-----

--nextPart7974929.RqnHuFZ18C--




