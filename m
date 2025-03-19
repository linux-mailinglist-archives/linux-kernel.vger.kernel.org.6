Return-Path: <linux-kernel+bounces-568330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8419A69411
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BB03AA3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE3E1ACEAB;
	Wed, 19 Mar 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSEz3psg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD18F6D;
	Wed, 19 Mar 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398967; cv=none; b=CB10Y+bhX33+CBMRdWQRQSEG9/EyZhBBXiBgIDCze2mCOlCG2wtgAeksXR6Z0pTvUXJDXjYxMxKchf9K46OGFRMUqQN7nJX4fLlwjY4+sbl/tp4wm91K9GfervITchoJ17g0L9m3P8Zj7QW5f6YzzH6dqa9Fv6mpvm+np0oxSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398967; c=relaxed/simple;
	bh=hq/Xnzz8NMzDPSLzFIZjOUjCU+qawzTX6aJY0OdgJU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lJNgBZSBwuQUMCHW5QW5LWSQteDMxQoYd7TV6YvnGGyXULpqksvXgJZc/UNTrtdlc6L9Rgs7HZxQCeyHHwppE5dZ/SKGPU0TTrmtqgdp94BAVYbXJWLfoQ/YJ1jSXZQb/gEcfAcUueEEnSvyBU9Uy32Wk0WNiiwIRd9NB6pct9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSEz3psg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B774C4CEE8;
	Wed, 19 Mar 2025 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398966;
	bh=hq/Xnzz8NMzDPSLzFIZjOUjCU+qawzTX6aJY0OdgJU8=;
	h=Date:From:To:Cc:Subject:From;
	b=NSEz3psgFAvfdr6kGes2WdQn93cYKLAPDY7Onb/4ONmEKnuxSD/dI1vZk7sl9cH16
	 LEG4Yfj9/Wu6AluM6S4umVVUKG0+HwQwMyVIO0Zx1TKl4Dj2fHJHGXMcAV5w85IMJa
	 gc1DYGsR0HX3v5sT2xQQ0dfepb9FCe+fvqUUpD2RaIZLAu2Fy+/W49lWvNN6nC56BW
	 FlsmcO2oPXYgLBxP4rAPlyDHAhyvKg7pKr4j439vZSV8N01ar0Mfp9OXaYFNK58GNN
	 bm64RE/pOXNTy7S3qIaAaAErFMzWD6eDhUJ1xX+prKsqMWrcC+IpgODbdBiBwGD99S
	 GZzL3KK4nkjdA==
Date: Wed, 19 Mar 2025 08:42:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 20.1.1 uploaded
Message-ID: <20250319154242.GA3599324@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 20.1.1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 20.x
series is no longer supported.

Cheers,
Nathan

