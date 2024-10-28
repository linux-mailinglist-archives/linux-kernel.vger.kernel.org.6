Return-Path: <linux-kernel+bounces-384355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331AC9B2949
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654FC1C21253
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306320262B;
	Mon, 28 Oct 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pzgx8mhv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="musIYBWa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D891FF7DE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100948; cv=none; b=Hb3MRez9lU6rXioW/SzkL/vBGd9mCzJXSC7NIZ7LIOHKOLVpEm4EYHUeijzaWKATRcpVOxCTOb7dusbjwjTJanwyD6DWZUBuZzsL9+4Cp1xR3V4N4bSOYFabXI2axTLMTTmPkPDZAR6VdnCpCK6z+cjlHG29rbNLg3A3Uh92ltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100948; c=relaxed/simple;
	bh=Cq0ZzGu90SucZ8ajRc3od8UJWqbgFmp+Py2FeFdl0CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWQbGjLRpFffFZvDQLc8kxE4vSTwJjoMhTUKMB1QsC6a/fKiCjKpzMgeceWG/CK+o5MoNeHoh8pYsSQscoIMk/jtgCCq4ylm7AKIo6qnRDBYvHaXdC66Brzc6x8OakYSekGSzR8QU9t9q4NYBJLxV+LDY3hSlvn2G9NWozW8cvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pzgx8mhv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=musIYBWa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEI2R8CFsxxO8R3+8zaBmsgZn012uBT8pRI4pMPBjzQ=;
	b=Pzgx8mhv6ZUVyj2g9o0d1CJi1vrO1uiyG0Q9GYVQ/X4uQKtI8+nZpucLKMfhe2rvVZBCeh
	kIvFxJQvZFYcgsLCc9pVZx5uopznfymmnz0fIwwGnJnWZfwnVyrAn0Jl+KSjc6gF5wMCdy
	PabFHuh05prA6rnWfFWGIpGmUo0MA3uwo5nb9cuRA1X7qUVAPX9OcEO23BNoxNmCRT+XW+
	aOYIH+h0O7m8Vlr8wWIr3wglrcy8nQoUIFgDrkDZDP6BKRwdnzEg7kDJclPJJQBFXyV2wY
	tms0uTH1srF00OoLIz10Hp/aaR9x1yBSZBYKpN3gh2QLqvX9v1PWqHHAoDEYvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEI2R8CFsxxO8R3+8zaBmsgZn012uBT8pRI4pMPBjzQ=;
	b=musIYBWarZ9xT5ao6lENWmIRFqCUCS8NovER9/6RsEwHj3mHK3VjE4FP0blHRD7/MxqUdH
	gHuXKlktcKb8AjAg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/44] drm/amdgpu: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:05 +0100
Message-Id: <3caf17b166eadf57ff9b10f49895519759ae8ed5.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index d4c2afafbb73..9f78dd176057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -188,8 +188,8 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev=
, struct drm_crtc *crtc,
 	amdgpu_crtc->connector =3D NULL;
 	amdgpu_crtc->vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
=20
-	hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_RE=
L);
-	amdgpu_crtc->vblank_timer.function =3D &amdgpu_vkms_vblank_simulate;
+	hrtimer_setup(&amdgpu_crtc->vblank_timer, &amdgpu_vkms_vblank_simulate, C=
LOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	return ret;
 }
--=20
2.39.5


