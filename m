Return-Path: <linux-kernel+bounces-230840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F97918295
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68A0283FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B82183098;
	Wed, 26 Jun 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGxX/tQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68656178362
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408918; cv=none; b=hQFj4AIvgbc3ObWQsp0o73aRKn8l/i9So5GiAoMTwVQYlhuiNV5JZCYzZGEyc6mngkdacaMnmkBPc8RhoOB+KEjGDjqgkQ9IJd3Ebi/HXFzYGbTi2m5B5/gcHZQTBdJu2GCeUr6sNI20Cnkkn53NVVzGJpWKtxnMjhXAG5x9YCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408918; c=relaxed/simple;
	bh=/f7qXJRAQAHwAWa526EQGIlJOvnCKod+JBCXhprTJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1YbormlmIU0rWKsdNyyxQPXQKo2ZJpWK7C0XkxigtcrCs1PWMtGi5+FB+9Jc05iRetBQLyAPr8qv9h5pNjkGc9F5G8qmEUyaXXyP/7OsV+4idoXuCJi697m1AKyTzrL7N4ACUCAZMJPOsGp+SFOav8TlSJxmrqoCTCRJetU24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGxX/tQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831EDC32782;
	Wed, 26 Jun 2024 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408918;
	bh=/f7qXJRAQAHwAWa526EQGIlJOvnCKod+JBCXhprTJl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGxX/tQ535wBYJrTvCEBxdUcJdDU2wG4w/cALO73RVMqPEOSv8vF5Lq69tQ+261Rn
	 rUKZHcTI0NU5mrRfXK+2sJgIddVDBQjXtv2pGbe8vfj1/9/5+dV8NLsQ+R3G2Ai47V
	 f6Ftby9yzajYJV1owvL4VOEIX6GjgWAwA0bRT8xPTK3wuNz8Bwcagvl0MznMDf10dj
	 +skPVWTMaojKiPmkrunV2nXJD91HMC3Bv+PsNjpulnmnDnd5t/DcTBVEqEVqWwWt8k
	 8GPp7nFGaHr0VZ+99iSZAw+sxXW1xE1zWUa5ax7oXnsQNTIkJizRWbyE6UDw8QjdzB
	 ZjtQUDdxGHD1A==
From: Maxime Ripard <mripard@kernel.org>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>
Subject: Re: (subset) [PATCH v2 1/2] MAINTAINERS: drm: vc4: Add Raspberry Pi as maintainers
Date: Wed, 26 Jun 2024 15:35:10 +0200
Message-ID: <171940890753.2204713.7508698225650706276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
References: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Jun 2024 14:19:25 +0100, Dave Stevenson wrote:
> Add myself as maintainer for VC4 alongside Maxime, and
> our internal review list as reviewer.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

