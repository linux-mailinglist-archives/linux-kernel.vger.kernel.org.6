Return-Path: <linux-kernel+bounces-327023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC9976FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4400A1C23A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8D1BE868;
	Thu, 12 Sep 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spdTUW1y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576791BC09F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164254; cv=none; b=RWSK579CvcpL5URTe2CKA/RQuYfwXN6tpwuhF3M6rif8iDl83702O17T77ziIsrkUihnr/5hhBOODS2aDfcfVEwPY+bubNlHLuj4TSsFDOBp1LVl4QWwI9WyT8eqC6PkT67vnDfvg0gV+MMdpODCPBxOnMbRyM7+7Fsho8LP0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164254; c=relaxed/simple;
	bh=/u7emNOLxIDUjr++03pD8Z/lxJ7HDXd0Y6MHouVCViw=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=P1ORd0cogH+l3p+jH0XsAY9s9wL69SKjX+vm+i5/X6WgspbO5UArEGIamRhHycHLbhPvEHyHO6MZhMXdZJWBrn7YcX8RJkGxQacyZu0ZyZlw8gHxGaPUlRXmy4FA7XAx8XSsin815kM54cxNCQMYZ7Ek96Wjd/5KBVkTKv4GrT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spdTUW1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E58C4CEC3;
	Thu, 12 Sep 2024 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164254;
	bh=/u7emNOLxIDUjr++03pD8Z/lxJ7HDXd0Y6MHouVCViw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=spdTUW1yZ9zAbCB4ZjRdEv4JZvzuO6e0yK51h7W3b2FwSwTUbVkro7exf/JhPIXo6
	 uHEYkxRFnPff/psUPDz6HoS9bIN4aYPozC7ClBElbVYKl4vcLV8XdPsclvz/RmTQ+N
	 pj52nieB269A41pj/EtzGMrmNESkAZNCmm47yoAO25J740Lot2smZAPJFWW2iJoYgz
	 UD3J18JC/NkOp5sVxML+enqpd3xqLE38wgSTHNNFyNDgkCHMXVBvtig8ZmqtZN6/rJ
	 3eHkXaSO9fu6xujgkCv9uVie6gl/n8mKRnljgXzVO+h4e3xD6fu4xfb1skqH64Ouat
	 ob8Aa+SVSjppA==
Message-ID: <993bbe0a1b503505dd2e9b33b94e2b83@kernel.org>
Date: Thu, 12 Sep 2024 18:04:11 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Devarsh Thakkar" <devarsht@ti.com>
Subject: Re: [PATCH] drm/tidss: Add MIT license along with GPL-2.0
In-Reply-To: <20240912171142.3241719-1-devarsht@ti.com>
References: <20240912171142.3241719-1-devarsht@ti.com>
Cc: ahalaney@redhat.com, airlied@gmail.com, cai.huoqing@linux.dev, caihuoqing@baidu.com, colin.i.king@gmail.com, dakr@redhat.com, daniel@ffwll.ch, devarsht@ti.com, dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, geert+renesas@glider.be, grandmaster@al2klimov.de, j-choudhary@ti.com, javierm@redhat.com, jyri.sarha@iki.fi, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, nm@ti.com, praneeth@ti.com, r-ravikumar@ti.com, robh@kernel.org, sam@ravnborg.org, simona.vetter@ffwll.ch, tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, u.kleine-koenig@pengutronix.de, vigneshr@ti.com, ville.syrjala@linux.intel.com, wangxiaojun11@huawei.com, yuanjilin@cdjrlc.com, yuehaibing@huawei.com, "Maxime
 Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 12 Sep 2024 22:41:42 +0530, Devarsh Thakkar wrote:
> Modify license to include dual licensing as GPL-2.0-only OR MIT license f=
or
> tidss display driver. This allows other operating system ecosystems such =
as
> Zephyr and also the commercial firmwares to refer and derive code from th=
is
> display driver in a more permissive manner.
>=20
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

