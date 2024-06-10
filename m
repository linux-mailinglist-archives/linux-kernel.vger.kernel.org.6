Return-Path: <linux-kernel+bounces-208045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D7901FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8832C282DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6590214885B;
	Mon, 10 Jun 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkzfbU2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9480C13;
	Mon, 10 Jun 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016365; cv=none; b=sw8vW73EgykWn27iVijmmKIOKQXmXETp3cGUGuQSb2yu1l6KParpaiY5jXFNknJxAkRnUypFkNrA1aZn5Y/eEpA8ewzUufttjOWPbc3yfaiR3BTlhWfGKPFeo0sjnAI1khi+A3tqaWRiaDbY27FANwX2YBljAbbH0LPmlYrxuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016365; c=relaxed/simple;
	bh=ZvmWNkqtnIkP/GSS8Mvn1rp3F3QT+Ac9zEEHAh777Ok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pC7WZk0K4PSScd49+urQ6Cl6HF8WU662LIHXh2cgOe45YhfjjFDkI00+IYAiOgt/zC5ts5sWQbGOjH4NME/SFfXNKGuCPWfmvZN4jMaMsld0R91mAFayl+JpkB7JKJd2jiIagYTwTaZS0tIWSZmtlkqrx59wnc9pzp/X+qKX8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkzfbU2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C32C2BBFC;
	Mon, 10 Jun 2024 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718016365;
	bh=ZvmWNkqtnIkP/GSS8Mvn1rp3F3QT+Ac9zEEHAh777Ok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TkzfbU2GWOQ14hYlAbuLwNfRKI4I7XPPqDyZcaA6q30GJbqVm/MX0K7ydInP7XdUV
	 fhBRPQynK6wre7Tt2Z6CSCVZoWtWzlxiUSseR7rPA+J9CS2kSLgqrrOzGo+q04OwGI
	 uGsAs+C7qKfG/eMOUKAE0MSwWKwKIRH9hYG4Gxou637P1Unrf9Yd2tyUMKzMIiHVqB
	 MODIT7cz3wiCyI+jISBPXbnsK5AFNoPe+/ZDXAV/MgdfOjk2i6DHZRQlWj8QdrZJVW
	 DsWXgsNZFI/r1w3AA3VsUbwb+98rYCDHKxAUFsVFLF+ldtIzWaaK86WOjY//TVJFCo
	 yAGZQPtTVO3Ow==
From: Maxime Ripard <mripard@kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240609-md-drivers-gpu-drm-tiny-v1-1-6905fe4ada50@quicinc.com>
References: <20240609-md-drivers-gpu-drm-tiny-v1-1-6905fe4ada50@quicinc.com>
Subject: Re: (subset) [PATCH] drm/tiny: add missing MODULE_DESCRIPTION()
 macros
Message-Id: <171801636247.423417.4844444283186848367.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 12:46:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 09 Jun 2024 10:20:27 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/bochs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/cirrus.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/gm12u320.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


