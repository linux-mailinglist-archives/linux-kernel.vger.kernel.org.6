Return-Path: <linux-kernel+bounces-183915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B48C9FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B88DB213D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FFE13774C;
	Mon, 20 May 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th8Qs/aE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B6136E2B;
	Mon, 20 May 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219582; cv=none; b=L4eTDIpKGUzOuQIOohSjO8Mp4rZTn2rqMx0R0gEDDKjxsE0iVEGmp8HFmcNeElL3ZtnhU8vmZvbB06c2dRr9F+nxLiEdtQIjDsn1kFJi5FoSB1aFlg1gAtNaJ/fzFTKqlMeY33NxehiJfT/ON82RgW1bd79e0/dickPy7wakbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219582; c=relaxed/simple;
	bh=2FJ07d8DgDe52fowMphmtvHhTWRSPM6nzFVguY1V0j8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Voske4HJKbhaOI3dXHzL6cqCdKY2xt+QDCrUP7FcXdDLorb5uxUNc69IxpA1dU80iGx42h1kXvdEO+dGIqfDqQNFOznINRJSCpfpchnffmQQRMWGwg2wQ45cUad5I8XLwzoC1uw389cezM/qHYcf4K00ifvwkineUMuWxC5DTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th8Qs/aE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847D5C2BD10;
	Mon, 20 May 2024 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716219581;
	bh=2FJ07d8DgDe52fowMphmtvHhTWRSPM6nzFVguY1V0j8=;
	h=Date:From:To:Cc:Subject:From;
	b=Th8Qs/aEfWvWQmD9GndbxkfaHQ4YZ/VcnlWDeguQehlJ1sAWn8yYdpqv/+5ct0wIx
	 v2Qm0Us+sr2x9J10dvBpD4bjf14NQpNjDwb7v+m17zhySOHdyKC/nGbaHRqA8yUaLA
	 kBdnvM/gHYZ8nGWWy7+TgXCfAF9Sbz+ULvb22tncf67ovPIhXvTx0va+4MhgXxDA+V
	 reJG3m2jg0gzNTaK+fMJ5PHpdDNzPVNIH8yyN8X6BD/eF/cKmTzVEN81fpjYD3foqH
	 MNxI5jfUiJX7sjAXoqqo7ew8eMNT6Bp+E4qo/OsiZzrc4GMFhPb4xEIh/bCKNCEFn6
	 N3RvuOq/cVH7g==
Date: Mon, 20 May 2024 08:39:39 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.6 uploaded
Message-ID: <20240520153939.GA1166124@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.6 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This is currently scheduled to be the last 18.x release unless a
critical issue is found:

https://discourse.llvm.org/t/18-1-6-released/79068

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that they can be
investigated and fixed in main if they are still relevant there.

Cheers,
Nathan

