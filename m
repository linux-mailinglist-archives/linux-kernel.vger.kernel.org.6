Return-Path: <linux-kernel+bounces-445135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7F49F11D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8731887AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CC1E3791;
	Fri, 13 Dec 2024 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndh8KagD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD542F24
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106381; cv=none; b=u5EX1+WeIHDLN6ug6Yj0GbkTsJQ2Htf7PlR7GnV0RPdftYfVBsWwhMXf6FXCFhFjel6wKU4WN4vAGaPvc8v1kfrS6eisTdHFcydmx56/7brJuH+eqVm/C0uNepiY+ZNSNiWCT9ik7+SThSa/s0YMShEIgg1gby4w9WRVNqOB2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106381; c=relaxed/simple;
	bh=kdhy92VFTEQXiuo32/qsaRnNKb4dWA/LMwOiSwmh7Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=olqWyZkhv+k3xpQZXWC24Pd4CzuWyBjHycJRNMwqxqcqiFC9fwevvmvb7jVnFvi7WsCLRuJpqMWAKEvYNH59n5PISZSedxtvIIXOij/a9w0fkp/jJqcsmL+4bhTFyr6BlKjuzYx+WP0min3ERtA9855RcD9k3S9259FieUiUSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndh8KagD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1FE4C4CED0;
	Fri, 13 Dec 2024 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734106380;
	bh=kdhy92VFTEQXiuo32/qsaRnNKb4dWA/LMwOiSwmh7Os=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ndh8KagDiB1CW6XJ8O2sqCuLvOa0PEyAuR+65XShcsuqLEYnBVpMTGSwa7flczias
	 cR/3WpiKVPjyPhluTuf/WrZ8Wy1ergXuSWPmZa9h0MEvRJdmLCkaDKJ687yuJaJJtZ
	 Ry/5ZaYRpHpnat0oJtI7w8Nz/KK5j3n/eUNmoboS+1LrOycklMLDFpqIHsaz5e+OJX
	 ST+pwHsdigg5q3guwFvGIy0lFw6rrbZFkca+F0fZ+oADwkUzQl1J9YsljDtCO/b8Wp
	 qtuGQ32L4Md2c67lcZV98cxrZK0D6OLxhyp4y02TiBT76bggZAPi1SbOnBfqXIij8N
	 6xM8kGdo7wrHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6318E7717F;
	Fri, 13 Dec 2024 16:13:00 +0000 (UTC)
From: Ross Burton via B4 Relay <devnull+ross.burton.arm.com@kernel.org>
Date: Fri, 13 Dec 2024 16:12:58 +0000
Subject: [PATCH] arm64: defconfig: remove obsolete CONFIG_SM_DISPCC_8650
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-clkmaster-v1-1-dcbf7fad37b1@arm.com>
X-B4-Tracking: v=1; b=H4sIAAldXGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Nj3eSc7NzE4pLUIl1TU4tU0xTzZEszs2QloPqCotS0zAqwWdGxtbU
 AZmVDoFsAAAA=
X-Change-ID: 20241213-clkmaster-558e5d7c966c
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Burton <ross.burton@arm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058;
 i=ross.burton@arm.com; h=from:subject:message-id;
 bh=epENDaJFaEN+XJXFXZ723Iyyxb7oJBNFgTPKcQODkWo=;
 b=kA0DAAgBZItO7TOROJ0ByyZiAGdcXQvIqGC4hPhLJYfOvCIyA/T+rzDsNRxIyP39hHE1cxwB3
 IkCMwQAAQgAHRYhBIf9jOMBgVWcojlzDGSLTu0zkTidBQJnXF0LAAoJEGSLTu0zkTidtUUQALlI
 eHpo8h7c6m53q4NRc5Oca+Yj504O56wR7RfZApjR1hmzhklavRFuDBkfXtpYmoja3Mg73mN1cu0
 jhnHVRn8azedLxL5BQnh5UNa6ZH7voXrmeFyp+DrEPnozElBSlYilXvyfmj5sdkU7J/hxSiux8g
 Egyclnn6TYepZ+t59SajE3gmtQLj/Q731dS8B/7Tc/pr0dcxLxozTohv3o1Yl2c9vCK/r5AvgNy
 +t3Xm85Dc6JLnDgv00iR8a/FsbKC7N0/jcv0RwZZKfjAu8TFdSsZCM7ki/ppKRa9H9ZPQ4NLkgK
 YlnY3h9wtj5BI/cpDecn/X4cg5hln5RvjmAMRurk/zDwjekzmFUGCMV+UKdMT4FmWHcpvE0BWvx
 CNHLMb8Adu2wDe+1VYqJbZY1vHWUZSKNlbSb2AOEjaNf3K/jDiTEy6aaxAtuzipb2Hs/JvT/n20
 HM6i2Gy2tsvLsonwd/T2U8fDhAPOH2/nJEj5HjH+r/f6DnPn61Oqed1DR99GJtV7YwLVaClXa1J
 63WeHvvVi71mEaBpWSUV+QJo8Ygfq9AREPUZrTEGX8N9VadFUNIbvphZQnoUKA0ScHeIqS73ml9
 qfNGVimrwZc5Mz+2Itqrq1k2paKu8CESgrbgSP5O78mlsuTpXIjZN/W/eyWv3A7hkzTGItFsU2N
 6VWsg
X-Developer-Key: i=ross.burton@arm.com; a=openpgp;
 fpr=87FD8CE30181559CA239730C648B4EED3391389D
X-Endpoint-Received: by B4 Relay for ross.burton@arm.com/default with
 auth_id=59
X-Original-From: Ross Burton <ross.burton@arm.com>
Reply-To: ross.burton@arm.com

From: Ross Burton <ross.burton@arm.com>

This option was removed from the Kconfig in commit 802b83205519 ("clk:
qcom: fold dispcc-sm8650 info dispcc-sm8550") but it was not removed
from the defconfig.

Fixes: 802b83205519 ("clk: qcom: fold dispcc-sm8650 info dispcc-sm8550")
Signed-off-by: Ross Burton <ross.burton@arm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e6158633f07c1f3532fba62f09b31e7448..c6d6a31a8f48c7ce9c9ca74e29db3b8835bfd556 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1352,7 +1352,6 @@ CONFIG_SM_DISPCC_6115=m
 CONFIG_SM_DISPCC_8250=y
 CONFIG_SM_DISPCC_8450=m
 CONFIG_SM_DISPCC_8550=m
-CONFIG_SM_DISPCC_8650=m
 CONFIG_SM_GCC_4450=y
 CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y

---
base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
change-id: 20241213-clkmaster-558e5d7c966c

Best regards,
-- 
Ross Burton <ross.burton@arm.com>



