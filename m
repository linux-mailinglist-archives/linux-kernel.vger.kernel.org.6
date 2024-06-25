Return-Path: <linux-kernel+bounces-228435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E5915FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB5751C209C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E542B1465BF;
	Tue, 25 Jun 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRQHNIYO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567C73463
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300080; cv=none; b=jhKycn/K6QFg0+BdFgVbY6ZJPVVOwgPlrudjDis7hhec6n9HnZ5GIO6zGF/wakQwSOZvV9Lnp4VSmHTE6yUGH9d/5BMO9Jv40eyO0bExVYa26qgjSZB7QUgdbvUMnA6E/6NeMbjW8DFfEo36ms7BK9miINP2Yrbunq8QsdhQXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300080; c=relaxed/simple;
	bh=paWhFo4l8mdM1qqnlq7WGsuggTFK1HuSiJILXMv3gB4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=LR2HQmzDHjcQRUgW6sIHAeA3hch429LrLhteE1/d45mngqSp9kuw/Q7ytZeLC5KUFcgjkHfDXSlRFsKt5mv56vZd+qT2Yfz0bIYVCxqLudK2Hy91mod7Ibiwzo6KFUJKoB1ZK7iNomj6B6Dooz0ZTQfHEetSS8msxD+N4N5vzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRQHNIYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CFEC32781;
	Tue, 25 Jun 2024 07:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719300079;
	bh=paWhFo4l8mdM1qqnlq7WGsuggTFK1HuSiJILXMv3gB4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=fRQHNIYOI/OeAebWGlTn5lIYMN2ap0+GwLeKpOPNZYXhkB0b4d5vzgxxHMP8rvjOj
	 ctcBPO21BzuzJqdD0oCPkCci5/A0PE69VVqRPB3COrFX1ap0zUJH2L7yPlwrUFEDYb
	 ML2KJgGUrF/FYKGIqHH6gWBJXaHfUPcTskAWsdXy9H5Q72jisJTYIoOuYd8H5LkOi1
	 LTdtJQN8AKzPSOpOqVmuuSReY5r5DE8yCHFYjdq8kfbB/5/lCmaHVJ58AvA2JKI66n
	 fZay/HKkDJSWC2ROhUHbJNoByKMbQ5y7qzenkDdANxIAGIjbhn7ru0lSR+VRtnLumk
	 VM/cR+1v0/EWA==
Message-ID: <1f46ea7a6787ad3c63fd3decbca45742@kernel.org>
Date: Tue, 25 Jun 2024 07:21:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] drm/connector: hdmi: shorten too long function name
In-Reply-To: <20240624-hdmi-connector-shorten-name-v1-1-5bd3410138db@linaro.org>
References: <20240624-hdmi-connector-shorten-name-v1-1-5bd3410138db@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Mark Brown" <broonie@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Mon, 24 Jun 2024 20:39:58 +0300, Dmitry Baryshkov wrote:
> If CONFIG_MODVERSIONS is enabled, then using the HDMI Connector
> framework can result in build failures. Rename the function to make it
> fit into the name requirements.
>=20
> ERROR: modpost: too long symbol "drm_atomic_helper_connector_hdmi_disable=
_audio_infoframe" [drivers/gpu/drm/msm/msm.ko]
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

