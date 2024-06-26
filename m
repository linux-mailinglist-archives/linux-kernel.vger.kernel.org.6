Return-Path: <linux-kernel+bounces-230842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B138F918298
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AA91C2405E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74F185080;
	Wed, 26 Jun 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvk8jt5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E407184127
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408921; cv=none; b=Tj0sza3zIuuxW7MroZhxkH0xfxrmytyGQGEKlYaICIQKWlGzjilCldmv2HNrVeC4n27bUSFsRnzch9QPFIcFKNCtsBtNcRzXOsjTPh2qPLE8KANzP9Pc8jv/kIlHD0ktqG9yLXFBnHO8FW0sBKdgigM6JogRkxMvkVPBJuj/2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408921; c=relaxed/simple;
	bh=AIlpDGCONnWhxQyQ02FM69zXP8cQkr1yPRCkzWt917c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL2dkKD/hgc+6NQ9jjmJNSLzZRfjjSdHk8hIIcJ2mx31LiyEl/z9zM1PYP3g2Eh2vcxNJIuvZzVWgwtqW2lR8zmnNhdQIa1NOXImZMvem33jxo/B/lNwfexQpBLb9RjeWiQyaYYpCFWjJM0FuZS6WPLLjhqyfst7aKpwrfWE4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvk8jt5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D2DC4AF10;
	Wed, 26 Jun 2024 13:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408920;
	bh=AIlpDGCONnWhxQyQ02FM69zXP8cQkr1yPRCkzWt917c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvk8jt5lGmK2V8+IkXOm1g+XqpFdsSqfEAjxigSx8sQjb89osGtu+PoFrOWCVlM/p
	 gbDIEPLVvA0ppH0gp1+4FrfDcQMizf6y+pXinjzv2tfNOfgaNvkheC6h26ogmW+6m6
	 6JeqifBP5l+sTbQVRTtJGbAew/kJI3nCBrSWuoTjTfjRy2/ixEF2wcmwqsNvItHn/b
	 YwN8377YlJAYGViz8HsBBmuOLlFawR+Qrl8QvgMfhIZ4q7PKyOtBfZLk3Qikq2RqNL
	 cJ6Hy1Tm4IUyFExc2y0/IRFWuxIpftdhO606aR+w6pMFc2dpEVuGdTCCq36oB2E9u8
	 aywMeyyqCQMbA==
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
Subject: Re: (subset) [PATCH v2 2/2] MAINTAINERS: drm: vc4: Drop Emma's tree
Date: Wed, 26 Jun 2024 15:35:11 +0200
Message-ID: <171940890753.2204713.4133860106720254064.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621131926.3133484-2-dave.stevenson@raspberrypi.com>
References: <20240621131926.3133484-1-dave.stevenson@raspberrypi.com> <20240621131926.3133484-2-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Jun 2024 14:19:26 +0100, Dave Stevenson wrote:
> Emma stepped back from VC4 maintenance a while ago, and
> all patches are now merged through drm-misc.
> 
> Drop Emma's tree from MAINTAINERS.
> 
> 

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

