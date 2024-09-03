Return-Path: <linux-kernel+bounces-313627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21896A7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A91C23B36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD6A1DC73E;
	Tue,  3 Sep 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0oVuO/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05D1DC72B;
	Tue,  3 Sep 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393092; cv=none; b=qZsd66ntFKzWyuLFeUsj0NXaOyHjmeo+N7g4qx20BwX2z1jbWBwi00rovWlmuErietyeWAaS1+6wXvJTwjpohxzchJC5m42JlNO/zvhaKh3cgL5e8hX0ku52+IuvSxwHhQh7a9SJ2cO/ZxQ8vOX702vP9P5fAWtYLWiRB1rbtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393092; c=relaxed/simple;
	bh=mpNQTvs6cbrdkoCApyObjJYIVixt9+35kwl/BJbjvB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ehA/n9bWsP+c6PyEGQpAExsq6JqccgkvOw7tp72hHkZ0g43623gymXnm9NpM2MjwZcz3aKaUPf5C8yCKMbaqOD32w8GrSC7Cjf5xDNgWx9I8HO7ExKkFFaxYetJrYa5wlNVGbEuJNipBmkB9cIjxL82Ill1FARmxpfl3Syrs/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0oVuO/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01911C4CEC4;
	Tue,  3 Sep 2024 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725393090;
	bh=mpNQTvs6cbrdkoCApyObjJYIVixt9+35kwl/BJbjvB8=;
	h=Date:From:To:Cc:Subject:From;
	b=B0oVuO/bFBYsb4RZXHX4kKHwNI8fqBDt17fMsdNbIh9f7ZPTspy4tcdeDujpcqa2k
	 vnN2lYsBWTpium5jVNJSbE38i7QELt98MbRAvFeHZgeNFL1VALjwcn++dvSvltQKDG
	 l6MWTilb2V0vnkBLhd3/tSd1/0bQy66ab4/2X9BVQcxnRwgYPPjQpHQ6pfFBmgURl5
	 cCkQ9FJvDGFiMm6BIDVetZp3EwgwclNBH98x83IH0osn65saSEfkcbHfeAAG3jyMpL
	 ulxslBuzfGgmII2dW7mulvDh+XbhdmRYOme0Q+lz1nUNj5b4vjIeDYpR4yEwtKNk4G
	 dnkhHty0xMZkA==
Date: Tue, 3 Sep 2024 12:51:28 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.0-rc4 uploaded
Message-ID: <20240903195128.GA2607877@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded the fourth LLVM 19.1.0 release candidate to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the initial
19.1.0 release happens.

Cheers,
Nathan

