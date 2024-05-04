Return-Path: <linux-kernel+bounces-168634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359E98BBB12
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18F2282AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08EB20DC4;
	Sat,  4 May 2024 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeEqBrsf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F171CFAF
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714824863; cv=none; b=q4rhLlx2buSCq/MvfDTBvEDzQp7fLaniKMONZEJ3X7jlAbXQ1DaYLEM59S7UmA78Da7rAXjMKmWGEbaUNtpyB6o+zTmdxVGJzn4q+LBfKsi936WRzhzbGfLjfX2bTHWsFf3isoj04z8YGxoYwNNSQRC6f2iv7ix1ZdY2KdcdNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714824863; c=relaxed/simple;
	bh=w7n0QpKIzd+FJnDpgW9IsvunqZ0NkMZk0lKoOyuacJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tAna7vsQN3NlcSEUnXrGy/r5ClRmA5vUjsopUKhuxyPOMrLmbBJSC+BuI1jmh7xL+Mmzp2vFfxmkloUHk2n7HtXtHxzlXdn/kBGI4FfIbADwnOb3TzsK+MYQLO7f/vhREW5wA25bgiw3UQ++m6XSkPf/y3K0m/cJfhAP332f0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeEqBrsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C749CC072AA;
	Sat,  4 May 2024 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714824862;
	bh=w7n0QpKIzd+FJnDpgW9IsvunqZ0NkMZk0lKoOyuacJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BeEqBrsfEyYXnU9+qu5k0Ys02vl5Lvtc140amWUKVyHwKUFzTx2/D/oOiDBJyK5V7
	 pCi69Dm+nPZsiHOhYdy3sE5mRWnZEgznnsNc/gUw4nnVxInUTk1AMZeqQvn/sQubuI
	 6rMg0OHKmHWhwvRwLuwA7ImIgL3ulSVMhsCo0pPWUcIewBD5WvVutXsMTv6e4drNOY
	 DSPQbgWgaoDroUh1otRxntksJ7HxnUDkxyPVh3Ry+CQ0O9EjW6DcocFaFpnWnPVd7t
	 nGICAScEpRUGTuhLOBUaJkTX154wp7/mxeQf46/KnX/RG/uO9H1Efv2imCkWNke9x+
	 xm+G8oygnn6Og==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, krzysztof.kozlowski@linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240426104129.2211949-1-peter.griffin@linaro.org>
References: <20240426104129.2211949-1-peter.griffin@linaro.org>
Subject: Re: [PATCH RESEND 0/2] phy-samsung-ufs fixes
Message-Id: <171482485731.28322.17976284474709721365.b4-ty@kernel.org>
Date: Sat, 04 May 2024 17:44:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 26 Apr 2024 11:41:27 +0100, Peter Griffin wrote:
> Two minor fixes for the phy-samsung-ufs driver. These were sent previously
> as part of the v2 of the UFS series [1], but I'm re-sending after
> splitting the patches out into separate series (clocks, phy, UFS, dts), to
> hopefully make things clearer and easier for the relevant maintainers.
> 
> These patches were based on feedback received from Andre and Dan on the ML
> after the gs101 phy patches were queued [2].
> 
> [...]

Applied, thanks!

[1/2] phy: samsung-ufs: ufs: remove superfluous mfd/syscon.h header
      commit: 8b19c45ae4c0480ea07ab9f33c43d0fa6ea43aa1
[2/2] phy: samsung-ufs: ufs: exit on first reported error
      commit: 2ff6365e2271282bea155541e5e3deb9d9ff1572

Best regards,
-- 
~Vinod



