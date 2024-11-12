Return-Path: <linux-kernel+bounces-406291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360099C5CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C2F1F22696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C957202F84;
	Tue, 12 Nov 2024 16:10:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA32003AE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427813; cv=none; b=T9J+BnCG/X6HK2gzRizI9PSzislwO70NjyUEBWUh3w7Cz2aJFYvfRFTYvKJNrV2iumsmcAgHj05NAJ3lfpscXgP0LxH189zwoLIaVLu2oXt3OuOFivaCvD9byQkIw7dqwwB3BxFeUSM+j5mbhasS4z8wcterGTotNpjY6P65s6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427813; c=relaxed/simple;
	bh=Y1T2ZCPwSTyJigZrfJePc4U/DtUA7QW9UrEcttxLdAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roWMIdj3EkquAADWWwbawTgQ7vybh9+3xvtzx9SGK3Cf4IOMBQlDINges6Sqq8y8g5heVl1a+NeVEqQbnHtl1k1C1vGh2ff4o+vXFj4SdIB1CYFw6yBddXTnF3ROyptYaEXC7H8aXi1n31i/bG4Xzk/fCoXfhm7x4l5nA9v6YxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9B5C4CECD;
	Tue, 12 Nov 2024 16:10:10 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Change protval as 'pteval_t' in map_range()
Date: Tue, 12 Nov 2024 16:10:07 +0000
Message-Id: <173142780464.896456.6904974640753007235.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241111075249.609493-1-anshuman.khandual@arm.com>
References: <20241111075249.609493-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Nov 2024 13:22:49 +0530, Anshuman Khandual wrote:
> pgprot_t has been defined as an encapsulated structure with pteval_t as its
> element. Hence it is prudent to use pteval_t as the type instead of via the
> size based u64. Besides pteval_t type might be different size later on with
> FEAT_D128.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Change protval as 'pteval_t' in map_range()
      https://git.kernel.org/arm64/c/de7fb8d3a2c9

-- 
Catalin


