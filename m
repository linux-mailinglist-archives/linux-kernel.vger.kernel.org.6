Return-Path: <linux-kernel+bounces-541299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5499DA4BB10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1D9171107
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010A1EB186;
	Mon,  3 Mar 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek491Sbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF42E630;
	Mon,  3 Mar 2025 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995121; cv=none; b=vBuSwhMTpzAbQMZixM/wG/MCOl9vBabGal976PwGB8uMAzP2z/9pphu0w6vj9Br2BHinL9TD0GDFUmFggTH3n10Xm46x1ArRWV4a7HopJVyRDO/9U+pcozgq/LnDBeVPkoG7oftoyjnphzNxV0bi1fZ7EmxyewakOxT+b2qf1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995121; c=relaxed/simple;
	bh=9MjpxNDWc0Mel493RuZtnmix9eO5EL7yH9UaB35eo6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BN2Fyj6KHbyZ5v+oM2uIjxpFkDWKw/Syd7FxLvtlQ624hQAtxBcH+FVPC6DrmyL0cSiBSWbaFYXI3+iY9fb487MwOzdn9dr4Q9NsQu2vS+dV+v7rzMHBri8ucyAKFy9ychlM+K4Hec9uBaV5nToEseqMCD7VivcBhKlIDnRIHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek491Sbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF0DC4CEE4;
	Mon,  3 Mar 2025 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740995120;
	bh=9MjpxNDWc0Mel493RuZtnmix9eO5EL7yH9UaB35eo6U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ek491SbccVRRWyc8CFtPBbXGQDRHNVeEKQGU+vU/YAllzteV4QCXiCuFX2oLI91eW
	 gFmqsNGV7QAvZt0Fl89wFkfbTJv3Y4xZEp/0kH7647YQAAvLbRbkT5JJFjqA0DLtO2
	 xGeVIwvdwCPJYQrKcBHnxBT/xHcUjpEjLnbO9UbFee56Vix/Z/T6Ya7y+pkk14bTug
	 H9fB/UctibrjtLPyHi3NLrDVduTApQfN8vyFqMzB2bFlJVfsYG0tniXvEBh5/mEj6B
	 YxKhhnOtE6sOca3bxkl4lz0pizRkrN6UuQC1NZh30mC04Jb+DExm4jL2j0fms+hyor
	 C4F57XtYRhw0g==
From: Robert Foss <rfoss@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228083248.676473-1-colin.i.king@gmail.com>
References: <20250228083248.676473-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] drm/bridge: Fix spelling mistake "gettin" ->
 "getting"
Message-Id: <174099511726.139840.6705775137322314261.b4-ty@kernel.org>
Date: Mon, 03 Mar 2025 10:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 28 Feb 2025 08:32:47 +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> 

Applied, thanks!

[1/1] drm/bridge: Fix spelling mistake "gettin" -> "getting"
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/db505ff68c12



Rob



