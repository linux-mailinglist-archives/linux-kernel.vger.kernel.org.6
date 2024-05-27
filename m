Return-Path: <linux-kernel+bounces-189960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF198CF7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5A91C20F30
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D4130497;
	Mon, 27 May 2024 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRJ3Wi8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484D6BFAA;
	Mon, 27 May 2024 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716778865; cv=none; b=WhHhYLpECwYQIPI4+wCwfiKAtGqzm0dPH1eHIqQEVXXmCJKU2Um2Y4vqG12vtWeF4AajxSowTiX5fJbDIlsSadzY5xMEAA+Z7n9Sdze5VeTe3cdoVBHp2bHv3Kw1FmWHyuxZnBfQqeh5RZ+tbpL4vqnL9z8MAJPLpG7nxUIQGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716778865; c=relaxed/simple;
	bh=UaTwXb1+fxy6xm5IfQ8PiUAi/qB3CV0rmGWTZ2Y4Jms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMcw27sVUo2n+RJnkjIdmfrxG9ETyctK+qaIf3WXL7cPqeQWzAm7iz2nvVcwcbjAwXXkXIRJ4VVoGQuCFtLgdLcgYVW2/FnhNYN4Rjv3bKCq06RaIDUu82Rv7uQIuuNPKnKQgOZbP9iU2oSZqKLQS+PGFm/hLPFKeDMChEpenX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRJ3Wi8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00CFC32782;
	Mon, 27 May 2024 03:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716778865;
	bh=UaTwXb1+fxy6xm5IfQ8PiUAi/qB3CV0rmGWTZ2Y4Jms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bRJ3Wi8/QJzatI443183HUdf3odjiqEiSE4HwlB2ENi/wtwADsNMLi9vD+WzrU1O6
	 FZ6HWlIUZNR4YPJ61ZElEy8MO4A2uvMGguzfy2q5LUkEvaSiyDbVuOGmE9Ulo+jfzF
	 zTLRzH3/IvmShHT1CQBh/anm7QcFKGTBuC1rYBUBsaq3yJAzw8Yj4O/ECVmef+QneZ
	 BOEPZL6pMJ1cOfUIWSfxac9uNNchmLOr9B2aKKd2sKlErdkyV+HVnh/y8NSdheLMxf
	 qcsUSTDo2nB0C4cRobCIinPOrMzQFf9ZywG842G9Az7RGd2yB5+xvAqw1Y1t2poA0z
	 SHCNL/awnOKEw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v5 0/3] arm64: qcom-sm8[456]50: properly describe the PCIe Gen4x2 PHY AUX clock
Date: Sun, 26 May 2024 22:00:33 -0500
Message-ID: <171677884196.490947.11229533300541315825.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v5-0-10c650cfeade@linaro.org>
References: <20240502-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v5-0-10c650cfeade@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 02 May 2024 10:00:35 +0200, Neil Armstrong wrote:
> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock named
> "PHY_AUX_CLK" which is an input of the Global Clock Controller (GCC) which
> is muxed & gated then returned to the PHY as an input.
> 
> Document the clock IDs to select the PIPE clock or the AUX clock,
> also enforce a second clock-output-names and a #clock-cells value of 1
> for the PCIe Gen4x2 PHY found in the SM8[456]50 SoCs.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8450: correct pcie1 phy clocks inputs to gcc
      commit: e7686284066073e3f39b02df0f71db96d7538f48
[2/3] arm64: dts: qcom: sm8550: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
      commit: 0cc97d9e3fdf9a7b71b4edfd020a44c54c40df52
[3/3] arm64: dts: qcom: sm8650: remove pcie-1-phy-aux-clk and add pcie1_phy pcie1_phy_aux_clk
      commit: d00b42f170dfa4d5ffbd616aec36de8159168bba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

