Return-Path: <linux-kernel+bounces-227768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A048915655
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DBF1F2456D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9E81A01C0;
	Mon, 24 Jun 2024 18:12:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D91A01B6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252767; cv=none; b=EhXL/qxPthsSzcPOdBNDWMAwlYsrxxiEjcU0pbUfOkrOQAgrPGlyOZ0Vjgh1UUu6Jby8U9CiGcu641hVW2W/88Jwe9lZG6o8eKZirtdZ2W2TAbnnXKomHEmjl0xmgpDZs7ilSUhvUJ7e7BA2Kh5OzpLIbzp4Fqc2qbb7iPqHOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252767; c=relaxed/simple;
	bh=OKXbM8AwAtm73/HrZJz59qwChbcuVyTAC+ttVRZVvVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2d/l503jCo4NaPBhNV/8Ln85cJb/HJd4Nz1W0V6D1ITOfXmbzSy1e4ZEUGTalnBRQ1RAOBdPu+CEUN1ewchYv/VhJh/aO/fX9Na+98E3/ipA4LErHb9sZzdB1usWmGSA4CqdDKclDVhZnPt6RC0dE4/gsTbNxss31VlRgpdrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2A6C2BBFC;
	Mon, 24 Jun 2024 18:12:44 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	ardb@kernel.org,
	mark.rutland@arm.com,
	Seongsu Park <sgsu.park@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	infinite.run@gmail.com
Subject: Re: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
Date: Mon, 24 Jun 2024 19:12:42 +0100
Message-Id: <171925273633.3100383.12523755678461122239.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523122146.144483-1-sgsu.park@samsung.com>
References: <CGME20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b@epcas1p4.samsung.com> <20240523122146.144483-1-sgsu.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 May 2024 21:21:46 +0900, Seongsu Park wrote:
> The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and encode
> the virtual address space translated by TTBR0_EL1. When updating the
> field, for example because we are switching to/from the idmap page-table,
> __cpu_set_tcr_t0sz() erroneously treats its 't0sz' argument as unshifted,
> resulting in harmless but confusing double shifts by 0 in the code.
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Cleanup __cpu_set_tcr_t0sz()
      https://git.kernel.org/arm64/c/cf938f91784f

-- 
Catalin


