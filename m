Return-Path: <linux-kernel+bounces-208043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95125901FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B75C285BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45F8004F;
	Mon, 10 Jun 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrP9lFJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD680023;
	Mon, 10 Jun 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016359; cv=none; b=lx2bfAW6ae0BwWDY45XXWMhPMeKzrtnGsd74M7MGmZJwPo5qjc8xx/ivPztBUJg2RJ73vB4J2ttk17Fss0zayEp/3/IhlMD62zT+5twKdpPGzwFkLoGgbogx8Mu3l1008hXpi966iV4ObVKgI42PBUmoeh0S1Vuk4OFIjq/aKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016359; c=relaxed/simple;
	bh=de/Je/u5h8UnoelIFxXxYL1UFEqTFQEJfReeA722jNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ViLcv/3P7yiuWsInQKb08b2bURmiZoLJ9cH1ct+p7ilLTf3OSApq4BV3+VzMmUhVDCtGqjmrL1QhmECb3lVzymJVNLz/ixM4eDYtzT0KzzMbmaXL9XOxrRdBHG3wOk3/ILomjfjaiuqZeOfTDMxHwLyvd9RtBMod7O8RysNZXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrP9lFJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8FEC2BBFC;
	Mon, 10 Jun 2024 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718016359;
	bh=de/Je/u5h8UnoelIFxXxYL1UFEqTFQEJfReeA722jNc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qrP9lFJ5a6imNng6a5GOKmfAX7NQ8rDyd/P/RTarBlfpC/X0FAU2rLs71a+Tk/jeQ
	 m3WM90YrLMwyWt/wqrnU8Vaq2CG9vnCyxB6utCxDls5QeBNZ5hj9cQ4rwVx/jX6Aod
	 V/oDfX9B3uUpP265WreyFeY807Y8rGvR+oDuM1DTyoCvqvy+hegHTx92Q34zmkDqkX
	 up73mmN1ZNGgBXYJJiDrdkuT//oyNdF+PAT6FS2wZYCEBWdFd+6DmAQmLCiFGUtB8i
	 1mWxMPYCVyED82xvqOMX/KJbOF8vHFlER4FyoeeL2mxLLYjSn2D6LBYL3rXmssRUH+
	 2lAVs1IldrG1A==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240606-md-drivers-gpu-drm-tests-v1-1-228ca6213969@quicinc.com>
References: <20240606-md-drivers-gpu-drm-tests-v1-1-228ca6213969@quicinc.com>
Subject: Re: (subset) [PATCH] drm/tests: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <171801635662.423417.8331156128814369849.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 12:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 06 Jun 2024 21:42:46 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_kunit_helpers.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_buddy_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_cmdline_parser_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_connector_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_damage_helper_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_dp_mst_helper_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_exec_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_format_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_framebuffer_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_gem_shmem_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_managed_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_mm_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_modes_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_plane_helper_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_probe_helper_test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tests/drm_rect_test.o
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


