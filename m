Return-Path: <linux-kernel+bounces-430385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B39E303E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3422162284
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AC7E1;
	Wed,  4 Dec 2024 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZM0ci3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0C621;
	Wed,  4 Dec 2024 00:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270815; cv=none; b=jPhPFryUCiuWivkW4oXZJZ/26ucTdP50OiQ3WMHoJvfvf5pKKY1jqKQe6LyYeepjXA0kcAw6oraCy/fE3TuxEnnSYk+jOEMIvWgkzsLci5l/whA0Zp+awYwVfR+34lNI77Oa9j0htCm2FjZQQ9CllbVD4Pfso4Fkclqnqp0P0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270815; c=relaxed/simple;
	bh=Z+fsk004cBBqNkzOJvq3U5lWef2Rto2pUzQRXxmdweo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DMtZavPaYw78olc2TUGpkQKpzkPnayflc/jJUeEboKhyWgkT6vEOsJ7vpgRj8oDDzWfmy0HdYP6ueZHVdh5CWMQZF4sXiomv/ejNl8Mxy4yf4JKgdMUcaJ7hQUWnbBt/NtpN6och0AMQ7LgHmj3Q0FlmCvMT3eEnyNziTut3uQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZM0ci3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F78EC4CEDC;
	Wed,  4 Dec 2024 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733270814;
	bh=Z+fsk004cBBqNkzOJvq3U5lWef2Rto2pUzQRXxmdweo=;
	h=Date:From:To:Cc:Subject:From;
	b=KZM0ci3/C3Wcx7zooDmaQ58+QnkorXPSqo6ks/ZZlHbFtxj+wT2l3P6VbglQZVX5o
	 BanErC9FIXJBIxNuIHWUJbEiJkL8kHc8qxRMaW/B5aiUBSiqfUghnbfzU96CeLaQcV
	 ZukEapL7qOfx/HAKe9tDI37Su5dCSQ7+jgEKREFZTk7RJLoZZWwkKX5ZRTKQHmjnJ6
	 +GVu47AYGLDF5wWs2OAQYfG62rrp4odfPZbeMBOIK/714tytSOWpQGpovuwKcOAd0D
	 tW+OdqY+P+dmtdQJUNAvW0Ti+3HHZsgRjIUjXI1RnE36IHnv4Rndn7/ZXgJgr6xftr
	 7LtQ1y2SO7m3g==
Date: Tue, 3 Dec 2024 17:06:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.5 uploaded
Message-ID: <20241204000652.GA1999416@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 19.1.5 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 19.x
series is no longer supported.

Cheers,
Nathan

