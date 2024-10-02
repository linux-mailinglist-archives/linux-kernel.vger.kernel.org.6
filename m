Return-Path: <linux-kernel+bounces-346984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41198CBA7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25852B22B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9617C96;
	Wed,  2 Oct 2024 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLIVlbTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1D17BA2;
	Wed,  2 Oct 2024 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841004; cv=none; b=aTDm8nm5rH6masHvBnY9G+nni5oEG4vUm59WFjxUJOEOSLjccsXmv/YsyCPDYH/EFu0fh4k8cB2J0VvsFWoNy3xjF/PtCuxccrQ6KDzvMIi6dSdNPN98MgmlFkqPk2qIbitM+iiLOI/k+RpYtc1prBR82OTmSg3xizVZjlOP4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841004; c=relaxed/simple;
	bh=rKRhENrnmkOfVesk43wu9Gtrg+oV56LeStbJWPaJVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HoM2Xm9lFDKrMFVKHLxZEEN18Twnrmh35Qhlby6HKjzILhjHqirhBV6B86DDzau22S3NQHnQyrN9nym6XrKDDPux2GU6wzGJlelk9Din/Km37sJa3pyWlaEk3BduuU4edEmprCtMHyWTvETtrs5UquJxV3JDcT1m9Eb3j8jgh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLIVlbTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA034C4CEC5;
	Wed,  2 Oct 2024 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727841004;
	bh=rKRhENrnmkOfVesk43wu9Gtrg+oV56LeStbJWPaJVe8=;
	h=Date:From:To:Cc:Subject:From;
	b=uLIVlbTBV6MjQ2WAUS6A171PIgiwJ64hsBl8fGgbYXIx8Se1C4TCg34rhZ6tlhy9V
	 iPeGHIWqMwbOaxeJjtD63ICkLelFh57ler8Jcn8buaDoC67PkBNpotJUIuCGB65A2T
	 4EAv8vnOU626GzPBFZhIKTQhG9lhz2PT3QsAT0j77+QMWn4m2u9U9f2ea7WA3KmZTT
	 f3vLHOGWdZKzKl/c6pSkGOnqxeYOY28eT0/EPEcgKM0CbAbMqBIsvcuvraHOGBAGsy
	 FyKO7raG+9hz+1PjxqBAXVtdfVHC7f1IKvCcAJgG50bAgbwisYSm/xX+0GrOMA5Fq6
	 YWkZvA6K+oDrg==
Date: Tue, 1 Oct 2024 20:50:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 19.1.1 uploaded
Message-ID: <20241002035002.GA2829204@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 19.1.1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 19.x
series is no longer supported.

Cheers,
Nathan

