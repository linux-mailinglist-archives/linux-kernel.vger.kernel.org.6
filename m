Return-Path: <linux-kernel+bounces-208044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD50901FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3066C1C21BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EB380C0A;
	Mon, 10 Jun 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD6Ke5P6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930C80BE5;
	Mon, 10 Jun 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016362; cv=none; b=BWM5VyYuj1SymK5d8qkOZbJ4YToGtITTt8VvdznXnNGLSwrITqT8TF8wCLu/Sixaf8AV6ldeY/paucOt0TZ9np70ezWaXmpUklbbFGefFzeHQHUiLNYuGAgjAsFSWtP0clArRb/qbWHEod08+e5LkU+p6dnmonQX+9KqCJMHvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016362; c=relaxed/simple;
	bh=nrn7srJm+U4otPWZqCTdnxpvVVkgQwsjU2tQUJtYpKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U2wrhoZ/BrAmAJHFwkyYkwV2OcVOkVdUhUSZw0ilMJ1U+QIHKFyICvXuWCGLxdEJT9sMxycnKpLUa7L+5ELecUPN0uQBE1+ywImYOyvfXP2q9QFfP3n0V7x10VQPw7kPB+d/6kdOILdI0UO2QIJJC194Xq3gqJHKgY7RxqaujHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD6Ke5P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6336C4AF4D;
	Mon, 10 Jun 2024 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718016362;
	bh=nrn7srJm+U4otPWZqCTdnxpvVVkgQwsjU2tQUJtYpKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uD6Ke5P61mkZo6ApWgMJzh3AIZ2I4prdWX6Irnt6T+aD67mYzQAEeAz5v9AjxG/7j
	 pEPG+7YtA7utHwRD2dSe3WC4ijl95ncugpd/0zIEoE6h2ePQ/NDjiX0Th4jjWNf3PG
	 zkPhr9mNmzcSvfVVNRKj9Wk0WVsfQ/ZnHXL73AWZtHu1OWwtm3TQsceZznC82fVy7Z
	 Cbssu/b8gpmr3QNK2NAZptZeXlteulCY5bqWSjslWFIKwdF4YMz3WrQWsUQMVTveBb
	 hYfst3nwnq0N+8iIMK2VR1frTIea7u1Qv5v+qjvoCrws/soBAPL3NAHagGrO9+gdcC
	 P0tI+DX5gw8nA==
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20240609-md-drivers-gpu-drm-panel-v1-1-04b2a1ae7412@quicinc.com>
References: <20240609-md-drivers-gpu-drm-panel-v1-1-04b2a1ae7412@quicinc.com>
Subject: Re: (subset) [PATCH] drm/panel: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <171801635967.423417.5891299339124414288.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 12:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 09 Jun 2024 09:53:21 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-abt-y030xx067a.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-auo-a030jtn01.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-innolux-ej030na.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-newvision-nv3052c.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-novatek-nt39016.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-orisetech-ota5601a.o
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


