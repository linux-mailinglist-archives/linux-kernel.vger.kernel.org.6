Return-Path: <linux-kernel+bounces-449954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB919F58A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDAA7A3F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5A01F9F4E;
	Tue, 17 Dec 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVICBSc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413321F8F0A;
	Tue, 17 Dec 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470439; cv=none; b=BIuFjdTDywAyWAy7Rx1Kad0FQsTiBmdGTZhA08tqN4PS/T2lUNyjNSJm1ddtsA0VsCOjsP0YXErWkSOh41kdb5vhpN+y42GWTYuQitLeQ44ZZ6qRa92pFM4hv+YGquqrMAXAoLmgKTgS3q5xmCcQf0jW4d6RmSuhDxd6qs6cH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470439; c=relaxed/simple;
	bh=OuhV49idgGSGTPuwn8qhhQpfCulTr1r67ho90pUomTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iE0bxeM9YCvYFK+VHkcR35FdL6wk1lLHRovfmZz6WDyevjYjw15e1Nl2eDPW2hdWxm1bljIpydu400TELmgtifibzWVUFCcJwJGtziJ/tEAA0Ray5Z/BWNUCe0cvTOxKfu4Zaip0Qj+tgL+Tkjo8DcGaKaoBVpCl7v2asAs2Wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVICBSc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DB4C4CED7;
	Tue, 17 Dec 2024 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734470438;
	bh=OuhV49idgGSGTPuwn8qhhQpfCulTr1r67ho90pUomTg=;
	h=Date:From:To:Cc:Subject:From;
	b=XVICBSc5WFUersqjelEVhLO8pc1wkrGnFbJLdvSBH7W52h/TKNdckIp3dzsB1/NOk
	 DFuFKHi9crdtfNIHqSlBQTwO686ZYbqSwZbnUjT7qaSnWT3GXh1lK9w8MO2vWpAxl/
	 Dvs43CII8mXQxki9JGUfrOVPhexTx+t9Av6RsJHWWn5DfvZC6rnK8xkvzAHmjBgRDG
	 OX9objChsNhGNSh04dKOC722gpbsd99XKa/nRYXiE9SpAJDoKjj2UhJQVEfYUDPeJX
	 ODSgE/UfBqXX7bSL4wNOivZvYsTBeS/gVnfrPWTXDlfZ8M5g8f04BUo41HTjBVkA7w
	 be/tXWheL6JBw==
Date: Tue, 17 Dec 2024 14:20:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.6 uploaded
Message-ID: <20241217212035.GA2842889@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 19.1.6 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 19.x
series is no longer supported.

Cheers,
Nathan

