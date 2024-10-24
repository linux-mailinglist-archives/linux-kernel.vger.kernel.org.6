Return-Path: <linux-kernel+bounces-380174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4499AE9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FE91F21ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7E1EBA11;
	Thu, 24 Oct 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2B8GiT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0A18A957;
	Thu, 24 Oct 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782362; cv=none; b=At+Y4aNlIGHYljlgeI6DLpMmitts3vdJY9GmSoRtN9YBEw6g4npVYkxqRk0ehogi9swExDXV696Ef7NHkqPv7ZTZpWN6ALxtcgbtao+CvVu5+SbpzQui62rQX9LhzmI3eskIZR3BMg2KnnWdC2RbIFVh6w4dQkncF6QO/scKsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782362; c=relaxed/simple;
	bh=Ih493C7FW7huTj70GvMdQCxCv0/8gBvIIgko/BVBESQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=JiomKdS3b9uaK9HIoqM39fgAPn08jpwddtBtdNbaV2cRYDMpcSrF1wWZwQlHxiN6F4Hf43Gzgm5UDkPKY+j9uqRjBnwGlGeNBFOQNv7soTG1N7Flt1Ya2iS+k+VIn56hkSUtbvbm6TnnqQuOrQKqwSPfe54dLEKew8Yc9+nM0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2B8GiT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4830FC4CEC7;
	Thu, 24 Oct 2024 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782361;
	bh=Ih493C7FW7huTj70GvMdQCxCv0/8gBvIIgko/BVBESQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=G2B8GiT06sGhvAw8upxtM0+4xoxyH2VU5Fs2aV8Al5mf91nP+UD9BCyr8wxtcM8wq
	 VCmJN7wdKuj8FdYcDhTFEDpfx1uK0I+897Y5r1LBrarAwoUlKOQB3lAFScFx7ZstWn
	 xU2HUvAs/GrFlF1cSAweX7XZ59QcWpNVQfXYA4oXTgzef1RaSzz6mDI/hD52/ki9wj
	 Xdi7WTeDIG39ORLQJRsHowGLTWUbFsECRnBcbU91mbvXGGVWvbHiRTKwaDpeYqYr6y
	 wAgdjvcRVdhrByzczYohXrfkDIrIv/Yp6HRW+4LMMc3xc1gc8PJCyMYY9kS1Dfnox8
	 qH0T0lJDW9jTw==
Message-ID: <35fc492aa7d6298eba531d08e9fccfa4@kernel.org>
Date: Thu, 24 Oct 2024 15:05:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 23/37] drm/vc4: drv: Add support for 2712 D-step
In-Reply-To: <20241023-drm-vc4-2712-support-v1-23-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-23-1cc2d5594907@raspberrypi.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Conor Dooley" <conor+dt@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Florian Fainelli" <florian.fainelli@broadcom.com>, "Javier
 Martinez Canillas" <javierm@redhat.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Michael Turquette" <mturquette@baylibre.com>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Ray Jui" <rjui@broadcom.com>, "Rob
 Herring" <robh@kernel.org>, "Scott Branden" <sbranden@broadcom.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Stephen Boyd" <sboyd@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Will Deacon" <will@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 23 Oct 2024 17:50:20 +0100, Dave Stevenson wrote:
> Add in the compatible string and VC4_GEN_ enum for the D-step
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

