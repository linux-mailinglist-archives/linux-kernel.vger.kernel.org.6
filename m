Return-Path: <linux-kernel+bounces-442720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3C69EE0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1383E1889678
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE8204C2E;
	Thu, 12 Dec 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSDWwKZi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB61FECD6;
	Thu, 12 Dec 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990574; cv=none; b=i4C+q9ZBgvSAEB/FB2bB+mU8ME8fTcK4mJ+8MpEiXdW+UYlKDwtEG3Pyn7VwjI2cptzWS6Ng22FLlfvooNMMLoofxS8SVQMw3Dt6/1gCvnHmn5JaiEB6uF4wgge/2kDxt/YGJz0x93giIlxm0BQoq4DLgVsOIXyX4D766LZNuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990574; c=relaxed/simple;
	bh=hZXuWLeRcpitaebs/MTxUMPLPFc8ankf78kpdgoJb/Y=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=jww00fWGkXdEt7JTDvWk3xv6EQFPtz/RMefFX8cX2HVu0wD+WEM7YrRaIsmbWB0mnNPRyqiyA3e9zrcom1pLwA4o8VDjeCfoTQ+ZWPRVP2RDh+Azs0xlDEJMp7D22DT1IP/yaR5RmKo6DbjtNja0t9ibUfaVSLMzaw+2E5NWf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSDWwKZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11CEC4CED1;
	Thu, 12 Dec 2024 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990574;
	bh=hZXuWLeRcpitaebs/MTxUMPLPFc8ankf78kpdgoJb/Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=SSDWwKZiCYHX9NGGzfbwxjU8OV1dPQ9m32YcoauTAmtyGvHMJvu2+k4V7v+TOfB35
	 FVtHtVu9gU7WwCdal7MIdfdBSWDp1ABEKiEk2MUle4vYUC32EvrPZxWbyYZNWzVnvI
	 PWPMxpTQvvhqFq/q+n884tUKE0UXg7FuRX/Cm27Ef94jTFVwBRdrFeYJSys1N/Mowl
	 2ejeJZRhHmxd3XETDBxexMWAlvSFeGnBNG3gWKeh4hObVhB9UelaO41fr1w2DYWtXp
	 FCS0DRAvorLWVTVW9fBJDkOJZLVuySQioLjVNcP3NnhKD6stoOsnM030AjE5/y/wNW
	 GcqvOcUVPFppQ==
Message-ID: <d89975ed06ae64a4871a8807f53d1e18@kernel.org>
Date: Thu, 12 Dec 2024 08:02:52 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>
Subject: Re: [PATCH v6 11/19] drm/imx: Add i.MX8qxp Display Controller
 interrupt controller
In-Reply-To: <20241209033923.3009629-12-victor.liu@nxp.com>
References: <20241209033923.3009629-12-victor.liu@nxp.com>
Cc: agx@sigxcpu.org, airlied@gmail.com, aisheng.dong@nxp.com, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, festevam@gmail.com, francesco@dolcini.it, frank.li@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, p.zabel@pengutronix.de, robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, simona@ffwll.ch, tglx@linutronix.de, tzimmermann@suse.de, u.kleine-koenig@baylibre.com, vkoul@kernel.org, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 9 Dec 2024 11:39:15 +0800, Liu Ying wrote:
> i.MX8qxp Display Controller has a built-in interrupt controller to support
> Enable/Status/Preset/Clear interrupt bit.  Add driver for it.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

