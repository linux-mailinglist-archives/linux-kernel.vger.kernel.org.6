Return-Path: <linux-kernel+bounces-290283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53949551C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687DAB2327C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339A41C4633;
	Fri, 16 Aug 2024 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQZmtA0n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668231BDA8C;
	Fri, 16 Aug 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838905; cv=none; b=DpePLm+hvJEekEfX2V1R4GVYOujf6qn/+6ZpipYkDssTYbPkEnmjRxuaRdbXQythrQfs2Ot735jSLbIp9z0uyJeULflB3Y3mWGoHkquEf8o/xljcT/5zOoyyGMl+6L9ceaVBM8pkSpGGqB3o2Bw+xl/syOmf3OCQl3myUedK/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838905; c=relaxed/simple;
	bh=OFCsg1Y2BNLhv2nE8/0oRy5vqPBeBpiDxe0JyGoYC4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TQ+CB6JFusvOr12dqIRknE2OwiffZ1OIWd4rHQ5hNnA8IWbN/Qr5e1qjGSRgssTSuQgYwTXKjA7BBH3t664/hjiV+mWduYJAUjtuabTs+E9EA0C3hFKIBrvOPhXnxgEzbjU1fd47jCfVPRieNrmQXsmKnW2Vl+hO7ETZPNGsf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQZmtA0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EC1C32782;
	Fri, 16 Aug 2024 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723838904;
	bh=OFCsg1Y2BNLhv2nE8/0oRy5vqPBeBpiDxe0JyGoYC4Q=;
	h=Date:From:To:Cc:Subject:From;
	b=IQZmtA0njZRGeOr5/8HIltUVr98Iv3oOGMCQPjpxWhPEV1uccP5Rm9oI0qztx2+fx
	 W79Ysb8Hj3J98PcdSnEMjXm5gPPxh+qxjNz6KxiEnTh+g0k36t0WDC1KmiO69XSy0X
	 oeemxB10a6CA94dXir2p2WtzPoOaHerk8owQCGTvLuAmXlLwzgREISjPcdkQTAdiZW
	 Ay3B5vxyZXvunLvwKUhWxy7g0BjcgYx7DI+Ro5wO2maXQ+TqA0TNcKQY9taRGQrkp/
	 v/twTjkpv+tqTSGISau+Zb8ynXDM01V/Z88hMwDgdukEPI6u5BX0s+WvBSgZ4PofyI
	 CAKTgCxcmhgdg==
Date: Fri, 16 Aug 2024 14:08:24 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.11, part 2
Message-ID: <20240816200824.GA2049154-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull a couple of DT fixes for 6.11.

Rob


The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.11-2

for you to fetch changes up to b739dffa5d570b411d4bdf4bb9b8dfd6b7d72305:

  of/irq: Prevent device address out-of-bounds read in interrupt map walk (2024-08-13 15:17:24 -0600)

----------------------------------------------------------------
Devicetree fixes for v6.11, part 2:

- Fix a possible (but unlikely) out-of-bounds read in interrupts parsing
  code

- Add AT25 EEPROM "fujitsu,mb85rs256" compatible

- Update Konrad Dybcio's email

----------------------------------------------------------------
Francesco Dolcini (1):
      dt-bindings: eeprom: at25: add fujitsu,mb85rs256 compatible

Konrad Dybcio (1):
      dt-bindings: Batch-update Konrad Dybcio's email

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map walk

 .../devicetree/bindings/clock/qcom,dispcc-sm6350.yaml     |  2 +-
 .../devicetree/bindings/clock/qcom,gcc-msm8994.yaml       |  2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6125.yaml        |  2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm6350.yaml        |  2 +-
 .../devicetree/bindings/clock/qcom,sm6115-gpucc.yaml      |  2 +-
 .../devicetree/bindings/clock/qcom,sm6125-gpucc.yaml      |  2 +-
 .../devicetree/bindings/clock/qcom,sm6350-camcc.yaml      |  2 +-
 .../devicetree/bindings/clock/qcom,sm6375-dispcc.yaml     |  2 +-
 .../devicetree/bindings/clock/qcom,sm6375-gcc.yaml        |  2 +-
 .../devicetree/bindings/clock/qcom,sm6375-gpucc.yaml      |  2 +-
 .../devicetree/bindings/clock/qcom,sm8350-videocc.yaml    |  2 +-
 .../devicetree/bindings/clock/qcom,sm8450-gpucc.yaml      |  2 +-
 .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml |  2 +-
 .../bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml   |  2 +-
 .../bindings/display/panel/sony,td4353-jdi.yaml           |  2 +-
 Documentation/devicetree/bindings/eeprom/at25.yaml        |  1 +
 .../bindings/interconnect/qcom,sc7280-rpmh.yaml           |  2 +-
 .../bindings/interconnect/qcom,sc8280xp-rpmh.yaml         |  2 +-
 .../bindings/interconnect/qcom,sm8450-rpmh.yaml           |  2 +-
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml   |  2 +-
 .../devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml    |  2 +-
 .../devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml     |  2 +-
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml     |  2 +-
 .../devicetree/bindings/remoteproc/qcom,rpm-proc.yaml     |  2 +-
 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml          |  2 +-
 drivers/of/irq.c                                          | 15 +++++++++++----
 26 files changed, 36 insertions(+), 28 deletions(-)

