Return-Path: <linux-kernel+bounces-191687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3238D129E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645CE1F221ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8DE288D1;
	Tue, 28 May 2024 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6DqkEgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160691C69A;
	Tue, 28 May 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867163; cv=none; b=j/qcQnvJaFWfjUtNky5+b/dRFLBA0aEl8qLIQrL2N7vs0n+nDLqVY/WRWYGoq5613X0wkxR1T7v79EwPCpHQ142xZyjx/VFAOczYhYd44ZsFKrCrdU2u39wchMP1637aS08XsNKbs57ne2hXhcz6HsCKwHlZvfe2x7jJu2Q6X8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867163; c=relaxed/simple;
	bh=bW+Ah5NRI5eoe53Nq3YvvI4Bo67E5Q8mEglfVDgRHRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoDuSMLAOgn6D3J62sUwVuhRzblAqNETKHIvm17+UrZ3slaSeh8DISaj+7ZmizZY5kuv7/NOMgoRBAGI2H/37KUSCACo7wexWhrpIdiKuNav5JJ7WhmXSoCnih2FvKm51uV7vi9oM9S/jkuuwvaI4mVugqBzG2mC/TOoufW1nLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6DqkEgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454B8C3277B;
	Tue, 28 May 2024 03:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867162;
	bh=bW+Ah5NRI5eoe53Nq3YvvI4Bo67E5Q8mEglfVDgRHRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6DqkEgTSg3ZPzQ9c29407Qj/dAV2GCl3HC09wchW7XsIinNyEaZuXv6IgOcEGzbN
	 2hn7SBpVik3wJa8LS+nch47je7q4DjzXe/FFEH5oGx/uv5Fu0+RcRiSPpxmdVgI+R/
	 YY8hF9HrfrQa0M54gq+JP/nGWtrJSFrpPCpckEFqEwhwIrWdfquI6f3R4jg9nECgE/
	 vLQWT49ULsZMQYND9t8fBO8dtx8xUletJAiztaKljaeJn2k73rP1z4GUDDMzotxC1A
	 MUQHMrfCN4JMbdWDW5BbJNW/Jz26kZak51W/5eNC5Jc87Svm+NINSfoGsqS1jrHkM6
	 xtrCVKzHTUtow==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: Increase max ports to 3
Date: Mon, 27 May 2024 22:32:09 -0500
Message-ID: <171686715141.523693.14867224380631675449.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org>
References: <20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 May 2024 11:16:01 +0300, Abel Vesa wrote:
> Up until now, all Qualcomm platforms only had maximum 2 ports. The X Elite
> (x1e80100) adds a third one. Increase the maximum allowed to 3.
> 
> 

Applied, thanks!

[1/1] soc: qcom: pmic_glink: Increase max ports to 3
      commit: a8a313c298b8becc7e2c0bab174df736d1f99450

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

