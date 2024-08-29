Return-Path: <linux-kernel+bounces-307517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4026964E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6291F2295C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4FF1B9B59;
	Thu, 29 Aug 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8FUDsFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC81B86E7;
	Thu, 29 Aug 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958347; cv=none; b=peO6dhQDhC5YJX1z5vv5fdNMwV9/BeY9ajWzVzWsnz4T33JYEf7aHF4jBLBCDr8pLOPtu2t0NeN+5JyOJpydn+fuXl1AAJr90potwroOK+j5smgL8nfSpGlj+M68w4w06IAFPw45TC1k6XCfHQ9UDB/tuyF7R0aXZnSfHHTsGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958347; c=relaxed/simple;
	bh=6VNX1ZO295qYsxEjzyqjGbUXtYFkzUXheM0fF+c+nfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eu3DBDXnRJURV6cBNGRwEVlJ7Hi6C5QKfXLvL70qxd6rb3KOF9NPaxZtREJQ3vgKD0pEdbiqMZCXY7Jl9854xx4wc1b4qa5PQPxdifT0//ghQRrREw24gBggLwvaxonC6vIonDpQV/54SjgeI5UdeY09PbpgXL6HlZtjpAOk/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8FUDsFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F0CC4CEC6;
	Thu, 29 Aug 2024 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958346;
	bh=6VNX1ZO295qYsxEjzyqjGbUXtYFkzUXheM0fF+c+nfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k8FUDsFhUNYb+zvQpP/FYRheP4rphUgNqwkLiqz7RZjlLU8YifZ9mQ84zu0yfBRAJ
	 puqGlANAGw+3Wm1pD1UyHwfuZq1cqbrf8hNZY3d2ArrhRrhRj1/sACV0BVxiqQMu8d
	 WJtsbYAqzCinEK6pDpailWBj4IZdGU/03u0fUVhG2HFvF5qLndSGb7Ktk4E/nf/MNl
	 VKHe1ICXQm8ckXKSA3uIP/L+Ju9p9WPf0ID2pmrGQGJuZuZ56uZpidASqR8sn7dY1C
	 E5q8f22T3U856BI8HHGz8LPbAOkb9yU+snP1E0mPpfH4UPTkhEFXHTITjHd771GP++
	 9FJ3UAvPNXFbA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240805-phy-qcom-qmp-pcie-write-all-tbls-second-port-v3-1-6967c6bf61d1@linaro.org>
References: <20240805-phy-qcom-qmp-pcie-write-all-tbls-second-port-v3-1-6967c6bf61d1@linaro.org>
Subject: Re: [PATCH v3] phy: qcom: qmp-pcie: Configure all tables on port B
 PHY
Message-Id: <172495834439.405683.7952114059467744681.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 00:35:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 05 Aug 2024 19:45:18 +0300, Abel Vesa wrote:
> Currently, only the RX and TX tables are written to the second PHY
> (port B) when the 4-lanes mode is configured, but according to Qualcomm
> internal documentation, the pcs, pcs_misc, serdes and ln_shrd tables need
> to be written as well.
> 
> 

Applied, thanks!

[1/1] phy: qcom: qmp-pcie: Configure all tables on port B PHY
      commit: 00c5f32283f377ec60870bccbd518d9feb7fbc52

Best regards,
-- 
~Vinod



