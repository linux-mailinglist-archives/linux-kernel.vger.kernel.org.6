Return-Path: <linux-kernel+bounces-384383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EEF9B2964
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EF31C21987
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738002071FA;
	Mon, 28 Oct 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Lw5CcYb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6bV3btNu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFB191F86
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100972; cv=none; b=VFaN8PY3Fx9ltDL3pQkQYAjAVewtJXpwVaaS1VvgxIdpTH2sHPmrgWBQW1xgZyGjKHrfwpFow0gGLnesYwAH7YzlK+hz/XXl9jzn6Yvk4NeCdEznCICEb/Au/GwCvQuviEk7gjmsGtXxf+fMt8Tr+OXhSd98jFrzEH8C+8zZ0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100972; c=relaxed/simple;
	bh=BKk3S0BW1jAtRhA7kOuL04ZUycoUFVfVgV866DvXyYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrBKXT3dE3FiGE+Vwxn+JaO1BlzXrZjhNuOE3FQuA6emxlN2EU3zHmGnoiZb5ooFNvxvSR/spJZ6vXQNK2CRpQIhlilH+ESUR8e5yzb/pviSQtAOcweaTmCC7JPgnG83D6TNmR3ExVpS5tL6aRos6xifXvPwDWUC7BWOKm03Xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Lw5CcYb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6bV3btNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaIiVRm/wcamEKjgFEQqGudvkLaUOjAsfxLAZPwyDlQ=;
	b=4Lw5CcYb2rsDfu9XHWnN2vK4/BWGGRYiudtkR4beOiZrqIHXZiERf2MpgFmZchnVPHVIDp
	NB9NVHyYBwzvHV0gy2Gpx7IJpDzI7f+AotayTOm11upc7AAv0aLHEQLYByMqgJQxvYIMsQ
	wDx5F1i9dR31fM1774NzYwo+RE9VwlXo8riwjEoJfifCvdtGzg+Nt0WfXJtXVq4+dSqy57
	uNX/ionij/E3nNivUjyQJEnFqiqmSYuXOuFA+4OFBkzwnHNFCF0NXit6HdOc/RrRRKIYgF
	F+pJxPvlRWa+re5YEr0EhSrd9bilK49lMDghsxRjF0YwzCdtQKECmckQSZxGBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JaIiVRm/wcamEKjgFEQqGudvkLaUOjAsfxLAZPwyDlQ=;
	b=6bV3btNuNIxOFMxaxV8LEIywEsoAntuHTf89/dAKwDdF/Bb6Z1i+6jkzqICAGRKwDZMZ4L
	ABMOf1yx+N6AwvAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 11/12] hrtimers: Rename debug_init_on_stack() to debug_setup_on_stack()
Date: Mon, 28 Oct 2024 08:35:55 +0100
Message-Id: <f271158256c22fa01141d5a510466c36094d12d8.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All the hrtimer_init*() functions have been renamed to hrtimer_setup*().
Rename debug_init_on_stack() to debug_setup_on_stack() as well, to keep the
names consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6c29d988e145..48bd61ee9d50 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -454,8 +454,8 @@ static inline void debug_setup(struct hrtimer *timer, c=
lockid_t clockid, enum hr
 	trace_hrtimer_init(timer, clockid, mode);
 }
=20
-static inline void debug_init_on_stack(struct hrtimer *timer, clockid_t cl=
ockid,
-				       enum hrtimer_mode mode)
+static inline void debug_setup_on_stack(struct hrtimer *timer, clockid_t c=
lockid,
+					enum hrtimer_mode mode)
 {
 	debug_hrtimer_init_on_stack(timer);
 	trace_hrtimer_init(timer, clockid, mode);
@@ -1613,7 +1613,7 @@ void hrtimer_setup_on_stack(struct hrtimer *timer,
 			    enum hrtimer_restart (*function)(struct hrtimer *),
 			    clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init_on_stack(timer, clock_id, mode);
+	debug_setup_on_stack(timer, clock_id, mode);
 	__hrtimer_setup(timer, function, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_on_stack);
@@ -2012,7 +2012,7 @@ static void __hrtimer_setup_sleeper(struct hrtimer_sl=
eeper *sl,
 void hrtimer_setup_sleeper_on_stack(struct hrtimer_sleeper *sl,
 				    clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init_on_stack(&sl->timer, clock_id, mode);
+	debug_setup_on_stack(&sl->timer, clock_id, mode);
 	__hrtimer_setup_sleeper(sl, clock_id, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_setup_sleeper_on_stack);
--=20
2.39.5


