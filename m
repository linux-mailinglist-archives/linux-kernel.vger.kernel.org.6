Return-Path: <linux-kernel+bounces-245376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F2492B1CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6ABD282686
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E2152176;
	Tue,  9 Jul 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVjSrTvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412E149C77
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512704; cv=none; b=sdiM2x21qMvBcaR1kOLu6yZLAddz593+XMg8ZEFIFu/f31W7mcvUsS6MkjaOXKY38w56YvSS3HlTsX70GI1BeZ/emUijcMftn1SS8uzr++HzqaJD4Iohwogl7cinbz4rE9qRAq0TcjWn72yRUFnRdXH+nqWUF4r8Uu/VQVLCvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512704; c=relaxed/simple;
	bh=gNoHnlGde32LHrAOGcjhcjPV0cFHv6TjFdHQRtUc0ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJhqcBddde4QLohMHrYo+SDxnBxklBG0qh3R1pOaRI54QGyf72nik87icQPWgmRvr8Q9wg5EvAsRyZ2ig7e//5zSDcsurKfe/LUb34QqV6rN1NY5Gute8VEIPaDW/fouQ8qg/g53PHUk7OZM4++wcr1qIhMC6WAw/ORxk0Q/GJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVjSrTvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF56CC3277B;
	Tue,  9 Jul 2024 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720512704;
	bh=gNoHnlGde32LHrAOGcjhcjPV0cFHv6TjFdHQRtUc0ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVjSrTvAZP5rtVFuL1LZ3S9nNOdyF21742VJk9t+t6eSeZ1dI6haojEx2hwaQFzUL
	 B/NI5iZ8Y3gNwVnRwt+fBu83NqaYioHVNNI96+glVuMWqXlwlaof8rDqn1J0krweCC
	 udboAD4K8Vnrzg0NGtvM84Ssd6HraNQcgF4x3s6tIpGsoLoUosdawtyKCu4jRsay2z
	 klQIBfAUq3RsHh7YU/fvYKE60+TiIaRMU+JPYlEYog641kvqfgpwjpU0KQidjmiSJR
	 C6JZ8cKLLoaxfqFYcnUJuGTIyrR/Gkbo6Z4L2mVistJHgrxtSAiJ1bQJS8D8er6tqZ
	 tV9zp0xAJJHbg==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org,
	Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: (subset) [PATCH v2] drm/drm_connector: Document Colorspace property variants
Date: Tue,  9 Jul 2024 10:11:39 +0200
Message-ID: <172051269761.180041.16742785029859589902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702143017.2429975-1-sebastian.wick@redhat.com>
References: <20240702143017.2429975-1-sebastian.wick@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 16:30:16 +0200, Sebastian Wick wrote:
> The initial idea of the Colorspace prop was that this maps 1:1 to
> InfoFrames/SDP but KMS does not give user space enough information nor
> control over the output format to figure out which variants can be used
> for a given KMS commit. At the same time, properties like Broadcast RGB
> expect full range quantization range being produced by user space from
> the CRTC and drivers to convert to the range expected by the sink for
> the chosen output format, mode, InfoFrames, etc.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

