Return-Path: <linux-kernel+bounces-430183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64719E2D64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CF516222D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3920A5E8;
	Tue,  3 Dec 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZbD5cB+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F22040BB;
	Tue,  3 Dec 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258435; cv=none; b=LWX6ZKLwnT3uK2CTTW0PEyJqnaZxe5O/JdG/CGdBL9/+oUehpvxyEoeY7BPb89n/TG4Pmwc4+/ywvo4LmhiNSnEtm5CHJXa96k/LzUXWpeaEp1yxIH6EVYvv1aGIfMGHdJezsTWSnRT5lpNJBIbw3APMEvvd9GRMRA8OdzkTPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258435; c=relaxed/simple;
	bh=4UjsiC0KsWowBXHcrV7nZu5jRThZpr9xrSV3uf9AHMY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MPbCBBiEmspyPDOc5V7NIvqoW+cJze/A1Kpffr1sXJ7A92OUsI8mX7gDaMgTGpuvZOtHTAcYVcrRO5pVXZr+C/d/f+f5/DnbcJfYhyc2XjWnOjLZKpgL25sZ8dM4LkGFfId3/d2Nf7wzDo5iVx/UMCGJqwBMaGE4gVv2J+YTjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZbD5cB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FBFC4CECF;
	Tue,  3 Dec 2024 20:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733258434;
	bh=4UjsiC0KsWowBXHcrV7nZu5jRThZpr9xrSV3uf9AHMY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jZbD5cB+8cM095ogWta+4NF5rrGHNyBhea4lomQM43bAe6yABlDfcBYrnNi1biFp/
	 YU01SFTTaCuEf7yRX102QK1LMjnUlK4W7XdvR3m1DFL2b+mltLTCveVTd4h+9EWX74
	 uADzl9CJNHLdocs3bt/4VEogA6aLuG/H1+zJiUsnhHp3jM3iOfpRdpYSx/clEjUKt4
	 0WLEhyZl72QMs5JJFv1QEIq6FzQz463EpnLWsjXp2t8d3vq80LTnImUVlJQ6ET8boQ
	 e83xR84FZ547Wz2dmicOwaSjwrfa50SdptnQHe/GWx28Z5Wm70sderqhxnwSowWALh
	 C+YGurMCYJ2TA==
Message-ID: <0c17fbef1e4dd692e2459255af0b4ace.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPY8ntD7tf6+PXKdWe8_KjCiPoemR0RQDiaHHndtjutOLGbR1w@mail.gmail.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com> <CAPY8ntBM=34pTiQ=t-CjtYEE5Ax6D=EtiY-sLT1keUkUMXuLeA@mail.gmail.com> <20241122-orthodox-mantis-of-reading-2dcdcf@houat> <13cfb66b-f904-4720-8829-a6d9db85aaa5@broadcom.com> <CAPY8ntD7tf6+PXKdWe8_KjCiPoemR0RQDiaHHndtjutOLGbR1w@mail.gmail.com>
Subject: Re: [PATCH 00/37] drm/vc4: Add support for BCM2712 / Pi5 display hardware
From: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Javier Martinez Canillas <javierm@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Date: Tue, 03 Dec 2024 12:40:32 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Dave Stevenson (2024-11-27 06:43:38)
>=20
> V2 includes fixing Maxime's comment on "[PATCH 31/37] clk: bcm: rpi:
> Allow cpufreq driver to also adjust gpu clocks" that Stephen also
> commented on.
>=20
> Stephen: Sorry, maintaining newbie, particularly for clocks. I see in
> linux-clk patchwork they are marked as "Awaiting Upstream". What, if
> anything, do I need to do on those?

I wasn't expecting to take the patches. If you want me to do so please
resend the clk patches and I'll apply them for the next merge window..

