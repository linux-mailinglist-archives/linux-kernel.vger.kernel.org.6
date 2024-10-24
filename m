Return-Path: <linux-kernel+bounces-380177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C68E9AE9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EC4B24B58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E71E7661;
	Thu, 24 Oct 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyklSNg+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695918A957;
	Thu, 24 Oct 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782472; cv=none; b=KR6FA7DVJ3logPHkjLjlycCbuRWMhXjc1SdmEBNpGwd5pcnc1cPiDC35KH8NkFgfKsjHhXqn00W79zCHIFFkN3Rbl0twEK4h0m0tWoB+JphDinkvR6EFXE/R6kKTi4z9TkaBK8B5343/h7LZRTO8SdybsPF137f10R0dZbaNiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782472; c=relaxed/simple;
	bh=gsSRaxF5qMUcw8w2aFZFzRk8Uw2PuZFPXxc0eD5vXhw=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=eMOhHxfJZGWaxmVwK0aL1WPWJkUG6Tg7KbeIoPPVKIepYRd7hveU/VvC3w+WqPcrK9Ac5JLyPkAKoceR2NKIAvThlUpb02uiAsxWf/tALKF8eHTTOkB7khAQa+LFW/maqBcvKL/OoFK1HR9DWadOanzDSJefd3aH6c8qssXJpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyklSNg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E471C4CEC7;
	Thu, 24 Oct 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782471;
	bh=gsSRaxF5qMUcw8w2aFZFzRk8Uw2PuZFPXxc0eD5vXhw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=HyklSNg+3Iov4TU9gqtKiQUm2hzQu0aZHkrNMPUa6dIsZbb4gGoBaapCT1JtLqTbb
	 CzvBJyu86RqlIErqmui2/Tieibxb12WjJkPOKUeAjKQ5/Bandf78Es5DC/QbL7vaJR
	 W/6CTpsmJD1A39S/EeI62TsB3jj+kMyiPkmWDiWwQ3mUswQc+JuRVzvKu3gBQh3QWF
	 wSWrRJMd/DXp5TIVdyGIqCJYSHRz66TYuazHO9YQaFytFGkAaMECjMYa7ykMH1gxbo
	 kBNeIiFnHilQSeU9bJSuledTFYxrC5piIIjt7t7uF4gQE+iLPGFVkx0ECw1MPavgp0
	 sW3E7vG58mAew==
Message-ID: <a308178ba289f0df76fbf031b3cb103b@kernel.org>
Date: Thu, 24 Oct 2024 15:07:49 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 24/37] drm/vc4: hvs: Add in support for 2712 D-step.
In-Reply-To: <20241023-drm-vc4-2712-support-v1-24-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-24-1cc2d5594907@raspberrypi.com>
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

On Wed, 23 Oct 2024 17:50:21 +0100, Dave Stevenson wrote:
> THe registers have been moved around, and a couple of minor changes
> made, so adapt for this.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

