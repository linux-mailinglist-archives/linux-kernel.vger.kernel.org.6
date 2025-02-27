Return-Path: <linux-kernel+bounces-535464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B2A4733B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2AB16F87E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC4183098;
	Thu, 27 Feb 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfmUmjMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5E161321;
	Thu, 27 Feb 2025 02:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740624803; cv=none; b=SH/qMKbnMLuYaeoWeuCXX4KPEikQ8EgjWkDo0f+o06U7DzGCdKL1sJh5ixK68GihO3i0+uaRB89RRJ2W4Lg/GjY5D6c6qF4m5K560FTrXYuRZemN4sB1a7XMgDEaPBCxOMDLP36JPATBYyStLaQGQa9W64PEPHCFC7TZiNHa3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740624803; c=relaxed/simple;
	bh=t5KzVkIxpyqElzCDPJkoLzsrJETmhcC+NGf070izwQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=daP0khN/ZktR1y4mTCv5R5ZB/m7eIl137wbNkclZcqkaZ2rx7ILzdOeKBK+xKXwGy0RKWSHC+28+9bk/sBHpwDFEBvqTAGk1LbVVBtr8YvuSDykPdy0slqxdqZ05LEqmIUBXLw+E9XIZzwZs6Ifobyprdu3z0vvD+HmqLFQ7i6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfmUmjMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D740BC4CED6;
	Thu, 27 Feb 2025 02:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740624802;
	bh=t5KzVkIxpyqElzCDPJkoLzsrJETmhcC+NGf070izwQs=;
	h=Date:From:To:Cc:Subject:From;
	b=MfmUmjMjWfp26Duhb+mgIOc4iBwrcV0IcKQUjYYtwaPGDnk4WcE52cIOv8q2ETTCP
	 5hHF7+sAlOgeX/TlwKNkSsecHtlFjTEO766TcywuEL1NKcTXMBASUJe662TZjFkxXE
	 lVBBgmMDNWOsydiNNutf4RAbXA0VnnqZYY/ZlE/UsK6c9ttbcsnurQoLmWvmtcqmXS
	 iIO8TnNcUVNYDVHHysz4hPQYJvhzOjF3XuPNMrk/tZa6RGkZLd1SLHv4CXW4Sl//iw
	 NlExiehLvZ3TAZonQL53+ZugCWEQEN6GEJK4EuUwrZ0VzzP5dx1o7CoaCj7hOmKotG
	 wxmNECqDVYO4A==
Date: Wed, 26 Feb 2025 19:53:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 20.1.0-rc3 uploaded
Message-ID: <20250227025319.GA3607450@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 20.1.0-rc3 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 20.x
series is no longer supported.

Cheers,
Nathan

