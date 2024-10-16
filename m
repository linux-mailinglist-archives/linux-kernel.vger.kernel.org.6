Return-Path: <linux-kernel+bounces-368435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFFB9A0FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2075D1C2238C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501F210C20;
	Wed, 16 Oct 2024 16:31:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DC20FABD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096276; cv=none; b=sq52DCf6Tum5ypbut6L11ETcFIH+I08XrMM3zYGvIA8//+1Sanbfgy+m0zQKAg6G9jmCjnbzGZRD/TyP8bXELFFuOlE88dCTkHHNgo7Kbll75hqafAc5Pk9C0dvm7FupDLn2FfaCz9wMnqvia1S8VBgSqbR6a99AtUzdRsceVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096276; c=relaxed/simple;
	bh=O0fsJVPFAH9bal8q4wlo4vxoaxh5ggbb1sftbiGMKYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJdits6eSrPCVZ2kbndAcw1+9Tx2wnf5iYBf4SpUKuHPuEIhG/zbRx+1pTHXZBYTKKptirHE6Ea8mNgAuSwWDQN7IG2NrTPgExOt6vEbfXYZbFo1RCMHT5adCTSyfcS95old5ZlkSgOTU0z8nW2MXHEmCsu96ekX5IRG6rnjg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CABC4CEC5;
	Wed, 16 Oct 2024 16:31:14 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64MMFR1_EL1 to DDI0601 2024-09
Date: Wed, 16 Oct 2024 17:31:12 +0100
Message-Id: <172909626930.3163971.6400872490646060749.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241011-arm64-aa64mmfr1-2024-09-v1-1-61935a085010@kernel.org>
References: <20241011-arm64-aa64mmfr1-2024-09-v1-1-61935a085010@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 11:30:25 +0100, Mark Brown wrote:
> ID_AA64MMFR1_EL1 has been updated by the architecture to enumerate several
> new architectural features since the last time sysreg was updated, sync
> with the definnition in DD0601 2024-09 to include two new versions of each
> of ETS and HAFDBS.
> 
> 

Applied to arm64 (for-next/sysreg), thanks!

[1/1] arm64/sysreg: Update ID_AA64MMFR1_EL1 to DDI0601 2024-09
      https://git.kernel.org/arm64/c/034993461890

-- 
Catalin


