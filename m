Return-Path: <linux-kernel+bounces-332016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E5A97B449
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256BEB280D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B818B49A;
	Tue, 17 Sep 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq43ICs/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7803839F7;
	Tue, 17 Sep 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600239; cv=none; b=tCtg9SO/KT/G64tHZS2F8ZM77vY6ToQariHXmoymNC0iKgzxDwcl1Fhjy2/AZNzDcOyVlT4wh8dqSXWEgP8qqVWi9A6wr6Y0/m4lQTMKW6pcdo6Yp7GxJi2Zvjp9AyIDt1c2gYW4QkaFqosWAdwzcpvtC0Be0Bj3Ie8HWMhKI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600239; c=relaxed/simple;
	bh=4x/rgInwhkVAgVydWW/4BlzimOyJ0qOJXz2WHFNRmVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NZjYeQ95qDnAvPNKur5YUTfI4p/1MFaOPb4qP2G209TuOXU0pfmiGrOOQjSMqNxbK5+ER7w+8btNtaaEDfUS+VY9eznChuX4T+H90j/OH38gv19DFfwdvzUlIlhrUKAQuiwUI69ZDPbluGPykpIuLZhSYqQNUtQRVpfpxmIEQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq43ICs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C36AC4CEC5;
	Tue, 17 Sep 2024 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726600238;
	bh=4x/rgInwhkVAgVydWW/4BlzimOyJ0qOJXz2WHFNRmVA=;
	h=Date:From:To:Cc:Subject:From;
	b=Lq43ICs/T5BAyYB/tdZXTR3SThNGIx/xo08I0YEmX4zKQlIvynUVcj+gCyZDFwjOm
	 JSHcam71LMDWzOiLNeLV606ZRDuK1M7xzbzH7IGkLi0dz3qvkFdB0/BBha21MM6hpF
	 ktaOddJsxIex9VlAEedwvGJ19gYLpnWckZU6Ut7NNhbWfUCGO1aPTSSwp4fRKXL0zp
	 U3K4k/jyqIDFm4TwycXuoVRAVbE7ksG5WzhySpXjkwkW25oUDLNa4chiPpJcrUv9gw
	 SzSPJyZFCQnrqJ7h1mt1Fr9ixFZ2BvZmFC3lN8aUomZO2u8bBpCGyDSOvSZZJYbWiZ
	 AcWX8MakVzQ9g==
Date: Tue, 17 Sep 2024 12:10:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.0 uploaded
Message-ID: <20240917191036.GA236618@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 19.1.0 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 19.x
series is no longer supported.

Cheers,
Nathan

