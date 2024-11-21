Return-Path: <linux-kernel+bounces-417564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A09D55CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334F9B22860
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41B1DE3C7;
	Thu, 21 Nov 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNnmp0qQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372C1DE3A8;
	Thu, 21 Nov 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229311; cv=none; b=N+ZjvxZj4ZKFtno511Vv7jsEw6m6Sd4hKPWdme64W2ecFm4ANXHWDF/k6EpHqvJ+NQX+NY0J8hE7okgkv6n1pv7/mIBZZLwaqIHl2plGDiOARONL2SMvCzAMZSHLfSq/BmorDDifhYD9C+xE2au7Sw84ZZgGDj6I14AhPlXzTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229311; c=relaxed/simple;
	bh=yt41PKWrEGJRnAjbz0PFhgIjDGDDXHQksKZGWxpFNBg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ceRQDB69389UHzseCgqOeX/HQmOeC8hdrV1BXDv/Jk0s+Qup0tKzbtBG1jdYNTX/sr+GcrLxZvj7Kmisc0KIqSHrIbeCW8mVHUFkb84u9OXy+PUTZS7zjyKmQDzwfnCUAf8NeYRLElt4osTuk2LTnMnXxp14GFHpIhFO9t5aPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNnmp0qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AC9C4CECC;
	Thu, 21 Nov 2024 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732229311;
	bh=yt41PKWrEGJRnAjbz0PFhgIjDGDDXHQksKZGWxpFNBg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rNnmp0qQL1nj3N2gOyBsQoO7xbSc6MAhn83m3EY+ySQiADVizmmo80xyy9puVyD/W
	 U3lvWAolldzlpXJRVNX/jm4csHUCkY4khC0nFdjQXulCODFHJpfqC8gvwtmcvQhuf8
	 DWFAtRq3JrgkuBEj0/a1gIWTqeC7WjAbfyWL3KINULzYidil+Caf8DCFgK0f+UAgnk
	 7aeHsM9acaL2XDG2BUMojUintNcQAMJlBCniNW6CHDbI2j41afeZvtg1Z1Kdv8uNLp
	 TLbQutV47LQnUFht2ZIF9JOBrmsusI4jBUzc8VmYWJH/0UcdxGXAcVMifof4dHccip
	 AbX6GkOkE6YNA==
Message-ID: <952e489881a673a3c2c803d534465d50.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023-drm-vc4-2712-support-v1-30-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com> <20241023-drm-vc4-2712-support-v1-30-1cc2d5594907@raspberrypi.com>
Subject: Re: [PATCH 30/37] clk: bcm: rpi: Add ISP to exported clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>, Dom Cobley <popcornmix@gmail.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, David Airlie <airlied@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, Javier Martinez Canillas <javierm@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Michael Turquette <mturquette@baylibre.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Ray Jui <rjui@broadcom.com>, Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>
Date: Thu, 21 Nov 2024 14:48:29 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dave Stevenson (2024-10-23 09:50:27)
> From: Dom Cobley <popcornmix@gmail.com>
>=20
> The ISP clock can be controlled by the driver, so register it
> with the clock subsystem.
>=20
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

