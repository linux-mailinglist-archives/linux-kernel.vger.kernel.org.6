Return-Path: <linux-kernel+bounces-414824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA47C9D2DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCD6283DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD11D2B21;
	Tue, 19 Nov 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR8QrvcT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E791D1F73;
	Tue, 19 Nov 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040685; cv=none; b=el/kZKrDbqGsf86JOHYqtiH9dFg7262sP3qORyRSeQD6Joq+B5IUHQMMwJyUqRytN8diT9ZZYc048mp1qf7wOiSpv4v0SJ4wCPb6+CKWTw0yUTcjGlFtcfpXmFWGcxP3wrDvOYgXFhMvY3muE/2raZTCb4LvqKtPhcQGYIsBG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040685; c=relaxed/simple;
	bh=V0QFm9faFwUNBEAolz5u06Peb4KA69sRGejzPlX6SBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QdsaHvgK8Qqgp7v4M2xIBOPNIqB73oaoCUtNokKDDIfm/8saL4t6Mkl8eQg+MxyplqHWno2SWwN0JJiKggXJPvK/hpu6YSA0IZoEt7XU47vCIBKrblIz/2PjfaACJ2sTYaxMahFRsgaQBsg3GHEn0kP0Sq8bsxHRDDQcnyUopPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR8QrvcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182CAC4CECF;
	Tue, 19 Nov 2024 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040684;
	bh=V0QFm9faFwUNBEAolz5u06Peb4KA69sRGejzPlX6SBw=;
	h=Date:From:To:Cc:Subject:From;
	b=MR8QrvcT8SMeNh7avKLEueEXvWzhZiqSYnHkH7tarHmasSsNJX6hzQL+PKVw7Me5P
	 O2Trwr++OVBh31TZAg6rTtp+NJ4IIkpkMgDbXEkU9flzUDgV01R11kulxXgzL8rBen
	 dOkoV4xuHMI9dLDps/jPA4O824KyvaODEnR0Y6ZzO0o6gGIeMUILee1UxAavHuw0LV
	 3y/2dLYFb++uH3xse+fCmh8zrgb98OhJTtN6X/xYwdY8CxCqk3IZC54vjorxIa3k3Y
	 koKiQT8UMJFeZTIgQA1KL05kPu/FBizgcWywBKCVBT6c5luKdE1+DWjOx+00NRMZEH
	 x/qAfS5x7goYg==
Date: Tue, 19 Nov 2024 11:24:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.4 uploaded
Message-ID: <20241119182442.GA416521@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 19.1.4 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 19.x
series is no longer supported.

Cheers,
Nathan

